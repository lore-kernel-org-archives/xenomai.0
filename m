From: GUGLIELMO NAVARRA <guglielmo.navarra@studenti.uniparthenope.it>
Date: Sat, 15 Dec 2012 12:07:23 +0000
Message-ID: <7385E066AECB78449EEDFA7EE2A2B2B60A052D7D@DB3PRD0410MB355.eurprd04.prod.outlook.com>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] [Xenomai-help] Latency calculation on da850 (Omap L138)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,
I ported i-pipe to the board da850 with TI L138 CPU.
I have no problems during startup, the system starts quietly.
I followed the guide http://www.xenomai.org/index.php/I-pipe-core:ArmPortin=
g,
the only thing that I did not (because do not use ) are the changes to the =
GPIO module.
When I run latency program in "user-task period" mode, the latency shows gr=
eat numbers and even negative,
which does not happen if i run latency in "in-kernel task period" mode, wit=
h more normal numbers.
Of course, before you run latency test, sending "echo 0 > /proc/xenomai/lat=
ency".

If I use cyclictest, the numbers are more correct. What could be the proble=
m?
Is there any mistake I made or that I missed in porting?

Thanks

root@Board<mailto:root@Board> ~>./usr/xenomai/bin/latency -t 0
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD| 370370.370| 918802.551|1418302.551|       0|     0| 370370.370|1418302=
.551
RTD| 370370.370| -81197.449| 418302.551|       0|     0| 370370.370|1418302=
.551
RTD| 370370.370|-1081197.448|-581697.448|       0|     0| 370370.370|141830=
2.551

RTD| 370370.370|-2081197.447|-1581697.448|       0|     0| 370370.370|14183=
02.55
1
RTD| 370370.370|1213769.849|1713269.849|       0|     0| 370370.370|1418302=
.551
RTD| 370370.370| 213769.850| 713269.849|       0|     0| 370370.370|1418302=
.551
RTD| 370370.370|-786230.150|-286730.150|       0|     0| 370370.370|1418302=
.551
RTD| 370370.370|-1786230.149|-1286730.149|       0|     0| 370370.370|14183=
02.55
1
RTD| 370370.370|1508737.148|2008237.147|       0|     0| 370370.370|1418302=
.551
RTD| 370370.370| 508737.148|1008237.148|       0|     0| 370370.370|1418302=
.551
RTD| 370370.370|-491262.851|   8237.148|       0|     0| 370370.370|1418302=
.551
RTD| 370370.370|-1491262.851|-991762.851|       0|     0| 370370.370|141830=
2.551

RTD| 370370.370|1803704.446|-1991762.850|       0|     0| 370370.370|141830=
2.551

RTD| 370370.370| 803704.447|1303204.446|       0|     0| 370370.370|1418302=
.551
RTD| 370370.370|-196295.553| 303204.447|       0|     0| 370370.370|1418302=
.551
?---|-----------|-----------|-----------|--------|------|------------------=
-----
--
RTS| 370370.370|-1786230.149|1418302.551|       0|     0|    00:00:15/00:00=
:15
root@Board<mailto:root@Board> ~>



root@Board<mailto:root@Board> ~>./usr/xenomai/bin/latency -t 1
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|     68.740|     77.299|    130.925|       0|     0|     68.740|    130=
.925
RTD|     67.554|     76.997|    132.776|       0|     0|     67.554|    132=
.776
RTD|     68.887|     77.536|    128.924|       0|     0|     67.554|    132=
.776
RTD|     65.368|     77.235|    136.405|       0|     0|     65.368|    136=
.405
RTD|     68.145|     77.162|    130.441|       0|     0|     65.368|    136=
.405
RTD|     68.144|     77.070|    133.292|       0|     0|     65.368|    136=
.405
RTD|     67.366|     77.239|    129.070|       0|     0|     65.368|    136=
.405
RTD|     67.514|     77.109|    128.921|       0|     0|     65.368|    136=
.405
RTD|     68.513|     77.471|    129.031|       0|     0|     65.368|    136=
.405
RTD|     66.994|     76.907|    132.920|       0|     0|     65.368|    136=
.405
RTD|     67.956|     77.237|    135.216|       0|     0|     65.368|    136=
.405
RTD|     67.141|     77.440|    138.104|       0|     0|     65.368|    138=
.104
RTD|     66.029|     77.157|    130.622|       0|     0|     65.368|    138=
.104
RTD|     67.436|     77.194|    128.843|       0|     0|     65.368|    138=
.104
RTD|     67.176|     77.353|    130.732|       0|     0|     65.368|    138=
.104
?---|-----------|-----------|-----------|--------|------|------------------=
-----
--
RTS|     65.368|     77.227|    138.104|       0|     0|    00:00:16/00:00:=
16
root@Board<mailto:root@Board> ~>



