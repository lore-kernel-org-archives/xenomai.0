From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Mar 2014 18:04:21 -0400
Message-ID: <20140331220421.GZ17765@csclub.uwaterloo.ca>
References: <20140331193742.GS17765@csclub.uwaterloo.ca>
 <5339C5AC.4040409@xenomai.org>
 <20140331204257.GT17765@csclub.uwaterloo.ca>
 <20140331205339.GU17765@csclub.uwaterloo.ca>
 <20140331205710.GV17765@csclub.uwaterloo.ca>
 <5339D8EB.3030702@xenomai.org>
 <20140331212534.GW17765@csclub.uwaterloo.ca>
 <5339E2CE.7060703@xenomai.org>
 <20140331215348.GX17765@csclub.uwaterloo.ca>
 <20140331215933.GY17765@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140331215933.GY17765@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Mar 31, 2014 at 05:59:33PM -0400, Lennart Sorensen wrote:
> On Mon, Mar 31, 2014 at 05:53:48PM -0400, Lennart Sorensen wrote:
> > I am using the xenomai-2.6 git tree (current commit I see is as HEAD is
> > 4081e1b032329bf0cc9442f466233d5fc1083fc5).
> > 
> > Doing a git pull I see I am 4 commits behind, and one does sound
> > interesting.  I will have to update that.
> 
> Hmm, the interesting patch does the same thing I already did myself to
> get it to compile.  I guess that is OK then.

Hmm, gdb is being not helpful at all:

root@omap5:/mnt/xenomai-2.6.3# gdb /usr/lib/xenomai/testsuite/latency 
GNU gdb (GDB) 7.4.1-debian
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-linux-gnueabihf".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /usr/lib/xenomai/testsuite/latency...done.
(gdb) run
Starting program: /usr/lib/xenomai/testsuite/latency 
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/arm-linux-gnueabihf/libthread_db.so.1".
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
[New Thread 0xb6e15470 (LWP 32035)]
[New Thread 0xb6e0d470 (LWP 32036)]
warming up...

Program received signal SIGILL, Illegal instruction.
[Switching to Thread 0xb6e0d470 (LWP 32036)]
0xffff0f04 in ?? ()
(gdb) where
#0  0xffff0f04 in ?? ()
Cannot access memory at address 0x3e0
(gdb) list
Cannot access memory at address 0x3e0
(gdb) 

-- 
Len Sorensen

