---
title: Proposal for a tabless web browser
author: David Soergel
layout: post
permalink: /2012/04/09/proposal-for-a-tabless-web-browser/
categories:
  - Attention Management
  - Organization
---
Browser tabs, bookmarks, and social bookmarking services considered harmful; a unified approach to web browsing is needed.  
<!--more-->

## The problem: it&#8217;s hard to keep track of web browsing

One of my various mental diseases is that I keep far too many tabs open in my web browsers. Similarly I have vast numbers of bookmarks, mostly stored on [Pinboard][1] but also in [Read it Later][2]. In fact I rarely refer back to these, but that&#8217;s more because they&#8217;re so poorly organized and unwieldy to deal with; if I know more or less what I&#8217;m looking for, it&#8217;s faster to just do a fresh Google search. Why then store bookmarks at all, or even keep open tabs?

For me there are a couple of possible reasons:

*   **I&#8217;m afraid to forget about a given topic entirely**. This is certainly the case for news stories: if I mark an article as interesting based on the headline, I certainly wouldn&#8217;t remember and search for it later; the only way I might actually read it is if it goes on a &#8220;to read&#8221; list of some kind. But it also applies to tasks or mini-projects that manifest themselves as web browsing sessions, where an open tab might remind me: &#8220;oh yeah, I was browsing Amazon reviews of motion-sensitive LED lighting for closets, but I got distracted.&#8221; So my open tabs sometimes function as a sort of to-do list regarding projects in progress, which (if I&#8217;m not tracking them somewhere else) I might otherwise inadvertently drop.

*   If the cost of finding something was high (i.e., not the first Google hit on the most obvious query), then I want to **save the cost of recapitulating the search**. If the answer to my question was very hard to find the first time, I might even fear that I just wouldn&#8217;t find it at all if I had to try again from scratch.

*   Benefit of familiarity: even if a later search on a similar topic would turn up an equally informative page, **I&#8217;d prefer to return to a page that I&#8217;ve already seen**&#8211; it will be easier for me to navigate if it&#8217;s familiar.

*   Tree-like browsing. I often want to explore multiple links from a given page; if I just click on the first one, then obviously I&#8217;ll soon lose track of the other links that I intended to visit, and even the page that they were on. The simple &#8220;forward&#8221; and &#8220;back&#8221; navigation does not model the **naturally branching structure of browsing**. (I think I&#8217;ve seen some experimental browsers or [plugins][3] that tried to track this, but they were unwieldy; the SnapBack feature in Safari is an example that is now defunct because it was too confusing). For now I deal with this by opening a tab for every link I want to follow from a given page. Together with [Tree Style Tab][4], this works pretty well but leads to many open tabs.

There are a number of mechanisms that people use to keep track of interesting URLs: browser history (perhaps in multiple browsers, or on different machines), open tabs, saved tab sets/browser sessions, local bookmarks, social bookmarks, [Read it Later][2]/[Instapaper][5], starred items in Google Reader, RSS feeds, and so forth. Synchronization schemes do exist within and among some of these, but in general they are poorly interoperable. So the minute you use more than one of these mechanisms things become Confusing, and in practice it&#8217;s hard to avoid using at least three or four.

But all of these are special cases of a single idea: **keeping track of a URL**, possibly together with a bit of metadata, such as tags and date visited. Even an open tab is just a bookmark; the only difference is that it&#8217;s easy to return to with a single click, and it &#8220;loads&#8221; quickly. An item from an RSS feed is just a &#8220;bookmark&#8221; that has been never visited (and that has not even been accepted as interesting).

So, here I propose a new user interface for web browsing that unifies the disparate means of tracking, flagging, and tagging visited URLs. The goal is to just directly support the way humans actually use the web.

## One window to rule them all

Humans do not multitask; our attention falls on exactly one thing at a time (though we may switch rapidly among them). Thus the very idea of parallel, simultaneous tracks of attention is harmful to how we actually work. But this is exactly what tabs are: they represent the idea that a number of different web pages can somehow be simultaneously within our attentional scope. Since that is not the case, we should do away with browser tabs. **There shall be only one browser window**, showing the page that currently has our attention. That&#8217;s it.

