Date: Tue, 25 Jan 2011 10:31:00 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
Message-ID: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] NULL pointer access on bfin when linking with
	xenomai and pthread
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Ok, I'll start a new thread with the details. I'm not so sure if this is actually
related to Xenomai, but until now I was only able to reproduce it in conjunction with
xenomai libs, so ...

The example is already reduced to a minimum. I'm working with a Blackfin-based
board like BF537-STAMP, with 2010R1-RC5 blackfin-linux-dist on it and stock kernel
as it comes with the dist (2.6.34.7-ADI-2010R1). Just Xenomai 2.5.3 was replaced
by 2.5.5.2. Toolchain is 2010R1-RC4 taken as binary from blackfin.uclinux.org.

The code itself actually doesn't seem to matter. The problem can be reproduced with an
example as simple as this "a.c":

> int main (void) { return 0; }

Normally, this can be started on the target via gdbserver and debugged from the host. 
I used the gdb command script

> file a.out
> target remote 10.0.10.9:2222
> break main
> cont

The target would run the example, and stop, e.g. at "Breakpoint 1, 0x00b7b626 in main ()"

These compile commands produce a working a.out:

> bfin-linux-uclibc-gcc  -L/opt/uClinux/blackfin-linux-dist/staging/usr/lib -lpthread a.c

or

> bfin-linux-uclibc-gcc  -L/opt/uClinux/blackfin-linux-dist/staging/usr/lib -lpthread_rt -lxenomai a.c

but this one that combines all -l options above doesn't:

> bfin-linux-uclibc-gcc  -L/opt/uClinux/blackfin-linux-dist/staging/usr/lib -lpthread_rt -lxenomai -lpthread a.c

(Adding -lrt, to complete the suggested posix-ldflags, doesn't help, so I omit
it here for shortness)

The result on the target, when started with gdbserver and as soon as the host
says "cont", is a NULL pointer access.  It seems to occur even before main() is
reached.

Following is the complete output on the target:

/tmp # gdbserver :2222 ./a.out
Process ./a.out created; pid = 320
Listening on port 2222
Remote debugging from host 10.0.10.10
NULL pointer access
Deferred Exception context
CURRENT PROCESS:
COMM=a.out PID=320  CPU=0
TEXT = 0x00ea9000-0x00ea96c8        DATA = 0x00eaa6c8-0x00eaa834
  BSS = 0x00eaa834-0x013a0000  USER-STACK = 0x013bfe60

return address: [0x01666f10]; contents of:
0x01666ef0:  e42f  0015  0c07  1405  3047  67f8  e628  0015 
0x01666f00:  320e  3044  300d  3014  e50a  003a  5ea2  9153 
0x01666f10: [9159] ac5b  0061  0c07  1404  6000  e628  0015 
0x01666f20:  e801  0000  05a4  0010  e51a  0016  05f4  e800

ADSP-BF537-0.3 533(MHz CCLK) 133(MHz SCLK) (mpu off)
Linux version 2.6.34.7-ADI-2010R1-svn10663 (kawk@domain.hid) (gcc version 4.3.5 (ADI-2010R1-RC4) ) #58 Mon Jan 24 17:24:55 CET 2011

SEQUENCER STATUS:		Not tainted
  SEQSTAT: 00060027  IPEND: 0008  IMASK: ffff  SYSCFG: 0006
   EXCAUSE   : 0x27
   physical IVG3 asserted : <0xffa0076c> { _trap + 0x0 }
  RETE: <0x00000000> /* Maybe null pointer? */
  RETN: <0x00b8a000> /* kernel dynamic memory */
  RETX: <0x00000480> /* Maybe fixed code section */
  RETS: <0x01666eda> [ /lib/libpthread.so.0 + 0x6eda ]
  PC  : <0x01666f10> [ /lib/libpthread.so.0 + 0x6f10 ]
DCPLB_FAULT_ADDR: <0x00000000> /* Maybe null pointer? */
ICPLB_FAULT_ADDR: <0x01666f10> [ /lib/libpthread.so.0 + 0x6f10 ]
PROCESSOR STATE:
  R0 : 0000001c    R1 : 013bd374    R2 : 013bd3f4    R3 : 00000008
  R4 : 013bd3f4    R5 : 013bd374    R6 : 015e9448    R7 : 00000000
  P0 : 000000ae    P1 : 015e9448    P2 : 015e9650    P3 : 00000000
  P4 : 0000001c    P5 : 015e8b40    FP : 013bd340    SP : 00b89f24
  LB0: 01620483    LT0: 01620482    LC0: 00000000
  LB1: 016675a1    LT1: 01667578    LC1: 000003ff
  B0 : 00000137    L0 : 00000000    M0 : 000000b4    I0 : 013bd6bc
  B1 : 000000c0    L1 : 00000000    M1 : 00000001    I1 : 00000001
  B2 : 7ffff000    L2 : 00000000    M2 : 00001802    I2 : 00000002
  B3 : 00000000    L3 : 00000000    M3 : 0000005b    I3 : 00000006
