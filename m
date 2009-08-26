MIME-Version: 1.0
Date: Wed, 26 Aug 2009 11:46:49 +0200
Message-ID: <2f7260f50908260246jed2b885q9c67375b19343920@domain.hid>
From: =?ISO-8859-1?Q?Imanol_Mart=EDnez?= <imanolmc@domain.hid>
Content-Type: multipart/alternative; boundary=0015175cd1e87aa65b047208548a
Subject: [Xenomai-help] Problem with PXA320 and xenomai 2.4.9
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

--0015175cd1e87aa65b047208548a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello all,

I have installed xenomai 2.4.9 in a linux 2.6.30 kernel. It seems that all
the boot is done correctly but when reaching the point to access the nfs
filesystem I get the following error:

<4>[   32.879389] WARNING: at net/sched/sch_generic.c:226
dev_watchdog+0x2c0/0x2e0()
[   32.879389] WARNING: at net/sched/sch_generic.c:226
dev_watchdog+0x2c0/0x2e0()
<6>[   33.055929] NETDEV WATCHDOG: eth0 (): transmit timed out
[   33.055929] NETDEV WATCHDOG: eth0 (): transmit timed out

and after some seconds

<7>[   39.438510] eth0: Tx timed out, lost interrupt? TSR=0x1, ISR=0x3,
t=160.
<7>[   49.765548] eth0: Tx timed out, lost interrupt? TSR=0x1, ISR=0x2,
t=1025.
<7>[   51.765562] eth0: Tx timed out, lost interrupt? TSR=0x1, ISR=0x2,
t=124

Any idea or help to solve this problem...

Thanks

  Imanol

I attached here all the boot log:



[    0.000000] Linux version 2.6.30 (root@domain.hid) (gcc version 4.2.2) #2
PREEMPT Wed Aug 26 11:25:01 CEST 2009
[    0.000000] CPU: XScale-V3 based processor [69056826] revision 6
(ARMv5TE), cr=0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Toradex Colibri PXA320
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] RO Mode clock: 60.00MHz (inactive)
[    0.000000] Run Mode clock: 403.00MHz (*31)
[    0.000000] Turbo Mode clock: 806.00MHz (*2, active)
[    0.000000] HSIO bus clock: 208.00MHz
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total
pages: 32512
[    0.000000] Kernel command line: root=/dev/nfs rw
nfsroot=172.16.5.4:/home/imanol/work/rootfilesystem/rootfs2.6
ip=172.16.5.253:172.16.5.4 rootdelay=2 console=ttyS0,9608
[    0.000000] NR_IRQS:192
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[   17.655537] I-pipe 1.14-00: pipeline enabled.
[   17.710434] Console: colour dummy device 80x30
[   17.766261] Dentry cache hash table entries: 16384 (order: 4, 65536
bytes)
[   17.851243] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[   17.943049] Memory: 128MB = 128MB total
[   17.991639] Memory: 124984KB available (3788K code, 829K data, 136K init,
0K highmem)
[   18.087889] SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0,
CPUs=1, Nodes=1
[   18.181969] Calibrating delay loop... 804.45 BogoMIPS (lpj=4022272)
[   18.479820] Security Framework initialized
[   18.531616] SELinux:  Disabled at boot.
[   18.580206] Mount-cache hash table entries: 512
[   18.637688] CPU: Testing write buffer coherency: failed, enabling
work-around
[   18.731872] net_namespace: 1044 bytes
[   18.780669] NET: Registered protocol family 16
[   18.850453] colibri_pxa3xx_init_eth(): taking MAC from serial boot tag
[   18.955285] bio: create slab <bio-0> at 0
[   19.013594] NET: Registered protocol family 8
[   19.068490] NET: Registered protocol family 20
[   19.130728] NET: Registered protocol family 2
[   19.249311] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[   19.335843] TCP established hash table entries: 4096 (order: 3, 32768
bytes)
[   19.422788] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[   19.502497] TCP: Hash tables configured (established 4096 bind 4096)
[   19.581069] TCP reno registered
[   19.621803] NET: Registered protocol family 1
[   19.680112] audit: initializing netlink socket (disabled)
[   19.747519] type=2000 audit(1.021:1): initialized
[   19.814926] I-pipe: Domain Xenomai registered.
[   19.870855] Xenomai: hal/arm started.
[   19.936402] Xenomai: real-time nucleus v2.4.9 (Big Bad Moon) loaded.
[   20.016112] Xenomai: starting native API services.
[   20.076177] Xenomai: starting POSIX services.
[   20.131177] Xenomai: starting RTDM services.
[   20.219985] VFS: Disk quotas dquot_6.5.2
[   20.270747] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   20.354282] msgmni has been set to 244
[   20.404940] alg: No test for stdrng (krng)
[   20.456942] io scheduler noop registered
[   20.506669] io scheduler anticipatory registered
[   20.564668] io scheduler deadline registered
[   20.619462] io scheduler cfq registered (default)
[   21.415728] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 22) is a
FFUART
[   21.500742] console [ttyS0] enabled
<6>[   25.144037] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 21) is a
BTUART
[   25.144037] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 21) is a
BTUART
<6>[   25.313995] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 20) is a
STUART
[   25.313995] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 20) is a
STUART
<6>[   25.504949] brd: module loaded
[   25.504949] brd: module loaded
<6>[   25.581625] ax88796 ax88796.0: 16bit, irq 100, c8862000, MAC:
00:14:2d:00:00:00
[   25.581625] ax88796 ax88796.0: 16bit, irq 100, c8862000, MAC:
00:14:2d:00:00:00
<6>[   25.764953] mice: PS/2 mouse device common for all mice
[   25.764953] mice: PS/2 mouse device common for all mice
<6>[   25.898874] TCP cubic registered
[   25.898874] TCP cubic registered
<6>[   25.980979] RPC: Registered udp transport module.
[   25.980979] RPC: Registered udp transport module.
<6>[   26.097035] RPC: Registered tcp transport module.
[   26.097035] RPC: Registered tcp transport module.
<4>[   26.213302] CAUTION: XScale iWMMXt coprocessor detected, but kernel
support is missing.
[   26.213302] CAUTION: XScale iWMMXt coprocessor detected, but kernel
support is missing.
<4>[   26.412091] registered taskstats version 1
[   26.412091] registered taskstats version 1
<4>[   26.513626] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   26.513626] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
<4>[   28.185633] IP-Config: Guessing netmask 255.255.0.0
[   28.185633] IP-Config: Guessing netmask 255.255.0.0
<4>[   28.306077] IP-Config: Complete:[   28.306077] IP-Config: Complete:
<4>[   28.384422]      device=eth0
[   28.384422]      device=eth0, addr=172.16.5.253, addr=172.16.5.253,
mask=255.255.0.0, mask=255.255.0.0, gw=255.255.255.255, gw=255.255.255.255,
<4>[   28.576631]      host=172.16.5.253, domain=, nis-domain=(none),
[   28.576631]      host=172.16.5.253, domain=, nis-domain=(none),
<4>[   28.721832]      bootserver=172.16.5.4,
[   28.721832]      bootserver=172.16.5.4, rootserver=172.16.5.4,
rootserver=172.16.5.4, rootpath=, rootpath=

