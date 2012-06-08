Message-ID: <4FD2133C.3070209@xenomai.org>
Date: Fri, 08 Jun 2012 16:59:08 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <DUB116-W111F330AEF9F9C3C8653C86AFF20@phx.gbl>
In-Reply-To: <DUB116-W111F330AEF9F9C3C8653C86AFF20@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Illegal use of supervisor resource
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fabio Visona <fabioviso@hotmail.com>
Cc: xenomai@xenomai.org

On 06/08/2012 03:51 PM, Fabio Visona wrote:
>
> Not sure if this issue is related to Xenomai or not, however I hope somebody can give me an hint:
> we are getting an error of the following form from time to time:
>

This is a I-pipe bug, caused by a spurious rescheduling over an IRQ 
context (blackfin is a bit special regarding this, to say the least). 
You may want to check whether 2.6.35.9-1.16-01 fixes the issue.

> Example 1:
>
> Illegal use of supervisor resource
> <5>  - Attempted to use a Supervisor register or instruction from User mode.
> <5>    Supervisor resources are registers and instructions that are reserved
> <5>    for Supervisor use: Supervisor only registers, all MMRs, and Supervisor
> <5>    only instructions.
> Kernel OOPS in progress
> Deferred Exception context
> No Valid process in current context
> return address: [0xffa002e6]; contents of:
> 0xffa002c0:  e331  949c  0030  3046  4d68  4f68  3210  a090
> 0xffa002d0:  4810  100e  e14a  001c  e10a  75e0  9110  0000
> 0xffa002e0:  0040  0020  9110 [0040] 6c66  0127  0010  e14a
> 0xffa002f0:  001c  e10a  75e0  9110  0040  6c66  0127  0010
> ADSP-BF518-0.0(Detected 0.2) 400(MHz CCLK) 80(MHz SCLK) (mpu off)
> Linux version 2.6.34.7-ADI-2010R1 (gcc version 4.3.5 (ADI-                                                                             2010R1-RC4) ) #220 Thu Jun 7 15:33:02 CEST 2012
> SEQUENCER STATUS:               Not tainted
>   SEQSTAT: 0000002e  IPEND: 0008  IMASK: ffff  SYSCFG: 0006
>    EXCAUSE   : 0x2e
>    physical IVG3 asserted :<0xffa0076c>  { _trap + 0x0 }
>   RETE:<0x00000000>  /* Maybe null pointer? */
>   RETN:<0x001d7fa4>  /* kernel dynamic memory (maybe user-space) */
>   RETX:<0x00000480>  /* Maybe fixed code section */
>   RETS:<0xffa002c4>  { _default_idle + 0x8 }
>   PC  :<0xffa002e6>  { _default_idle + 0x2a }
> DCPLB_FAULT_ADDR:<0x001c75e0>  /* kernel dynamic memory (maybe user-space) */
> ICPLB_FAULT_ADDR:<0xffa002e6>  { _default_idle + 0x2a }
> PROCESSOR STATE:
>   R0 : 0000ffff    R1 : fffffffc    R2 : ffff0000    R3 : 00000001
>   R4 : 00000000    R5 : 00000000    R6 : 00000000    R7 : ffa002bc
>   P0 : 00000240    P1 : 001cd5e0    P2 : 001c75e0    P3 : 001d6008
>   P4 : 001d6008    P5 : ffa002bc    FP : 001a126c    SP : 001d7ec8
>   LB0: 000c5fa9    LT0: 000c5fa6    LC0: 00000000
>   LB1: 01471f75    LT1: 01471f74    LC1: 00000000
>   B0 : 001cd5e8    L0 : 00000000    M0 : 00000000    I0 : 0000000f
>   B1 : 00000000    L1 : 00000000    M1 : 00000000    I1 : 00000003
>   B2 : 00000000    L2 : 00000000    M2 : 00000000    I2 : 00000001
>   B3 : 00000000    L3 : 00000000    M3 : 00000000    I3 : 0000001f
> A0.w: 00000005   A0.x: 00000000   A1.w: 00000005   A1.x: 00000000
> USP : 001d8000  ASTAT: 02003064
> Hardware Trace:
>     0 Target :<0x00003f18>  { _trap_c + 0x0 }
>       Source :<0xffa00700>  { _exception_to_level5 + 0xa4 } JUMP.L
>     1 Target :<0xffa0065c>  { _exception_to_level5 + 0x0 }
>       Source :<0xffa00510>  { _bfin_return_from_exception + 0x18 } RTX
>     2 Target :<0xffa004f8>  { _bfin_return_from_exception + 0x0 }
>       Source :<0xffa005b4>  { _ex_trap_c + 0x74 } JUMP.S
>     3 Target :<0xffa00540>  { _ex_trap_c + 0x0 }
>       Source :<0xffa007c6>  { _trap + 0x5a } JUMP (P4)
>     4 Target :<0xffa0076c>  { _trap + 0x0 }
>        FAULT :<0xffa002e6>  { _default_idle + 0x2a } STI R0
>       Source :<0xffa002e4>  { _default_idle + 0x28 } R0 = [P2]
>     5 Target :<0xffa002e4>  { _default_idle + 0x28 }
>       Source :<0xffa00d18>  { __common_int_entry + 0xd0 } RTI
>     6 Target :<0xffa00cb6>  { __common_int_entry + 0x6e }
>       Source :<0xffa00982>  { _system_call + 0xee } RTS
>     7 Target :<0xffa0097e>  { _system_call + 0xea }
>       Source :<0xffa0096e>  { _system_call + 0xda } IF !CC JUMP pcrel
>     8 Target :<0xffa00964>  { _system_call + 0xd0 }
>       Source :<0xffa00954>  { _system_call + 0xc0 } IF !CC JUMP pcrel
>     9 Target :<0xffa00952>  { _system_call + 0xbe }
>       Source :<0xffa00942>  { _system_call + 0xae } IF !CC JUMP pcrel
>    10 Target :<0xffa00930>  { _system_call + 0x9c }
>       Source :<0xffa00962>  { _system_call + 0xce } JUMP.S
>    11 Target :<0xffa00960>  { _system_call + 0xcc }
>       Source :<0x0013f576>  { _schedule + 0x2c6 } RTS
>    12 Target :<0x0013f566>  { _schedule + 0x2b6 }
>       Source :<0x0013f616>  { _schedule + 0x366 } JUMP.S
>    13 Target :<0x0013f616>  { _schedule + 0x366 }
>       Source :<0x00032fe2>  { ___ipipe_unstall_root + 0x2a } RTS
>    14 Target :<0x00032fb8>  { ___ipipe_unstall_root + 0x0 }
>       Source :<0x0013f612>  { _schedule + 0x362 } JUMP.L
>    15 Target :<0x0013f60c>  { _schedule + 0x35c }
>       Source :<0x0013f40a>  { _schedule + 0x15a } IF CC JUMP pcrel
> Kernel Stack
> Stack info:
>   SP: [0x001d7c74]<0x001d7c74>  /* kernel dynamic memory (maybe user-space) */
>   FP: (0x001d7fac)
>   Memory from 0x001d7c70 to 001d8000
> 001d7c70: 001d7d54 [00000400] 001c81e0  00011c36  001ae99c  0016ef7c  001ae9a6                                                                               00000000
> 001d7c90: 0000000f  00044b83  00011b54  00011b54  6c756465  736e0065  001d7d4c                                                                               001d7cb8
> 001d7cb0: 00000035  0000ffff  0000ffff  00009964  ffa002ac  00000001  0000000c                                                                               00000002
> 001d7cd0: 00000000  0001076c  00000000  481007af  00651005  00000002  01004e00                                                                               001d7fac
> 001d7cf0: 00007e82  001d7fac  0013f10c  001d7cf8  0016ef7c  00007e58  00000000                                                                               001d8000
> 001d7d10: 00000028  001d7d4c  00000002  00007f0a  001d7dec  001d7de8  00006424                                                                               001d7d28
> 001d7d30: 001d7fac  001d7d54  00000000  000063ec  00000033  00000000  00011c36                                                                               00011c36
> 001d7d50: 00000001  3078303c  37643130  3e343763  202a2f20  6e72656b  64206c65                                                                               6d616e79
> 001d7d70: 6d206369  726f6d65  6d282079  65627961  65737520  70732d72  29656361                                                                               002f2a20
> 001d7d90: 002f2a20  001d7dec  ffa00300  ffa002e6  ffa00300  001d7ddc  001d7de4                                                                               0000000f
> 001d7db0: 001d7dec  ffa002fe  00008988  001d7de4  001a126c  0013f10c  001d7ec8                                                                               0016e91c
> 001d7dd0: 001d6008  00000008  00000004  00000000  001d7e18  30313030  00000000                                                                               0000001d
> 001d7df0: 001a126c  000043d4  001d7ec8  00000013  001d6008  00000008  00000004                                                                               00000000
> 001d7e10: 0000002e  001d7ec8  001d7c74  00000001  001d7e4c  011b0664  00030005                                                                               001b0664
> 001d7e30: 00006ddc  001cd5e0  001b14a4  001b0664  00006844  ffffffff  00000001                                                                               00000024
> 001d7e50: 00000000  00000000  001c6184  001b09a8  00000344  001d7e98<0013f400>                                                                               0014132c
> 001d7e70: 001d7e98  0013f616  001b0664  001b0664  00000000  00000000  001d6008                                                                               001d6000
> 001d7e90: 001d6000  20000000  001a126c  ffa00960  ffa00704  001a3000  ffe02014                                                                               00000008
> 001d7eb0: 0000002e  00000000  00000000  00000000  00000000  00000480  00000480                                                                               00000008
> 001d7ed0: 0000002e  00000000  001d7fa4  00000480  ffa002e6  ffa002c4  0000ffff                                                                               02003064
> 001d7ef0: 01471f75  000c5fa9  01471f74  000c5fa6  00000000  00000000  00000005                                                                               00000000
> 001d7f10: 00000005  00000000  00000000  00000000  00000000  001cd5e8  00000000                                                                               00000000
> 001d7f30: 00000000  00000000  00000000  00000000  00000000  00000000  0000001f                                                                               00000001
> 001d7f50: 00000003  0000000f  001d8000  001a126c  ffa002bc  001d6008  001d6008                                                                               001c75e0
> 001d7f70: 001cd5e0  00000240  ffa002bc  00000000  00000000  00000000  00000001                                                                               ffff0000
> 001d7f90: fffffffc  0000ffff  0000ffff  00000240  00000006  ffa002bc  00000000 (                                                                             00000000)
> 001d7fb0:<ffa002b0>  00000000  001ef5a4  00000000  001d8000  001d8640  001c02c8                                                                               001a1004
> 001d7fd0: 00000000  001ef5a4  0016ca84  001766c8  8000003f  00000021  001d820c                                                                               001ef5a4
> 001d7ff0: 001e1a46  00000000  00000000  ffb00000
> Return addresses in stack:
>      address :<0x0013f400>  { _schedule + 0x150 }
>     frame  1 :<0xffa002b0>  { _cpu_idle + 0x30 }
> Modules linked in: bfmd_xeno_acq bfmd_xeno_drv bfmd_xeno_tim bfmd_xeno_ser gptim                                                                             ers bfin_mac
> Kernel panic - not syncing: Kernel exception
> Hardware Trace:
> Stack info:
>   SP: [0x001d7de8]<0x001d7de8>  /* kernel dynamic memory (maybe user-space) */
>   FP: (0x001d7fac)
>   Memory from 0x001d7de0 to 001d8000
> 001d7de0: 001d7de8  001d6008 [0016e930] 0013efca  001d7ec8  0016e930  001a64be                                                                               001a64be
> 001d7e00: 001a64be  001d7e18  000043e4  001d7ec8  00000008  001d7ec8  0000003f                                                                               00000001
> 001d7e20: 001d7e4c  011b0664  00030005  001b0664  00006ddc  001cd5e0  001b14a4                                                                               001b0664
> 001d7e40: 00006844  ffffffff  00000001  00000024  00000000  00000000  001c6184                                                                               001b09a8
> 001d7e60: 00000344  001d7e98<0013f400>  0014132c  001d7e98  0013f616  001b0664                                                                               001b0664
> 001d7e80: 00000000  00000000  001d6008  001d6000  001d6000  20000000  001a126c                                                                               ffa00960
> 001d7ea0: ffa00704  001a3000  ffe02014  00000008  0000002e  00000000  00000000                                                                               00000000
> 001d7ec0: 00000000  00000480  00000480  00000008  0000002e  00000000  001d7fa4                                                                               00000480
> 001d7ee0: ffa002e6  ffa002c4  0000ffff  02003064  01471f75  000c5fa9  01471f74                                                                               000c5fa6
> 001d7f00: 00000000  00000000  00000005  00000000  00000005  00000000  00000000                                                                               00000000
> 001d7f20: 00000000  001cd5e8  00000000  00000000  00000000  00000000  00000000                                                                               00000000
> 001d7f40: 00000000  00000000  0000001f  00000001  00000003  0000000f  001d8000                                                                               001a126c
> 001d7f60: ffa002bc  001d6008  001d6008  001c75e0  001cd5e0  00000240  ffa002bc                                                                               00000000
> 001d7f80: 00000000  00000000  00000001  ffff0000  fffffffc  0000ffff  0000ffff                                                                               00000240
> 001d7fa0: 00000006  ffa002bc  00000000 (00000000)<ffa002b0>  00000000  001ef5a4                                                                               00000000
> 001d7fc0: 001d8000  001d8640  001c02c8  001a1004  00000000  001ef5a4  0016ca84                                                                               001766c8
> 001d7fe0: 8000003f  00000021  001d820c  001ef5a4  001e1a46  00000000  00000000                                                                               ffb00000
> Return addresses in stack:
>      address :<0x0013f400>  { _schedule + 0x150 }
>     frame  1 :<0xffa002b0>  { _cpu_idle + 0x30 }
>
> Example 2:
>
> Illegal use of supervisor resource
> <5>  - Attempted to use a Supervisor register or instruction from User mode.
> <5>    Supervisor resources are registers and instructions that are reserved
> <5>    for Supervisor use: Supervisor only registers, all MMRs, and Supervisor
> <5>    only instructions.
> Kernel OOPS in progress
> Deferred Exception context
> No Valid process in current context
> return address: [0xffa002e6]; contents of:
> 0xffa002c0:  e331  949c  0030  3046  4d68  4f68  3210  a090
> 0xffa002d0:  4810  100e  e14a  001c  e10a  75e0  9110  0000
> 0xffa002e0:  0040  0020  9110 [0040] 6c66  0127  0010  e14a
> 0xffa002f0:  001c  e10a  75e0  9110  0040  6c66  0127  0010
> ADSP-BF518-0.0(Detected 0.2) 400(MHz CCLK) 80(MHz SCLK) (mpu off)
> Linux version 2.6.34.7-ADI-2010R1 (gcc version 4.3.5 (ADI-2010R1-RC4) ) #220 Thu Jun 7 15:33:02 CEST 2012
> SEQUENCER STATUS:               Not tainted
>   SEQSTAT: 0000002e  IPEND: 0008  IMASK: ffff  SYSCFG: 0006
>    EXCAUSE   : 0x2e
>    physical IVG3 asserted :<0xffa0076c>  { _trap + 0x0 }
>   RETE:<0x00000000>  /* Maybe null pointer? */
>   RETN:<0x001d7fa4>  /* kernel dynamic memory (maybe user-space) */
>   RETX:<0x00000480>  /* Maybe fixed code section */
>   RETS:<0xffa002c4>  { _default_idle + 0x8 }
>   PC  :<0xffa002e6>  { _default_idle + 0x2a }
> DCPLB_FAULT_ADDR:<0x001c75e0>  /* kernel dynamic memory (maybe user-space) */
> ICPLB_FAULT_ADDR:<0xffa002e6>  { _default_idle + 0x2a }
> PROCESSOR STATE:
>   R0 : 0000ffff    R1 : fffffffc    R2 : 012046a0    R3 : 00000065
>   R4 : 00000000    R5 : 00000000    R6 : 00000000    R7 : ffa002bc
>   P0 : ffa00a04    P1 : 001c75e0    P2 : 001c75e0    P3 : 001d6008
>   P4 : 001d6008    P5 : ffa002bc    FP : 001a126c    SP : 001d7ec8
>   LB0: 000c5fa9    LT0: 000c5fa6    LC0: 00000000
>   LB1: 01545faf    LT1: 01545fae    LC1: 00000000
>   B0 : 00000000    L0 : 00000000    M0 : 00000004    I0 : 00000000
>   B1 : 00000000    L1 : 00000000    M1 : 00000000    I1 : 00000001
>   B2 : 00000000    L2 : 00000000    M2 : 00000000    I2 : 00000000
>   B3 : 00000000    L3 : 00000000    M3 : 00000000    I3 : 00000000
> A0.w: 000002f1   A0.x: 00000000   A1.w: 00000015   A1.x: 00000000
> USP : 001d8000  ASTAT: 02003064
> Hardware Trace:
>     0 Target :<0x00003f18>  { _trap_c + 0x0 }
>       Source :<0xffa00700>  { _exception_to_level5 + 0xa4 } JUMP.L
>     1 Target :<0xffa0065c>  { _exception_to_level5 + 0x0 }
>       Source :<0xffa00510>  { _bfin_return_from_exception + 0x18 } RTX
>     2 Target :<0xffa004f8>  { _bfin_return_from_exception + 0x0 }
>       Source :<0xffa005b4>  { _ex_trap_c + 0x74 } JUMP.S
>     3 Target :<0xffa00540>  { _ex_trap_c + 0x0 }
>       Source :<0xffa007c6>  { _trap + 0x5a } JUMP (P4)
>     4 Target :<0xffa0076c>  { _trap + 0x0 }
>        FAULT :<0xffa002e6>  { _default_idle + 0x2a } STI R0
>       Source :<0xffa002e4>  { _default_idle + 0x28 } R0 = [P2]
>     5 Target :<0xffa002e4>  { _default_idle + 0x28 }
>       Source :<0xffa00d18>  { __common_int_entry + 0xd0 } RTI
>     6 Target :<0xffa00cb6>  { __common_int_entry + 0x6e }
>       Source :<0xffa00982>  { _system_call + 0xee } RTS
>     7 Target :<0xffa0097e>  { _system_call + 0xea }
>       Source :<0xffa0096e>  { _system_call + 0xda } IF !CC JUMP pcrel
>     8 Target :<0xffa00964>  { _system_call + 0xd0 }
>       Source :<0xffa00954>  { _system_call + 0xc0 } IF !CC JUMP pcrel
>     9 Target :<0xffa00952>  { _system_call + 0xbe }
>       Source :<0xffa00942>  { _system_call + 0xae } IF !CC JUMP pcrel
>    10 Target :<0xffa00930>  { _system_call + 0x9c }
>       Source :<0xffa00950>  { _system_call + 0xbc } JUMP.S
>    11 Target :<0xffa0094e>  { _system_call + 0xba }
>       Source :<0x00006a42>  { ___ipipe_sync_root + 0x7e } RTS
>    12 Target :<0x00006a22>  { ___ipipe_sync_root + 0x5e }
>       Source :<0x00006a1c>  { ___ipipe_sync_root + 0x58 } IF CC JUMP pcrel (BP)
>    13 Target :<0x00006a02>  { ___ipipe_sync_root + 0x3e }
>       Source :<0x000380c4>  { _xnpod_schedule_deferred + 0x20 } RTS
>    14 Target :<0x000380a4>  { _xnpod_schedule_deferred + 0x0 }
>       Source :<0x00006a00>  { ___ipipe_sync_root + 0x3c } CALL (P1)
>    15 Target :<0x000069e6>  { ___ipipe_sync_root + 0x22 }
>       Source :<0x000069e0>  { ___ipipe_sync_root + 0x1c } IF CC JUMP pcrel (BP)
> Kernel Stack
> Stack info:
>   SP: [0x001d7e54]<0x001d7e54>  /* kernel dynamic memory (maybe user-space) */
>   FP: (0x001d7fac)
>   Memory from 0x001d7e50 to 001d8000
> 001d7e50: 001c6000 [0000c762] 001c6000  001c6184  01029060  001d7e98  0013f566  001f17e0
> 001d7e70: 001c6000  01029060  001b0664  001b0664  00000000  00000000  001d6008  001d6000
> 001d7e90: 001d6000  001ce2e0  001a126c  ffa00960  ffa00704  001a3000  ffe02014  00000008
> 001d7eb0: 0000002e  00000000  00000000  00000000  00000000  00000480  00000480  00000008
> 001d7ed0: 0000002e  00000000  001d7fa4  00000480  ffa002e6  ffa002c4  0000ffff  02003064
> 001d7ef0: 01545faf  000c5fa9  01545fae  000c5fa6  00000000  00000000  00000015  00000000
> 001d7f10: 000002f1  00000000  00000000  00000000  00000000  00000000  00000000  00000000
> 001d7f30: 00000000  00000000  00000000  00000000  00000000  00000004  00000000  00000000
> 001d7f50: 00000001  00000000  001d8000  001a126c  ffa002bc  001d6008  001d6008  001c75e0
> 001d7f70: 001c75e0  ffa00a04  ffa002bc  00000000  00000000  00000000  00000065  012046a0
> 001d7f90: fffffffc  0000ffff  0000ffff  ffa00a04  00000006  ffa002bc  00000000 (00000000)
> 001d7fb0:<ffa002b0>  00000000  001ef5a4  00000000  001d8000  001d8640  001c02c8  001a1004
> 001d7fd0: 00000000  001ef5a4  0016ca84  001766c8  8000003f  00000021  001d820c  001ef5a4
> 001d7ff0: 001e1a46  00000000  00000000  ffb00000
> Return addresses in stack:
>     frame  1 :<0xffa002b0>  { _cpu_idle + 0x30 }
> Modules linked in: bfmd_xeno_acq bfmd_xeno_drv bfmd_xeno_tim bfmd_xeno_ser gptimers bfin_mac
> Kernel panic - not syncing: Kernel exception
> Hardware Trace:
> Stack info:
>   SP: [0x001d7de8]<0x001d7de8>  /* kernel dynamic memory (maybe user-space) */
>   FP: (0x001d7fac)
>   Memory from 0x001d7de0 to 001d8000
> 001d7de0: 001d7de8  001d6008 [0016e930] 0013efca  001d7ec8  0016e930  001a64be  001a64be
> 001d7e00: 001a64be  001d7e18  000043e4  001d7ec8  00000008  001d7ec8  0000003f  00000001
> 001d7e20: 00000001  00000003  00030005  0102908c  001c7ca0  01029094  001c6000  001c6184
> 001d7e40: 0000a4ec  001d7e64  0000c8e2  001c7ca0  001c6000  0000c762  001c6000  001c6184
> 001d7e60: 01029060  001d7e98  0013f566  001f17e0  001c6000  01029060  001b0664  001b0664
> 001d7e80: 00000000  00000000  001d6008  001d6000  001d6000  001ce2e0  001a126c  ffa00960
> 001d7ea0: ffa00704  001a3000  ffe02014  00000008  0000002e  00000000  00000000  00000000
> 001d7ec0: 00000000  00000480  00000480  00000008  0000002e  00000000  001d7fa4  00000480
> 001d7ee0: ffa002e6  ffa002c4  0000ffff  02003064  01545faf  000c5fa9  01545fae  000c5fa6
> 001d7f00: 00000000  00000000  00000015  00000000  000002f1  00000000  00000000  00000000
> 001d7f20: 00000000  00000000  00000000  00000000  00000000  00000000  00000000  00000000
> 001d7f40: 00000000  00000004  00000000  00000000  00000001  00000000  001d8000  001a126c
> 001d7f60: ffa002bc  001d6008  001d6008  001c75e0  001c75e0  ffa00a04  ffa002bc  00000000
> 001d7f80: 00000000  00000000  00000065  012046a0  fffffffc  0000ffff  0000ffff  ffa00a04
> 001d7fa0: 00000006  ffa002bc  00000000 (00000000)<ffa002b0>  00000000  001ef5a4  00000000
> 001d7fc0: 001d8000  001d8640  001c02c8  001a1004  00000000  001ef5a4  0016ca84  001766c8
> 001d7fe0: 8000003f  00000021  001d820c  001ef5a4  001e1a46  00000000  00000000  ffb00000
> Return addresses in stack:
>     frame  1 :<0xffa002b0>  { _cpu_idle + 0x30 }
>
> The faulty code is trying to enable interrupts while in user mode.
>
> Linux is 2.6.34.7, running on a Blackfin BF518 processor.
> Xenomai version 2.5.3 (I know I should upgrade to 2.6.0).
>
> We had similar errors very often when a mode switch occurred from rt mode to non-rt mode following a call to a real-time driver ioctl (.ioctl_rt in rtdm_device structure, with a NULL .ioclt_nrt counterpart) which returned -ENOSYS by mistake, instead of the correct 0 code.
>
> Thank you
>    		 	   		
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

