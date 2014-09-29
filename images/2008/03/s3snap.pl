#!/usr/bin/perl

# s3snap.pl
# Manage cycling, incremental, compressed, encrypted backups on Amazon S3.
#
# Copyright (c) 2001-2007 David Soergel
# 418 Richmond St., El Cerrito, CA  94530
# david@davidsoergel.com
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the author nor the names of any contributors may
#       be used to endorse or promote products derived from this software
#       without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


use strict;
use File::stat;

my $diffdir;
my $bucket; 
my $recipient;
my $encrypt;
my $delete_from_s3;
my $send_to_s3;

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
print "\n\n\n";
print "------------------------------------------------------------------\n";
print "Starting s3snap  $mday/$mon/$year   $hour:$min\n\n";

for(<STDIN>)
	{
	if(/^\s*#/) { next; }
	if(/^\s*$/) { next; }
	
	my ($type, $name, $skips, $diffs, $fulls) = split;
	print "($type, $name, $skips, $diffs, $fulls)\n";
	if($type eq "DiffDir")
		{
		$diffdir = $name;
		}
	elsif($type eq "Bucket")
		{
		$bucket = $name;
		}
	elsif($type eq "GpgRecipient")
		{
		$recipient = $name;
		$encrypt="gpg -r $recipient -e";
		}
	elsif($type eq "S3Keyfile")
		{
		$send_to_s3="java -Xmx128M -jar js3tream.jar --debug -z 25000000 -n -v -K $name -i -b";
		$delete_from_s3="java -jar js3tream.jar -v -K $name -d -b";
		}
	elsif($type eq "Directory")
		{
		if($yday % $skips != 0)
			{
			print "Skipping $name\n";
			next;
			}
			
		my $difffile = $diffdir . $name . ".diff";
		
	    	my $sb = stat($difffile);
	 	if(defined $sb)
			{	
			my ($sec,$min,$hour,$mday,$mon,$year,$wday,$diffyday,$isdst) = localtime($sb->mtime);
		
			if ( $diffyday == $yday )
				{
				print "Skipping $name; diff was already performed today\n";
				next;
				}
			}
			
		my $cycles = $fulls * $diffs;
		my $cyclenum = ($yday / $skips) % $cycles;
		
		my $type = "DIFF";

		if($cyclenum % $fulls == 0)
			{
			$type = "FULL";
			unlink $difffile;
			}
		
		my $datasource = "tar -g $difffile -C / -czp $name";
		my $bucketfullpath = "$bucket:$name-$cyclenum-$type";
	
		print "Directory $name -> $bucketfullpath\n";
		sendToS3($datasource, $bucketfullpath);
		}
	elsif ($type eq "MySQL")
		{
		if($yday % $skips != 0)
			{
			print "Skipping $name\n";
			next;
			}
		
		my $cycles = $fulls;
		my $cyclenum = ($yday / $skips) % $cycles;
		
		my $bucketfullpath = "$bucket:MySQL/$name-$cyclenum";
		print "MySQL $name -> $bucketfullpath\n";
		
		if($name eq "all") { $name = "--all-databases"; }
		my $datasource = "mysqldump --opt $name";
		sendToS3($datasource, $bucketfullpath);
		}
	elsif ($type eq "Subversion")
		{
		if($yday % $skips != 0)
			{
			print "Skipping $name\n";
			next;
			}
		
		my $cycles = $fulls;
		my $cyclenum = ($yday / $skips) % $cycles;
		
		my $datasource = "svnadmin -q dump $name";
		my $bucketfullpath = "$bucket:$name-$cyclenum";
		
		print "Subversion $name -> $bucketfullpath\n";
		sendToS3($datasource, $bucketfullpath);
		}	
	elsif ($type eq "SubversionDir")
		{
		if($yday % $skips != 0)
			{
			print "Skipping $name\n";
			next;
			}
		
		# inspired by https://popov-cs.grid.cf.ac.uk/subversion/WeSC/scripts/svn_backup
		
		my $cycles = $fulls;
		my $cyclenum = ($yday / $skips) % $cycles;
		
		opendir(DIR, $name);
		my @subdirs = readdir(DIR);
		closedir(DIR);

		foreach my $subdir (@subdirs) 
			{	
			`svnadmin verify $name/$subdir >& /dev/null`;
			if ($? == 0 )
				{
				my $datasource = "svnadmin -q dump $name/$subdir";
				my $bucketfullpath = "$bucket:$name/$subdir-$cyclenum";
				
				print "Subversion $name/$subdir -> $bucketfullpath\n";
				sendToS3($datasource, $bucketfullpath);
				}
			}
		}
	
	}

sub sendToS3
	{
	my ($datasource,$bucketfullpath) = @_;
	
	# delete the bucket if it exists
	`$delete_from_s3 $bucketfullpath`;
	
	# stream the data
	`$datasource | $encrypt | $send_to_s3 $bucketfullpath`;
	}