<6>[   28.889075] Waiting 2sec before mounting root device...
[   28.889075] Waiting 2sec before mounting root device...
<5>[   31.025935] Looking up port of RPC 100003/2 on 172.16.5.4
[   31.025935] Looking up port of RPC 100003/2 on 172.16.5.4
<4>[   32.765527] ------------[ cut here ]------------
[   32.765527] ------------[ cut here ]------------
<4>[   32.879389] WARNING: at net/sched/sch_generic.c:226
dev_watchdog+0x2c0/0x2e0()
[   32.879389] WARNING: at net/sched/sch_generic.c:226
dev_watchdog+0x2c0/0x2e0()
<6>[   33.055929] NETDEV WATCHDOG: eth0 (): transmit timed out
[   33.055929] NETDEV WATCHDOG: eth0 (): transmit timed out
<4>[   33.186505] Modules linked in:[   33.186505] Modules linked in:

<4>[   33.262762] Backtrace: [   33.262762] Backtrace:

<4>[   33.324394] [<c002e92c>] [   33.324394] [<c002e92c>]
(dump_backtrace+0x0/0x110) (dump_backtrace+0x0/0x110) from [<c002ea70>] from
[<c002ea70>] (dump_stack+0x18/0x1c)
(dump_stack+0x18/0x1c)
<4>[   33.530182]  r6:c0263194[   33.530182]  r6:c0263194 r5:c03b7148
r5:c03b7148 r4:000000e2 r4:000000e2

<4>[   33.644045] [<c002ea58>] [   33.644045] [<c002ea58>]
(dump_stack+0x0/0x1c) (dump_stack+0x0/0x1c) from [<c00405f0>] from
[<c00405f0>] (warn_slowpath_common+0x50/0x68)
(warn_slowpath_common+0x50/0x68)
<4>[   33.860280] [<c00405a0>] [   33.860280] [<c00405a0>]
(warn_slowpath_common+0x0/0x68) (warn_slowpath_common+0x0/0x68) from
[<c0040654>] from [<c0040654>] (warn_slowpa)
(warn_slowpath_fmt+0x30/0x38)
<4>[   34.091140]  r7:00000001[   34.091140]  r7:00000001 r6:c7a44000
r6:c7a44000 r5:c03e6ec0 r5:c03e6ec0 r4:c03dfd6c r4:c03dfd6c

<4>[   34.230073] [<c0040624>] [   34.230073] [<c0040624>]
(warn_slowpath_fmt+0x0/0x38) (warn_slowpath_fmt+0x0/0x38) from [<c0263194>]
from [<c0263194>] (dev_watchdog+0x2c)
(dev_watchdog+0x2c0/0x2e0)
<4>[   34.448397]  r3:c7a44000[   34.448397]  r3:c7a44000 r2:c03b71d0
r2:c03b71d0

<4>[   34.537189]  r4:c04a638c[   34.537189]  r4:c04a638c

