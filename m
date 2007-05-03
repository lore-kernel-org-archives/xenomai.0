Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 3 May 2007 16:32:49 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01E43DFF@is-hdq-exchange.marel.net>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-help] Kernel-oops, cyclictest, ctrl-c, MPC5200B
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi,

When experimenting with the cyclictest program for trying out
/proc/xenomai/latency I found out that ending this program with <STRG>-c
causes a Kernel oops of my 2.4.25 Kernel. There seems to be an infinite
recursion. /proc/xenomai/latency was left at its standard value.
Cyclictest is started without any parameters.

I use the Xenomai 2.3.1 release.=20

This is the translated output from ksymoops:

=3D=3D=3D=3D

ksymoops 2.4.11 on ppc 2.4.25.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.25/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid
lsmod file?
Error (regular_file): read_system_map stat /usr/src/linux/System.map
failed
Kernel stack overflow in process cda6e000, r1=3Dcda6e380
NIP: C011FC3C XER: 00000000 LR: C0120900 SP: CDA6E380 REGS: cda6e2d0
TRAP: 0300    Not tainted
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D cda6e000[390] 'cyclictest' Last syscall: 37
last math 00000000 last altivec 00000000
GPR00: 00000008 CDA6E380 CDA6E000 CFE21328 C025C9F8 CFE214B4 00000020
00000001
GPR08: 00000002 00000005 00000103 C025D650 00000000 1001B400 00000000
0FF82B80
GPR16: 00000000 00000000 C0200000 CDA6E540 C0237AA0 00000000 C0220000
00000000
GPR24: 00000001 C01FCE80 C0210000 C0237AA0 C0220000 00000001 00000001
C025C9F8
Call backtrace:
C01205F0 C0120900 C01179CC C011BC24 C0114E84 C01560D8 C0024D8C
C000EBDC C0005D0C C01205F0 C0120900 C01179CC C011BC24 C0114E84
C01560D8 C0024D8C C000EBDC C0005D0C C01205F0 C0120900 C01179CC
C011BC24 C0114E84 C01560D8 C0024D8C C000EBDC C0005D0C C01205F0
C0120900 C01179CC C011BC24 C0114E84 C01560D8
Kernel panic: kernel stack overflow
Warning (Oops_read): Code line not seen, dumping what data is available


>>NIP; c011fc3c <xntimer_freeze+dc/c20>   <=3D=3D=3D=3D=3D

>>GPR4; c025c9f8 <xnmod_glink_queue+228/164e0>
>>GPR11; c025d650 <xnmod_glink_queue+e80/164e0>
>>GPR18; c0200000 <ipipe_root+3180/35c0>
>>GPR20; c0237aa0 <rthal_domain+0/3020>
>>GPR22; c0220000 <ide_register_driver+8ac/68c4>
>>GPR25; c01fce80 <ipipe_root+0/35c0>
>>GPR26; c0210000 <sysctl_ip_default_ttl+1120/4b00>
>>GPR27; c0237aa0 <rthal_domain+0/3020>
>>GPR28; c0220000 <ide_register_driver+8ac/68c4>
>>GPR31; c025c9f8 <xnmod_glink_queue+228/164e0>

Trace; c01205f0 <xntimer_freeze+a90/c20>
Trace; c0120900 <xnshadow_relax+5c/158>
Trace; c01179cc <xnpod_fatal_helper+830/93c>
Trace; c011bc24 <xnpod_trap_fault+50/e4>
Trace; c0114e84 <xnintr_affinity+2e0/638>
Trace; c01560d8 <rthal_irq_end+dc/144>
Trace; c0024d8c <__ipipe_dispatch_event+b4/198>
Trace; c000ebdc <set_pte+a78/1220>
Trace; c0005d0c <ret_from_intercept+c/4c>
Trace; c01205f0 <xntimer_freeze+a90/c20>
Trace; c0120900 <xnshadow_relax+5c/158>
Trace; c01179cc <xnpod_fatal_helper+830/93c>
Trace; c011bc24 <xnpod_trap_fault+50/e4>
Trace; c0114e84 <xnintr_affinity+2e0/638>
Trace; c01560d8 <rthal_irq_end+dc/144>
Trace; c0024d8c <__ipipe_dispatch_event+b4/198>
Trace; c000ebdc <set_pte+a78/1220>
Trace; c0005d0c <ret_from_intercept+c/4c>
Trace; c01205f0 <xntimer_freeze+a90/c20>
Trace; c0120900 <xnshadow_relax+5c/158>
Trace; c01179cc <xnpod_fatal_helper+830/93c>
Trace; c011bc24 <xnpod_trap_fault+50/e4>
Trace; c0114e84 <xnintr_affinity+2e0/638>
Trace; c01560d8 <rthal_irq_end+dc/144>
Trace; c0024d8c <__ipipe_dispatch_event+b4/198>
Trace; c000ebdc <set_pte+a78/1220>
Trace; c0005d0c <ret_from_intercept+c/4c>
Trace; c01205f0 <xntimer_freeze+a90/c20>
Trace; c0120900 <xnshadow_relax+5c/158>
Trace; c01179cc <xnpod_fatal_helper+830/93c>
Trace; c011bc24 <xnpod_trap_fault+50/e4>
Trace; c0114e84 <xnintr_affinity+2e0/638>
Trace; c01560d8 <rthal_irq_end+dc/144>


3 warnings and 1 error issued.  Results may not be reliable.