[<img src="{{ site.baseurl }}/images/2012/04/TablessBrowser.png" alt="" title="TablessBrowser" width="1022" height="467" class="aligncenter size-full wp-image-105" />][6]

## Bookmarks and tabs are just flagged history items

As is already familiar, the browser keeps a history of each URL shown, together with the times when it was loaded. The functions previously served by tabs are better provided by the idea of flagging items in the browser history as &#8220;active&#8221;. Obviously a URL cannot be loaded in a tab if it is not also in the history, so in my current usage the fact that a tab is open is equivalent to &#8220;blessing&#8221; a history item with a flag meaning that it &#8220;deserves further consideration&#8221;.

Similarly, a bookmark is just an item that was previously visited&#8211;hence in the history&#8211;which has been flagged as &#8220;worth keeping track of&#8221;. It may additionally have tags associated with it, whether entered by hand or suggested by a social-bookmarking service.

## A user&#8217;s history is a single stream

When a user visits a page, that fact is immediately stored on a cloud service. The history is meant to represent the history of pages viewed by the user, regardless of in which browser or on which device. Metadata is synchronized too, of course, including the &#8220;active&#8221; and &#8220;bookmark&#8221; flags above.

## The history is always visible, but can be filtered and sorted

A list of history items is shown in a sidebar. It may be filtered to show only &#8220;active&#8221; items, or only bookmarks with a given tag or set of tags. It may be sorted by date, by priority, or by some sense of relevance (see below).

## Active history items are a todo list

To the extent that items flagged &#8220;active&#8221; in the history (the former tabs) are marked thus because they require attention, the set of these comprises a todo list. The task for each URL is to read the page and perhaps do something about it. Thus the history records may have appropriate metadata, such as deadlines (perhaps repeating, as in OmniFocus), priorities, and contexts (in the GTD sense).

Put differently: each history item may be given an urgency ranking, which is the same as a revisit start or stop date:

*   revisit never (abandon)
*   revisit sometime (interesting but not urgent)
*   revisit next week (interesting and somewhat time sensitive)
*   revisit now (remain active)

## History items are automatically tagged

Manual tagging of pages is too much work to be plausible for most people. So, items can be automatically tagged, by a number of possible mechanisms:

1.  Automatic acceptance of social-tagging suggestions.
2.  Context clues: which browser, which machine, time of day, location (when available).
3.  Markov tagging: especially when I follow a link from a given page (which has some tags), it&#8217;s likely that the next page should have the same tags. Similarly, when I look at two URLs close in time, they are likely to relate to the same tags. (That is: the Markov chains in question should operate both in the link-chain sense and in the chronological sense).
4.  Sticky tags: the user may type some tags (e.g., the name of a project that the current browsing session is about) that are automatically applied to every page.

