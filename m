Message-ID: <4C4F7930.90408@domain.hid>
Date: Tue, 27 Jul 2010 17:26:24 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------020004000903070407020305"
Subject: [Xenomai-help] Xenomai xeno-test hangs on 2.6.31 on BeagleBoard,
	same works on 2.6.33
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
--------------020004000903070407020305
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

  Below is the console log for 2.6.31. It hangs after starting the=20
workload...

Starting kernel ...

Uncompressing=20
Linux......................................................................=
............................
................................ done, booting the kernel.
Linux version 2.6.31-omap1 (Bob@domain.hid) (gcc version 4.3.3 (GCC) )=20
#4 Mon Jul 26 16:26:39 PDT 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
OMAP3430 ES3.0
SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=3DttyS2,115200n8=20
ip=3D192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:eth0:o
ff root=3D/dev/nfs rw=20
nfsroot=3D192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=3D1024,wsize=3D1024 r=
ootwait
PID hash table entries: 1024 (order: 10, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB =3D 256MB total
Memory: 255360KB available (3580K code, 415K data, 136K init, 0K highmem)
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 13000000 Hz
I-pipe 1.16-01: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 498.07 BogoMIPS (lpj=3D2490368)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
NET: Registered protocol family 16
Found NAND on CS0
Registering NAND on CS0
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VMMC1: 1850 <--> 3150 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
regulator: VPLL2: 1800 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
SCSI subsystem initialized
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red Hat, Inc.
msgmni has been set to 499
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
i2c /dev entries driver
pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new interface driver pegasus
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: OMAP-EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.31-omap1 ehci_hcd
usb usb1: SerialNumber: ehci-omap.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
g_ether gadget: using random self ethernet address
g_ether gadget: using random host ethernet address
usb0: MAC 22:04:5b:1d:e9:ea
usb0: HOST MAC 2e:a8:a3:51:23:88
g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget: g_ether ready
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 2
usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: Product: MUSB HDRC host driver
usb usb2: Manufacturer: Linux 2.6.31-omap1 musb-hcd
usb usb2: SerialNumber: musb_hdrc
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
twl4030_rtc twl4030_rtc: setting system clock to 2010-05-18 20:59:16 UTC=20
(1274216356)
usb 1-2: new high speed USB device using ehci-omap and address 2
mmc0: new high speed SDHC card at address 856e
mmcblk0: mmc0:856e SD04G 3.69 GiB
  mmcblk0:
usb 1-2: New USB device found, idVendor=3D0b95, idProduct=3D7720
usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
usb 1-2: Product: AX88772
usb 1-2: Manufacturer: ASIX Elec. Corp.
usb 1-2: SerialNumber: 000001
usb 1-2: configuration #1 chosen from 1 choice
  p1 p2
eth0: register 'asix' at usb-ehci-omap.0-2, ASIX AX88772 USB 2.0=20
Ethernet, 00:50:b6:05:d2:0c
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.1.81, mask=3D255.255.255.0, gw=3D192.16=
8.1.1,
      host=3Dbeagleboard, domain=3D, nis-domain=3D(none),
      bootserver=3D192.168.1.80, rootserver=3D192.168.1.80, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.1.80
Looking up port of RPC 100005/1 on 192.168.1.80
VFS: Mounted root (nfs filesystem) on device 0:13.
Freeing init memory: 136K
INIT: version 2.86 booting
Please wait: booting...
Starting udev
udev: starting version 151
Remounting root file system...
Caching udev devnodes
Populating dev cachemv: cannot rename '/tmp/uname': No such file or=20
directory
root: mount: mounting rootfs on / failed: No such file or directory
EXT2-fs: mmcblk0p2: couldn't mount because of unsupported optional=20
features (4).
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT3 FS on mmcblk0p2, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with writeback data mode.
NOT configuring network interfaces: / is an NFS mount
Starting to configure packages...
Nothing to be done
Finished to configure packages.
INIT: Entering runlevel: 5
Starting Dropbear SSH server: dropbear.
Starting syslogd/klogd: done

.-------.
|       |                  .-.
|   |   |-----.-----.-----.| |   .----..-----.-----.
|       |     | __  |  ---'| '--.|  .-'|     |     |
|   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
'---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
                 -'  |
                 '---'

The Angstrom Distribution beagleboard ttyS2

Angstrom 2010.4-test-20100518 beagleboard ttyS2

beagleboard login: root
root@domain.hid:~#  /usr/xenomai/bin/xeno-test -s -h -T 20
xeno-test: started -s -h -T 20
withBusybox is 1
xeno-test: running tests
/usr/xenomai/bin/xeno-test: eval: line 1: -h: not found

Tue May 18 20:59:50 UTC 2010
running: /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
         --version=3D"2.5.3"
         --cc=3D"arm-angstrom-linux-gnueabi-gcc -march=3Darmv7-a=20
-mtune=3Dcortex-a8 -mfpu=3Dneon -mfloat-abi=3Dsoftfp"
         --arch=3D"arm"
         --prefix=3D"/usr/xenomai"
         --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE=20
-D_REENTRANT -Wall -pipe -D__XENO__"
         --xeno-ldflags=3D"-L/usr/xenomai/lib -lxenomai -lpthread "
         --posix-cflags=3D""
         --posix-ldflags=3D"-Wl,@/usr/xenomai/lib/posix.wrappers=20
-L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lr
t "
         --library-dir=3D"/usr/xenomai/lib"

Tue May 18 20:59:50 UTC 2010
running: /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

BusyBox v1.13.2 (2010-05-18 15:45:51 PDT) multi-call binary
Linux beagleboard 2.6.31-omap1 #4 Mon Jul 26 16:26:39 PDT 2010 armv7l=20
unknown

module-init-tools      3.4
Modules Loaded

Tue May 18 20:59:50 UTC 2010
running: cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 3 (v7l)
BogoMIPS        : 498.07
Features        : swp half thumb fastmult vfp edsp neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x1
CPU part        : 0xc08
CPU revision    : 3

Hardware        : OMAP3 Beagle Board
Revision        : 0020
Serial          : 0000000000000000

Tue May 18 20:59:50 UTC 2010
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
6f0a1a5525e65155ee727ef0c3403ba9  /proc/cpuinfo

Tue May 18 20:59:51 UTC 2010
running: cat /proc/ipipe/Linux
        +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
        |+---- Sticky
        ||+--- Locked
        |||+-- Exclusive
        ||||+- Virtual
[IRQ]  |||||
    0:  A....
    1:  A....
... IRQ counts, values are the same ...
401:  A....
  416:  G...V
  417:  G...V
[Domain info]
id=3D0x00000000
priority=3D100

Tue May 18 20:59:51 UTC 2010
running: cat /proc/ipipe/Xenomai
        +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
        |+---- Sticky
        ||+--- Locked
        |||+-- Exclusive
        ||||+- Virtual
[IRQ]  |||||
   37:  W..X.
  418:  W...V
[Domain info]
id=3D0x58454e4f
priority=3Dtopmost

Tue May 18 20:59:51 UTC 2010
running: cat /proc/ipipe/version
1.16-01

Tue May 18 20:59:51 UTC 2010
running: generate_loads 1
dd workload started, pids 804 stored in /var/lock/xeno-test.703.pids

************************************************************
Below is the same user binary running with the 2.6.33 kernel...
************************************************************

root@domain.hid:~#  /usr/xenomai/bin/xeno-test -s -h -T 20 >=20
~/xeno-test-log.txt&
Console log contents.
xeno-test: started -s -h -T 20
withBusybox is 1
xeno-test: running tests
/usr/xenomai/bin/xeno-test: eval: line 1: -h: not found

Tue May 18 20:59:07 UTC 2010
running: /usr/xenomai/bin/xeno-config --verbose
xeno-config --verbose
         --version=3D"2.5.3"
         --cc=3D"arm-angstrom-linux-gnueabi-gcc -march=3Darmv7-a=20
-mtune=3Dcortex-a8 -mfpu=3Dneon -mfloat-abi=3Dsoftfp"
         --arch=3D"arm"
         --prefix=3D"/usr/xenomai"
         --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE=20
-D_REENTRANT -Wall -pipe -D__XENO__"
         --xeno-ldflags=3D"-L/usr/xenomai/lib -lxenomai -lpthread "
         --posix-cflags=3D""
         --posix-ldflags=3D"-Wl,@/usr/xenomai/lib/posix.wrappers=20
-L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt "
         --library-dir=3D"/usr/xenomai/lib"

Tue May 18 20:59:07 UTC 2010
running: /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

BusyBox v1.13.2 (2010-05-18 15:45:51 PDT) multi-call binary
Linux beagleboard 2.6.33 #3 Sun Jul 25 14:20:13 PDT 2010 armv7l unknown

module-init-tools      3.4
Modules Loaded

Tue May 18 20:59:08 UTC 2010
running: cat /proc/cpuinfo
Processor    : ARMv7 Processor rev 3 (v7l)
BogoMIPS    : 498.07
Features    : swp half thumb fastmult vfp edsp vfpv3
CPU implementer    : 0x41
CPU architecture: 7
CPU variant    : 0x1
CPU part    : 0xc08
CPU revision    : 3

Hardware    : OMAP3 Beagle Board
Revision    : 0020
Serial        : 0000000000000000

Tue May 18 20:59:08 UTC 2010
running: md5sum /proc/cpuinfo # cpuinfo fingerprint
a8fe0c59927140f286a50cc74b35f1d2  /proc/cpuinfo

Tue May 18 20:59:08 UTC 2010
running: cat /proc/ipipe/Linux
        +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
        |+---- Sticky
        ||+--- Locked
        |||+-- Exclusive
        ||||+- Virtual
[IRQ]  |||||
    0:  A....
    1:  A....
    2:  A....
... IRQ counts, values are the same ...
  401:  A....
  416:  G...V
  417:  G...V
[Domain info]
id=3D0x00000000
priority=3D100

Tue May 18 20:59:08 UTC 2010
running: cat /proc/ipipe/Xenomai
        +----- Handling ([A]ccepted, [G]rabbed, [W]ired, [D]iscarded)
        |+---- Sticky
        ||+--- Locked
        |||+-- Exclusive
        ||||+- Virtual
[IRQ]  |||||
   37:  W..X.
  418:  W...V
[Domain info]
id=3D0x58454e4f
priority=3Dtopmost

Tue May 18 20:59:08 UTC 2010
running: cat /proc/ipipe/version
1.16-01

Tue May 18 20:59:08 UTC 2010
running: generate_loads 1
dd workload started, pids 763 stored in /var/lock/xeno-test.662.pids

Tue May 18 20:59:08 UTC 2010
running: cat /proc/interrupts
            CPU0
   7:          0        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        165        INTC  DMA
  37:       1690        INTC  gp timer
  56:        262        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        211        INTC  serial idle, serial
  77:      12161        INTC  ehci_hcd:usb1
  83:        126        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
384:          0     twl4030  mmc0
Err:          0

Tue May 18 20:59:08 UTC 2010
running: cat /proc/loadavg
0.99 0.52 0.19 2/40 769

Tue May 18 20:59:08 UTC 2010
running: cat /proc/meminfo
MemTotal:         255720 kB
MemFree:          244632 kB
Buffers:              24 kB
Cached:             4720 kB
SwapCached:            0 kB
Active:             3512 kB
Inactive:           2684 kB
Active(anon):       1680 kB
Inactive(anon):        0 kB
Active(file):       1832 kB
Inactive(file):     2684 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                12 kB
Writeback:             0 kB
AnonPages:          1480 kB
Mapped:             1168 kB
Shmem:               228 kB
Slab:               3232 kB
SReclaimable:        964 kB
SUnreclaim:         2268 kB
KernelStack:         320 kB
PageTables:          180 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      127860 kB
Committed_AS:       4960 kB
VmallocTotal:     647168 kB
VmallocUsed:         592 kB
VmallocChunk:     646536 kB

Tue May 18 20:59:08 UTC 2010
running: cat /proc/xenomai/acct
0 0 0 0 0 00500080 82019860172 82010806172 82010806172 ROOT
0 0 0 1666 0 00000000 82019860172 7931615 7931615 IRQ37: [timer]

Tue May 18 20:59:08 UTC 2010
running: cat /proc/xenomai/apc
APC          CPU0
   0:            0    (pipe_wakeup)
   1:            0    (lostage_handler)
   2:            0    (registry_export)
   3:            0    (pse51_lostage_handler)
   4:            0    (deferred RTDM close)

Tue May 18 20:59:08 UTC 2010
running: cat /proc/xenomai/faults
TRAP         CPU0
   0:            0    (Data or instruction access)
   1:            0    (Section fault)
   2:            0    (Generic data abort)
   3:            0    (Unknown exception)
   4:            0    (Instruction breakpoint)
   5:            0    (Floating point exception)
   6:            0    (VFP Floating point exception)
   7:            0    (Undefined instruction)
   8:            0    (Unaligned access exception)

Tue May 18 20:59:08 UTC 2010
running: cat /proc/xenomai/hal
1.16-01

Tue May 18 20:59:08 UTC 2010
running: cat /proc/xenomai/heap
size=3D8192:used=3D8:pagesz=3D4096  (global sem heap)
size=3D259584:used=3D64:pagesz=3D512  (main heap)
size=3D129536:used=3D0:pagesz=3D512  (stack pool)

Tue May 18 20:59:08 UTC 2010
running: cat /proc/xenomai/irq
IRQ         CPU0
  37:        1687         [timer]
418:           0         [virtual]

Tue May 18 20:59:08 UTC 2010
running: cat /proc/xenomai/latency
9538

Tue May 18 20:59:08 UTC 2010
running: cat /proc/xenomai/sched
CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
   0  0      idle    -1      -         master     R          ROOT

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          0          0     00500080   99.9  ROOT
   0  0      0          1699       0     00000000    0.1  IRQ37: [timer]

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/timer
status=3Don:setup=3D76:clock=3D1071532788:timerdev=3Dgp timer:clockdev=3Dgp=
 timer

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/version
2.5.3

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/interfaces/native
0

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/interfaces/posix
0

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/interfaces/rtdm
0

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/interfaces/sys
0

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/registry/usage
slots=3D512:used=3D1:exported=3D0

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/rtdm/fildes
total=3D128:open=3D0:free=3D128

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/rtdm/named_devices
Hash    Name                Driver        /proc
24    rttest-timerbench0                 xeno_timerbench   =20
rttest-timerbench0
55    rttest-switchtest0                 xeno_switchtest   =20
rttest-switchtest0

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/rtdm/open_fildes
Index    Locked    Device        Owner [PID]

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/rtdm/protocol_devices
Hash    ProtocolFamily:SocketType    Driver        /proc

Tue May 18 20:59:09 UTC 2010
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT     INTERVAL    HANDLER      NAME
0    6035        1752        7811999     -           NULL        =20
[host-timer]

Tue May 18 20:59:09 UTC 2010
running: top
=1B[H=1B[JMem: 11256K used, 244464K free, 0K shrd, 24K buff, 4728K cached
CPU:  40% usr  60% sys   0% nic   0% idle   0% io   0% irq   0% sirq
Load average: 0.99 0.52 0.19 2/42 843
=1B[7m  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND=1B[0m
   763     1 root     R     2608   1%  92% dd if /dev/zero of /dev/null
   843   842 root     R     2608   1%   8% top
   657     1 root     S     2788   1%   0% -sh
   653     1 root     S     2672   1%   0% /sbin/syslogd -n -C64 -m 20
   688   662 root     S     2612   1%   0% /bin/sh=20
/usr/xenomai/bin/xeno-test -s
   662   657 root     S     2612   1%   0% /bin/sh=20
/usr/xenomai/bin/xeno-test -s

Tue May 18 20:59:09 UTC 2010
running: ./run -- -s -h -T 20 -t0 # latency
*
*
* Type ^C to stop this application.
*
*
Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)

Tue May 18 20:59:11 UTC 2010
running: ./run -- -s -h -T 20 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)

Tue May 18 20:59:12 UTC 2010
running: ./run -- -s -h -T 20 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)

Tue May 18 20:59:13 UTC 2010
running: ./run -- -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)
/usr/xenomai/bin/xeno-test: cd: line 1: can't cd to=20
/usr/xenomai/share/xenomai/testsuite/switchbench

Tue May 18 20:59:14 UTC 2010
running: ./run -- -h # switchbench
/usr/xenomai/bin/xeno-test: eval: line 1: ./run: not found

Tue May 18 20:59:14 UTC 2010
running: ./run -- -p 10 -n -l 1000 # cyclictest
*
*
* Type ^C to stop this application.
*
*
Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_nucleus?)