A0.w: 00000000   A0.x: 00000000   A1.w: 00000000   A1.x: 00000000
USP : 013bd330  ASTAT: 02003064

Hardware Trace:
    0 Target : <0x00003bf8> { _trap_c + 0x0 }
      Source : <0xffa00700> { _exception_to_level5 + 0xa4 } JUMP.L
    1 Target : <0xffa0065c> { _exception_to_level5 + 0x0 }
      Source : <0xffa00510> { _bfin_return_from_exception + 0x18 } RTX
    2 Target : <0xffa004f8> { _bfin_return_from_exception + 0x0 }
      Source : <0xffa005b4> { _ex_trap_c + 0x74 } JUMP.S
    3 Target : <0xffa00540> { _ex_trap_c + 0x0 }
      Source : <0xffa007c4> { _trap + 0x58 } JUMP (P4)
    4 Target : <0xffa0076c> { _trap + 0x0 }
       FAULT : <0x01666f10> [ /lib/libpthread.so.0 + 0x6f10 ] P1 = [P3]
      Source : <0x01666f0e> [ /lib/libpthread.so.0 + 0x6f0e ] P3 = [P2]
    5 Target : <0x01666eee> [ /lib/libpthread.so.0 + 0x6eee ]
      Source : <0x01666ee2> [ /lib/libpthread.so.0 + 0x6ee2 ] IF CC JUMP pcrel (BP)
    6 Target : <0x01666eda> [ /lib/libpthread.so.0 + 0x6eda ]
      Source : <0x01666e64> [ /lib/libpthread.so.0 + 0x6e64 ] RTS
    7 Target : <0x01666e60> [ /lib/libpthread.so.0 + 0x6e60 ]
      Source : <0x01666e3c> [ /lib/libpthread.so.0 + 0x6e3c ] JUMP.S
    8 Target : <0x01666e18> [ /lib/libpthread.so.0 + 0x6e18 ]
      Source : <0x01666ed6> [ /lib/libpthread.so.0 + 0x6ed6 ] CALL pcrel
    9 Target : <0x01666ec8> [ /lib/libpthread.so.0 + 0x6ec8 ]
      Source : <0xffa00d12> { __common_int_entry + 0xce } RTI
   10 Target : <0xffa00cb0> { __common_int_entry + 0x6c }
      Source : <0xffa00f80> { _evt_system_call + 0x64 } JUMP.S
   11 Target : <0xffa00f80> { _evt_system_call + 0x64 }
      Source : <0xffa00982> { _system_call + 0xee } RTS
   12 Target : <0xffa0097c> { _system_call + 0xe8 }
      Source : <0x000031fe> { _do_notify_resume + 0x52 } RTS
   13 Target : <0x000031fa> { _do_notify_resume + 0x4e }
      Source : <0x000031dc> { _do_notify_resume + 0x30 } IF CC JUMP pcrel (BP)
   14 Target : <0x000031ce> { _do_notify_resume + 0x22 }
      Source : <0x000031aa> { _do_signal + 0x126 } RTS
   15 Target : <0x000031a0> { _do_signal + 0x11c }
      Source : <0x00003118> { _do_signal + 0x94 } IF CC JUMP pcrel (BP)
Userspace Stack
Stack info:
  SP: [0x013bd330] <0x013bd330> [ a.out + 0x1d330 ]
  Memory from 0x013bd330 to 013be000
013bd330:[00000000] 00000000  00000000  00000000  013bd4d8  00000400  013bd638  00b8595c 
013bd350: 013bd580  01599628  0000001c  013be86c  0000001c  013bd374  013bd3f4  00000000 
013bd370: 00000000  0000001c  00000000  ffffffff  00000000  00000000  00000002  00000000 
013bd390: 00000000  00000000  00000000  00000000  00000000  00000000  00000000  00000000 
013bd3b0: 00000000  00000000  00000000  00000000  00000000  00000000  00000000  00000000 
...
013bdfb0: 00000000  00000000  00000000  00000000  00000000  00000000  00000000  00000000 
013bdfd0: 00000000  00000000  00000000  00000000  00000000  00000000  00000000  00000000 
013bdff0: 00000000  00000000  00000000  00000000 
Return addresses in stack:
     address : <0x01665f66> [ /lib/libpthread.so.0 + 0x5f66 ]
     address : <0x0166759a> [ /lib/libpthread.so.0 + 0x759a ]

The specified locations RETS and PC

> RETS: <0x01666eda> [ /lib/libpthread.so.0 + 0x6eda ]
> PC  : <0x01666f10> [ /lib/libpthread.so.0 + 0x6f10 ]

resolve to

> 0x6eda libpthread/linuxthreads.old/signals.c:113
> 0x6f10 libpthread/linuxthreads.old/signals.c:127

Kolja




