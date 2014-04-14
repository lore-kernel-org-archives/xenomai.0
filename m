Message-ID: <1397454499.3064.6.camel@localhost.localdomain>
From: Peter Howard <pjh@northern-ridge.com.au>
Date: Mon, 14 Apr 2014 15:48:19 +1000
In-Reply-To: <1397451751.3064.4.camel@localhost.localdomain>
References: <534534FD.5090805@xenomai.org>
 <1397113300.2720.5.camel@localhost.localdomain>
 <5346895B.6080401@xenomai.org>
 <1397159850.2881.3.camel@localhost.localdomain>
 <53471389.6000000@xenomai.org>
 <1397168263.6356.11.camel@localhost.localdomain>
 <534719F5.2020605@xenomai.org>
 <1397170912.6356.19.camel@localhost.localdomain>
 <20140411154630.GE17765@csclub.uwaterloo.ca>
 <1397435281.3064.1.camel@localhost.localdomain>
 <20140414011032.GG17765@csclub.uwaterloo.ca>
 <1397451751.3064.4.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] OMAP L138
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Mon, 2014-04-14 at 15:02 +1000, Peter Howard wrote:

> 
> The 3.11 git branch displays the same behavior as master, and on the
> 3.12 and 3.14 branches (and, presumably the 3.13 branch too) the kernel
> no longer detects the SD card (driver _is_ enabled).  Not sure where the
> bug appears, but it's one bug too many for the moment.
> 

I take it back; after my frustration levels returned to "acceptable",
git bisect found the offending commit in ~30 minute :-)  Once I've
resolved it fully I'll report properly on 3.12 and later.


-- 
Peter Howard <pjh@northern-ridge.com.au>


