MIME-Version: 1.0
Date: Fri, 4 Mar 2011 16:14:33 -0500
Message-ID: <AANLkTik6fDir0vM8E_pJerRXY=jvPBtnNnZFO+jwHnOd@domain.hid>
From: Eric Cohen <ericrebates@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Illegal instruction running trivial-periodic on ARM
	with 2.5.5.2/2.6.33
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

Hello, I am attempting to evaluate Xenomai and am running into an
illegal instruction when I try to run trivial-periodic.  I am running
Xenomai 2.5.5.2 with kernel 2.6.33.5-x3 on a Beagleboard.  Kernel and
Xenomai were cross compiled with CodeSourcery 4.4.1.  Upon boot I can
see /proc/xenomai/*.  Attempting to run trivial-periodic results in
the following output:

Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)

Note that CONFIG_XENO_OPT_PERVASIVE is in fact enabled, and nucleus is
built into the kernel.  Running in GDB, trivial-periodic receives
SIGILL (illegal instruction) and exits.  I get the following
backtrace:

#0  0x40022498 in xeno_bind_skin_opt () from /usr/xenomai/lib/libxenomai.so.0
#1  0x00000000 in ?? ()

And the disassembly around the PC is:

   0x4002247c <+124>:   movw    r0, #555        ; 0x22b
   0x40022480 <+128>:   mov     r6, r5
   0x40022484 <+132>:   mov     r1, r8
   0x40022488 <+136>:   mov     r2, #1610612743 ; 0x60000007
   0x4002248c <+140>:   mov     r3, #3
   0x40022490 <+144>:   mov     r4, r7
   0x40022494 <+148>:   svc     0x009f0042
=> 0x40022498 <+152>:   ldr     r12, [sp, #2140]        ; 0x85c
   0x4002249c <+156>:   cmp     r12, #0
   0x400224a0 <+160>:   beq     0x4002246c <xeno_bind_skin_opt+108>
   0x400224a4 <+164>:   mov     r2, r0
   0x400224a8 <+168>:   mvn     r1, #84 ; 0x54
   0x400224ac <+172>:   mov     r0, r11
   0x400224b0 <+176>:   bl      0x400220d8
   0x400224b4 <+180>:   cmn     r0, #85 ; 0x55

The other example programs result in a SIGILL in exactly the same place.

Does anyone have any ideas or suggestions?

Thank you.

- Eric