<4>[   34.600910] [<c0262ed4>] [   34.600910] [<c0262ed4>]
(dev_watchdog+0x0/0x2e0) (dev_watchdog+0x0/0x2e0) from [<c004bf28>] from
[<c004bf28>] (run_timer_softirq+0x1d0/0)
(run_timer_softirq+0x1d0/0x28c)
<4>[   34.821323] [<c004bd58>] [   34.821323] [<c004bd58>]
(run_timer_softirq+0x0/0x28c) (run_timer_softirq+0x0/0x28c) from
[<c0046734>] from [<c0046734>] (__do_softirq+0x)
(__do_softirq+0x94/0x1fc)
<4>[   35.039648] [<c00466a0>] [   35.039648] [<c00466a0>]
(__do_softirq+0x0/0x1fc) (__do_softirq+0x0/0x1fc) from [<c0046d50>] from
[<c0046d50>] (irq_exit+0x98/0xa0)
(irq_exit+0x98/0xa0)
<4>[   35.237079] [<c0046cb8>] [   35.237079] [<c0046cb8>]
(irq_exit+0x0/0xa0) (irq_exit+0x0/0xa0) from [<c002a060>] from [<c002a060>]
(_text+0x60/0x70)
(_text+0x60/0x70)
<4>[   35.417797]  r4:0000001a[   35.417797]  r4:0000001a

<4>[   35.481519] [<c002a000>] [   35.481519] [<c002a000>] (_text+0x0/0x70)
(_text+0x0/0x70) from [<c0080454>] from [<c0080454>]
(__ipipe_sync_stage+0x224/0x260)
(__ipipe_sync_stage+0x224/0x260)
<4>[   35.687307] Exception stack(0xc03dfe84 to 0xc03dfecc)
[   35.687307] Exception stack(0xc03dfe84 to 0xc03dfecc)
<4>[   35.811616] fe80: [   35.811616] fe80:                   fffffffe
fffffffe 00000000 00000000 c03ecfac c03ecfac c045b860 c045b860 c045b860
c045b860 c03ec454 c03ec454

<4>[   36.013226] fea0: [   36.013226] fea0: c03ed378 c03ed378 c04826e4
c04826e4 c03dfed8 c03dfed8 c03dfeb8 c03dfeb8 c008063c c008063c c008023c
c008023c c03ecfac c03ecfac

<4>[   36.214836] fec0: [   36.214836] fec0: c03ed374 c03ed374 c045b860
c045b860 c045b860
c045b860

<4>[   36.416446]  r6:00000340[   36.416446]  r6:00000340 r5:00000000
r5:00000000 r4:c03ec454 r4:c03ec454

<4>[   36.530309] [<c0080230>] [   36.530309] [<c0080230>]
(__ipipe_sync_stage+0x0/0x260) (__ipipe_sync_stage+0x0/0x260) from
[<c008063c>] from [<c008063c>] (__ipipe_walk_)
(__ipipe_walk_pipeline+0xe8/0xfc)
<4>[   36.767436] [<c0080554>] [   36.767436] [<c0080554>]
(__ipipe_walk_pipeline+0x0/0xfc) (__ipipe_walk_pipeline+0x0/0xfc) from
[<c00806d0>] from [<c00806d0>] (__ipipe_d)
(__ipipe_dispatch_wired_nocheck+0x80/0xb0)
<4>[   37.027545]  r8:c045b860[   37.027545]  r8:c045b860 r7:c045b860
r7:c045b860 r6:c03ed374 r6:c03ed374 r5:c04826e0 r5:c04826e0 r4:c03ecfac
r4:c03ecfac

<4>[   37.191549] [<c0080650>] [   37.191549] [<c0080650>]
(__ipipe_dispatch_wired_nocheck+0x0/0xb0)
(__ipipe_dispatch_wired_nocheck+0x0/0xb0) from [<c008135c>] from [<c00)
(__ipipe_dispatch_wired+0x4c/0x88)
<4>[   37.453747]  r7:00000000[   37.453747]  r7:00000000 r6:0000001a
r6:0000001a r5:00000340 r5:00000340 r4:0000001a r4:0000001a

<4>[   37.592680] [<c0081310>] [   37.592680] [<c0081310>]
(__ipipe_dispatch_wired+0x0/0x88) (__ipipe_dispatch_wired+0x0/0x88) from
[<c002fdbc>] from [<c002fdbc>] (__ipipe)
(__ipipe_handle_irq+0x158/0x1ac)
<4>[   37.833986]  r4:c04826e0[   37.833986]  r4:c04826e0

<4>[   37.897707] [<c002fc64>] [   37.897707] [<c002fc64>]
(__ipipe_handle_irq+0x0/0x1ac) (__ipipe_handle_irq+0x0/0x1ac) from
[<c002fe40>] from [<c002fe40>] (__ipipe_grab_)
(__ipipe_grab_irq+0x30/0xac)
<4>[   38.124387] [<c002fe10>] [   38.124387] [<c002fe10>]
(__ipipe_grab_irq+0x0/0xac) (__ipipe_grab_irq+0x0/0xac) from [<c02f7930>]
from [<c02f7930>] (__irq_svc+0x30/0xd8)
(__irq_svc+0x30/0xd8)
<4>[   38.330176] [<c002bce0>] [   38.330176] [<c002bce0>]
(default_idle+0x0/0x6c) (default_idle+0x0/0x6c) from [<c002bbac>] from
[<c002bbac>] (cpu_idle+0x48/0x78)
(cpu_idle+0x48/0x78)
<4>[   38.525519] [<c002bb64>] [   38.525519] [<c002bb64>]
(cpu_idle+0x0/0x78) (cpu_idle+0x0/0x78) from [<c02f3e28>] from [<c02f3e28>]
(rest_init+0x6c/0x80)
(rest_init+0x6c/0x80)
<4>[   38.714593]  r6:c0027ee0[   38.714593]  r6:c0027ee0 r5:c04088dc
r5:c04088dc r4:c04952ac r4:c04952ac