Tags inferred by these various mechanisms are shown at the top of the browser window for every page, as soon as it is loaded. The user thus has an opportunity to edit them (with no extra clicks or navigation to a &#8220;tag edit&#8221; screen), but also can simply view and accept them by doing nothing.

## History results may be context-sensitive

One way to sort or filter the displayed history items is to consider the context of what the user is currently doing. This may be represented by the currently active sticky tags, as well as the same context clues above (device, browser, time, location). One might also consider clues from the currently viewed page (or the history of the 10 most recently viewed pages), such as tags, social tagging suggestions, the domain of the URL, word frequencies in the text, and inbound and outbound link structure (given Google-like data). The point of all this is to provide &#8220;related items&#8221; as one of the selectable views of the history.

## Topic modelling

The natural extension of the above is to run an off-the-shelf topic modelling tool such as [Mallet][7] on the full text of all history items. &#8220;Related items&#8221; might then include those pages with similar topic vectors. A newly visited URL can be classified into an existing topic model, and this can be used to suggest tags (not only those that others have used, but also those that this user has used for similar pages).

Better yet, a [Factorie][8]-based approach (presumably involving a fairly compute-intensive cloud service) could continuously refine the topics and tags, as the user visits and tags new pages. This mechanism would propagate suggested tags both among users and within a user (i.e., pages containing similar topics should have similar tags), and could take inferred tags and other metadata into account (though with a lower weight than manually-assigned tags).

Obviously topic-modelling the entire web would be a substantial undertaking; here the hope is that the document sets to be processed are much smaller&#8211;perhaps a few thousand per user, or tens of millions for a joint model among users, but not (yet) tens of billions.

It&#8217;s worth noting here that [DevonThink][9] does quite a good job of sorting documents into preexisting categories (provided that these contain enough examples already). It is not so good at generating the topics de novo, though.

## Semantic relationships among tags

&#8220;Folksonomies&#8221; deal poorly or not at all with synonyms, alternate spellings, and semantic relationships among tags (such as is-a and containment relations) that are the stuff of full-fledged ontologies. Here, we may learn relationships among tags, both per user and jointly, simply by their co-occurrence in tag lists (0th order) or by co-occurrence in sets of related documents (in a sense, topic modelling over the tag sets of document clusters). Thus a search for &#8220;cooking&#8221; may return results tagged &#8220;recipe&#8221;, through a mechanism that is entirely emergent from user data.

It may also be useful to allow users to specify some simple relationships, such as synonomy or containment; that way a user may tag something only &#8220;Scala&#8221; but then retrieve it in a search for &#8220;programming&#8221;.

## Diversity slider

A slider allows the user to select the &#8220;diversity&#8221; of the shown history items, from &#8220;same&#8221; to &#8220;different&#8221;. When &#8220;same&#8221; is selected, the results are what you would expect given the other filtering and sorting choices: the most recent pages, the most related pages, the best matches to a query, etc. But as the slider is moved towards &#8220;different&#8221;, and ever-broader selection of divergent pages (e.g. older, or poorer matches, etc.) is shown. Past a certain point, these are grouped and briefly summarized: e.g. by date or by topic. When documents are tagged or topic-modelled, the scope of the topics and possible containment relationships can be used to present an ever more diverse view. For instance, when viewing a recipe for chocolate cake, selecting &#8220;same&#8221; might produce alternate recipes for chocolate cake, and sliding towards &#8220;different&#8221; might give recipes for other chocolate desserts, then for desserts generally, and so forth.

Admittedly this feature needs a good deal more thought; the point is just to allow the user to &#8220;zoom out&#8221;&#8211;and then back in again&#8211;along whatever dimension is indicated by the other sorting & filtering choices: time, topical relatedness, etc.

## Bulk retagging UI

A substantial frustration with existing tagged-bookmark systems is that it can be surprisingly hard to manage tags in bulk: for instance, to select a large set of bookmarks and add a tag to all of them, or to remove a tag from a set, or to rename a tag. Fixing this requires two things: 1) a simple UI (for which the iTunes bulk metadata editor is a reasonable model) and 2) an underlying data representation that allows making such changes efficiently. One possible reason why the current state of affairs is so lame is that tags often seem to be stored in a fully denormalized manner, as text strings attached to each URL.

## Conclusion

A web browser taking this described approach is a form of intelligent assistant, explicitly helping the user to focus his or her attention on high-value information, while at the same time lending confidence that history is automatically captured and categorized. Such a browser is but one example of an &#8220;attention management&#8221; tool, of which others may apply similar principles to various tasks other than web browsing.

As with all of these [half-baked][10] ideas, please let me know if you&#8217;d like to help build it!

 [1]: http://pinboard.in
 [2]: http://www.readitlaterlist.com
 [3]: https://addons.mozilla.org/en-US/firefox/addon/session-history-tree
 [4]: https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/
 [5]: http://www.instapaper.com
 [6]: {{ site.baseurl }}/images/2012/04/TablessBrowser.png
 [7]: http://mallet.cs.umass.edu
 [8]: https://code.google.com/p/factorie/
 [9]: http://www.devontechnologies.com/products/devonthink/overview.html
 [10]: http://dev.davidsoergel.com/half-baked/
