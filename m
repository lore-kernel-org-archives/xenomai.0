Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA249B.A4311184"
Date: Mon, 24 Aug 2009 11:17:02 +0200
Message-ID: <EB48F2CADC239E44A8598CC0B0571102E4A9C6@domain.hid>
References: <EB48F2CADC239E44A8598CC0B0571102E4A9BE@XVS-DCFR-21.europe.corp.altran.com>
	<4A8C23BE.8050904@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C2@domain.hid>
	<4A8E628C.8010001@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C4@domain.hid>
	<4A8F1E70.6090608@domain.hid>
From: =?iso-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Subject: [Xenomai-help] RE :  Native message queue and synchronisation
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA249B.A4311184
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the delay, I've issued a problem using the serial line.

As I can see in the Oops trace, the problem is due to my compiler. I'll =
checked my compilation parameters or a newer version of my compiler.

I can also see that there is a problem with the CPU_FREQ option. It's =
mentioned as a "latency killer" in the TROUBLESHOOTING document. I'll =
checked it too.

Thanks a lot,


Linux version 2.6.28-dirty (berruer@domain.hid) (gcc version 4.2.3 =
(Sourcery G++ Lite 2008q1-126)) #2 Fri Aug 21 16:46:20 CEST 2009
CPU: XScale-PXA255 [69052d06] revision 6 (ARMv5TE), cr=3D0000397f
CPU: VIVT data cache, VIVT instruction cache
Machine: Arcom/Eurotech VIPER SBC
Memory policy: ECC disabled, Data cache writeback
Memory clock: 99.53MHz (*27)
Run Mode clock: 99.53MHz (*1)
Turbo Mode clock: 99.53MHz (*1.0, inactive)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
16256
Kernel command line: root=3D/dev/nfs =
nfsroot=3D/srv/nfsboot,nfsvers=3D3,tcp =
ip=3D192.168.0.118:192.168.0.117:::::off: console=3DttyS1,115200
PID hash table entries: 256 (order: 8, 1024 bytes)
I-pipe 1.12-02: pipeline enabled.
Console: colour dummy device 80x30
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB =3D 64MB total
Memory: 62004KB available (2500K code, 263K data, 100K init)
Calibrating delay loop... 99.32 BogoMIPS (lpj=3D496640)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 288 bytes
NET: Registered protocol family 16
viper: hardware v2i3 detected. CPLD revision 1.
I2C: i2c-0: PXA I2C adapter
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
PXA CPU frequency change support initialized
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: real-time nucleus v2.4.8 (Lords Of Karma) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 121
io scheduler noop registered
io scheduler deadline registered (default)
pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq =3D 38) is a FFUART
pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq =3D 37) is a BTUART
console [ttyS1] enabled
pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq =3D 36) is a STUART
pxa2xx-uart.3: ttyS3 at MMIO 0x41600000 (irq =3D 23) is a HWUART
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@domain.hid>
eth0: SMC91C11xFD (rev 1) at c486c300 IRQ 24 [nowait]
eth0: Ethernet addr: 00:80:66:10:52:b3
physmap platform flash device: 02000000 at 04000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
cmdlinepart partition parsing not available
Searching for RedBoot partition table in physmap-flash.0 at offset 0x0
3 RedBoot partitions found on MTD device physmap-flash.0
Creating 3 MTD partitions on "physmap-flash.0":
0x00000000-0x0001f000 : "FIS directory"
mtd: partition "FIS directory" doesn't end on an erase block -- force =
read-only
0x0001f000-0x00020000 : "RedBoot config"
mtd: partition "RedBoot config" doesn't start on an erase block boundary =
-- force read-only
0x00020000-0x02000000 : "filesystem"
physmap platform flash device: 00100000 at 00000000
Found: AMD AM29LV800BB
physmap-flash.1: Found 1 x16 devices at 0x0 in 16-bit bank
number of JEDEC chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
Searching for RedBoot partition table in physmap-flash.1 at offset 0x0
No RedBoot partition table detected in physmap-flash.1
Using physmap partition information
Creating 1 MTD partitions on "physmap-flash.1":
0x00000000-0x00100000 : "RedBoot"
i2c /dev entries driver
i2c-gpio i2c-gpio.1: using pins 83 (SDA) and 84 (SCL)
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
XScale DSP coprocessor detected.
eth0: link down
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
     device=3Deth0, addr=3D192.168.0.118, mask=3D255.255.255.0, =
