---
title: Resolving software component dependencies using compatibility tests
author: David Soergel
layout: post
permalink: /2012/06/26/resolving-software-component-dependencies-using-compatibility-tests/
categories:
  - Java
  - Software Systems
---
Modern software frequently depends on preexisting components, which in turn have their own dependencies. Managing these dependencies (e.g., automatically downloading the correct set of prerequisites) is a substantial industry that touches nearly every software development effort. In the Java world, Maven is the dominant mechanism; Scala users may use SBT; Perl provides CPAN; other languages have more or less developed systems; and Linux package managers address essentially the same issue. These solutions remain awkward, particularly in the case of conflicting requirements specified by different components. Developers spend untold hours in the dreaded &#8220;[dependency hell][1]&#8220;, trying to establish a mutually compatible set of dependencies just to allow a simple program to compile. Some see this problem as hopeless, and provide mechanisms to allow composing arbitrary components while isolating conflicting areas from one another (e.g., [OSGi][2], [Maven Shade][3]). That is not always practical, especially for the vast majority of smaller-scale projects where such engineering investments are out of scope. At the same time, I think that we can gain some clarity on dependency management by designing the supporting infrastructure in the right way.  
<!--more-->

## Mutable names represent substitutable artifacts

Digital artifacts, such as jar files, are unique things; in a world of final variables, each must have a different name. The most concrete way to express dependencies among artifacts, then, is to refer very precisely to the exact build (for instance, using the hash of the jar file as an ID). However this does not allow for a lot of flexibility that we&#8217;d like to have when composing sets of dependencies, and in dealing with transitive dependency conflicts.

Version numbers are a means of variable mutability: we want to be able to refer to different actual artifacts by the same name. The point of doing this is that we expect them to behave similarly, i.e. to be substitutable.

In the Maven/Java context, aside from the &#8220;group ID&#8221; and &#8220;artifact ID&#8221;, the package and class names contained in the jars constitute mutable names too, because they are the key used for classpath searching. To really enforce an immutable worldview, we&#8217;d have to add a build number to the class names themselves (!), or perhaps in a package name (e.g., com.davidsoergel.dsutils.8474.StringUtils). A similar effect can be accomplished with Maven Shade. But of course that is not what we want.

The question of whether artifacts are substitutable or not is really a continuum: minor version number updates are likely substitutable, but major ones are often not. Sometimes package authors (or user communities) make non-substitutability of major versions extra explicit by making the version number part of the name (e.g., Maven2), indicating that the new product serves a similar purpose to the old one but has a completely different API. Similarly, sometimes artifacts keep their name but move from one group to another (often for apparently beaurocratic reasons); this makes the artifacts appear completely distinct, breaking the possibility of version substitution.

Any anyway, the degree to which one artifact can be substituted for another depends on the task. A common pattern is backwards compatibility: core functionality continues to work but later versions add new features. In that case, a dependency should point to the oldest version that will work, since pointing at a newer version suggests that the newer features are used when in fact they&#8217;re not.

Conversely, there may be different implementations of the same API, which are in fact substitutable despite having different names. This is sometimes handled (poorly, e.g. in the case of Java XML parsers and logging packages) by making the API an artifact in its own right, containing singletons or factories as needed so that implementations can be swapped at runtime simply by placing one or another on the classpath.

## Dependencies by duck typing

A lot of confusions around dependency version numbers might be alleviated by expressing a dependency simply by a set of tests. This is something like duck typing or &#8220;structural typing&#8221; in Scala: if a library works *for our purposes* then we can use it. This is somewhat related to &#8220;[behavior driven development][4]&#8220;), with the twist that the downstream users write (or at least select) the tests that they care about to satisfy the dependency. In the simplest case, of course, the user can just specify &#8220;all the tests&#8221;, but this may be a more stringent requirement than is really needed. Automated tools might assist is selecting a relevant set of tests, for instance using code coverage metrics to find tests that exercise the same library code that the user&#8217;s program does.

A related issue is the granularity of artifacts: finer grain requires more management overhead, but allows paying attention to only those changes you are likely to care about. Some projects model this by providing a number of of related artifacts a la carte. In general it&#8217;s accepted that, when depending on a library, you drag along a lot of stuff you don&#8217;t need. But when that stuff changes, the version number increments, and it&#8217;s hard to tell if that&#8217;s relevant to your program or not. In the limit we could give every class, object, method, etc. a version number! But packaging coherent sets at some level is essential for sanity. When the packaged objects form a tightly connected cluster, that makes sense anyway; when they don&#8217;t (e.g., [dsutils][5]), then nearly every version update is irrelevant to nearly every dependent program, but that&#8217;s the cost of not packaging each class individually.

Of course, substitutability may not just be a matter of tests passing; maybe there are performance differences, or untested side effects, or important functionality which lacks a test.

## Versioning tests

