Date: Sun, 16 Sep 2007 18:31:09 +0200 (CEST)
From: Andras Garzo <garzo@domain.hid>
Message-ID: <Pine.LNX.4.64.0709161755410.27787@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Xenomai-help] User space apps crash on Blackfin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi!

On BF537-Stamp with uClinux 2007R1RC3 I get the following when
I try to run user space real time application. The same
happens when running latency test program:


root:/usr/xenomai/bin> ./latency -t0 -T20 -h


Jump to address 0 - 0x0fff

CURRENT PROCESS:

COMM=latency PID=156
TEXT = 0x034f0000-0x034f6f58  DATA = 0x0310cf58-0x0310d520
BSS = 0x0310d520-0x03120000   USER-STACK = 0x0313feb0

return address: 0x00000420; contents of [PC-16...PC+8]:


RETE:  00000000  RETN: 030b8000  RETX: 00000420  RETS: 035c76d8
IPEND: 0030  SYSCFG: 0036
SEQSTAT: 0006002d    SP: 030b7f24
R0: 0310f010    R1: 00000000    R2: 00000001    R3: 00000001
R4: 00000000    R5: 030b44f0    R6: 0311d380    R7: 0310f000
P0: 0310f010    P1: 00000000    P2: 00000420    P3: 0311d380
P4: 00000000    P5: 0310f010    FP: 0313fa80
A0.w: 00000000    A0.x: 00000000    A1.w: 00000000    A1.x: 00000000
LB0: 0359477d  LT0: 03594770  LC0: 00000000
LB1: 036bef55  LT1: 036bef54  LC1: 00000000
B0: 00000000  L0: 00000000  M0: 00000000  I0: 0313fa81
B1: 00000000  L1: 00000000  M1: 00000000  I1: 00004440
B2: 00000000  L2: 00000000  M2: 00000000  I2: 00000000
B3: 00000000  L3: 00000000  M3: 00000000  I3: 00000000

USP: 0313fa74   ASTAT: 02003025
DCPLB_FAULT_ADDR=0310f010
ICPLB_FAULT_ADDR=00000420


Hardware Trace:
 0 Target : <0x00004530> { _trap_c + 0x0 }
   Source : <0xffa00b40> { _exception_to_level5 + 0xb4 }
 1 Target : <0xffa00a8c> { _exception_to_level5 + 0x0 }
   Source : <0xffa00a8a> { _ex_trap_c + 0x4e }
 2 Target : <0xffa00a3c> { _ex_trap_c + 0x0 }
   Source : <0xffa00be0> { _trap + 0x28 }
 3 Target : <0xffa00bb8> { _trap + 0x0 }
   Source : <0x035c76d6> [ /lib/libpthread-0.9.29.so + 0x76d6 ]
 4 Target : <0x035c76b8> [ /lib/libpthread-0.9.29.so + 0x76b8 ]
   Source : <0x0359473e> [ /lib/ld-uClibc-0.9.29.so + 0x473e ]
 5 Target : <0x0359472c> [ /lib/ld-uClibc-0.9.29.so + 0x472c ]
   Source : <0x0359279e> [ /lib/ld-uClibc-0.9.29.so + 0x279e ]
 6 Target : <0x03592792> [ /lib/ld-uClibc-0.9.29.so + 0x2792 ]
   Source : <0x0359275a> [ /lib/ld-uClibc-0.9.29.so + 0x275a ]
 7 Target : <0x0359274c> [ /lib/ld-uClibc-0.9.29.so + 0x274c ]
   Source : <0x03592714> [ /lib/ld-uClibc-0.9.29.so + 0x2714 ]
 8 Target : <0x03592710> [ /lib/ld-uClibc-0.9.29.so + 0x2710 ]
   Source : <0x0359120a> [ /lib/ld-uClibc-0.9.29.so + 0x120a ]
 9 Target : <0x03591204> [ /lib/ld-uClibc-0.9.29.so + 0x1204 ]
   Source : <0x035911e8> [ /lib/ld-uClibc-0.9.29.so + 0x11e8 ]
10 Target : <0x035911e4> [ /lib/ld-uClibc-0.9.29.so + 0x11e4 ]
   Source : <0x035911d6> [ /lib/ld-uClibc-0.9.29.so + 0x11d6 ]
11 Target : <0x035911ce> [ /lib/ld-uClibc-0.9.29.so + 0x11ce ]
   Source : <0x03591200> [ /lib/ld-uClibc-0.9.29.so + 0x1200 ]
12 Target : <0x035911ec> [ /lib/ld-uClibc-0.9.29.so + 0x11ec ]
   Source : <0x035911cc> [ /lib/ld-uClibc-0.9.29.so + 0x11cc ]
13 Target : <0x035911c0> [ /lib/ld-uClibc-0.9.29.so + 0x11c0 ]
   Source : <0x035923e4> [ /lib/ld-uClibc-0.9.29.so + 0x23e4 ]
14 Target : <0x035923d8> [ /lib/ld-uClibc-0.9.29.so + 0x23d8 ]
   Source : <0x035923b2> [ /lib/ld-uClibc-0.9.29.so + 0x23b2 ]
15 Target : <0x0359239a> [ /lib/ld-uClibc-0.9.29.so + 0x239a ]
   Source : <0x03592380> [ /lib/ld-uClibc-0.9.29.so + 0x2380 ]
Stack from 030b7efc:
        00000000 ffa00b44 00160744 00160744 00160744 030b44f0 00000000 0313fa70
        00000000 0304d0d2 00000420 00000030 0006002d 00000000 030b8000 00000420
        00000420 035c76d8 0310f010 02003025 036bef55 0359477d 036bef54 03594770
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 00004440 0313fa81 0313fa74 0313fa80
Call Trace:

SIGSEGV

I use Xenomai 2.3.2. cross-compiled with uclibc by running 
configure -build=i686-pc-linux-gnu --host=blackfin-unknown-linux-gnu \
CC=bfin-linux-uclibc-gcc CXX=bfin-linux-uclibc-gcc AR=bfin-linux-uclibc-ar \
LD=bfin-linux-uclibc-ld --disable-shared

I tried with Xenomai version 2.3.3., but nothing changed.
Do you have any idea, what might be the problem?

Thanks,
 
Andras Garzo