Tue May 18 20:59:15 UTC 2010
running: cat /proc/interrupts
            CPU0
   7:          0        INTC  TWL4030-PIH
  11:          0        INTC  prcm
  12:        180        INTC  DMA
  37:       2344        INTC  gp timer
  56:        262        INTC  i2c_omap
  61:          0        INTC  i2c_omap
  72:          1        INTC  serial idle
  73:          1        INTC  serial idle
  74:        227        INTC  serial idle, serial
  77:      15403        INTC  ehci_hcd:usb1
  83:        201        INTC  mmc0
  92:          0        INTC  musb_hdrc
  93:          0        INTC  musb_hdrc
378:          0     twl4030  twl4030_usb
384:          0     twl4030  mmc0
Err:          0

Tue May 18 20:59:15 UTC 2010
running: cat /proc/loadavg
1.07 0.55 0.20 2/40 1256

Tue May 18 20:59:15 UTC 2010
running: cat /proc/meminfo
MemTotal:         255720 kB
MemFree:          243732 kB
Buffers:              24 kB
Cached:             5460 kB
SwapCached:            0 kB
Active:             3704 kB
Inactive:           3236 kB
Active(anon):       1688 kB
Inactive(anon):        0 kB
Active(file):       2016 kB
Inactive(file):     3236 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 4 kB
Writeback:             0 kB
AnonPages:          1484 kB
Mapped:             1168 kB
Shmem:               232 kB
Slab:               3348 kB
SReclaimable:       1016 kB
SUnreclaim:         2332 kB
KernelStack:         328 kB
PageTables:          180 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:      127860 kB
Committed_AS:       4964 kB
VmallocTotal:     647168 kB
VmallocUsed:         592 kB
VmallocChunk:     646536 kB

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/acct
0 0 0 0 0 00500080 6210005610 6206070380 88546642321 ROOT
0 0 0 2321 0 00000000 6210005610 3506769 11649615 IRQ37: [timer]

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/apc
APC          CPU0
   0:            0    (pipe_wakeup)
   1:            0    (lostage_handler)
   2:            0    (registry_export)
   3:            0    (pse51_lostage_handler)
   4:            0    (deferred RTDM close)

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/faults
TRAP         CPU0
   0:            0    (Data or instruction access)
   1:            0    (Section fault)
   2:            0    (Generic data abort)
   3:            0    (Unknown exception)
   4:            0    (Instruction breakpoint)
   5:            0    (Floating point exception)
   6:            0    (VFP Floating point exception)
   7:            0    (Undefined instruction)
   8:            0    (Unaligned access exception)

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/hal
1.16-01

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/heap
size=3D8192:used=3D8:pagesz=3D4096  (global sem heap)
size=3D259584:used=3D64:pagesz=3D512  (main heap)
size=3D129536:used=3D0:pagesz=3D512  (stack pool)

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/irq
IRQ         CPU0
  37:        2341         [timer]
