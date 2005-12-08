From: "linux" <linux@domain.hid>
Date: Thu, 8 Dec 2005 10:04:57 +0100
Message-ID: <001201c5fbd6$76cee1d0$0200000a@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0013_01C5FBDE.D89349D0"
Subject: [Xenomai-help] insmod: error inserting './xeno_posix.ko': -1
	Unknown symbol in module
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

------=_NextPart_000_0013_01C5FBDE.D89349D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I have downloaded a 2.6.14 kernel from kernel.org.
Also have I applied the adeos patch belonging to this kernel. Rebooted =
with
this kernel, and all ok.

Then I configured and compiled the xenomai tree. All ok. Only thing I
changed to the config was the enable of the serial driver.=20

Added the path to /usr/realtime/bin
	with PATH=3D$PATH:/usr/realtime/bin
went to the /usr/realtime/testsuite/latency
en did ./run

I got :

linux-test ~ #
linux-test ~ #
linux-test ~ #
linux-test ~ # cd /usr/realtime/
linux-test realtime # echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:/us=
r/i
686-
pc-linux-gnu/gcc-bin/3.3.5-20050130
linux-test realtime #
linux-test realtime #
linux-test realtime # PATH=3D$PATH:/usr/realtime/bin
linux-test realtime #
linux-test realtime # cd /usr/realtime/testsuite/latency/=20
linux-test latency # ./run
head: `-1' option is obsolete; use `-n 1' since this will be removed in =
the
futu re
*
*
* Type ^C to stop this application.
*
*
insmod: error inserting '/usr/realtime/modules/xeno_hal.ko': -1 No such
device
ERROR: cannot load /usr/realtime/modules/xeno_hal.ko
Xenomai: native skin or user-space support unavailable.
(did you load the xeno_native.ko module?)
linux-test latency #=20
linux-test latency #
linux-test latency #
linux-test latency #
linux-test latency # cd ../../modules/
linux-test modules # ls -all
total 536
drwxr-xr-x  2 root root   4096 Dec  7 17:15 .
drwxr-xr-x  9 root root   4096 Dec  7 17:16 ..
-rw-r--r--  1 root root  16413 Dec  7 17:15 xeno_16550A.ko
-rw-r--r--  1 root root  20255 Dec  7 17:14 xeno_hal.ko
-rw-r--r--  1 root root 136473 Dec  7 17:15 xeno_native.ko
-rw-r--r--  1 root root 135807 Dec  7 17:14 xeno_nucleus.ko
-rw-r--r--  1 root root 160091 Dec  7 17:15 xeno_posix.ko
-rw-r--r--  1 root root  43588 Dec  7 17:15 xeno_rtdm.ko=20
# linux-test modules=20
# linux-test modules=20
# linux-test modules=20
# linux-test modules=20
# linux-test modules=20
# insmod ./xeno_native.ko
insmod: error inserting './xeno_native.ko': -1 Unknown symbol in module=20
 linux-test modules=20
# insmod ./xeno_nucleus.ko
insmod: error inserting './xeno_nucleus.ko': -1 Unknown symbol in module
linux-test modules=20
# insmod ./xeno_posix.ko
insmod: error inserting './xeno_posix.ko': -1 Unknown symbol in module
linux-test modules=20
# linux-test modules=20
# linux-test modules=20


The complete output of dmesg command is attached in file...=20
Indeed it complains about a lot of unknown symbols.

I have compiled everything from :=20

linux-test / #
linux-test / #
linux-test / # cd /usr/src/
linux-test src # ls -all
total 20
drwxr-xr-x   5 root root 4096 Dec  7 16:40 .
drwxr-xr-x  14 root root 4096 Dec  7 17:14 ..
-rw-r--r--   1 root root    0 Oct 20 02:22 .keep
lrwxrwxrwx   1 root root   12 Dec  7 16:39 linux -> linux-2.6.14
drwxr-xr-x  19 root root 4096 Dec  8 10:23 linux-2.6.14
drwxr-xr-x  19 root root 4096 Dec  7 14:26 linux-2.6.14-gentoo-r2
lrwxrwxrwx   1 root root   14 Dec  7 16:40 realtime -> xenomai-2.0.1/
drwxrwxrwx  14 1000 1000 4096 Dec  7 17:14 xenomai-2.0.1
linux-test src #