gw=3D255.255.255.255,
     host=3D192.168.0.118, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.0.117, rootserver=3D192.168.0.117, rootpath=3D
Looking up port of RPC 100003/3 on 192.168.0.117
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Looking up port of RPC 100005/3 on 192.168.0.117
VFS: Mounted root (nfs filesystem).
Freeing init memory: 100K
INIT: version 2.86 booting
hwclock: can't open '/dev/misc/rtc': No such file or directory
INIT: Entering runlevel: 3
login[303]: root login on 'pts/0'
Internal error: Oops - undefined instruction: 0 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.28-dirty #2)
PC is at dsp_do+0x34/0x54
LR is at notifier_call_chain+0x34/0x78
pc : [<c0027c80>]    lr : [<c004dd68>]    psr: 60000093
sp : c0293f10  ip : c0293f20  fp : c0293f1c
r10: c0292000  r9 : 69052d06  r8 : 00000002
r7 : c39e2000  r6 : 00000000  r5 : fffffffe  r4 : 00000000
r3 : c0292000  r2 : c0293f10  r1 : 00000002  r0 : c39e2000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0000397f  Table: a39cc000  DAC: 00000015
Process swapper (pid: 0, stack limit =3D 0xc0292270)
Stack: (0xc0293f10 to 0xc0294000)
3f00:                                     c0293f44 c0293f20 c004dd68 =
c0027c58=20
3f20: c39e201c c02950c0 00000015 c3823680 c38b2960 69052d06 c0293f5c =
c0293f48=20
3f40: c004ddc8 c004dd40 00000000 c02ad700 c0293f74 c0293f60 c004ddf0 =
c004ddb8=20
3f60: 00000000 c0292000 c0293f9c c0293f78 c0021fe8 c004dddc c00236e0 =
c0292000=20
3f80: c029eb60 c0295d40 a0019ea0 a0019e38 c0293fb4 c0293fa0 c00235dc =
c0206a3c=20
3fa0: c02c7e58 c02accc0 c0293fc4 c0293fb8 c0205294 c002359c c0293ff4 =
c0293fc8=20
3fc0: c00089cc c0205248 c0008380 00000000 00000000 c001bd98 00000000 =
0000397d=20
3fe0: c02acdd8 c001bd94 00000000 c0293ff8 a0008034 c000879c 00000000 =
00000000=20
Backtrace:=20
[<c0027c4c>] (dsp_do+0x0/0x54) from [<c004dd68>] =
(notifier_call_chain+0x34/0x78)
[<c004dd34>] (notifier_call_chain+0x0/0x78) from [<c004ddc8>] =
(__atomic_notifier_call_chain+0x1c/0x24)
 r9:69052d06 r8:c38b2960 r7:c3823680 r6:00000015 r5:c02950c0
r4:c39e201c
[<c004ddac>] (__atomic_notifier_call_chain+0x0/0x24) from [<c004ddf0>] =
(atomic_notifier_call_chain+0x20/0x28)
[<c004ddd0>] (atomic_notifier_call_chain+0x0/0x28) from [<c0021fe8>] =
(__switch_to+0x30/0x38)
[<c0206a30>] (schedule+0x0/0x400) from [<c00235dc>] (cpu_idle+0x4c/0x58)
[<c0023590>] (cpu_idle+0x0/0x58) from [<c0205294>] (rest_init+0x58/0x6c)
 r5:c02accc0 r4:c02c7e58
[<c020523c>] (rest_init+0x0/0x6c) from [<c00089cc>] =
(start_kernel+0x23c/0x288)
[<c0008790>] (start_kernel+0x0/0x288) from [<a0008034>] (0xa0008034)
 r6:c001bd94 r5:c02acdd8 r4:0000397d
Code: 1a000008 e1a0200d e3c23d7f e3c3303f (ec521000)=20
---[ end trace 0ae9945a496219a0 ]---
Kernel panic - not syncing: Attempted to kill the idle task!