418:           0         [virtual]

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/latency
9538

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/sched
CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
   0  0      idle    -1      -         master     R          ROOT

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          0          0     00500080   99.9  ROOT
   0  0      0          2353       0     00000000    0.1  IRQ37: [timer]

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/timebases
NAME       RESOLUTION     JIFFIES   STATUS
master              1         n/a   enabled,set

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/timer
status=3Don:setup=3D76:clock=3D1156507211:timerdev=3Dgp timer:clockdev=3Dgp=
 timer

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/version
2.5.3

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/interfaces/native
0

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/interfaces/posix
0

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/interfaces/rtdm
0

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/interfaces/sys
0

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/registry/usage
slots=3D512:used=3D1:exported=3D0

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/rtdm/fildes
total=3D128:open=3D0:free=3D128

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/rtdm/named_devices
Hash    Name                Driver        /proc
24    rttest-timerbench0                 xeno_timerbench   =20
rttest-timerbench0
55    rttest-switchtest0                 xeno_switchtest   =20
rttest-switchtest0

Tue May 18 20:59:15 UTC 2010
running: cat /proc/xenomai/rtdm/open_fildes
Index    Locked    Device        Owner [PID]

Tue May 18 20:59:16 UTC 2010
running: cat /proc/xenomai/rtdm/protocol_devices
Hash    ProtocolFamily:SocketType    Driver        /proc

Tue May 18 20:59:16 UTC 2010
running: cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT     INTERVAL    HANDLER      NAME
0    6690        2407        7816307     -           NULL        =20
[host-timer]