Kernel that's running :=20

linux-test src # uname -r
2.6.14-ipipe
linux-test src #

Installation dir was kept default :=20

linux-test / #
linux-test / #ls -all /usr/realtime/
total 36
drwxr-xr-x   9 root root 4096 Dec  7 17:16 .
drwxr-xr-x  14 root root 4096 Dec  7 17:14 ..
drwxr-xr-x   2 root root 4096 Dec  7 17:16 bin
lrwxrwxrwx   1 root root   17 Dec  7 17:16 build -> /usr/src/realtime
drwxr-xr-x   6 root root 4096 Dec  7 17:15 include
drwxr-xr-x   2 root root 4096 Dec  7 17:15 lib
drwxr-xr-x   4 root root 4096 Dec  7 17:16 man
drwxr-xr-x   2 root root 4096 Dec  8 10:28 modules
drwxr-xr-x   4 root root 4096 Dec  7 17:16 share
lrwxrwxrwx   1 root root   17 Dec  7 17:16 source -> /usr/src/realtime
lrwxrwxrwx   1 root root   25 Dec  7 17:16 symbols ->
/usr/src/realtime/symbols
drwxr-xr-x   6 root root 4096 Dec  7 17:16 testsuite
linux-test / #=20
linux-test / #


The patch that I applied was : adeos-ipipe-2.6.14-i386-1.0-11.patch

Can someone please help me get started... what am I doing wrong ?

Best regards and thanks a lot !

Martijn


------=_NextPart_000_0013_01C5FBDE.D89349D0
Content-Type: text/plain;
	name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.6.14-ipipe (root@domain.hid) (gcc version 3.3.5-20050130 =
(Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #1 SMP =
PREEMPT Wed Dec 7 16:55:45 CET 2005=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)=0A=
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)=0A=
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)=0A=
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)=0A=
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)=0A=
Warning only 896MB will be used.=0A=
Use a HIGHMEM enabled kernel.=0A=
896MB LOWMEM available.=0A=
On node 0 totalpages: 229376=0A=
  DMA zone: 4096 pages, LIFO batch:1=0A=
  Normal zone: 225280 pages, LIFO batch:31=0A=
  HighMem zone: 0 pages, LIFO batch:1=0A=
