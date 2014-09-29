---
title: 's3napback: Cycling, Incremental, Compressed, Encrypted Backups to Amazon S3'
author: David Soergel
layout: post
permalink: /2008/05/07/s3napback-cycling-incremental-compressed-encrypted-backups-to-amazon-s3/
categories:
  - Sysadmin
---
## The problem

In searching for a way to back up one of my Linux boxes to Amazon S3, I was surprised to find that none of the many backup methods and scripts I found on the net did what I wanted, so [I wrote yet another one][1].

<!--more-->

The design requirements were:

*   Occasional full backups, and daily incremental backups
*   Stream data to S3, rather than making a local temp file first (i.e., if I want to archive all of /home at once, there&#8217;s no point in making huge local tarball, doing lots of disk access in the process)
*   Break up large archives into manageable chunks
*   Encryption

As far as I could tell, no available backup script (including, e.g. s3sync, backup-manager, s3backup, etc. etc.) met all four requirements.

The closest thing is [js3tream][2], which handles streaming and splitting, but not incrementalness or encryption. Those are both fairly easy to add, though, using tar and gpg, as [suggested][3] by the js3tream author. However, the s3backup.sh script he provides uses temp files (unnecessarily), and does not encrypt. So I modified it a bit to produce [s3backup-gpg-streaming.sh][4].

That&#8217;s not the end of the story, though, since it leaves open the problem of managing the backup rotation. I found the explicit cron jobs suggested on the js3tream site too messy, especially since I sometimes want to back up a lot of different directories. Some other available solutions will send incremental backups to S3, but never purge the old ones, and so use ever more storage.

Finally, I wanted to easily deal with MySQL and Subversion dumps.

## The solution

I wrote s3napback, which wraps js3tream and solves all of the above issues by providing:

*   Dead-simple configuration
*   Automatic rotation of backup sets
*   Alternation of full and incremental backups (using &#8220;tar -g&#8221;)
*   Integrated GPG encryption
*   No temporary files used anywhere, only pipes and TCP streams (optionally, uses smallish temp files to save memory)
*   Integrated handling of MySQL dumps
*   Integrated handling of Subversion repositories, and of directories containing multiple Subversion repositories.

It&#8217;s not rocket science, just a wrapper that makes things a bit easier.

Check out the [project page][1] for more info and to download it!

 [1]: http://dev.davidsoergel.com/trac/s3napback/
 [2]: http://js3tream.sourceforge.net
 [3]: http://js3tream.sourceforge.net/linux_tar.html
 [4]: http://dev.davidsoergel.com/trac/s3napback/browser/trunk/s3backup-gpg-streaming.sh