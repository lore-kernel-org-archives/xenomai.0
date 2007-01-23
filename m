From: Jeff Weber <jweber@domain.hid>
Date: Tue, 23 Jan 2007 14:48:35 -0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701231448.35285.jweber@domain.hid>
Subject: [Xenomai-help] isolating unwanted mode switch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai Help <xenomai@xenomai.org>

Greetings,

I have a multi-threaded C++ realtime application that is encountering an unwanted switch to secondary mode.
To isolate the mode switch, I've enabled enabled the task mode T_WARNSW to deliver the signal SIGXCPU.
gdb shows me where the SIGXCPU signal was delivered to the real time thread, presumably upon the
transition from primary to secondary mode:

Here's the backtrace of the core file:

0  0x080eb5ce in AMSC::CSeqMeas::input (this=0x81af900, dat=0xb642cccc, 
    tm=@0x81b1ac0) at prj/src/amscseqmeas.cpp:1656
(gdb) bt
#0  0x080eb5ce in AMSC::CSeqMeas::input (this=0x81af900, dat=0xb642cccc, tm=@0x81b1ac0) at prj/src/amscseqmeas.cpp:1656
#1  0x080de1cd in fastdelegate::FastDelegate2<unsigned short*, RtTime const&, void>::operator() (this=0x8253330, p1=0xb642cccc, p2=@0x81b1ac0) at prj/src/fastdelegate.h:1076
#2  0x080dc1f6 in AMSC::CRtA2dHdlr::hsThreadwIrqFnc (this=0x81b1b20) at prj/src/amsca2d.cpp:669
#3  0x080ba3ef in fastdelegate::FastDelegate0<void>::operator() (this=0x81b1b58) at prj/src/fastdelegate.h:906
#4  0x080c22c3 in AMSC::CRtThread::starter (arg=0x81b1b28) at prj/src/amscthread.h:444
#5  0xb7eb944e in rt_task_trampoline (cookie=0x81b1b28) at /usr/src/xenomai-2.2.4/src/skins/native/task.c:89
#6  0xb7f1234b in start_thread () from /lib/libpthread.so.0
#7  0xb7d4165e in clone () from /lib/libc.so.6

Here's source code (x86 assembly view) of frame #0 near the SIGXCPU delivery point:
Dump of assembler code from 0x80eb5a4 to 0x80eb6a4:
    0x080eb5a4 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+232>:   mov    0x8(%ebp),%eax
    0x080eb5a7 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+235>:   mov    0x71c(%eax),%ecx
    0x080eb5ad <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+241>:   mov    0x8(%ebp),%eax
    0x080eb5b0 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+244>:   mov    0x720(%eax),%eax
    0x080eb5b6 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+250>:   mov    %eax,%edx
    0x080eb5b8 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+252>:   mov    %edx,%eax
    0x080eb5ba <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+254>:   shl    $0x2,%eax
    0x080eb5bd <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+257>:   add    %edx,%eax
    0x080eb5bf <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+259>:   shl    $0x2,%eax
    0x080eb5c2 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+262>:   add    %eax,%ecx
    0x080eb5c4 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+264>:   mov    0x10(%ebp),%eax
    0x080eb5c7 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+267>:   mov    0x4(%eax),%edx
    0x080eb5ca <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+270>:   mov    (%eax),%eax
    0x080eb5cc <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+272>:   mov    %eax,(%ecx)
    0x080eb5ce <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+274>:   mov    %edx,0x4(%ecx)  <-frame pointer here
    0x080eb5d1 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+277>:   mov    0x8(%ebp),%eax
    0x080eb5d4 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+280>:   mov    0x71c(%eax),%ecx
    0x080eb5da <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+286>:   mov    0x8(%ebp),%eax
    0x080eb5dd <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+289>:   mov    0x720(%eax),%eax
    0x080eb5e3 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+295>:   mov    %eax,%edx
    0x080eb5e5 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+297>:   mov    %edx,%eax
    0x080eb5e7 <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+299>:   shl    $0x2,%eax
    0x080eb5ea <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+302>:   add    %edx,%eax
    0x080eb5ec <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+304>:   shl    $0x2,%eax
    0x080eb5ef <_ZN4AMSC8CSeqMeas5inputEPtRK6RtTime+307>:   lea    (%ecx,%eax,1),%ebx

Hmmm.  I expected to see a system call at or near the signal receipt point.  To confirm, I coded up
a quick test case that called printf() from a realtime thread in primary mode, with T_WARNSW enabled.
Sure enough, the signalled fram from the simple test case looks as suspected:
Dump of assembler code for function __kernel_vsyscall:
    0xffffe400 <__kernel_vsyscall+0>:       push   %ecx
    0xffffe401 <__kernel_vsyscall+1>:       push   %edx
    0xffffe402 <__kernel_vsyscall+2>:       push   %ebp
    0xffffe403 <__kernel_vsyscall+3>:       mov    %esp,%ebp
    0xffffe405 <__kernel_vsyscall+5>:       sysenter 
    0xffffe407 <__kernel_vsyscall+7>:       nop    
    0xffffe408 <__kernel_vsyscall+8>:       nop    
    0xffffe409 <__kernel_vsyscall+9>:       nop    
    0xffffe40a <__kernel_vsyscall+10>:      nop    
    0xffffe40b <__kernel_vsyscall+11>:      nop    
    0xffffe40c <__kernel_vsyscall+12>:      nop    
    0xffffe40d <__kernel_vsyscall+13>:      nop    
    0xffffe40e <__kernel_vsyscall+14>:      jmp    0xffffe403 <__kernel_vsyscall+3>
    0xffffe410 <__kernel_vsyscall+16>:      pop    %ebp               <- frame pointer here
    0xffffe411 <__kernel_vsyscall+17>:      pop    %edx
    0xffffe412 <__kernel_vsyscall+18>:      pop    %ecx
    0xffffe413 <__kernel_vsyscall+19>:      ret    
    0xffffe414 <__kernel_vsyscall+20>:      nop    
    0xffffe415 <__kernel_vsyscall+21>:      nop    

So in the original mutli-threaded realtime application above, I see no evidence of a system call
at the point the SIGXCPU was sent.

What am I missing?

Are there other events (not system calls) that initiate a switch to secondary mode?

Or, what is the best way to isolate the unwanted mode switch?

my config:
Xenomai 2.2.4
Linux 2.6.17.14

	thanks,
	Jeff