+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| BERRUER S=E9bastien
| Trainee at Altran Ouest
| Centre d'Affaires Alphasis
| 35760 Saint-Gr=E9goire - FRANCE
| Tel: 06-76-35-29-55
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D





------_=_NextPart_001_01CA249B.A4311184
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE : [Xenomai-help] Native message queue and =
synchronisation</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
Sorry for the delay, I've issued a problem using the serial line.<BR>
<BR>
As I can see in the Oops trace, the problem is due to my compiler. I'll =
checked my compilation parameters or a newer version of my compiler.<BR>
<BR>
I can also see that there is a problem with the CPU_FREQ option. It's =
mentioned as a &quot;latency killer&quot; in the TROUBLESHOOTING =
document. I'll checked it too.<BR>
<BR>
Thanks a lot,<BR>
<BR>
<BR>
Linux version 2.6.28-dirty (berruer@domain.hid) (gcc version 4.2.3 =
(Sourcery G++ Lite 2008q1-126)) #2 Fri Aug 21 16:46:20 CEST 2009<BR>
CPU: XScale-PXA255 [69052d06] revision 6 (ARMv5TE), cr=3D0000397f<BR>
CPU: VIVT data cache, VIVT instruction cache<BR>
Machine: Arcom/Eurotech VIPER SBC<BR>
Memory policy: ECC disabled, Data cache writeback<BR>
Memory clock: 99.53MHz (*27)<BR>
Run Mode clock: 99.53MHz (*1)<BR>
Turbo Mode clock: 99.53MHz (*1.0, inactive)<BR>
Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total =
pages: 16256<BR>
Kernel command line: root=3D/dev/nfs =
nfsroot=3D/srv/nfsboot,nfsvers=3D3,tcp =
ip=3D192.168.0.118:192.168.0.117:::::off: console=3DttyS1,115200<BR>
PID hash table entries: 256 (order: 8, 1024 bytes)<BR>
I-pipe 1.12-02: pipeline enabled.<BR>
Console: colour dummy device 80x30<BR>
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<BR>
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<BR>
Memory: 64MB =3D 64MB total<BR>
Memory: 62004KB available (2500K code, 263K data, 100K init)<BR>
Calibrating delay loop... 99.32 BogoMIPS (lpj=3D496640)<BR>
Mount-cache hash table entries: 512<BR>
CPU: Testing write buffer coherency: ok<BR>
net_namespace: 288 bytes<BR>
NET: Registered protocol family 16<BR>
viper: hardware v2i3 detected. CPLD revision 1.<BR>
I2C: i2c-0: PXA I2C adapter<BR>
NET: Registered protocol family 2<BR>
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)<BR>
TCP established hash table entries: 2048 (order: 2, 16384 bytes)<BR>
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)<BR>
TCP: Hash tables configured (established 2048 bind 2048)<BR>
TCP reno registered<BR>
NET: Registered protocol family 1<BR>
PXA CPU frequency change support initialized<BR>
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE<BR>
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE<BR>
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE<BR>
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE<BR>
I-pipe: Domain Xenomai registered.<BR>
Xenomai: hal/arm started.<BR>
Xenomai: real-time nucleus v2.4.8 (Lords Of Karma) loaded.<BR>
Xenomai: starting native API services.<BR>
Xenomai: starting POSIX services.<BR>
Xenomai: starting RTDM services.<BR>
JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.<BR>
msgmni has been set to 121<BR>
io scheduler noop registered<BR>
io scheduler deadline registered (default)<BR>
pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq =3D 38) is a FFUART<BR>
pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq =3D 37) is a BTUART<BR>
console [ttyS1] enabled<BR>
pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq =3D 36) is a STUART<BR>
pxa2xx-uart.3: ttyS3 at MMIO 0x41600000 (irq =3D 23) is a HWUART<BR>
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre &lt;nico@domain.hid&gt;<BR>
eth0: SMC91C11xFD (rev 1) at c486c300 IRQ 24 [nowait]<BR>
eth0: Ethernet addr: 00:80:66:10:52:b3<BR>
physmap platform flash device: 02000000 at 04000000<BR>
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank<BR>
&nbsp;Intel/Sharp Extended Query Table at 0x0031<BR>
Using buffer write method<BR>
cfi_cmdset_0001: Erase suspend on write enabled<BR>
cmdlinepart partition parsing not available<BR>
Searching for RedBoot partition table in physmap-flash.0 at offset =
0x0<BR>
3 RedBoot partitions found on MTD device physmap-flash.0<BR>
Creating 3 MTD partitions on &quot;physmap-flash.0&quot;:<BR>
0x00000000-0x0001f000 : &quot;FIS directory&quot;<BR>
mtd: partition &quot;FIS directory&quot; doesn't end on an erase block =
-- force read-only<BR>
0x0001f000-0x00020000 : &quot;RedBoot config&quot;<BR>
mtd: partition &quot;RedBoot config&quot; doesn't start on an erase =
block boundary -- force read-only<BR>
0x00020000-0x02000000 : &quot;filesystem&quot;<BR>
physmap platform flash device: 00100000 at 00000000<BR>
Found: AMD AM29LV800BB<BR>
physmap-flash.1: Found 1 x16 devices at 0x0 in 16-bit bank<BR>
number of JEDEC chips: 1<BR>
cfi_cmdset_0002: Disabling erase-suspend-program due to code =
brokenness.<BR>
cmdlinepart partition parsing not available<BR>
Searching for RedBoot partition table in physmap-flash.1 at offset =
0x0<BR>
No RedBoot partition table detected in physmap-flash.1<BR>
Using physmap partition information<BR>
Creating 1 MTD partitions on &quot;physmap-flash.1&quot;:<BR>
0x00000000-0x00100000 : &quot;RedBoot&quot;<BR>
i2c /dev entries driver<BR>
i2c-gpio i2c-gpio.1: using pins 83 (SDA) and 84 (SCL)<BR>
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE<BR>
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE<BR>
CPU PXA: Unknown policy found. Using CPUFREQ_POLICY_PERFORMANCE<BR>
TCP cubic registered<BR>
NET: Registered protocol family 17<BR>
RPC: Registered udp transport module.<BR>
RPC: Registered tcp transport module.<BR>
XScale DSP coprocessor detected.<BR>
eth0: link down<BR>
IP-Config: Guessing netmask 255.255.255.0<BR>
IP-Config: Complete:<BR>
&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, addr=3D192.168.0.118, =
mask=3D255.255.255.0, gw=3D255.255.255.255,<BR>
&nbsp;&nbsp;&nbsp;&nbsp; host=3D192.168.0.118, domain=3D, =
nis-domain=3D(none),<BR>
&nbsp;&nbsp;&nbsp;&nbsp; bootserver=3D192.168.0.117, =
rootserver=3D192.168.0.117, rootpath=3D<BR>
Looking up port of RPC 100003/3 on 192.168.0.117<BR>
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1<BR>
Looking up port of RPC 100005/3 on 192.168.0.117<BR>
VFS: Mounted root (nfs filesystem).<BR>
Freeing init memory: 100K<BR>
INIT: version 2.86 booting<BR>
hwclock: can't open '/dev/misc/rtc': No such file or directory<BR>
INIT: Entering runlevel: 3<BR>
login[303]: root login on 'pts/0'<BR>
Internal error: Oops - undefined instruction: 0 [#1]<BR>
Modules linked in:<BR>
CPU: 0&nbsp;&nbsp;&nbsp; Not tainted&nbsp; (2.6.28-dirty #2)<BR>
PC is at dsp_do+0x34/0x54<BR>
LR is at notifier_call_chain+0x34/0x78<BR>
pc : [&lt;c0027c80&gt;]&nbsp;&nbsp;&nbsp; lr : =
[&lt;c004dd68&gt;]&nbsp;&nbsp;&nbsp; psr: 60000093<BR>
sp : c0293f10&nbsp; ip : c0293f20&nbsp; fp : c0293f1c<BR>
r10: c0292000&nbsp; r9 : 69052d06&nbsp; r8 : 00000002<BR>
r7 : c39e2000&nbsp; r6 : 00000000&nbsp; r5 : fffffffe&nbsp; r4 : =
00000000<BR>
r3 : c0292000&nbsp; r2 : c0293f10&nbsp; r1 : 00000002&nbsp; r0 : =
c39e2000<BR>
Flags: nZCv&nbsp; IRQs off&nbsp; FIQs on&nbsp; Mode SVC_32&nbsp; ISA =
ARM&nbsp; Segment kernel<BR>
Control: 0000397f&nbsp; Table: a39cc000&nbsp; DAC: 00000015<BR>
Process swapper (pid: 0, stack limit =3D 0xc0292270)<BR>
Stack: (0xc0293f10 to 0xc0294000)<BR>
3f00:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; c0293f44 c0293f20 c004dd68 c0027c58<BR>
3f20: c39e201c c02950c0 00000015 c3823680 c38b2960 69052d06 c0293f5c =
c0293f48<BR>
3f40: c004ddc8 c004dd40 00000000 c02ad700 c0293f74 c0293f60 c004ddf0 =
c004ddb8<BR>
3f60: 00000000 c0292000 c0293f9c c0293f78 c0021fe8 c004dddc c00236e0 =
c0292000<BR>
3f80: c029eb60 c0295d40 a0019ea0 a0019e38 c0293fb4 c0293fa0 c00235dc =
c0206a3c<BR>
3fa0: c02c7e58 c02accc0 c0293fc4 c0293fb8 c0205294 c002359c c0293ff4 =
c0293fc8<BR>
3fc0: c00089cc c0205248 c0008380 00000000 00000000 c001bd98 00000000 =
0000397d<BR>
3fe0: c02acdd8 c001bd94 00000000 c0293ff8 a0008034 c000879c 00000000 =
00000000<BR>
Backtrace:<BR>
[&lt;c0027c4c&gt;] (dsp_do+0x0/0x54) from [&lt;c004dd68&gt;] =
(notifier_call_chain+0x34/0x78)<BR>
[&lt;c004dd34&gt;] (notifier_call_chain+0x0/0x78) from =
[&lt;c004ddc8&gt;] (__atomic_notifier_call_chain+0x1c/0x24)<BR>
&nbsp;r9:69052d06 r8:c38b2960 r7:c3823680 r6:00000015 r5:c02950c0<BR>
r4:c39e201c<BR>
[&lt;c004ddac&gt;] (__atomic_notifier_call_chain+0x0/0x24) from =
[&lt;c004ddf0&gt;] (atomic_notifier_call_chain+0x20/0x28)<BR>
[&lt;c004ddd0&gt;] (atomic_notifier_call_chain+0x0/0x28) from =
[&lt;c0021fe8&gt;] (__switch_to+0x30/0x38)<BR>
[&lt;c0206a30&gt;] (schedule+0x0/0x400) from [&lt;c00235dc&gt;] =
(cpu_idle+0x4c/0x58)<BR>
[&lt;c0023590&gt;] (cpu_idle+0x0/0x58) from [&lt;c0205294&gt;] =
(rest_init+0x58/0x6c)<BR>
&nbsp;r5:c02accc0 r4:c02c7e58<BR>
[&lt;c020523c&gt;] (rest_init+0x0/0x6c) from [&lt;c00089cc&gt;] =
(start_kernel+0x23c/0x288)<BR>
[&lt;c0008790&gt;] (start_kernel+0x0/0x288) from [&lt;a0008034&gt;] =
(0xa0008034)<BR>
&nbsp;r6:c001bd94 r5:c02acdd8 r4:0000397d<BR>
Code: 1a000008 e1a0200d e3c23d7f e3c3303f (ec521000)<BR>
---[ end trace 0ae9945a496219a0 ]---<BR>
Kernel panic - not syncing: Attempted to kill the idle task!<BR>
<BR>
<BR>
<BR>
<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
| BERRUER S=E9bastien<BR>
| Trainee at Altran Ouest<BR>
| Centre d'Affaires Alphasis<BR>
| 35760 Saint-Gr=E9goire - FRANCE<BR>
| Tel: 06-76-35-29-55<BR>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA249B.A4311184--