DMI 2.2 present.=0A=
ACPI: RSDP (v000 VIA694                                ) @ 0x000f7620=0A=
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000=0A=
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040=0A=
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000=0A=
Allocating PCI resources starting at 50000000 (gap: 40000000:bfff0000)=0A=
Built 1 zonelists=0A=
Kernel command line: root=3D/dev/hda3=0A=
Local APIC disabled by BIOS -- you can enable it with "lapic"=0A=
mapped APIC to ffffd000 (01745000)=0A=
Initializing CPU#0=0A=
PID hash table entries: 4096 (order: 12, 65536 bytes)=0A=
Detected 1156.470 MHz processor.=0A=
Using tsc for high-res timesource=0A=
I-pipe 1.0-10: pipeline enabled.=0A=
Console: colour VGA+ 80x25=0A=
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)=0A=
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)=0A=
Memory: 904420k/917504k available (2928k kernel code, 12644k reserved, =
938k data, 224k init, 0k highmem)=0A=
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.=0A=
Calibrating delay using timer specific routine.. 2319.39 BogoMIPS =
(lpj=3D4638798)=0A=
Mount-cache hash table entries: 512=0A=
CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 =
00000000 00000000 00000000=0A=
CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 =
00000000 00000000 00000000=0A=
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)=0A=
CPU: L2 Cache: 256K (64 bytes/line)=0A=
CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020 00000000 =
00000000 00000000=0A=
Intel machine check architecture supported.=0A=
Intel machine check reporting enabled on CPU#0.=0A=
mtrr: v2.0 (20020519)=0A=
Enabling fast FPU save and restore... done.=0A=
Enabling unmasked SIMD FPU exception support... done.=0A=
Checking 'hlt' instruction... OK.=0A=
ACPI: setting ELCR to 0200 (from 0e00)=0A=
CPU0: AMD Athlon(tm)  stepping 02=0A=
SMP motherboard not detected.=0A=
Local APIC not detected. Using dummy APIC emulation.=0A=
Brought up 1 CPUs=0A=
NET: Registered protocol family 16=0A=
ACPI: bus type pci registered=0A=
PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=3D1=0A=
PCI: Using configuration type 1=0A=
ACPI: Subsystem revision 20050902=0A=
ACPI: Interpreter enabled=0A=
ACPI: Using PIC for interrupt routing=0A=
ACPI: PCI Root Bridge [PCI0] (0000:00)=0A=
PCI: Probing PCI hardware (bus 00)=0A=
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0=0A=
Boot video device is 0000:01:00.0=0A=
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]=0A=
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)=0A=
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, =
disabled.=0A=
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)=0A=
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)=0A=
Linux Plug and Play Support v0.97 (c) Adam Belay=0A=
pnp: PnP ACPI init=0A=
pnp: PnP ACPI: found 12 devices=0A=
SCSI subsystem initialized=0A=
usbcore: registered new driver usbfs=0A=
usbcore: registered new driver hub=0A=
PCI: Using ACPI for IRQ routing=0A=
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post =
a report=0A=
PCI: Bridge: 0000:00:01.0=0A=
  IO window: disabled.=0A=
  MEM window: d2000000-d3ffffff=0A=
  PREFETCH window: d0000000-d1ffffff=0A=
PCI: Setting latency timer of device 0000:00:01.0 to 64=0A=
Machine check exception polling timer started.=0A=
audit: initializing netlink socket (disabled)=0A=
audit(1134033884.876:1): initialized=0A=
Installing knfsd (copyright (C) 1996 okir@domain.hid=
ACPI: Power Button (FF) [PWRF]=0A=
ACPI: Power Button (CM) [PWRB]=0A=
ACPI: Sleep Button (CM) [SLPB]=0A=
ACPI: Fan [FAN] (on)=0A=
ACPI: CPU0 (power states: C1[C1] C2[C2])=0A=
ACPI: Thermal Zone [THRM] (48 C)=0A=
ibm_acpi: ec object not found=0A=
lp: driver loaded but no devices found=0A=
Linux agpgart interface v0.101 (c) Dave Jones=0A=
[drm] Initialized drm 1.0.0 20040925=0A=
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12=0A=
serio: i8042 AUX port at 0x60,0x64 irq 12=0A=
serio: i8042 KBD port at 0x60,0x64 irq 1=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled=0A=
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0A=
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=0A=
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0A=
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=0A=
parport: PnPBIOS parport detected.=0A=
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]=0A=
lp0: using parport0 (interrupt-driven).=0A=
io scheduler noop registered=0A=
io scheduler anticipatory registered=0A=
io scheduler deadline registered=0A=
io scheduler cfq registered=0A=
FDC 0 is a post-1991 82077=0A=
8139too Fast Ethernet driver 0.9.27=0A=
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10=0A=
PCI: setting IRQ 10 as level-triggered=0A=
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 10 (level, =
low) -> IRQ 10=0A=
eth0: RealTek RTL8139 at 0xc000, 00:e0:7d:d1:c2:b2, IRQ 10=0A=
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
Probing IDE interface ide0...=0A=
hda: Maxtor 54098H8, ATA DISK drive=0A=
hdb: Maxtor 6Y120P0, ATA DISK drive=0A=
Probing IDE interface ide1...=0A=
hdc: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive=0A=
hdd: PIONEER DVD-RW DVR-107D, ATAPI CD/DVD-ROM drive=0A=
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
ide1 at 0x170-0x177,0x376 on irq 15=0A=
hda: max request size: 128KiB=0A=
hda: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=3D65535/16/63=0A=
hda: cache flushes not supported=0A=
 hda: hda1 hda2 hda3 hda4=0A=
