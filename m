From: "Daniel Merrill" <daniel.merrill@psware.com>
References: <efafe9af.0000172c.00000011@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<52558563.2010408@xenomai.org>	<8fed609f.0000172c.00000017@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<525587A2.5000507@xenomai.org>
 <73cb019f.0000172c.0000001c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <8a1928a6.00000970.00000009@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <1aa47ae4.00001700.00000005@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <526681B9.1010302@xenomai.org> <5266907C.4010905@xenomai.org>
 <5266AD85.2040201@xenomai.org>
 <3f032cae.00001700.0000001c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <526807D4.9030405@xenomai.org>
In-Reply-To: <526807D4.9030405@xenomai.org>
Date: Wed, 23 Oct 2013 16:11:30 -0700 (MST)
Message-ID: <d73ca437.00001700.00000035@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Xenomai] t_suspend and XNBREAK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Philippe Gerum' <rpm@xenomai.org>, 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

>
> Ok, I can't reproduce with this code yet. Let's proceed differently.
> Could you apply the patch below, then send back the kernel output
> you should get when the issue happens? The traces are emitted only when
> a task self-suspends using a null tid, which should restrict the scope
> enough to avoid extraneous messages. I'd be interested in the gdb output
> you get as well when running over gdb into this issue (i.e. which 
> t_suspend()
> call fails with -EINTR in this case - lineno?).
>
> In the meantime, you may also try switching temporarily to 2.6.3,
> just for testing. It is 100% ABI and API compatible with 2.6.2.1,
> you would only need to recompile your app, nothing more. You don't
> have to switch i-pipe support for doing this. We fixed a
> couple of issues in the 2.6.3 time frame wrt GDB support. Although
> I don't see a direct relationship between your issue and what we fixed,
> it makes sense to do a quick check anyway.
>
> TIA,
> --
> Philippe.

Ok, here is the log output, plus the gdb output run on 2.6.3

Oct 23 16:05:55 JETSdev kernel: [ 7013.901317] t_suspend: self-suspend 
SUB1[1387], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.901324] t_suspend: self-suspend 
SUB2[1388], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.901344] t_suspend: self-suspend 
SUB3[1389], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.906328] t_suspend: unblocked 
SUB3[1389], sigpending=1, state=0x302180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.906330]    => SIG19 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.906339] t_suspend: unblocked 
SUB2[1388], sigpending=1, state=0x302180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.906340]    => SIG19 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.907202] t_suspend: self-suspend 
SUB3[1389], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.907210] t_suspend: self-suspend 
SUB2[1388], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.907223] t_suspend: self-suspend 
SUB1[1387], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.912273] t_suspend: unblocked 
SUB3[1389], sigpending=1, state=0x302180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.912274]    => SIG19 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.912282] t_suspend: unblocked 
SUB2[1388], sigpending=1, state=0x302180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.912283]    => SIG19 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.912290] t_suspend: unblocked 
SUB1[1387], sigpending=1, state=0x302180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.912291]    => SIG19 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.912694] t_suspend: self-suspend 
SUB3[1389], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.912701] t_suspend: self-suspend 
SUB2[1388], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.912707] t_suspend: self-suspend 
SUB1[1387], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.912783] t_suspend: unblocked 
SUB3[1389], sigpending=1, state=0x302180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.912784]    => SIG19 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.912792] t_suspend: unblocked 
SUB2[1388], sigpending=1, state=0x302180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.912792]    => SIG19 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.912799] t_suspend: unblocked 
SUB1[1387], sigpending=1, state=0x302180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.912800]    => SIG19 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.914466] t_suspend: self-suspend 
SUB3[1389], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.914474] t_suspend: self-suspend 
SUB2[1388], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.914480] t_suspend: self-suspend 
SUB1[1387], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.914515] t_suspend: unblocked 
SUB1[1387], sigpending=1, state=0x300180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.914516]    => SIG32 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.914751] t_suspend: unblocked 
SUB3[1389], sigpending=1, state=0x302180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.914752]    => SIG19 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.915840] t_suspend: self-suspend 
SUB3[1389], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.915858] t_suspend: self-suspend 
SUB2[1388], sigpending=0, state=0x300180, info=0x0
Oct 23 16:05:55 JETSdev kernel: [ 7013.920201] t_suspend: unblocked 
SUB2[1388], sigpending=1, state=0x300180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.920203]    => SIG32 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.922922] t_suspend: unblocked 
SUB3[1389], sigpending=1, state=0x302180, info=0xc
Oct 23 16:05:55 JETSdev kernel: [ 7013.922924]    => SIG19 pending
Oct 23 16:05:55 JETSdev kernel: [ 7013.923319] t_suspend: self-suspend 
SUB3[1389], sigpending=0, state=0x300180, info=0x0

jets@JETSdev:~/projects/tdelete_fail_test$ gdb test
GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2.1) 7.4-2012.04
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later 
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-linux-gnu".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /home/jets/projects/tdelete_fail_test/test...done.
Breakpoint 1 at 0x80486fa: file test.c, line 20.
Breakpoint 2 at 0x8048765: file test.c, line 35.
Breakpoint 3 at 0x80487d0: file test.c, line 50.
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/i386-linux-gnu/libthread_db.so.1".
[New Thread 0xb7fd3b40 (LWP 1386)]
[New Thread 0xb7fceb40 (LWP 1387)]
[New Thread 0xb7deab40 (LWP 1388)]
[New Thread 0xb7de5b40 (LWP 1389)]
SUB1 TID:124
subTask1, suspend returned 0
[Switching to Thread 0xb7fceb40 (LWP 1387)]

Breakpoint 3, subTask1 () at test.c:50
50		retValue = t_suspend(0);
SUB2 TID:125
subTask2, suspend returned 0
[Switching to Thread 0xb7deab40 (LWP 1388)]

Breakpoint 2, subTask2 () at test.c:35
35		retValue = t_suspend(0);
subTask1, suspend returned -4
[Thread 0xb7deab40 (LWP 1388) exited]

It hangs after subTask1 fails to suspend because subTask1 starts misbehaving 
at that point and never gives up time.

Anyway hopefully this starts to lead us down the right path. Thanks

Dan Merrill