<4>[   38.828456] [<c02f3dbc>] [   38.828456] [<c02f3dbc>]
(rest_init+0x0/0x80) (rest_init+0x0/0x80) from [<c0008bc8>] from
[<c0008bc8>] (start_kernel+0x21c/0x30c)
(start_kernel+0x21c/0x30c)
<4>[   39.030067] [<c00089ac>] [   39.030067] [<c00089ac>]
(start_kernel+0x0/0x30c) (start_kernel+0x0/0x30c) from [<80008034>] from
[<80008034>] (0x80008034)
(0x80008034)
<4>[   39.210784]  r6:c00282e4[   39.210784]  r6:c00282e4 r5:c0408938
r5:c0408938 r4:0000397d r4:0000397d

<4>[   39.324647] ---[ end trace 8741cd9a646bbb13 ]---
[   39.324647] ---[ end trace 8741cd9a646bbb13 ]---
<7>[   39.438510] eth0: Tx timed out, lost interrupt? TSR=0x1, ISR=0x3,
t=160.
<7>[   49.765548] eth0: Tx timed out, lost interrupt? TSR=0x1, ISR=0x2,
t=1025.
<7>[   51.765562] eth0: Tx timed out, lost interrupt? TSR=0x1, ISR=0x2,
t=124

--0015175cd1e87aa65b047208548a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><font size=3D"2">Hello all,<br><br>I have installed xenomai 2.4.9 in a l=
inux 2.6.30 kernel. It seems that all the boot is done correctly but when r=
eaching the point to access the nfs filesystem I get the following error:<b=
r>
<br>&lt;4&gt;[=A0=A0 32.879389] WARNING: at net/sched/sch_generic.c:226 dev=
_watchdog+0x2c0/0x2e0()<br>[=A0=A0 32.879389] WARNING: at net/sched/sch_gen=
eric.c:226 dev_watchdog+0x2c0/0x2e0()<br>&lt;6&gt;[=A0=A0 33.055929] NETDEV=
 WATCHDOG: eth0 (): transmit timed out<br>
[=A0=A0 33.055929] NETDEV WATCHDOG: eth0 (): transmit timed out<br><br>and =
after some seconds<br><br>&lt;7&gt;[=A0=A0 39.438510] eth0: Tx timed out, l=
ost interrupt? TSR=3D0x1, ISR=3D0x3, t=3D160.<br>&lt;7&gt;[=A0=A0 49.765548=
] eth0: Tx timed out, lost interrupt? TSR=3D0x1, ISR=3D0x2, t=3D1025.<br>
&lt;7&gt;[=A0=A0 51.765562] eth0: Tx timed out, lost interrupt? TSR=3D0x1, =
ISR=3D0x2, t=3D124<br><br>Any idea or help to solve this problem...<br><br>=
Thanks<br><br>=A0 Imanol<br><br>I attached here all the boot log:<br><br><b=
r><br>[=A0=A0=A0 0.000000] Linux version 2.6.30 (root@domain.hid) (gcc vers=
ion 4.2.2) #2 PREEMPT Wed Aug 26 11:25:01 CEST 2009<br>
[=A0=A0=A0 0.000000] CPU: XScale-V3 based processor [69056826] revision 6 (=
ARMv5TE), cr=3D0000397f<br>[=A0=A0=A0 0.000000] CPU: VIVT data cache, VIVT =
instruction cache<br>[=A0=A0=A0 0.000000] Machine: Toradex Colibri PXA320<b=
r>[=A0=A0=A0 0.000000] Memory policy: ECC disabled, Data cache writeback<br=
>
[=A0=A0=A0 0.000000] RO Mode clock: 60.00MHz (inactive)<br>[=A0=A0=A0 0.000=
000] Run Mode clock: 403.00MHz (*31)<br>[=A0=A0=A0 0.000000] Turbo Mode clo=
ck: 806.00MHz (*2, active)<br>[=A0=A0=A0 0.000000] HSIO bus clock: 208.00MH=
z<br>[=A0=A0=A0 0.000000] Built 1 zonelists in Zone order, mobility groupin=
g on.=A0 Total pages: 32512<br>
[=A0=A0=A0 0.000000] Kernel command line: root=3D/dev/nfs rw nfsroot=3D172.=
16.5.4:/home/imanol/work/rootfilesystem/rootfs2.6 ip=3D172.16.5.253:172.16.=
5.4 rootdelay=3D2 console=3DttyS0,9608<br>[=A0=A0=A0 0.000000] NR_IRQS:192<=
br>[=A0=A0=A0 0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)<=
br>
[=A0=A0 17.655537] I-pipe 1.14-00: pipeline enabled.<br>[=A0=A0 17.710434] =
Console: colour dummy device 80x30<br>[=A0=A0 17.766261] Dentry cache hash =
table entries: 16384 (order: 4, 65536 bytes)<br>[=A0=A0 17.851243] Inode-ca=
che hash table entries: 8192 (order: 3, 32768 bytes)<br>
[=A0=A0 17.943049] Memory: 128MB =3D 128MB total<br>[=A0=A0 17.991639] Memo=
ry: 124984KB available (3788K code, 829K data, 136K init, 0K highmem)<br>[=
=A0=A0 18.087889] SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-3, MinObject=
s=3D0, CPUs=3D1, Nodes=3D1<br>
[=A0=A0 18.181969] Calibrating delay loop... 804.45 BogoMIPS (lpj=3D4022272=
)<br>[=A0=A0 18.479820] Security Framework initialized<br>[=A0=A0 18.531616=
] SELinux:=A0 Disabled at boot.<br>[=A0=A0 18.580206] Mount-cache hash tabl=
e entries: 512<br>
[=A0=A0 18.637688] CPU: Testing write buffer coherency: failed, enabling wo=
rk-around<br>[=A0=A0 18.731872] net_namespace: 1044 bytes<br>[=A0=A0 18.780=
669] NET: Registered protocol family 16<br>[=A0=A0 18.850453] colibri_pxa3x=
x_init_eth(): taking MAC from serial boot tag<br>
[=A0=A0 18.955285] bio: create slab &lt;bio-0&gt; at 0<br>[=A0=A0 19.013594=
] NET: Registered protocol family 8<br>[=A0=A0 19.068490] NET: Registered p=
rotocol family 20<br>[=A0=A0 19.130728] NET: Registered protocol family 2<b=
r>[=A0=A0 19.249311] IP route cache hash table entries: 1024 (order: 0, 409=
6 bytes)<br>
[=A0=A0 19.335843] TCP established hash table entries: 4096 (order: 3, 3276=
8 bytes)<br>[=A0=A0 19.422788] TCP bind hash table entries: 4096 (order: 2,=
 16384 bytes)<br>[=A0=A0 19.502497] TCP: Hash tables configured (establishe=
d 4096 bind 4096)<br>
[=A0=A0 19.581069] TCP reno registered<br>[=A0=A0 19.621803] NET: Registere=
d protocol family 1<br>[=A0=A0 19.680112] audit: initializing netlink socke=
t (disabled)<br>[=A0=A0 19.747519] type=3D2000 audit(1.021:1): initialized<=
br>[=A0=A0 19.814926] I-pipe: Domain Xenomai registered.<br>
[=A0=A0 19.870855] Xenomai: hal/arm started.<br>[=A0=A0 19.936402] Xenomai:=
 real-time nucleus v2.4.9 (Big Bad Moon) loaded.<br>[=A0=A0 20.016112] Xeno=