hdb: max request size: 128KiB=0A=
hdb: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=3D65535/16/63=0A=
hdb: cache flushes supported=0A=
 hdb: hdb1=0A=
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache=0A=
Uniform CD-ROM driver Revision: 3.20=0A=
hdd: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache=0A=
libata version 1.12 loaded.=0A=
ieee1394: raw1394: /dev/raw1394 device initialized=0A=
usbmon: debugfs is not available=0A=
USB Universal Host Controller Interface driver v2.3=0A=
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11=0A=
PCI: setting IRQ 11 as level-triggered=0A=
ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 11 (level, =
low) -> IRQ 11=0A=
uhci_hcd 0000:00:11.2: UHCI Host Controller=0A=
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1=0A=
uhci_hcd 0000:00:11.2: irq 11, io base 0x0000e400=0A=
hub 1-0:1.0: USB hub found=0A=
hub 1-0:1.0: 2 ports detected=0A=
ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 11 (level, =
low) -> IRQ 11=0A=
uhci_hcd 0000:00:11.3: UHCI Host Controller=0A=
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2=0A=
uhci_hcd 0000:00:11.3: irq 11, io base 0x0000e800=0A=
hub 2-0:1.0: USB hub found=0A=
hub 2-0:1.0: 2 ports detected=0A=
usb 1-2: new full speed USB device using uhci_hcd and address 2=0A=
usbcore: registered new driver usblp=0A=
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver=0A=
Initializing USB Mass Storage driver...=0A=
usbcore: registered new driver usb-storage=0A=
USB Mass Storage support registered.=0A=
usbcore: registered new driver usbhid=0A=
drivers/usb/input/hid-core.c: v2.6:USB HID core driver=0A=
mice: PS/2 mouse device common for all mice=0A=
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 =
08:13:09 2005 UTC).=0A=
ALSA device list:=0A=
  No soundcards found.=0A=