Tests should be versioned separately from the main code, although naturally the tests will depend on certain versions of the underlying code (or, in a behavior-driven model, will just fail). Consider the case of package Foobar versions 1.0, 1.1, and 2.0. Initially a bunch of tests of core functionality pass for all three, so a user believes that they are substitutable. But then it turns out that a required function was just untested, so the user adds a test for it (and perhaps but not necessarily submits it back to the package maintainer). The new test reveals that things started working in 1.1. However, that test should not be attached to the 2.0 code base. It could go on a numbered 1.1 branch (e.g., 1.1.01), I suppose, but it seems wrong to increment the main version number since only the tests changed and not the actual code. Or, it should it go on a 1.0 branch, showing that the original release actually didn&#8217;t behave as expected.

So a test should always be runnable against the earliest version of the code where it was expected to pass. Such tests can then be run against later versions of the code to demonstrate backwards-compatibility.

But what if an API change, or even an underlying functionality change, make the test fail in a later version&#8211;but that is considered the correct behavior? Then the library is no longer backwards-compatible with respect to that test. That&#8217;s OK, as long as we&#8217;re measuring compatibility based on sets of passing tests. In this view, the failure of some test does not mean that the library has a bug; it means only that the library is not compatible with a given expectation, about which some downstream users may not care. Others who do care about that functionality will know which versions to use or not. Indeed some users may prefer the opposite expectation, represented by a different test. (Of course, a set of tests encoding a coherent set of expectations should nonetheless reveal bugs!)

So, why not go ahead and run all tests against all versions of the code? Sure, tests written for v2.0 will usually fail against v1.0 (likely with ClassNotFoundException and such), but that will provide the raw data for what works and what doesn&#8217;t in every version. Most importantly this allows completely decoupling test versions from code versions, which in turn enables the behavior-based specification of dependencies above.

## Conflict resolution

In the status-quo systems, e.g. Maven2 and Ivy, conflicting dependency versions are resolved by [pluggable strategies][6], including things like &#8220;latest revision&#8221; and &#8220;latest compatible&#8221;.

Apparently the usual syntax for specifying a dependency version in pom.xml file indicates [only a preference][7], not a requirement. However, both Ivy and Maven allow specifying a specific version, or a [range of versions][8] (bounded or unbounded, inclusive or exclusive). As far as I can tell they do not allow specifying discontinous ranges, though in reality that is a common case (e.g., 1.0 worked, 1.1 introduced a bug, 1.2 fixed the bug).

Those dependency constraints are placed at the point in the tree where the dependency is specified (i.e., at the intermediate node that actually needs it). In addition, &#8220;<dependencyManagement>&#8221; sections can be placed at the root of the tree (or anywhere else) to impose constraints on any transitive dependencies. So that can be used to force a specific version of some jar that a project does not use directly. Making that jar a normal dependency (i.e. via &#8220;<dependency>&#8221;) might also have the desired effect, but only by coincidence (e.g. if the &#8220;nearest to the root&#8221; rule is used, or the requested version is a higher one than the transitive dependency specified, etc.). And anyway this is a misuse of the syntax, as it wrongly states a direct dependency that does not actually exist.

In a behavior-typed dependency system, all that is needed to resolve multiple transitive dependencies is to find an artifact meeting all of the specified requirements. This automatically allows for the case of accepting discontinuous ranges, and allows various nice heuristics for selecting among them. For instance, one might argue that the version of a library in which the desired functionality is most stable would be the last in the longest series of compatible versions, or (by a similar argument) the latest minor version of the oldest major version. It also allows choosing a runtime-swappable implementation of an API: it shouldn&#8217;t matter that two artifacts have different names, as long as they pass the same tests.

## Improving conflict resolution with data

To the extent that dependency version constraints are specified in a pom or similar: that should be stored in a separate source repository. As upstream dependencies are updated, it may turn out that certain versions work with a given project and others don&#8217;t; there&#8217;s no way of predicting that when packaging the dependent library. We&#8217;d like to be able to update the dependency constraints&#8211;a sort of metadata&#8211;without touching the underlying data.

In fact, perhaps dependency versions should not be in poms at all, since compatibility is more an empirical issue than a proscriptive one. But where can we get the empirical data? From all of the millions of daily compilation and testing jobs run worldwide! All of that data can be collected automatically (with user permission, of course). In the case of the Java ecosystem, for instance, Maven/Ivy/SBT plugins would do the trick.

1.  Crowdsourced info on which pairs/triples/bundles of versions of things are mutually compatible. This data helps to cover the gap of code for which no explicit tests have been written. If downstream tests happen to exercise upstream code, and they give the expected results, that&#8217;s some indication that the upstream code was OK; and conversely downstream test failures at least cast some doubt on untested upstream code. In other words: sufficent integration tests can provide some sense of security when unit tests are lacking. For better or for worse, this is effectively what happens in real life anyway: lots of code goes untested, but developers shrug because it appears to work in the aggregate.

2.  Crowdsourced info on which versions of things are effectively equivalent. Possibly, try to distinguish version updates that are just bugfixes from version updates that introduce new features. This falls out of #1: every time two different versions of something both work with a given downstream component, that increases their equivalence score.