mai: starting native API services.<br>[=A0=A0 20.076177] Xenomai: starting =
POSIX services.<br>
[=A0=A0 20.131177] Xenomai: starting RTDM services.<br>[=A0=A0 20.219985] V=
FS: Disk quotas dquot_6.5.2<br>[=A0=A0 20.270747] Dquot-cache hash table en=
tries: 1024 (order 0, 4096 bytes)<br>[=A0=A0 20.354282] msgmni has been set=
 to 244<br>[=A0=A0 20.404940] alg: No test for stdrng (krng)<br>
[=A0=A0 20.456942] io scheduler noop registered<br>[=A0=A0 20.506669] io sc=
heduler anticipatory registered<br>[=A0=A0 20.564668] io scheduler deadline=
 registered<br>[=A0=A0 20.619462] io scheduler cfq registered (default)<br>=
[=A0=A0 21.415728] pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq =3D 22) is =
a FFUART<br>
[=A0=A0 21.500742] console [ttyS0] enabled<br>&lt;6&gt;[=A0=A0 25.144037] p=
xa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq =3D 21) is a BTUART<br>[=A0=A0 =
25.144037] pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq =3D 21) is a BTUART=
<br>&lt;6&gt;[=A0=A0 25.313995] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (ir=
q =3D 20) is a STUART<br>
[=A0=A0 25.313995] pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq =3D 20) is =
a STUART<br>&lt;6&gt;[=A0=A0 25.504949] brd: module loaded<br>[=A0=A0 25.50=
4949] brd: module loaded<br>&lt;6&gt;[=A0=A0 25.581625] ax88796 ax88796.0: =
16bit, irq 100, c8862000, MAC: 00:14:2d:00:00:00<br>
[=A0=A0 25.581625] ax88796 ax88796.0: 16bit, irq 100, c8862000, MAC: 00:14:=
2d:00:00:00<br>&lt;6&gt;[=A0=A0 25.764953] mice: PS/2 mouse device common f=
or all mice<br>[=A0=A0 25.764953] mice: PS/2 mouse device common for all mi=
ce<br>&lt;6&gt;[=A0=A0 25.898874] TCP cubic registered<br>
[=A0=A0 25.898874] TCP cubic registered<br>&lt;6&gt;[=A0=A0 25.980979] RPC:=
 Registered udp transport module.<br>[=A0=A0 25.980979] RPC: Registered udp=
 transport module.<br>&lt;6&gt;[=A0=A0 26.097035] RPC: Registered tcp trans=