oprofile: using timer interrupt.=0A=
NET: Registered protocol family 2=0A=
input: AT Translated Set 2 keyboard on isa0060/serio0=0A=
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)=0A=
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)=0A=
TCP: Hash tables configured (established 131072 bind 65536)=0A=
TCP reno registered=0A=
ip_conntrack version 2.3 (7168 buckets, 57344 max) - 216 bytes per =
conntrack=0A=
ip_tables: (C) 2000-2002 Netfilter core team=0A=
ipt_recent v0.3.1: Stephen Frost <sfrost@domain.hid>.  =
http://snowman.net/projects/ipt_recent/=0A=
arp_tables: (C) 2002 David S. Miller=0A=
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1=0A=
TCP bic registered=0A=
NET: Registered protocol family 1=0A=
NET: Registered protocol family 17=0A=
Using IPI Shortcut mode=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
VFS: Mounted root (ext3 filesystem) readonly.=0A=
Freeing unused kernel memory: 224k freed=0A=
kjournald starting.  Commit interval 5 seconds=0A=
Adding 999928k swap on /dev/hda2.  Priority:-1 extents:1 across:999928k=0A=
EXT3 FS on hda3, internal journal=0A=
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1=0A=
xeno_native: Unknown symbol nktimer=0A=
xeno_native: Unknown symbol xnheap_schedule_free=0A=
xeno_native: Unknown symbol xnshadow_register_interface=0A=
xeno_native: Unknown symbol xntimer_get_timeout=0A=
xeno_native: Unknown symbol xnpipe_connect=0A=
xeno_native: Unknown symbol xnpod_unblock_thread=0A=
xeno_native: Unknown symbol xncore_detach=0A=
xeno_native: Unknown symbol xnpod_shutdown=0A=
xeno_native: Unknown symbol xnpod_remove_hook=0A=
xeno_native: Unknown symbol rthal_apc_free=0A=
xeno_native: Unknown symbol xnsynch_wakeup_one_sleeper=0A=
xeno_native: Unknown symbol xnheap_init=0A=
xeno_native: Unknown symbol xnpod_announce_tick=0A=
xeno_native: Unknown symbol rthal_apc_schedule=0A=
xeno_native: Unknown symbol nkgkptd=0A=
xeno_native: Unknown symbol xnpod_init_thread=0A=
xeno_native: Unknown symbol rthal_strncpy_from_user=0A=
xeno_native: Unknown symbol xnpod_get_time=0A=
xeno_native: Unknown symbol xnpod_renice_thread=0A=
xeno_native: Unknown symbol xnheap_alloc=0A=
xeno_native: Unknown symbol xntimer_destroy=0A=
xeno_native: Unknown symbol xnintr_enable=0A=
xeno_native: Unknown symbol kheap=0A=
xeno_native: Unknown symbol xnpod_start_timer=0A=
xeno_native: Unknown symbol xnpod_stop_timer=0A=
xeno_native: Unknown symbol xntimer_init=0A=
xeno_native: Unknown symbol rthal_tunables=0A=
xeno_native: Unknown symbol xnpod_wait_thread_period=0A=
xeno_native: Unknown symbol rthal_domain=0A=
xeno_native: Unknown symbol xnsynch_wakeup_this_sleeper=0A=
xeno_native: Unknown symbol xnshadow_relax=0A=
xeno_native: Unknown symbol xnsynch_flush=0A=
xeno_native: Unknown symbol nkpod=0A=
xeno_native: Unknown symbol xnintr_detach=0A=
xeno_native: Unknown symbol nklock=0A=
xeno_native: Unknown symbol xnshadow_map=0A=
xeno_native: Unknown symbol xnpipe_disconnect=0A=
xeno_native: Unknown symbol xnshadow_unmap=0A=
xeno_native: Unknown symbol xnheap_destroy=0A=
xeno_native: Unknown symbol xncore_attach=0A=
xeno_native: Unknown symbol xnshadow_signal_completion=0A=
xeno_native: Unknown symbol xnshadow_unregister_interface=0A=
xeno_native: Unknown symbol xnheap_test_and_free=0A=
xeno_native: Unknown symbol xnpod_add_hook=0A=
xeno_native: Unknown symbol xnpod_set_thread_periodic=0A=
xeno_native: Unknown symbol xnsynch_init=0A=
xeno_native: Unknown symbol xntimer_start=0A=
xeno_native: Unknown symbol xnpod_schedule=0A=
xeno_native: Unknown symbol xnheap_destroy_shared=0A=
xeno_native: Unknown symbol rthal_apc_alloc=0A=
xeno_native: Unknown symbol rthal_proc_root=0A=
xeno_native: Unknown symbol xnpod_start_thread=0A=
xeno_native: Unknown symbol xnpod_set_thread_mode=0A=
xeno_native: Unknown symbol xnpod_suspend_thread=0A=
xeno_native: Unknown symbol xnheap_free=0A=
xeno_native: Unknown symbol xnintr_disable=0A=
xeno_native: Unknown symbol xnintr_attach=0A=
xeno_native: Unknown symbol xnheap_init_shared=0A=
xeno_native: Unknown symbol xnpipe_send=0A=
xeno_native: Unknown symbol xnintr_init=0A=
xeno_native: Unknown symbol xnsynch_sleep_on=0A=
xeno_native: Unknown symbol xnpod_delete_thread=0A=
xeno_native: Unknown symbol xnpipe_recv=0A=
xeno_native: Unknown symbol xnintr_destroy=0A=
xeno_native: Unknown symbol xnpod_resume_thread=0A=
xeno_native: Unknown symbol xntimer_get_date=0A=
xeno_posix: Unknown symbol nktimer=0A=
xeno_posix: Unknown symbol xnshadow_register_interface=0A=
xeno_posix: Unknown symbol xntimer_get_timeout=0A=
xeno_posix: Unknown symbol xnpod_unblock_thread=0A=
xeno_posix: Unknown symbol xncore_detach=0A=
xeno_posix: Unknown symbol xnpod_shutdown=0A=
xeno_posix: Unknown symbol xnpod_remove_hook=0A=
xeno_posix: Unknown symbol xnpod_fatal_helper=0A=
xeno_posix: Unknown symbol xnsynch_wakeup_one_sleeper=0A=
xeno_posix: Unknown symbol xnpod_announce_tick=0A=
xeno_posix: Unknown symbol xnpod_init_thread=0A=
xeno_posix: Unknown symbol rthal_strncpy_from_user=0A=
xeno_posix: Unknown symbol xnpod_get_time=0A=
xeno_posix: Unknown symbol xnpod_renice_thread=0A=
xeno_posix: Unknown symbol xnheap_alloc=0A=
xeno_posix: Unknown symbol xntimer_destroy=0A=
xeno_posix: Unknown symbol xnintr_enable=0A=
xeno_posix: Unknown symbol kheap=0A=
xeno_posix: Unknown symbol xnpod_start_timer=0A=
xeno_posix: Unknown symbol xnpod_stop_timer=0A=
xeno_posix: Unknown symbol xntimer_init=0A=
xeno_posix: Unknown symbol rthal_tunables=0A=
xeno_posix: Unknown symbol xnpod_wait_thread_period=0A=
xeno_posix: Unknown symbol rthal_domain=0A=
xeno_posix: Unknown symbol xnshadow_relax=0A=
xeno_posix: Unknown symbol xnsynch_flush=0A=
xeno_posix: Unknown symbol nkpod=0A=
xeno_posix: Unknown symbol xnintr_detach=0A=
xeno_posix: Unknown symbol nklock=0A=
xeno_posix: Unknown symbol xnshadow_map=0A=
xeno_posix: Unknown symbol xnshadow_unmap=0A=
xeno_posix: Unknown symbol xncore_attach=0A=
xeno_posix: Unknown symbol xnshadow_unregister_interface=0A=
xeno_posix: Unknown symbol xnpod_add_hook=0A=
xeno_posix: Unknown symbol xnpod_set_thread_periodic=0A=
xeno_posix: Unknown symbol xnsynch_init=0A=
xeno_posix: Unknown symbol xntimer_start=0A=
xeno_posix: Unknown symbol xnpod_schedule=0A=
xeno_posix: Unknown symbol xnpod_start_thread=0A=
xeno_posix: Unknown symbol xnpod_set_thread_mode=0A=
xeno_posix: Unknown symbol xnpod_suspend_thread=0A=
xeno_posix: Unknown symbol xnheap_free=0A=
xeno_posix: Unknown symbol xnshadow_suspend=0A=
xeno_posix: Unknown symbol xnintr_disable=0A=
xeno_posix: Unknown symbol xnintr_attach=0A=
xeno_posix: Unknown symbol xnintr_init=0A=
xeno_posix: Unknown symbol xnpod_check_context=0A=
xeno_posix: Unknown symbol xnsynch_sleep_on=0A=
xeno_posix: Unknown symbol xnpod_delete_thread=0A=
xeno_posix: Unknown symbol xnintr_destroy=0A=
xeno_posix: Unknown symbol xnpod_resume_thread=0A=

------=_NextPart_000_0013_01C5FBDE.D89349D0--