Tue May 18 20:59:16 UTC 2010
running: top
=1B[H=1B[JMem: 12088K used, 243632K free, 0K shrd, 24K buff, 5468K cached
CPU:  18% usr  81% sys   0% nic   0% idle   0% io   0% irq   0% sirq
Load average: 1.07 0.55 0.20 2/42 1330
=1B[7m  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND=1B[0m
   763     1 root     R     2608   1%  91% dd if /dev/zero of /dev/null
  1330  1329 root     R     2608   1%   9% top
   657     1 root     S     2788   1%   0% -sh
   653     1 root     S     2672   1%   0% /sbin/syslogd -n -C64 -m 20
   688   662 root     S     2612   1%   0% /bin/sh=20
/usr/xenomai/bin/xeno-test -s
   662   657 root     S     2612   1%   0% /bin/sh=20
/usr/xenomai/bin/xeno-test -s
   763 root      2608 R    dd if /dev/zero of /dev/null
  1334 root      2612 S    grep 763
xeno-test: finished

Any idea what's causing this?
Regards,
Bob Feretich







--------------020004000903070407020305
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Below is the console log for 2.6.31. It hangs after starting the
    workload...<br>
    <br>
    <small><tt>Starting kernel ...<br>
        <br>
        Uncompressing
Linux..................................................................................................<br>
        ................................ done, booting the kernel.<br>
        Linux version 2.6.31-omap1 (<a class="moz-txt-link-abbreviated" href="mailto:Bob@domain.hid">Bob@domain.hid</a>) (gcc version 4.3.3
        (GCC) ) #4 Mon Jul 26 16:26:39 PDT 2010<br>
        CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f<br>
        CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction
        cache<br>
        Machine: OMAP3 Beagle Board<br>
        Memory policy: ECC disabled, Data cache writeback<br>
        OMAP3430 ES3.0<br>
        SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000<br>
        Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total
        pages: 65024<br>
        Kernel command line: console=ttyS2,115200n8
ip=192.168.1.81:192.168.1.80:192.168.1.1:255.255.255.0:beagleboard:eth0:o<br>
        ff root=/dev/nfs rw
        nfsroot=192.168.1.80:/home/Bob/NFSROOT,nolock,rsize=1024,wsize=1024
        rootwait<br>
        PID hash table entries: 1024 (order: 10, 4096 bytes)<br>
        Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
        Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
        Memory: 128MB 128MB = 256MB total<br>
        Memory: 255360KB available (3580K code, 415K data, 136K init, 0K
        highmem)<br>
        NR_IRQS:402<br>
        Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz<br>
        Reprogramming SDRC clock to 332000000 Hz<br>
        GPMC revision 5.0<br>
        IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96
        interrupts<br>
        Total of 96 interrupts on 1 active controller<br>
        OMAP34xx GPIO hardware version 2.5<br>
        OMAP clockevent source: GPTIMER1 at 13000000 Hz<br>
        I-pipe 1.16-01: pipeline enabled.<br>
        Console: colour dummy device 80x30<br>
        Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)<br>
        Mount-cache hash table entries: 512<br>
        CPU: Testing write buffer coherency: ok<br>
        regulator: core version 0.5<br>
        NET: Registered protocol family 16<br>
        Found NAND on CS0<br>
        Registering NAND on CS0<br>
        OMAP DMA hardware revision 4.0<br>
        bio: create slab &lt;bio-0&gt; at 0<br>
        i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz<br>
        twl4030: PIH (irq 7) chaining IRQs 368..375<br>
        twl4030: power (irq 373) chaining IRQs 376..383<br>
        twl4030: gpio (irq 368) chaining IRQs 384..401<br>
        regulator: VMMC1: 1850 &lt;--&gt; 3150 mV normal standby<br>
        regulator: VDAC: 1800 mV normal standby<br>
        regulator: VUSB1V5: 1500 mV normal standby<br>
        regulator: VUSB1V8: 1800 mV normal standby<br>
        regulator: VUSB3V1: 3100 mV normal standby<br>
        regulator: VPLL2: 1800 mV normal standby<br>
        regulator: VSIM: 1800 &lt;--&gt; 3000 mV normal standby<br>
        i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz<br>
        SCSI subsystem initialized<br>
        twl4030_usb twl4030_usb: Initialized TWL4030 USB module<br>
        usbcore: registered new interface driver usbfs<br>
        usbcore: registered new interface driver hub<br>
        usbcore: registered new device driver usb<br>
        musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0<br>
        musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92<br>
        NET: Registered protocol family 2<br>
        IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<br>
        TCP established hash table entries: 8192 (order: 4, 65536 bytes)<br>
        TCP bind hash table entries: 8192 (order: 3, 32768 bytes)<br>
        TCP: Hash tables configured (established 8192 bind 8192)<br>
        TCP reno registered<br>
        NET: Registered protocol family 1<br>
        I-pipe: Domain Xenomai registered.<br>
        Xenomai: hal/arm started.<br>
        Xenomai: scheduling class idle registered.<br>
        Xenomai: scheduling class rt registered.<br>
        Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts) loaded.<br>
        Xenomai: starting native API services.<br>
        Xenomai: starting POSIX services.<br>
        Xenomai: starting RTDM services.<br>
        VFS: Disk quotas dquot_6.5.2<br>
        Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>
        JFFS2 version 2.2. (NAND) &iuml;&iquest;&frac12;&Acirc;&copy; 2001-2006 Red Hat, Inc.<br>
        msgmni has been set to 499<br>
        alg: No test for stdrng (krng)<br>
        Block layer SCSI generic (bsg) driver version 0.4 loaded (major
        253)<br>
        io scheduler noop registered<br>
        io scheduler anticipatory registered (default)<br>
        io scheduler deadline registered<br>
        io scheduler cfq registered<br>
        Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled<br>
        serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654<br>
        serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654<br>
        serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654<br>
        console [ttyS2] enabled<br>
        brd: module loaded<br>
        loop: module loaded<br>
        i2c /dev entries driver<br>
        pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet
        driver<br>
        usbcore: registered new interface driver pegasus<br>
        usbcore: registered new interface driver asix<br>
        usbcore: registered new interface driver cdc_ether<br>
        usbcore: registered new interface driver net1080<br>
        usbcore: registered new interface driver cdc_subset<br>
        usbcore: registered new interface driver zaurus<br>
        usbmon: debugfs is not available<br>
        ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver<br>
        ehci-omap ehci-omap.0: OMAP-EHCI Host Controller<br>
        ehci-omap ehci-omap.0: new USB bus registered, assigned bus
        number 1<br>
        ehci-omap ehci-omap.0: irq 77, io mem 0x48064800<br>
        ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00<br>
        usb usb1: New USB device found, idVendor=1d6b, idProduct=0002<br>
        usb usb1: New USB device strings: Mfr=3, Product=2,
        SerialNumber=1<br>
        usb usb1: Product: OMAP-EHCI Host Controller<br>
        usb usb1: Manufacturer: Linux 2.6.31-omap1 ehci_hcd<br>
        usb usb1: SerialNumber: ehci-omap.0<br>
        usb usb1: configuration #1 chosen from 1 choice<br>
        hub 1-0:1.0: USB hub found<br>
        hub 1-0:1.0: 3 ports detected<br>
        g_ether gadget: using random self ethernet address<br>
        g_ether gadget: using random host ethernet address<br>
        usb0: MAC 22:04:5b:1d:e9:ea<br>
        usb0: HOST MAC 2e:a8:a3:51:23:88<br>
        g_ether gadget: Ethernet Gadget, version: Memorial Day 2008<br>
        g_ether gadget: g_ether ready<br>
        musb_hdrc musb_hdrc: MUSB HDRC host driver<br>
        musb_hdrc musb_hdrc: new USB bus registered, assigned bus number
        2<br>
        usb usb2: New USB device found, idVendor=1d6b, idProduct=0002<br>
        usb usb2: New USB device strings: Mfr=3, Product=2,
        SerialNumber=1<br>
        usb usb2: Product: MUSB HDRC host driver<br>
        usb usb2: Manufacturer: Linux 2.6.31-omap1 musb-hcd<br>
        usb usb2: SerialNumber: musb_hdrc<br>
        usb usb2: configuration #1 chosen from 1 choice<br>
        hub 2-0:1.0: USB hub found<br>
        hub 2-0:1.0: 1 port detected<br>
        twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as
        rtc0<br>
        mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock<br>
        TCP cubic registered<br>
        NET: Registered protocol family 17<br>
        NET: Registered protocol family 15<br>
        RPC: Registered udp transport module.<br>
        RPC: Registered tcp transport module.<br>
        Power Management for TI OMAP3.<br>
        VFP support v0.3: implementor 41 architecture 3 part 30 variant
        c rev 1<br>
        regulator_init_complete: incomplete constraints, leaving VDVI on<br>
        regulator_init_complete: incomplete constraints, leaving VDAC on<br>
        twl4030_rtc twl4030_rtc: setting system clock to 2010-05-18
        20:59:16 UTC (1274216356)<br>
        usb 1-2: new high speed USB device using ehci-omap and address 2<br>
        mmc0: new high speed SDHC card at address 856e<br>
        mmcblk0: mmc0:856e SD04G 3.69 GiB <br>
        &nbsp;mmcblk0:<br>
        usb 1-2: New USB device found, idVendor=0b95, idProduct=7720<br>
        usb 1-2: New USB device strings: Mfr=1, Product=2,
        SerialNumber=3<br>
        usb 1-2: Product: AX88772 <br>
        usb 1-2: Manufacturer: ASIX Elec. Corp.<br>
        usb 1-2: SerialNumber: 000001<br>
        usb 1-2: configuration #1 chosen from 1 choice<br>
        &nbsp;p1 p2<br>
        eth0: register 'asix' at usb-ehci-omap.0-2, ASIX AX88772 USB 2.0
        Ethernet, 00:50:b6:05:d2:0c<br>
        eth0: link up, 100Mbps, half-duplex, lpa 0x40A1<br>
        eth0: link up, 100Mbps, half-duplex, lpa 0x40A1<br>
        IP-Config: Complete:<br>
        &nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=192.168.1.81, mask=255.255.255.0,
        gw=192.168.1.1,<br>
        &nbsp;&nbsp;&nbsp;&nbsp; host=beagleboard, domain=, nis-domain=(none),<br>
        &nbsp;&nbsp;&nbsp;&nbsp; bootserver=192.168.1.80, rootserver=192.168.1.80, rootpath=<br>
        Looking up port of RPC 100003/2 on 192.168.1.80<br>
        Looking up port of RPC 100005/1 on 192.168.1.80<br>
        VFS: Mounted root (nfs filesystem) on device 0:13.<br>
        Freeing init memory: 136K<br>
        INIT: version 2.86 booting<br>
        Please wait: booting...<br>
        Starting udev<br>
        udev: starting version 151<br>
        Remounting root file system...<br>
        Caching udev devnodes<br>
        Populating dev cachemv: cannot rename '/tmp/uname': No such file
        or directory<br>
        root: mount: mounting rootfs on / failed: No such file or
        directory<br>
        EXT2-fs: mmcblk0p2: couldn't mount because of unsupported
        optional features (4).<br>
        kjournald starting.&nbsp; Commit interval 5 seconds<br>
        EXT3-fs warning: mounting unchecked fs, running e2fsck is
        recommended<br>
        EXT3 FS on mmcblk0p2, internal journal<br>
        EXT3-fs: recovery complete.<br>
        EXT3-fs: mounted filesystem with writeback data mode.<br>
        NOT configuring network interfaces: / is an NFS mount<br>
        Starting to configure packages...<br>
        Nothing to be done<br>
        Finished to configure packages.<br>
        INIT: Entering runlevel: 5<br>
        Starting Dropbear SSH server: dropbear.<br>
        Starting syslogd/klogd: done<br>
        <br>
        .-------.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .-.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
        |&nbsp;&nbsp; |&nbsp;&nbsp; |-----.-----.-----.| |&nbsp;&nbsp; .----..-----.-----.<br>
        |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; | __&nbsp; |&nbsp; ---'| '--.|&nbsp; .-'|&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; |<br>
        |&nbsp;&nbsp; |&nbsp;&nbsp; |&nbsp; |&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; |---&nbsp; ||&nbsp; --'|&nbsp; |&nbsp; |&nbsp; '&nbsp; | | | |<br>
        '---'---'--'--'--.&nbsp; |-----''----''--'&nbsp; '-----'-'-'-'<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -'&nbsp; |<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '---'<br>
        <br>
        The Angstrom Distribution beagleboard ttyS2<br>
        <br>
        Angstrom 2010.4-test-20100518 beagleboard ttyS2<br>
        <br>
        beagleboard login: root<br>
        root@domain.hid:~#&nbsp; /usr/xenomai/bin/xeno-test -s -h -T
        20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
        xeno-test: started -s -h -T 20<br>
        withBusybox is 1<br>
        xeno-test: running tests<br>
        /usr/xenomai/bin/xeno-test: eval: line 1: -h: not found<br>
        <br>
        Tue May 18 20:59:50 UTC 2010<br>
        running: /usr/xenomai/bin/xeno-config --verbose<br>
        xeno-config --verbose<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --version="2.5.3"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --cc="arm-angstrom-linux-gnueabi-gcc -march=armv7-a
        -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --arch="arm"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --prefix="/usr/xenomai"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE
        -D_REENTRANT -Wall -pipe -D__XENO__"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread "<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --posix-cflags=""<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers
        -L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lr<br>
        t "<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --library-dir="/usr/xenomai/lib"<br>
        <br>
        Tue May 18 20:59:50 UTC 2010<br>
        running: /usr/xenomai/bin/xeno-info<br>
        If some fields are empty or look unusual you may have an old
        version.<br>
        Compare to the current minimal requirements in
        Documentation/Changes.<br>
        &nbsp;<br>
        BusyBox v1.13.2 (2010-05-18 15:45:51 PDT) multi-call binary<br>
        Linux beagleboard 2.6.31-omap1 #4 Mon Jul 26 16:26:39 PDT 2010
        armv7l unknown<br>
        &nbsp;<br>
        module-init-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.4<br>
        Modules Loaded&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
        <br>
        Tue May 18 20:59:50 UTC 2010<br>
        running: cat /proc/cpuinfo<br>
        Processor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : ARMv7 Processor rev 3 (v7l)<br>
        BogoMIPS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 498.07<br>
        Features&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : swp half thumb fastmult vfp edsp neon vfpv3 <br>
        CPU implementer : 0x41<br>
        CPU architecture: 7<br>
        CPU variant&nbsp;&nbsp;&nbsp;&nbsp; : 0x1<br>
        CPU part&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xc08<br>
        CPU revision&nbsp;&nbsp;&nbsp; : 3<br>
        <br>
        Hardware&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : OMAP3 Beagle Board<br>
        Revision&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0020<br>
        Serial&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0000000000000000<br>
        <br>
        Tue May 18 20:59:50 UTC 2010<br>
        running: md5sum /proc/cpuinfo # cpuinfo fingerprint<br>
        6f0a1a5525e65155ee727ef0c3403ba9&nbsp; /proc/cpuinfo<br>
        <br>
        Tue May 18 20:59:51 UTC 2010<br>
        running: cat /proc/ipipe/Linux<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +----- Handling ([A]ccepted, [G]rabbed, [W]ired,
        [D]iscarded)<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |+---- Sticky<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||+--- Locked<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |||+-- Exclusive<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||||+- Virtual<br>
        [IRQ]&nbsp; |||||<br>
        &nbsp;&nbsp; 0:&nbsp; A....<br>
        &nbsp;&nbsp; 1:&nbsp; A....<br>
        &nbsp;</tt></small><small><tt>... IRQ counts, values are the same ...<br>
        &nbsp;</tt></small><small><tt>401:&nbsp; A....<br>
        &nbsp;416:&nbsp; G...V<br>
        &nbsp;417:&nbsp; G...V<br>
        [Domain info]<br>
        id=0x00000000<br>
        priority=100<br>
        <br>
        Tue May 18 20:59:51 UTC 2010<br>
        running: cat /proc/ipipe/Xenomai<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +----- Handling ([A]ccepted, [G]rabbed, [W]ired,
        [D]iscarded)<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |+---- Sticky<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||+--- Locked<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |||+-- Exclusive<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||||+- Virtual<br>
        [IRQ]&nbsp; |||||<br>
        &nbsp; 37:&nbsp; W..X.<br>
        &nbsp;418:&nbsp; W...V<br>
        [Domain info]<br>
        id=0x58454e4f<br>
        priority=topmost<br>
        <br>
        Tue May 18 20:59:51 UTC 2010<br>
        running: cat /proc/ipipe/version<br>
        1.16-01<br>
        <br>
        Tue May 18 20:59:51 UTC 2010<br>
        running: generate_loads 1<br>
        dd workload started, pids 804 stored in
        /var/lock/xeno-test.703.pids</tt></small><br>
    <br>
    ************************************************************<br>
    Below is the same user binary running with the 2.6.33 kernel...<br>
    ************************************************************<br>
    <br>
    <small><tt>root@domain.hid:~#&nbsp; /usr/xenomai/bin/xeno-test -s -h -T
        20 &gt; ~/xeno-test-log.txt&amp;<br>
      </tt>Console log contents. &nbsp;<tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
      </tt></small><small><tt>xeno-test: started -s -h -T 20<br>
        withBusybox is 1<br>
        xeno-test: running tests<br>
        /usr/xenomai/bin/xeno-test: eval: line 1: -h: not found<br>
        <br>
        Tue May 18 20:59:07 UTC 2010<br>
        running: /usr/xenomai/bin/xeno-config --verbose<br>
        xeno-config --verbose<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --version="2.5.3"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --cc="arm-angstrom-linux-gnueabi-gcc -march=armv7-a
        -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --arch="arm"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --prefix="/usr/xenomai"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE
        -D_REENTRANT -Wall -pipe -D__XENO__"<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread "<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --posix-cflags=""<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --posix-ldflags=<a class="moz-txt-link-rfc2396E" href="mailto:-Wl,@/usr/xenomai/lib/posix.wrappers-L/usr/xenomai/lib-lpthread_rt-lxenomai-lpthread-lrt">"-Wl,@/usr/xenomai/lib/posix.wrappers
        -L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt "</a><br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --library-dir="/usr/xenomai/lib"<br>
        <br>
        Tue May 18 20:59:07 UTC 2010<br>
        running: /usr/xenomai/bin/xeno-info<br>
        If some fields are empty or look unusual you may have an old
        version.<br>
        Compare to the current minimal requirements in
        Documentation/Changes.<br>
        &nbsp;<br>
        BusyBox v1.13.2 (2010-05-18 15:45:51 PDT) multi-call binary<br>
        Linux beagleboard 2.6.33 #3 Sun Jul 25 14:20:13 PDT 2010 armv7l
        unknown<br>
        &nbsp;<br>
        module-init-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.4<br>
        Modules Loaded&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/cpuinfo<br>
        Processor&nbsp;&nbsp;&nbsp; : ARMv7 Processor rev 3 (v7l)<br>
        BogoMIPS&nbsp;&nbsp;&nbsp; : 498.07<br>
        Features&nbsp;&nbsp;&nbsp; : swp half thumb fastmult vfp edsp vfpv3 <br>
        CPU implementer&nbsp;&nbsp;&nbsp; : 0x41<br>
        CPU architecture: 7<br>
        CPU variant&nbsp;&nbsp;&nbsp; : 0x1<br>
        CPU part&nbsp;&nbsp;&nbsp; : 0xc08<br>
        CPU revision&nbsp;&nbsp;&nbsp; : 3<br>
        <br>
        Hardware&nbsp;&nbsp;&nbsp; : OMAP3 Beagle Board<br>
        Revision&nbsp;&nbsp;&nbsp; : 0020<br>
        Serial&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : 0000000000000000<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: md5sum /proc/cpuinfo # cpuinfo fingerprint<br>
        a8fe0c59927140f286a50cc74b35f1d2&nbsp; /proc/cpuinfo<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/ipipe/Linux<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +----- Handling ([A]ccepted, [G]rabbed, [W]ired,
        [D]iscarded)<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |+---- Sticky<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||+--- Locked<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |||+-- Exclusive<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||||+- Virtual<br>
        [IRQ]&nbsp; |||||<br>
        &nbsp;&nbsp; 0:&nbsp; A....<br>
        &nbsp;&nbsp; 1:&nbsp; A....<br>
        &nbsp;&nbsp; 2:&nbsp; A....<br>
        ... IRQ counts, values are the same ...<br>
        &nbsp;401:&nbsp; A....<br>
        &nbsp;416:&nbsp; G...V<br>
        &nbsp;417:&nbsp; G...V<br>
        [Domain info]<br>
        id=0x00000000<br>
        priority=100<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/ipipe/Xenomai<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +----- Handling ([A]ccepted, [G]rabbed, [W]ired,
        [D]iscarded)<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |+---- Sticky<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||+--- Locked<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |||+-- Exclusive<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||||+- Virtual<br>
        [IRQ]&nbsp; |||||<br>
        &nbsp; 37:&nbsp; W..X.<br>
        &nbsp;418:&nbsp; W...V<br>
        [Domain info]<br>
        id=0x58454e4f<br>
        priority=topmost<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/ipipe/version<br>
        1.16-01<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: generate_loads 1<br>
        dd workload started, pids 763 stored in
        /var/lock/xeno-test.662.pids<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/interrupts<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
        &nbsp; 7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; TWL4030-PIH<br>
        &nbsp;11:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; prcm<br>
        &nbsp;12:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 165&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; DMA<br>
        &nbsp;37:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1690&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; gp timer<br>
        &nbsp;56:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 262&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; i2c_omap<br>
        &nbsp;61:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; i2c_omap<br>
        &nbsp;72:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; serial idle<br>
        &nbsp;73:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; serial idle<br>
        &nbsp;74:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 211&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; serial idle, serial<br>
        &nbsp;77:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12161&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; ehci_hcd:usb1<br>
        &nbsp;83:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 126&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; mmc0<br>
        &nbsp;92:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; musb_hdrc<br>
        &nbsp;93:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; musb_hdrc<br>
        378:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; twl4030&nbsp; twl4030_usb<br>
        384:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; twl4030&nbsp; mmc0<br>
        Err:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/loadavg<br>
        0.99 0.52 0.19 2/40 769<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/meminfo<br>
        MemTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 255720 kB<br>
        MemFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 244632 kB<br>
        Buffers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24 kB<br>
        Cached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4720 kB<br>
        SwapCached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        Active:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3512 kB<br>
        Inactive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2684 kB<br>
        Active(anon):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1680 kB<br>
        Inactive(anon):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        Active(file):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1832 kB<br>
        Inactive(file):&nbsp;&nbsp;&nbsp;&nbsp; 2684 kB<br>
        Unevictable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        Mlocked:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        SwapTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        SwapFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        Dirty:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12 kB<br>
        Writeback:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        AnonPages:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1480 kB<br>
        Mapped:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1168 kB<br>
        Shmem:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 228 kB<br>
        Slab:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3232 kB<br>
        SReclaimable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 964 kB<br>
        SUnreclaim:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2268 kB<br>
        KernelStack:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 320 kB<br>
        PageTables:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 180 kB<br>
        NFS_Unstable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        Bounce:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        WritebackTmp:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        CommitLimit:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 127860 kB<br>
        Committed_AS:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4960 kB<br>
        VmallocTotal:&nbsp;&nbsp;&nbsp;&nbsp; 647168 kB<br>
        VmallocUsed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 592 kB<br>
        VmallocChunk:&nbsp;&nbsp;&nbsp;&nbsp; 646536 kB<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/xenomai/acct<br>
        0 0 0 0 0 00500080 82019860172 82010806172 82010806172 ROOT<br>
        0 0 0 1666 0 00000000 82019860172 7931615 7931615 IRQ37: [timer]<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/xenomai/apc<br>
        APC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
        &nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (pipe_wakeup)<br>
        &nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (lostage_handler)<br>
        &nbsp; 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (registry_export)<br>
        &nbsp; 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (pse51_lostage_handler)<br>
        &nbsp; 4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (deferred RTDM close)<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/xenomai/faults<br>
        TRAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
        &nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Data or instruction access)<br>
        &nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Section fault)<br>
        &nbsp; 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Generic data abort)<br>
        &nbsp; 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Unknown exception)<br>
        &nbsp; 4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Instruction breakpoint)<br>
        &nbsp; 5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Floating point exception)<br>
        &nbsp; 6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (VFP Floating point exception)<br>
        &nbsp; 7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Undefined instruction)<br>
        &nbsp; 8:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Unaligned access exception)<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/xenomai/hal<br>
        1.16-01<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/xenomai/heap<br>
        size=8192:used=8:pagesz=4096&nbsp; (global sem heap)<br>
        size=259584:used=64:pagesz=512&nbsp; (main heap)<br>
        size=129536:used=0:pagesz=512&nbsp; (stack pool)<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/xenomai/irq<br>
        IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
        &nbsp;37:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1687&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [timer]<br>
        418:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [virtual]<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/xenomai/latency<br>
        9538<br>
        <br>
        Tue May 18 20:59:08 UTC 2010<br>
        running: cat /proc/xenomai/sched<br>
        CPU&nbsp; PID&nbsp;&nbsp;&nbsp; CLASS&nbsp; PRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIMEOUT&nbsp;&nbsp; TIMEBASE&nbsp;&nbsp; STAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NAME<br>
        &nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idle&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; master&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ROOT<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/stat<br>
        CPU&nbsp; PID&nbsp;&nbsp;&nbsp; MSW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CSW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PF&nbsp;&nbsp;&nbsp; STAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %CPU&nbsp; NAME<br>
        &nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 00500080&nbsp;&nbsp; 99.9&nbsp; ROOT<br>
        &nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1699&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 00000000&nbsp;&nbsp;&nbsp; 0.1&nbsp; IRQ37:
        [timer]<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/timebases<br>
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RESOLUTION&nbsp;&nbsp;&nbsp;&nbsp; JIFFIES&nbsp;&nbsp; STATUS<br>
        master&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n/a&nbsp;&nbsp; enabled,set<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/timer<br>
        status=on:setup=76:clock=1071532788:timerdev=gp
        timer:clockdev=gp timer<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/version<br>
        2.5.3<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/interfaces/native<br>
        0<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/interfaces/posix<br>
        0<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/interfaces/rtdm<br>
        0<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/interfaces/sys<br>
        0<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/registry/usage<br>
        slots=512:used=1:exported=0<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/rtdm/fildes<br>
        total=128:open=0:free=128<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/rtdm/named_devices<br>
        Hash&nbsp;&nbsp;&nbsp; Name&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Driver&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /proc<br>
        24&nbsp;&nbsp;&nbsp; rttest-timerbench0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; xeno_timerbench&nbsp;&nbsp;&nbsp;
        rttest-timerbench0<br>
        55&nbsp;&nbsp;&nbsp; rttest-switchtest0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; xeno_switchtest&nbsp;&nbsp;&nbsp;
        rttest-switchtest0<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/rtdm/open_fildes<br>
        Index&nbsp;&nbsp;&nbsp; Locked&nbsp;&nbsp;&nbsp; Device&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Owner [PID]<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/rtdm/protocol_devices<br>
        Hash&nbsp;&nbsp;&nbsp; ProtocolFamily:SocketType&nbsp;&nbsp;&nbsp; Driver&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /proc<br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: cat /proc/xenomai/timerstat/master<br>
        CPU&nbsp; SCHEDULED&nbsp;&nbsp; FIRED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp; INTERVAL&nbsp;&nbsp;&nbsp;
        HANDLER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
        0&nbsp;&nbsp;&nbsp; 6035&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1752&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7811999&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        NULL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [host-timer]&nbsp;&nbsp; <br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: top<br>
        [H[JMem: 11256K used, 244464K free, 0K shrd, 24K buff, 4728K
        cached<br>
        CPU:&nbsp; 40% usr&nbsp; 60% sys&nbsp;&nbsp; 0% nic&nbsp;&nbsp; 0% idle&nbsp;&nbsp; 0% io&nbsp;&nbsp; 0% irq&nbsp;&nbsp; 0%
        sirq<br>
        Load average: 0.99 0.52 0.19 2/42 843<br>
        [7m&nbsp; PID&nbsp; PPID USER&nbsp;&nbsp;&nbsp;&nbsp; STAT&nbsp;&nbsp; VSZ %MEM %CPU COMMAND[0m<br>
        &nbsp; 763&nbsp;&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp; 2608&nbsp;&nbsp; 1%&nbsp; 92% dd if /dev/zero of
        /dev/null <br>
        &nbsp; 843&nbsp;&nbsp; 842 root&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp; 2608&nbsp;&nbsp; 1%&nbsp;&nbsp; 8% top <br>
        &nbsp; 657&nbsp;&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp; 2788&nbsp;&nbsp; 1%&nbsp;&nbsp; 0% -sh <br>
        &nbsp; 653&nbsp;&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp; 2672&nbsp;&nbsp; 1%&nbsp;&nbsp; 0% /sbin/syslogd -n -C64
        -m 20 <br>
        &nbsp; 688&nbsp;&nbsp; 662 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp; 2612&nbsp;&nbsp; 1%&nbsp;&nbsp; 0% /bin/sh
        /usr/xenomai/bin/xeno-test -s <br>
        &nbsp; 662&nbsp;&nbsp; 657 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp; 2612&nbsp;&nbsp; 1%&nbsp;&nbsp; 0% /bin/sh
        /usr/xenomai/bin/xeno-test -s <br>
        <br>
        Tue May 18 20:59:09 UTC 2010<br>
        running: ./run -- -s -h -T 20 -t0 # latency<br>
        *<br>
        *<br>
        * Type ^C to stop this application.<br>
        *<br>
        *<br>
        Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
        (modprobe xeno_nucleus?)<br>
        <br>
        Tue May 18 20:59:11 UTC 2010<br>
        running: ./run -- -s -h -T 20 -t1 # latency<br>
        *<br>
        *<br>
        * Type ^C to stop this application.<br>
        *<br>
        *<br>
        Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
        (modprobe xeno_nucleus?)<br>
        <br>
        Tue May 18 20:59:12 UTC 2010<br>
        running: ./run -- -s -h -T 20 -t2 # latency<br>
        *<br>
        *<br>
        * Type ^C to stop this application.<br>
        *<br>
        *<br>
        Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
        (modprobe xeno_nucleus?)<br>
        <br>
        Tue May 18 20:59:13 UTC 2010<br>
        running: ./run -- -T 120 # switchtest<br>
        *<br>
        *<br>
        * Type ^C to stop this application.<br>
        *<br>
        *<br>
        Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
        (modprobe xeno_nucleus?)<br>
        /usr/xenomai/bin/xeno-test: cd: line 1: can't cd to
        /usr/xenomai/share/xenomai/testsuite/switchbench<br>
        <br>
        Tue May 18 20:59:14 UTC 2010<br>
        running: ./run -- -h # switchbench<br>
        /usr/xenomai/bin/xeno-test: eval: line 1: ./run: not found<br>
        <br>
        Tue May 18 20:59:14 UTC 2010<br>
        running: ./run -- -p 10 -n -l 1000 # cyclictest<br>
        *<br>
        *<br>
        * Type ^C to stop this application.<br>
        *<br>
        *<br>
        Xenomai or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
        (modprobe xeno_nucleus?)<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/interrupts<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
        &nbsp; 7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; TWL4030-PIH<br>
        &nbsp;11:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; prcm<br>
        &nbsp;12:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 180&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; DMA<br>
        &nbsp;37:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2344&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; gp timer<br>
        &nbsp;56:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 262&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; i2c_omap<br>
        &nbsp;61:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; i2c_omap<br>
        &nbsp;72:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; serial idle<br>
        &nbsp;73:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; serial idle<br>
        &nbsp;74:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 227&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; serial idle, serial<br>
        &nbsp;77:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15403&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; ehci_hcd:usb1<br>
        &nbsp;83:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 201&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; mmc0<br>
        &nbsp;92:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; musb_hdrc<br>
        &nbsp;93:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTC&nbsp; musb_hdrc<br>
        378:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; twl4030&nbsp; twl4030_usb<br>
        384:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; twl4030&nbsp; mmc0<br>
        Err:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/loadavg<br>
        1.07 0.55 0.20 2/40 1256<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/meminfo<br>
        MemTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 255720 kB<br>
        MemFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 243732 kB<br>
        Buffers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24 kB<br>
        Cached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5460 kB<br>
        SwapCached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        Active:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3704 kB<br>
        Inactive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3236 kB<br>
        Active(anon):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1688 kB<br>
        Inactive(anon):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        Active(file):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2016 kB<br>
        Inactive(file):&nbsp;&nbsp;&nbsp;&nbsp; 3236 kB<br>
        Unevictable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        Mlocked:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        SwapTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        SwapFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        Dirty:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 kB<br>
        Writeback:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        AnonPages:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1484 kB<br>
        Mapped:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1168 kB<br>
        Shmem:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 232 kB<br>
        Slab:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3348 kB<br>
        SReclaimable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1016 kB<br>
        SUnreclaim:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2332 kB<br>
        KernelStack:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 328 kB<br>
        PageTables:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 180 kB<br>
        NFS_Unstable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        Bounce:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        WritebackTmp:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>
        CommitLimit:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 127860 kB<br>
        Committed_AS:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4964 kB<br>
        VmallocTotal:&nbsp;&nbsp;&nbsp;&nbsp; 647168 kB<br>
        VmallocUsed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 592 kB<br>
        VmallocChunk:&nbsp;&nbsp;&nbsp;&nbsp; 646536 kB<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/acct<br>
        0 0 0 0 0 00500080 6210005610 6206070380 88546642321 ROOT<br>
        0 0 0 2321 0 00000000 6210005610 3506769 11649615 IRQ37: [timer]<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/apc<br>
        APC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
        &nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (pipe_wakeup)<br>
        &nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (lostage_handler)<br>
        &nbsp; 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (registry_export)<br>
        &nbsp; 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (pse51_lostage_handler)<br>
        &nbsp; 4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (deferred RTDM close)<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/faults<br>
        TRAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
        &nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Data or instruction access)<br>
        &nbsp; 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Section fault)<br>
        &nbsp; 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Generic data abort)<br>
        &nbsp; 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Unknown exception)<br>
        &nbsp; 4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Instruction breakpoint)<br>
        &nbsp; 5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Floating point exception)<br>
        &nbsp; 6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (VFP Floating point exception)<br>
        &nbsp; 7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Undefined instruction)<br>
        &nbsp; 8:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; (Unaligned access exception)<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/hal<br>
        1.16-01<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/heap<br>
        size=8192:used=8:pagesz=4096&nbsp; (global sem heap)<br>
        size=259584:used=64:pagesz=512&nbsp; (main heap)<br>
        size=129536:used=0:pagesz=512&nbsp; (stack pool)<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/irq<br>
        IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>
        &nbsp;37:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2341&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [timer]<br>
        418:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [virtual]<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/latency<br>
        9538<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/sched<br>
        CPU&nbsp; PID&nbsp;&nbsp;&nbsp; CLASS&nbsp; PRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIMEOUT&nbsp;&nbsp; TIMEBASE&nbsp;&nbsp; STAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NAME<br>
        &nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idle&nbsp;&nbsp;&nbsp; -1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; master&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ROOT<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/stat<br>
        CPU&nbsp; PID&nbsp;&nbsp;&nbsp; MSW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CSW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PF&nbsp;&nbsp;&nbsp; STAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %CPU&nbsp; NAME<br>
        &nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 00500080&nbsp;&nbsp; 99.9&nbsp; ROOT<br>
        &nbsp; 0&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2353&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 00000000&nbsp;&nbsp;&nbsp; 0.1&nbsp; IRQ37:
        [timer]<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/timebases<br>
        NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RESOLUTION&nbsp;&nbsp;&nbsp;&nbsp; JIFFIES&nbsp;&nbsp; STATUS<br>
        master&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n/a&nbsp;&nbsp; enabled,set<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/timer<br>
        status=on:setup=76:clock=1156507211:timerdev=gp
        timer:clockdev=gp timer<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/version<br>
        2.5.3<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/interfaces/native<br>
        0<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/interfaces/posix<br>
        0<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/interfaces/rtdm<br>
        0<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/interfaces/sys<br>
        0<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/registry/usage<br>
        slots=512:used=1:exported=0<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/rtdm/fildes<br>
        total=128:open=0:free=128<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/rtdm/named_devices<br>
        Hash&nbsp;&nbsp;&nbsp; Name&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Driver&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /proc<br>
        24&nbsp;&nbsp;&nbsp; rttest-timerbench0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; xeno_timerbench&nbsp;&nbsp;&nbsp;
        rttest-timerbench0<br>
        55&nbsp;&nbsp;&nbsp; rttest-switchtest0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; xeno_switchtest&nbsp;&nbsp;&nbsp;
        rttest-switchtest0<br>
        <br>
        Tue May 18 20:59:15 UTC 2010<br>
        running: cat /proc/xenomai/rtdm/open_fildes<br>
        Index&nbsp;&nbsp;&nbsp; Locked&nbsp;&nbsp;&nbsp; Device&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; Owner [PID]<br>
        <br>
        Tue May 18 20:59:16 UTC 2010<br>
        running: cat /proc/xenomai/rtdm/protocol_devices<br>
        Hash&nbsp;&nbsp;&nbsp; ProtocolFamily:SocketType&nbsp;&nbsp;&nbsp; Driver&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /proc<br>
        <br>
        Tue May 18 20:59:16 UTC 2010<br>
        running: cat /proc/xenomai/timerstat/master<br>
        CPU&nbsp; SCHEDULED&nbsp;&nbsp; FIRED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp; INTERVAL&nbsp;&nbsp;&nbsp;
        HANDLER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
        0&nbsp;&nbsp;&nbsp; 6690&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2407&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7816307&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        NULL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [host-timer]&nbsp;&nbsp; <br>
        <br>
        Tue May 18 20:59:16 UTC 2010<br>
        running: top<br>
        [H[JMem: 12088K used, 243632K free, 0K shrd, 24K buff, 5468K
        cached<br>
        CPU:&nbsp; 18% usr&nbsp; 81% sys&nbsp;&nbsp; 0% nic&nbsp;&nbsp; 0% idle&nbsp;&nbsp; 0% io&nbsp;&nbsp; 0% irq&nbsp;&nbsp; 0%
        sirq<br>
        Load average: 1.07 0.55 0.20 2/42 1330<br>
        [7m&nbsp; PID&nbsp; PPID USER&nbsp;&nbsp;&nbsp;&nbsp; STAT&nbsp;&nbsp; VSZ %MEM %CPU COMMAND[0m<br>
        &nbsp; 763&nbsp;&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp; 2608&nbsp;&nbsp; 1%&nbsp; 91% dd if /dev/zero of
        /dev/null <br>
        &nbsp;1330&nbsp; 1329 root&nbsp;&nbsp;&nbsp;&nbsp; R&nbsp;&nbsp;&nbsp;&nbsp; 2608&nbsp;&nbsp; 1%&nbsp;&nbsp; 9% top <br>
        &nbsp; 657&nbsp;&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp; 2788&nbsp;&nbsp; 1%&nbsp;&nbsp; 0% -sh <br>
        &nbsp; 653&nbsp;&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp; 2672&nbsp;&nbsp; 1%&nbsp;&nbsp; 0% /sbin/syslogd -n -C64
        -m 20 <br>
        &nbsp; 688&nbsp;&nbsp; 662 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp; 2612&nbsp;&nbsp; 1%&nbsp;&nbsp; 0% /bin/sh
        /usr/xenomai/bin/xeno-test -s <br>
        &nbsp; 662&nbsp;&nbsp; 657 root&nbsp;&nbsp;&nbsp;&nbsp; S&nbsp;&nbsp;&nbsp;&nbsp; 2612&nbsp;&nbsp; 1%&nbsp;&nbsp; 0% /bin/sh
        /usr/xenomai/bin/xeno-test -s <br>
        &nbsp; 763 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2608 R&nbsp;&nbsp;&nbsp; dd if /dev/zero of /dev/null <br>
        &nbsp;1334 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2612 S&nbsp;&nbsp;&nbsp; grep 763 <br>
        xeno-test: finished<br>
      </tt></small><br>
    Any idea what's causing this?<br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
  </body>
</html>

--------------020004000903070407020305--

