From: "Daniel Merrill" <daniel.merrill@psware.com>
References: <efafe9af.0000172c.00000011@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<52558563.2010408@xenomai.org>	<8fed609f.0000172c.00000017@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<525587A2.5000507@xenomai.org>
 <73cb019f.0000172c.0000001c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <8a1928a6.00000970.00000009@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <1aa47ae4.00001700.00000005@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <526681B9.1010302@xenomai.org> <5266907C.4010905@xenomai.org>
 <5266AD85.2040201@xenomai.org>
 <3f032cae.00001700.0000001c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <526807D4.9030405@xenomai.org>
 <d73ca437.00001700.00000035@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <5268F068.7000201@xenomai.org>
In-Reply-To: <5268F068.7000201@xenomai.org>
Date: Thu, 24 Oct 2013 11:24:15 -0700 (MST)
Message-ID: <b4532001.00001700.0000005e@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
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
> - Do you handle SIG32 specifically in GDB, so that the
> latter does not intercept the signal? If not, could you check whether
> this makes any difference? (i.e. "handle SIG32 nostop noprint pass")
>
> - Could you apply the patch below, keeping the previous one in?
> We should be sending back -ERESTARTSYS to the kernel when the
> issue happens, and this behaves as if the Xenomai core did
> not.
>

New log with new gdb output with patch applied