port module.<br>
[=A0=A0 26.097035] RPC: Registered tcp transport module.<br>&lt;4&gt;[=A0=
=A0 26.213302] CAUTION: XScale iWMMXt coprocessor detected, but kernel supp=
ort is missing.<br>[=A0=A0 26.213302] CAUTION: XScale iWMMXt coprocessor de=
tected, but kernel support is missing.<br>
&lt;4&gt;[=A0=A0 26.412091] registered taskstats version 1<br>[=A0=A0 26.41=
2091] registered taskstats version 1<br>&lt;4&gt;[=A0=A0 26.513626] drivers=
/rtc/hctosys.c: unable to open rtc device (rtc0)<br>[=A0=A0 26.513626] driv=
ers/rtc/hctosys.c: unable to open rtc device (rtc0)<br>
&lt;4&gt;[=A0=A0 28.185633] IP-Config: Guessing netmask 255.255.0.0<br>[=A0=
=A0 28.185633] IP-Config: Guessing netmask 255.255.0.0<br>&lt;4&gt;[=A0=A0 =
28.306077] IP-Config: Complete:[=A0=A0 28.306077] IP-Config: Complete:<br>&=
lt;4&gt;[=A0=A0 28.384422]=A0=A0=A0=A0=A0 device=3Deth0<br>
[=A0=A0 28.384422]=A0=A0=A0=A0=A0 device=3Deth0, addr=3D172.16.5.253, addr=
=3D172.16.5.253, mask=3D255.255.0.0, mask=3D255.255.0.0, gw=3D255.255.255.2=
55, gw=3D255.255.255.255,<br>&lt;4&gt;[=A0=A0 28.576631]=A0=A0=A0=A0=A0 hos=
t=3D172.16.5.253, domain=3D, nis-domain=3D(none),<br>
[=A0=A0 28.576631]=A0=A0=A0=A0=A0 host=3D172.16.5.253, domain=3D, nis-domai=
n=3D(none),<br>&lt;4&gt;[=A0=A0 28.721832]=A0=A0=A0=A0=A0 bootserver=3D172.=
16.5.4,<br>[=A0=A0 28.721832]=A0=A0=A0=A0=A0 bootserver=3D172.16.5.4, roots=
erver=3D172.16.5.4, rootserver=3D172.16.5.4, rootpath=3D, rootpath=3D<br>
<br>&lt;6&gt;[=A0=A0 28.889075] Waiting 2sec before mounting root device...=
<br>[=A0=A0 28.889075] Waiting 2sec before mounting root device...<br>&lt;5=
&gt;[=A0=A0 31.025935] Looking up port of RPC 100003/2 on 172.16.5.4<br>[=
=A0=A0 31.025935] Looking up port of RPC 100003/2 on 172.16.5.4<br>
&lt;4&gt;[=A0=A0 32.765527] ------------[ cut here ]------------<br>[=A0=A0=
 32.765527] ------------[ cut here ]------------<br>&lt;4&gt;[=A0=A0 32.879=
389] WARNING: at net/sched/sch_generic.c:226 dev_watchdog+0x2c0/0x2e0()<br>=
[=A0=A0 32.879389] WARNING: at net/sched/sch_generic.c:226 dev_watchdog+0x2=
c0/0x2e0()<br>
&lt;6&gt;[=A0=A0 33.055929] NETDEV WATCHDOG: eth0 (): transmit timed out<br=
>[=A0=A0 33.055929] NETDEV WATCHDOG: eth0 (): transmit timed out<br>&lt;4&g=
t;[=A0=A0 33.186505] Modules linked in:[=A0=A0 33.186505] Modules linked in=
:<br><br>&lt;4&gt;[=A0=A0 33.262762] Backtrace: [=A0=A0 33.262762] Backtrac=
e:<br>
<br>&lt;4&gt;[=A0=A0 33.324394] [&lt;c002e92c&gt;] [=A0=A0 33.324394] [&lt;=
c002e92c&gt;] (dump_backtrace+0x0/0x110) (dump_backtrace+0x0/0x110) from [&=
lt;c002ea70&gt;] from [&lt;c002ea70&gt;] (dump_stack+0x18/0x1c)<br>(dump_st=
ack+0x18/0x1c)<br>
&lt;4&gt;[=A0=A0 33.530182]=A0 r6:c0263194[=A0=A0 33.530182]=A0 r6:c0263194=
 r5:c03b7148 r5:c03b7148 r4:000000e2 r4:000000e2<br><br>&lt;4&gt;[=A0=A0 33=
.644045] [&lt;c002ea58&gt;] [=A0=A0 33.644045] [&lt;c002ea58&gt;] (dump_sta=
ck+0x0/0x1c) (dump_stack+0x0/0x1c) from [&lt;c00405f0&gt;] from [&lt;c00405=
f0&gt;] (warn_slowpath_common+0x50/0x68)<br>
(warn_slowpath_common+0x50/0x68)<br>&lt;4&gt;[=A0=A0 33.860280] [&lt;c00405=
a0&gt;] [=A0=A0 33.860280] [&lt;c00405a0&gt;] (warn_slowpath_common+0x0/0x6=
8) (warn_slowpath_common+0x0/0x68) from [&lt;c0040654&gt;] from [&lt;c00406=
54&gt;] (warn_slowpa)<br>
(warn_slowpath_fmt+0x30/0x38)<br>&lt;4&gt;[=A0=A0 34.091140]=A0 r7:00000001=
[=A0=A0 34.091140]=A0 r7:00000001 r6:c7a44000 r6:c7a44000 r5:c03e6ec0 r5:c0=
3e6ec0 r4:c03dfd6c r4:c03dfd6c<br><br>&lt;4&gt;[=A0=A0 34.230073] [&lt;c004=
0624&gt;] [=A0=A0 34.230073] [&lt;c0040624&gt;] (warn_slowpath_fmt+0x0/0x38=
) (warn_slowpath_fmt+0x0/0x38) from [&lt;c0263194&gt;] from [&lt;c0263194&g=
t;] (dev_watchdog+0x2c)<br>
(dev_watchdog+0x2c0/0x2e0)<br>&lt;4&gt;[=A0=A0 34.448397]=A0 r3:c7a44000[=
=A0=A0 34.448397]=A0 r3:c7a44000 r2:c03b71d0 r2:c03b71d0<br><br>&lt;4&gt;[=
=A0=A0 34.537189]=A0 r4:c04a638c[=A0=A0 34.537189]=A0 r4:c04a638c<br><br>&l=
t;4&gt;[=A0=A0 34.600910] [&lt;c0262ed4&gt;] [=A0=A0 34.600910] [&lt;c0262e=
d4&gt;] (dev_watchdog+0x0/0x2e0) (dev_watchdog+0x0/0x2e0) from [&lt;c004bf2=
8&gt;] from [&lt;c004bf28&gt;] (run_timer_softirq+0x1d0/0)<br>
(run_timer_softirq+0x1d0/0x28c)<br>&lt;4&gt;[=A0=A0 34.821323] [&lt;c004bd5=
8&gt;] [=A0=A0 34.821323] [&lt;c004bd58&gt;] (run_timer_softirq+0x0/0x28c) =
(run_timer_softirq+0x0/0x28c) from [&lt;c0046734&gt;] from [&lt;c0046734&gt=
;] (__do_softirq+0x)<br>
(__do_softirq+0x94/0x1fc)<br>&lt;4&gt;[=A0=A0 35.039648] [&lt;c00466a0&gt;]=
 [=A0=A0 35.039648] [&lt;c00466a0&gt;] (__do_softirq+0x0/0x1fc) (__do_softi=
rq+0x0/0x1fc) from [&lt;c0046d50&gt;] from [&lt;c0046d50&gt;] (irq_exit+0x9=
8/0xa0)<br>
(irq_exit+0x98/0xa0)<br>&lt;4&gt;[=A0=A0 35.237079] [&lt;c0046cb8&gt;] [=A0=
=A0 35.237079] [&lt;c0046cb8&gt;] (irq_exit+0x0/0xa0) (irq_exit+0x0/0xa0) f=
rom [&lt;c002a060&gt;] from [&lt;c002a060&gt;] (_text+0x60/0x70)<br>(_text+=
0x60/0x70)<br>
&lt;4&gt;[=A0=A0 35.417797]=A0 r4:0000001a[=A0=A0 35.417797]=A0 r4:0000001a=
<br><br>&lt;4&gt;[=A0=A0 35.481519] [&lt;c002a000&gt;] [=A0=A0 35.481519] [=
&lt;c002a000&gt;] (_text+0x0/0x70) (_text+0x0/0x70) from [&lt;c0080454&gt;]=
 from [&lt;c0080454&gt;] (__ipipe_sync_stage+0x224/0x260)<br>
