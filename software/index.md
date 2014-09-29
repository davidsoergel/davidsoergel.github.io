---
title: Software
author: David Soergel
layout: page
---
Welcome! This is the home for various of my development projects, all written in Java unless otherwise noted. Forums, issue trackers, downloads, and documentation can be found within each project.

In many cases the documentation is incomplete; please [let me know][1] if there&#8217;s something you&#8217;d like documentation about, in which case I&#8217;ll try to write it asap.

In addition to the project-specific sites linked below, there is [aggregated API documentation][2] for all Java projects, a [build server][3] for all Java projects, and a [Maven2 repository][4] containing both releases and snapshots.

<table cellspacing="10">
  <tr>
    <td colspan="2">
      <h2>
        Stand-alone projects
      </h2>
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="s3napback" href="trac/s3napback/">s3napback</a>
    </td>
    
    <td valign="top">
      Cycling, incremental, compressed, encrypted backups to Amazon S3.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="RTAX" href="trac/rtax/">RTAX</a>
    </td>
    
    <td valign="top">
      Rapid and accurate taxonomic classification of short paired-end sequence reads from the 16S ribosomal RNA gene.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="featuretools" href="trac/featuretools/">featuretools</a>
    </td>
    
    <td valign="top">
      A perl package for dealing with sequence annotations. In particular, includes featuregrep, a program which searches sequences, together with associated DAS files or feature databases, for patterns. Uses an extended regular expression syntax to specify annotations as part of the search pattern (in addition to the sequence characters themselves).
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="Jandy" href="trac/jandy/">Jandy</a>
    </td>
    
    <td valign="top">
      Jandy is a program for managing multiple runs of scientific software. It facilitates running a program a number of times, perhaps with different combinations of input parameters, and keeps track of the outputs produced from each run in a database. Runs may be computed in parallel on a cluster. Jandy can produce some plots from the collection of inputs and outputs.
    </td>
    
    <td>
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="MSENSR" href="trac/msensr/">MSENSR</a>
    </td>
    
    <td valign="top">
      Microbe Statistics from Environmental Nucleotide Sequence Reads. Computes various statistics from collections of nucleotide sequences, in hopes of discovering correlations between sequence statistics, phylogeny, and community composition. Also, generates simulated metagenomic data sets.
    </td>
    
    <td valign="top">
    </td>
  </tr>
  
  <tr>
    <td colspan="2">
      <h2>
        Science packages
      </h2>
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="phyloutils" href="trac/phyloutils/">phyloutils</a>
    </td>
    
    <td valign="top">
      Provides data structures for weighted phylogenetic trees, and various operations on such trees. Includes phylogenetic alpha and beta diversity measures such as Weighted UniFrac. Also, computes phylogenetic distances between species based on the Ciccarelli et. al. 2006 tree of life.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="ncbitaxonomy" href="trac/ncbitaxonomy/">ncbitaxonomy</a>
    </td>
    
    <td valign="top">
      Provides a Hibernate-based object-relational interface to the NCBI taxonomy database, and convenience classes for navigating it.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="sequtils" href="trac/sequtils/">sequtils</a>
    </td>
    
    <td valign="top">
      Utility classes for dealing with biological sequences.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="stats" href="trac/stats/">stats</a>
    </td>
    
    <td valign="top">
      Some basic data structures and distributions for statistical computations.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="ml" href="trac/ml/">ml</a>
    </td>
    
    <td valign="top">
      Generic machine learning package. Provides a framework for supervised and unsupervised clustering (both online and batch), and currently implements naive Bayesian, k-NN, K-means, and Kohonen SOM clustering. Computes Variable Memory Markov models (aka PSTs) on strings. Also, implements various Monte Carlo methods (including Metropolis-coupled MCMC).
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="jlibsvm" href="trac/jlibsvm/">jlibsvm</a>
    </td>
    
    <td valign="top">
      Heavily refactored Java port of <a href="http://www.csie.ntu.edu.tw/~cjlin/libsvm/">LIBSVM</a>, providing efficient training of Support Vector Machines. Provides many new features, including a fully generified API; the ability to add custom kernels for arbitrary data types; and integrated scaling and normalization.
    </td>
  </tr>
  
  <tr>
    <td colspan="2">
      <h2>
        Utilities packages
      </h2>
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="conja" href="trac/conja/">conja</a>
    </td>
    
    <td valign="top">
      Incredibly easy functional concurrency in Java. Conja lets your code take advantage of multicore processors with no configuration and minimal code changes. It basically wraps java.utils.concurrent in syntactic sugar that encourages a functional style.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="dsutils" href="trac/dsutils/">dsutils</a>
    </td>
    
    <td valign="top">
      Provides various general utility classes. Some of these have slowly been replaced over the years by new features in the JDK and by the Apache Commons packages.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="runutils" href="trac/runutils/">runutils</a>
    </td>
    
    <td valign="top">
      Provides standard APIs and utility classes having to do with managing program runs and threads. Provides annotation-based runtime injection of configuration parameters into objects. Provides a framework for queueing tasks to be performed in separate threads (possibly obsoleted by similar functionality in java.util.concurrent).
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="chartutils" href="trac/chartutils/">chartutils</a>
    </td>
    
    <td valign="top">
      Convenience classes for generating plots with the JFreeChart package.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="springjpautils" href="trac/springjpautils/">springjpautils</a>
    </td>
    
    <td valign="top">
      Base classes for using JPA with Spring and Hibernate.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="event" href="trac/event/">event</a>
    </td>
    
    <td valign="top">
      A notification framework for event-driven programs, especially useful for Swing GUIs. Provides an event broker that distributes events around a network of sources, relays, and listeners. Facilitates live updating of disparate components in an application whose relationships with each other are dynamic. Does not replace, but rather complements, methods of dealing with low-level events such as mouse clicks (e.g., the XML Actions framework). Provides a higher layer of events with semantic meaning to the application.
    </td>
  </tr>
  
  <tr>
    <td colspan="2">
      <h2>
        Infrastructure
      </h2>
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="devenvironment" href="trac/devenvironment/">devenvironment</a>
    </td>
    
    <td valign="top">
      Summary of how my development environment works, including IDE, build tools, documentation generation, and so forth.
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="svnnotebook" href="trac/svnnotebook/">svnnotebook</a>
    </td>
    
    <td valign="top">
      Facilitates storing notebooks intermingled with project files in Subversion repositories. Extracts changes for a given time range from the repositories and formats them nicely, i.e. for weekly reporting. Builds browseable web sites of all formatted notebooks, organized by both topic and date. Supports Markdown syntax.
    </td>
  </tr>
  
  <tr>
    <td colspan="2">
      <h2>
        Older projects
      </h2>
    </td>
  </tr>
  
  <tr>
    <td valign="top">
      <a title="pdftank" href="trac/pdftank/">pdftank</a>
    </td>
    
    <td valign="top">
      Automatically navigate journal web sites to download and cache full-text PDFs.
    </td>
  </tr>
</table>

 [1]: mailto:dev@davidsoergel.com
 [2]: apidocs "API Documentation"
 [3]: jenkins/ "Build Server"
 [4]: http://dev.davidsoergel.com/nexus