Oct 24 11:16:19 JETSdev kernel: [  127.043727] t_suspend: self-suspend 
SUB1[2280], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.043735] t_suspend: self-suspend 
SUB2[2281], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.043754] t_suspend: self-suspend 
SUB3[2282], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.054237] t_suspend: unblocked 
SUB3[2282], sigpending=1, state=0x302180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.054239]    => SIG19 pending
Oct 24 11:16:19 JETSdev kernel: [  127.054240] request_syscall_restart[hi]: 
SUB3, state=0x302180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.054251] t_suspend: unblocked 
SUB2[2281], sigpending=1, state=0x302180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.054251]    => SIG19 pending
Oct 24 11:16:19 JETSdev kernel: [  127.054252] request_syscall_restart[hi]: 
SUB2, state=0x302180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.054261] request_syscall_restart[lo]: 
CONT, state=0x302180, info=0xc, rval=-4, sysflags=0x6
Oct 24 11:16:19 JETSdev kernel: [  127.054269] request_syscall_restart[lo]: 
MAIN, state=0xb02180, info=0xc, rval=-4, sysflags=0x6
Oct 24 11:16:19 JETSdev kernel: [  127.055902] t_suspend: self-suspend 
SUB3[2282], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.055910] t_suspend: self-suspend 
SUB2[2281], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.055928] t_suspend: self-suspend 
SUB1[2280], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.060439] t_suspend: unblocked 
SUB3[2282], sigpending=1, state=0x302180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.060441]    => SIG19 pending
Oct 24 11:16:19 JETSdev kernel: [  127.060442] request_syscall_restart[lo]: 
SUB3, state=0x302180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.060453] t_suspend: unblocked 
SUB2[2281], sigpending=1, state=0x302180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.060454]    => SIG19 pending
Oct 24 11:16:19 JETSdev kernel: [  127.060455] request_syscall_restart[lo]: 
SUB2, state=0x302180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.060464] t_suspend: unblocked 
SUB1[2280], sigpending=1, state=0x302180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.060465]    => SIG19 pending
Oct 24 11:16:19 JETSdev kernel: [  127.060466] request_syscall_restart[lo]: 
SUB1, state=0x302180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.060477] request_syscall_restart[lo]: 
MAIN, state=0xb02180, info=0xc, rval=-4, sysflags=0x6
Oct 24 11:16:19 JETSdev kernel: [  127.060935] t_suspend: self-suspend 
SUB3[2282], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.060943] t_suspend: self-suspend 
SUB2[2281], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.060950] t_suspend: self-suspend 
SUB1[2280], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.061060] t_suspend: unblocked 
SUB3[2282], sigpending=1, state=0x302180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.061061]    => SIG19 pending
Oct 24 11:16:19 JETSdev kernel: [  127.061062] request_syscall_restart[lo]: 
SUB3, state=0x302180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.061070] t_suspend: unblocked 
SUB2[2281], sigpending=1, state=0x302180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.061071]    => SIG19 pending
Oct 24 11:16:19 JETSdev kernel: [  127.061072] request_syscall_restart[lo]: 
SUB2, state=0x302180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.061079] t_suspend: unblocked 
SUB1[2280], sigpending=1, state=0x302180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.061080]    => SIG19 pending
Oct 24 11:16:19 JETSdev kernel: [  127.061081] request_syscall_restart[lo]: 
SUB1, state=0x302180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.061089] request_syscall_restart[lo]: 
MAIN, state=0xb02180, info=0xc, rval=-4, sysflags=0x6
Oct 24 11:16:19 JETSdev kernel: [  127.062059] t_suspend: self-suspend 
SUB3[2282], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.062068] t_suspend: self-suspend 
SUB2[2281], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.062074] t_suspend: self-suspend 
SUB1[2280], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.062116] t_suspend: unblocked 
SUB1[2280], sigpending=1, state=0x300180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.062117]    => SIG32 pending
Oct 24 11:16:19 JETSdev kernel: [  127.062117] request_syscall_restart[lo]: 
SUB1, state=0x300180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.062385] t_suspend: unblocked 
SUB3[2282], sigpending=1, state=0x302180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.062386]    => SIG19 pending
Oct 24 11:16:19 JETSdev kernel: [  127.062387] request_syscall_restart[lo]: 
SUB3, state=0x302180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.062396] request_syscall_restart[lo]: 
CONT, state=0x302180, info=0xc, rval=-4, sysflags=0x6
Oct 24 11:16:19 JETSdev kernel: [  127.062404] request_syscall_restart[lo]: 
MAIN, state=0xb02180, info=0xc, rval=-4, sysflags=0x6
Oct 24 11:16:19 JETSdev kernel: [  127.063467] t_suspend: self-suspend 
SUB3[2282], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.063482] t_suspend: self-suspend 
SUB2[2281], sigpending=0, state=0x300180, info=0x0
Oct 24 11:16:19 JETSdev kernel: [  127.068227] t_suspend: unblocked 
SUB2[2281], sigpending=1, state=0x300180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.068228]    => SIG32 pending
Oct 24 11:16:19 JETSdev kernel: [  127.068229] request_syscall_restart[lo]: 
SUB2, state=0x300180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.068292] t_suspend: unblocked 
SUB3[2282], sigpending=1, state=0x302180, info=0xc
Oct 24 11:16:19 JETSdev kernel: [  127.068293]    => SIG19 pending
Oct 24 11:16:19 JETSdev kernel: [  127.068294] request_syscall_restart[lo]: 
SUB3, state=0x302180, info=0xc, rval=-4, sysflags=0x22
Oct 24 11:16:19 JETSdev kernel: [  127.068310] request_syscall_restart[lo]: 
MAIN, state=0xb02180, info=0xc, rval=-4, sysflags=0x6
Oct 24 11:16:19 JETSdev kernel: [  127.068562] t_suspend: self-suspend 
SUB3[2282], sigpending=0, state=0x300180, info=0x0


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
[New Thread 0xb7fd3b40 (LWP 2279)]
[New Thread 0xb7fceb40 (LWP 2280)]
[New Thread 0xb7deab40 (LWP 2281)]
[New Thread 0xb7de5b40 (LWP 2282)]
SUB1 TID:4
subTask1, suspend returned 0
[Switching to Thread 0xb7fceb40 (LWP 2280)]

Breakpoint 3, subTask1 () at test.c:50
50		retValue = t_suspend(0);
SUB2 TID:5
subTask2, suspend returned 0
[Switching to Thread 0xb7deab40 (LWP 2281)]

Breakpoint 2, subTask2 () at test.c:35
35		retValue = t_suspend(0);
subTask1, suspend returned -4
[Thread 0xb7deab40 (LWP 2281) exited]