(__ipipe_sync_stage+0x224/0x260)<br>&lt;4&gt;[=A0=A0 35.687307] Exception s=
tack(0xc03dfe84 to 0xc03dfecc)<br>[=A0=A0 35.687307] Exception stack(0xc03d=
fe84 to 0xc03dfecc)<br>&lt;4&gt;[=A0=A0 35.811616] fe80: [=A0=A0 35.811616]=
 fe80:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fffffffe fffff=
ffe 00000000 00000000 c03ecfac c03ecfac c045b860 c045b860 c045b860 c045b860=
 c03ec454 c03ec454=A0<br>
<br>&lt;4&gt;[=A0=A0 36.013226] fea0: [=A0=A0 36.013226] fea0: c03ed378 c03=
ed378 c04826e4 c04826e4 c03dfed8 c03dfed8 c03dfeb8 c03dfeb8 c008063c c00806=
3c c008023c c008023c c03ecfac c03ecfac=A0<br><br>&lt;4&gt;[=A0=A0 36.214836=
] fec0: [=A0=A0 36.214836] fec0: c03ed374 c03ed374 c045b860 c045b860 c045b8=
60 c045b860=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0<br>
<br>&lt;4&gt;[=A0=A0 36.416446]=A0 r6:00000340[=A0=A0 36.416446]=A0 r6:0000=
0340 r5:00000000 r5:00000000 r4:c03ec454 r4:c03ec454<br><br>&lt;4&gt;[=A0=
=A0 36.530309] [&lt;c0080230&gt;] [=A0=A0 36.530309] [&lt;c0080230&gt;] (__=
ipipe_sync_stage+0x0/0x260) (__ipipe_sync_stage+0x0/0x260) from [&lt;c00806=
3c&gt;] from [&lt;c008063c&gt;] (__ipipe_walk_)<br>
(__ipipe_walk_pipeline+0xe8/0xfc)<br>&lt;4&gt;[=A0=A0 36.767436] [&lt;c0080=
554&gt;] [=A0=A0 36.767436] [&lt;c0080554&gt;] (__ipipe_walk_pipeline+0x0/0=
xfc) (__ipipe_walk_pipeline+0x0/0xfc) from [&lt;c00806d0&gt;] from [&lt;c00=
806d0&gt;] (__ipipe_d)<br>
(__ipipe_dispatch_wired_nocheck+0x80/0xb0)<br>&lt;4&gt;[=A0=A0 37.027545]=
=A0 r8:c045b860[=A0=A0 37.027545]=A0 r8:c045b860 r7:c045b860 r7:c045b860 r6=
:c03ed374 r6:c03ed374 r5:c04826e0 r5:c04826e0 r4:c03ecfac r4:c03ecfac<br><b=
r>&lt;4&gt;[=A0=A0 37.191549] [&lt;c0080650&gt;] [=A0=A0 37.191549] [&lt;c0=
080650&gt;] (__ipipe_dispatch_wired_nocheck+0x0/0xb0) (__ipipe_dispatch_wir=
ed_nocheck+0x0/0xb0) from [&lt;c008135c&gt;] from [&lt;c00)<br>
(__ipipe_dispatch_wired+0x4c/0x88)<br>&lt;4&gt;[=A0=A0 37.453747]=A0 r7:000=
00000[=A0=A0 37.453747]=A0 r7:00000000 r6:0000001a r6:0000001a r5:00000340 =
r5:00000340 r4:0000001a r4:0000001a<br><br>&lt;4&gt;[=A0=A0 37.592680] [&lt=
;c0081310&gt;] [=A0=A0 37.592680] [&lt;c0081310&gt;] (__ipipe_dispatch_wire=
d+0x0/0x88) (__ipipe_dispatch_wired+0x0/0x88) from [&lt;c002fdbc&gt;] from =
[&lt;c002fdbc&gt;] (__ipipe)<br>
(__ipipe_handle_irq+0x158/0x1ac)<br>&lt;4&gt;[=A0=A0 37.833986]=A0 r4:c0482=
6e0[=A0=A0 37.833986]=A0 r4:c04826e0<br><br>&lt;4&gt;[=A0=A0 37.897707] [&l=
t;c002fc64&gt;] [=A0=A0 37.897707] [&lt;c002fc64&gt;] (__ipipe_handle_irq+0=
x0/0x1ac) (__ipipe_handle_irq+0x0/0x1ac) from [&lt;c002fe40&gt;] from [&lt;=
c002fe40&gt;] (__ipipe_grab_)<br>
(__ipipe_grab_irq+0x30/0xac)<br>&lt;4&gt;[=A0=A0 38.124387] [&lt;c002fe10&g=
t;] [=A0=A0 38.124387] [&lt;c002fe10&gt;] (__ipipe_grab_irq+0x0/0xac) (__ip=
ipe_grab_irq+0x0/0xac) from [&lt;c02f7930&gt;] from [&lt;c02f7930&gt;] (__i=
rq_svc+0x30/0xd8)<br>
(__irq_svc+0x30/0xd8)<br>&lt;4&gt;[=A0=A0 38.330176] [&lt;c002bce0&gt;] [=
=A0=A0 38.330176] [&lt;c002bce0&gt;] (default_idle+0x0/0x6c) (default_idle+=
0x0/0x6c) from [&lt;c002bbac&gt;] from [&lt;c002bbac&gt;] (cpu_idle+0x48/0x=
78)<br>
(cpu_idle+0x48/0x78)<br>&lt;4&gt;[=A0=A0 38.525519] [&lt;c002bb64&gt;] [=A0=
=A0 38.525519] [&lt;c002bb64&gt;] (cpu_idle+0x0/0x78) (cpu_idle+0x0/0x78) f=
rom [&lt;c02f3e28&gt;] from [&lt;c02f3e28&gt;] (rest_init+0x6c/0x80)<br>(re=
st_init+0x6c/0x80)<br>
&lt;4&gt;[=A0=A0 38.714593]=A0 r6:c0027ee0[=A0=A0 38.714593]=A0 r6:c0027ee0=
 r5:c04088dc r5:c04088dc r4:c04952ac r4:c04952ac<br><br>&lt;4&gt;[=A0=A0 38=
.828456] [&lt;c02f3dbc&gt;] [=A0=A0 38.828456] [&lt;c02f3dbc&gt;] (rest_ini=
t+0x0/0x80) (rest_init+0x0/0x80) from [&lt;c0008bc8&gt;] from [&lt;c0008bc8=
&gt;] (start_kernel+0x21c/0x30c)<br>
(start_kernel+0x21c/0x30c)<br>&lt;4&gt;[=A0=A0 39.030067] [&lt;c00089ac&gt;=
] [=A0=A0 39.030067] [&lt;c00089ac&gt;] (start_kernel+0x0/0x30c) (start_ker=
nel+0x0/0x30c) from [&lt;80008034&gt;] from [&lt;80008034&gt;] (0x80008034)=
<br>
(0x80008034)<br>&lt;4&gt;[=A0=A0 39.210784]=A0 r6:c00282e4[=A0=A0 39.210784=
]=A0 r6:c00282e4 r5:c0408938 r5:c0408938 r4:0000397d r4:0000397d<br><br>&lt=
;4&gt;[=A0=A0 39.324647] ---[ end trace 8741cd9a646bbb13 ]---<br>[=A0=A0 39=
.324647] ---[ end trace 8741cd9a646bbb13 ]---<br>
&lt;7&gt;[=A0=A0 39.438510] eth0: Tx timed out, lost interrupt? TSR=3D0x1, =
ISR=3D0x3, t=3D160.<br>&lt;7&gt;[=A0=A0 49.765548] eth0: Tx timed out, lost=
 interrupt? TSR=3D0x1, ISR=3D0x2, t=3D1025.<br>&lt;7&gt;[=A0=A0 51.765562] =
eth0: Tx timed out, lost interrupt? TSR=3D0x1, ISR=3D0x2, t=3D124</font> </=
p>

--0015175cd1e87aa65b047208548a--