Startup kernel log:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 3.2.21-ipipe (omap@Sviluppo<mailto:omap@Sviluppo>) (gcc versi=
on 4.6.3 (Sourcery CodeBenc
h Lite 2012.03-57) ) #56 PREEMPT Sat Dec 15 12:11:05 CET 2012
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: DaVinci DA850/OMAP-L138/AM18x EVM
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writethrough
DaVinci da850/omap-l138 variant 0x0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: mem=3D32M ip=3D192.168.1.141 console=3DttyS2,115200n8 =
root=3D/dev/m
mcblk0p1 rootfstype=3Dext2 earlyprintk=3Dserial,ttyS2,115200
PID hash table entries: 128 (order: -3, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB =3D 32MB total
Memory: 27168k/27168k available, 5600k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc2800000 - 0xfea00000   ( 962 MB)
    lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc0475978   (4535 kB)
      .init : 0xc0476000 - 0xc0499000   ( 140 kB)
      .data : 0xc049a000 - 0xc04c5ff8   ( 176 kB)
       .bss : 0xc04c601c - 0xc0526ce8   ( 388 kB)
NR_IRQS:245
 *** Davinci Clock Rate : 27000000 ***
 *** Clock Reload : 270000 ***
I-pipe, 27.000 MHz clocksource
Interrupt pipeline (release #1)
Console: colour dummy device 80x30
Calibrating delay loop... 167.32 BogoMIPS (lpj=3D836608)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
DaVinci: 144 gpio irqs
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
pca953x 1-0020: failed reading register
pca953x: probe of 1-0020 failed with error -121
pca953x 1-0021: interrupt support not compiled in
Switching to clocksource ipipe_tsc
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
EMAC: MII PHY configured, RMII PHY will not be functional
I-pipe: head domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.1 (Light Years Away) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
msgmni has been set to 53
io scheduler noop registered (default)
start plist test
end plist test
Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x1c42000 (irq =3D 25) is a 16550A
serial8250.0: ttyS1 at MMIO 0x1d0c000 (irq =3D 53) is a 16550A
=FFserial8250.0: ttyS2 at MMIO 0x1d0d000 (irq =3D 61) is a 16550A
console [ttyS2] enabled, bootconsole disabled
console [ttyS2] enabled, bootconsole disabled
brd: module loaded
davinci_mdio davinci_mdio.0: davinci mdio revision 1.5
davinci_mdio davinci_mdio.0: detected phy mask fffffffe
davinci_mdio.0: probed
davinci_mdio davinci_mdio.0: phy[0]: device 0:00, driver unknown
input: gpio-keys-polled as /devices/platform/gpio-keys-polled.1/input/input=
0
i2c /dev entries driver
davinci_mmc davinci_mmc.0: Using DMA, 4-bit mode
TCP cubic registered
NET: Registered protocol family 17
console [netcon0] enabled
netconsole: network logging started
davinci_mdio davinci_mdio.0: resetting idled controller
net eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=3D0:00, id=3D=
7c0f1)
mmc0: new SD card at address e624
mmcblk0: mmc0:e624 SD128 120 MiB
 mmcblk0: p1
PHY: 0:00 - Link is Up - 100/Full
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
     device=3Deth0, addr=3D192.168.1.141, mask=3D255.255.255.0, gw=3D255.25=
5.255.255,
     host=3D192.168.1.141, domain=3D, nis-domain=3D(none),
     bootserver=3D255.255.255.255, rootserver=3D255.255.255.255, rootpath=
=3D
EXT2-fs (mmcblk0p1): warning: mounting unchecked fs, running e2fsck is reco=
mmend
ed
VFS: Mounted root (ext2 filesystem) on device 179:1.
Freeing init memory: 140K
init started: BusyBox v1.20.0 (2012-05-31 14:27:57 CEST)