3.  Crowdsourced info on which specific tests pass in which &#8220;worlds&#8221; (i.e., sets of component version numbers). I.e., back off the &#8220;perfect equivalence&#8221; definition to allow finding equivalances with respect to only certain functionality.

The design of a distributed system for collecting, managing, and distributing these data remains an exercise for the future.

## Testing all artifacts in a consistent world

The idea that we fetch dependencies transitively in response to their declaration in a pom seems backwards. Instead we should propose a world by providing exactly one version of each library, and then recompile and test everything to determine whether the world works. This guarantees that a library is run using the same version of its dependencies against which it was compiled. In the status quo, a library may well be compiled and tested against one set of versions, but then its binaries are distributed and run against another set of dependency versions. This seems obviously error-prone.

A automated build process should proceed in phases:

*   collect the list of dependencies transitively declared, with all of their constraints (whether expressed as version numbers or as test sets).
*   For each of the dependency names, collect the list of versions available in the wild together with their test results.
*   Choose the most recent set of versions that satisfies all of the constraints (or throw an error if not possible), according to some selection strategy. (This is Ivy&#8217;s &#8220;latest-compatible&#8221; setting).
*   Collect the chosen artifact versions into a private &#8220;world&#8221;, ideally in source form, and including their associated tests.
*   Compile all the artifacts in partial order. This demonstrates that the APIs in this world are all compatible.
*   Run all the tests. Here, these are intended as integration tests: they show that particular version bundles are mutually compatible. Iff the tests for a given package *and for all of its transitive dependencies* pass, report success for that bundle. (If the tests are really comprehensive, then the compilation step is not needed, since any mismatched APIs will result in a runtime exception in the tests. However, compilation will catch API mismatches that are not exercised by the available tests.)

## Version control changeset ids, build numbers, and version numbers

Given a deterministic build process, a given version number associated with a binary distribution (e.g., v2.2) is just a friendly name for a specific version of the source code (e.g., 7eae88hc) that happens to have been built. Usually the source code should be &#8220;tagged&#8221; with the friendly name. The build number is another tag for the same version, but ought to be irrelevant since the build should be exactly reproducible from the sources. So in general when I speak of &#8220;version numbers&#8221; throughout I really mean source code revisions. This is important because of the need to recompile things to confirm API compatibility.

The other thing that friendly version numbers can be good for is bundling a release of multiple source repositories that form a coherent whole (see the granularity issue above): that is, it&#8217;s a means of declaring that a given set of artifact versions ought to work together.

## Conclusion

Dependency resolution is a hairy mess, largely because existing solutions depend on version numbers. These provide essentially no information about the provided functionality or compatibility with other components; thus, knowing that a specific version of some component works in a given context allows no inferences about whether other versions would also work. This fact hampers automatic updating of components over time and automatic resolution of dependency conflicts. These issues may however be resolved by basing dependencies on acceptance criteria in the form of reproducible tests, rather than on their version number proxies.

## See also

I.-C. Yoon, A. Sussman, A. Memon, and A. Porter. [Direct-dependency-based software compatibility testing][9]. In Proceedings of the 22th IEEE/ACM International Conference On Automated Software Engineering, Nov. 2007.

I.-C. Yoon, A. Sussman, A. Memon, and A. Porter. [Effective and scalable software compatibility testing][10]. In Proceedings of the International Symposium on Software Testing and Analysis, pages 63–74, Jul. 2008.

I.-C. Yoon, A. Sussman, A. Memon, and A. Porter. [Prioritizing component compatibility tests via user preferences][11]. In Proceedings of the 25th IEEE International Conference on Software Maintenance, Sep. 2009.

I.-C. Yoon, A. Sussman, A. Memon, and A. Porter. [Towards Incremental Component Compatibility Testing][12]. In CBSE &#8217;11: Proceedings of the 14th International ACM SIGSOFT Symposium on Component Based Software Engineering, 2011.

 [1]: https://en.wikipedia.org/wiki/Dependency_hell
 [2]: https://en.wikipedia.org/wiki/OSGi
 [3]: https://maven.apache.org/plugins/maven-shade-plugin/examples/class-relocation.html
 [4]: https://en.wikipedia.org/wiki/Behavior_Driven_Development
 [5]: http://dev.davidsoergel.com/trac/dsutils
 [6]: https://ant.apache.org/ivy/history/2.1.0/settings/conflict-managers.html
 [7]: http://guntherpopp.blogspot.com/2011/03/understanding-maven-dependency.html
 [8]: https://ant.apache.org/ivy/history/2.1.0/ivyfile/dependency.html
 [9]: http://www.cs.umd.edu/~atif/papers/YoonSussmanPorterMemonASE2007-abstract.html
 [10]: http://www.cs.umd.edu/~atif/papers/YoonSussmanMemonPorterISSTA2008-abstract.html
 [11]: http://www.cs.umd.edu/~atif/papers/YoonSussmanMemonPorterICSM2009-abstract.html
 [12]: http://www.cs.umd.edu/~atif/papers/YoonSussmanMemonPorterCBSE2011-abstract.html