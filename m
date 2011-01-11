From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1101111846540.17125@domain.hid>
References: <alpine.DEB.1.10.1101111320530.16506@domain.hid>
	<4D2C80FC.7040903@domain.hid>
	<alpine.DEB.1.10.1101111846540.17125@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 Jan 2011 19:07:06 +0100
Message-ID: <1294769226.1828.247.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] blackfin kernel oops under heavy load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2011-01-11 at 19:02 +0100, Kolja Waschk wrote:
> > Ok. Could you try with current xenomai-2.5 tip? We fixed a few things
> > which might, possibly, with some luck, be the cause of this issue.
> 
> I tried, but to me the result looks similar (see below). BTW, I have to
> correct my previous report regarding the I-Pipe version, I actually used
> adeos-ipipe-2.6.34-blackfin-1.15-01.patch. Not 1.14-02.
> 
> I'm unsure where I should set a reasonable breakpoint with gdb (attached via
> gdbproxy) so that I could get a better backtrace? I tried to break at traps_c
> but the stackframe at that time probably is of no help anymore.
> 
> Here's an example of the Illegal use of supervisor resource (the NULL pointer
> exception didn't happen so far). This happened with 2.5.git. A difference to
> the previous recordings is that the first reported source is _schedule and
> not _xnpod_schedule_deferred, but I observed that sometimes also with 2.5.5.2.

This issue is possibly an Adeos bug, not a Xenomai one, despite the
traces. If that is true, then gdb won't be of no help in the kind of
context I'm thinking of (interrupt related, more precisely in the IRQ
level transition we use internally to run syscalls and epilogues of
realtime IRQs), and there is no straightforward tips on how to track it
unfortunately. Well, your report is queued, thanks. I can't do much
better for now.

> 
> 
> > Illegal use of supervisor resource
> <5> - Attempted to use a Supervisor register or instruction from User mode.
> <5>   Supervisor resources are registers and instructions that are reserved
> <5>   for Supervisor use: Supervisor only registers, all MMRs, and Supervisor
> <5>   only instructions.
> Deferred Exception context
> CURRENT PROCESS:
> COMM=pfda PID=252  CPU=0
> TEXT = 0x01640000-0x01665c5c        DATA = 0x016a0c5c-0x016a9314
>   BSS = 0x016a9314-0x01700000  USER-STACK = 0x0175fe40
> 
> return address: [0x000063f6]; contents of:
> 0x000063d0:  9151  e14a  001d  e10a  a424  9110  6fa6  4800 
> 0x000063e0:  1409  e14a  001d  e10a  45e4  9110  60f9  0808 
> 0x000063f0:  1403  0001  2000 [0037] 0c41  1802  0061  304e 
> 0x00006400:  4d69  4f69  0032  3211  a090  4c38  b090  6200
> 
> ADSP-BF537-0.3 533(MHz CCLK) 133(MHz SCLK) (mpu off)
> Linux version 2.6.34.7-ADI-2010R1-svn10663 (kawk@domain.hid) (gcc version 4.3.5 (ADI-2010R1-RC4) ) #7 Tue Jan 11 18:24:08 CET 2011
> 
> SEQUENCER STATUS:		Not tainted
>   SEQSTAT: 0000002e  IPEND: 0008  IMASK: ffff  SYSCFG: 0006
>    EXCAUSE   : 0x2e
>    physical IVG3 asserted : <0xffa0076c> { _trap + 0x0 }
>   RETE: <0x00000000> /* Maybe null pointer? */
>   RETN: <0x00cb1f18> /* kernel dynamic memory */
>   RETX: <0x00000480> /* Maybe fixed code section */
>   RETS: <0xffa0094e> { _system_call + 0xba }
>   PC  : <0x000063f6> { ___ipipe_sync_root + 0x32 }
> DCPLB_FAULT_ADDR: <0x001d45e4> /* kernel dynamic memory */
> ICPLB_FAULT_ADDR: <0x000063f6> { ___ipipe_sync_root + 0x32 }
> PROCESSOR STATE:
>   R0 : 0000ffff    R1 : 0000001f    R2 : 00847e86    R3 : 00000000
>   R4 : 0000fffe    R5 : 00f5a1f4    R6 : 00f08004    R7 : 00000080
>   P0 : 001d45e4    P1 : 0003761c    P2 : 001d45e4    P3 : 0091cc68
>   P4 : 0091cc68    P5 : 00cb0000    FP : 00f5a158    SP : 00cb1e3c
>   LB0: 013e04a1    LT0: 013e049e    LC0: 00000000
>   LB1: 013dcfdf    LT1: 013dcfde    LC1: 00000000
>   B0 : 00000137    L0 : 00000000    M0 : 00000000    I0 : 00000000
>   B1 : 000000c0    L1 : 00000000    M1 : 00000000    I1 : 00000001
>   B2 : 7ffff000    L2 : 00000000    M2 : 00000000    I2 : 00000000
>   B3 : 00000000    L3 : 00000000    M3 : 0000005b    I3 : 00000140
> A0.w: 00000000   A0.x: 00000000   A1.w: 00000006   A1.x: 00000000
> USP : 00f5a130  ASTAT: 02003004
> 
> Hardware Trace:
>     0 Target : <0x00003bf8> { _trap_c + 0x0 }
>       Source : <0xffa00700> { _exception_to_level5 + 0xa4 } JUMP.L
>     1 Target : <0xffa0065c> { _exception_to_level5 + 0x0 }
>       Source : <0xffa00510> { _bfin_return_from_exception + 0x18 } RTX
>     2 Target : <0xffa004f8> { _bfin_return_from_exception + 0x0 }
>       Source : <0xffa005b4> { _ex_trap_c + 0x74 } JUMP.S
>     3 Target : <0xffa00540> { _ex_trap_c + 0x0 }
>       Source : <0xffa007c4> { _trap + 0x58 } JUMP (P4)
>     4 Target : <0xffa0076c> { _trap + 0x0 }
>        FAULT : <0x000063f6> { ___ipipe_sync_root + 0x32 } CLI R7
>       Source : <0x000063f0> { ___ipipe_sync_root + 0x2c } IF !CC JUMP pcrel (BP)
>     5 Target : <0x000063c4> { ___ipipe_sync_root + 0x0 }
>       Source : <0xffa0094a> { _system_call + 0xb6 } CALL pcrel
>     6 Target : <0xffa0094a> { _system_call + 0xb6 }
>       Source : <0xffa00d12> { __common_int_entry + 0xce } RTI
>     7 Target : <0xffa00cb0> { __common_int_entry + 0x6c }
>       Source : <0xffa00982> { _system_call + 0xee } RTS
>     8 Target : <0xffa0097e> { _system_call + 0xea }
>       Source : <0xffa0096e> { _system_call + 0xda } IF !CC JUMP pcrel
>     9 Target : <0xffa00964> { _system_call + 0xd0 }
>       Source : <0xffa00954> { _system_call + 0xc0 } IF !CC JUMP pcrel
>    10 Target : <0xffa00952> { _system_call + 0xbe }
>       Source : <0xffa00942> { _system_call + 0xae } IF !CC JUMP pcrel
>    11 Target : <0xffa00930> { _system_call + 0x9c }
>       Source : <0xffa00962> { _system_call + 0xce } JUMP.S
>    12 Target : <0xffa00960> { _system_call + 0xcc }
>       Source : <0xffa01da6> { _schedule + 0x2e6 } RTS
>    13 Target : <0xffa01d96> { _schedule + 0x2d6 }
>       Source : <0x00032a2e> { ___ipipe_unstall_root + 0x2e } RTS
>    14 Target : <0x00032a1e> { ___ipipe_unstall_root + 0x1e }
>       Source : <0x00032a18> { ___ipipe_unstall_root + 0x18 } IF CC JUMP pcrel (BP)
>    15 Target : <0x00032a00> { ___ipipe_unstall_root + 0x0 }
>       Source : <0xffa01d92> { _schedule + 0x2d2 } JUMP.L
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



