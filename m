Message-ID: <45E1641F.1050009@domain.hid>
Date: Sun, 25 Feb 2007 11:25:35 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000404020906060106020507"
Subject: [Xenomai-core] Kernel lockup with lapic on old AMD Athlon
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------000404020906060106020507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

here is the boot log of an hangup of 2.6.20 with I-pipe 1.7-02 and 
Xenomai todays trunk. I already reported this hangup a while ago but now 
I get an oops. At that time Gilles said that lapic on old Athlons might 
be buggy. Does the attached boot log confirm this assumption? 2.6.20-rt8 
is working, BTW.

Thanks.

Wolfgang.

--------------000404020906060106020507
Content-Type: text/x-log;
 name="bernex-ipipe-lockup.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bernex-ipipe-lockup.log"

Linux version 2.6.20-ipipe (wolf@domain.hid) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 PREEMPT Sun Feb 25 10:21:36 CET 2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001fef0000 end: 000000001fff0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001fff0000 size: 0000000000003000 end: 000000001fff3000 type: 4
copy_e820_map() start: 000000001fff3000 size: 000000000000d000 end: 0000000020000000 type: 3
copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131056
  HighMem    131056 ->   131056
early_node_map[1] active PFN ranges
    0:        0 ->   131056
DMI 2.2 present.
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
Detected 1099.576 MHz processor.
Built 1 zonelists.  Total pages: 130033
Kernel command line: ro root=LABEL=/ rhgb console=tty0 console=ttyS1,19200 lapicLocal APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Enabling fast FPU save and restore... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0434000 soft=c0435000
PID hash table entries: 2048 (order: 11, 8192 bytes)
I-pipe 1.7-02: pipeline enabled.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514108k/524224k available (2165k kernel code, 9552k reserved, 872k data, 216k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9c000 - 0xfffff000   ( 396 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc03f9000 - 0xc042f000   ( 216 kB)
      .data : 0xc031d467 - 0xc03f75d0   ( 872 kB)
      .text : 0xc0100000 - 0xc031d467   (2165 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2199.58 BogoMIPS (lpj=1099790)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0800 (from 0e20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
PCI quirk: region 6000-607f claimed by vt82c686 HW-mon
PCI quirk: region 5000-500f claimed by vt82c686 SMB
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: d8000000-d9ffffff
  PREFETCH window: d4000000-d7ffffff
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 1064k freed
audit: initializing netlink socket (disabled)
audit(1172401011.843:1): initialized
I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
Xenomai: real-time nucleus v2.4-devel (Bells Of Lal) loaded.
Xenomai: starting native API services.
BUG: NMI Watchdog detected LOCKUP on CPU0, eip c02b6dd8, registers:
Modules linked in:
CPU:    0
EIP:    0060:[<c02b6dd8>]    Not tainted VLI
EFLAGS: 00000002   (2.6.20-ipipe #1)
EIP is at rthal_broadcast_to_local_timers+0x7/0x2a
eax: 000810ef   ebx: c16a1760   ecx: 00000286   edx: fffff000
esi: 000000a0   edi: 00000001   ebp: 00000000   esp: c0434fd4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=c0434000 task=dfe815f0 task.ti=c147c000)
Stack: c013d919 c03eeb00 00000000 c03eeb30 c03b7300 c013ed0c c147ce74 00000000
       c013ec96 c03eeb00 c0105031
Call Trace:
 [<c013d919>] handle_IRQ_event+0x1e/0x47
 [<c013ed0c>] handle_level_irq+0x76/0xbf
 [<c013ec96>] handle_level_irq+0x0/0xbf
 [<c0105031>] do_IRQ+0xb5/0xdc
 [<c0140867>] __ipipe_sync_stage+0xd1/0x117
 [<c014086c>] __ipipe_sync_stage+0xd6/0x117
 [<c0140e22>] __ipipe_unstall_root+0x1a/0x1c
 [<c0119d9c>] vprintk+0x2c1/0x321
 [<c017b2dd>] __kmalloc+0x91/0x9c
 [<c0319bff>] _spin_unlock+0x1b/0x3b
 [<c01aebf7>] proc_register+0x85/0xfe
 [<c01af050>] create_proc_entry+0x8b/0x9f
 [<c0143c90>] iface_read_proc+0x0/0x6a
 [<c0143a30>] add_proc_leaf+0x20/0x45
 [<c0119e3e>] printk+0x42/0xa8
 [<c014e3a0>] __native_skin_init+0xa5/0xf1
 [<c0100417>] init+0x97/0x24c
 [<c0102d27>] ret_from_fork+0x7/0x1c
 [<c0102ee8>] restore_nocheck_notrace+0x0/0xf
 [<c0100380>] init+0x0/0x24c
 [<c0100380>] init+0x0/0x24c
 [<c0103a73>] kernel_thread_helper+0x7/0x10
 =======================
Code: 80 00 00 00 89 ea 8b 44 24 20 89 44 24 04 8b 44 24 08 89 04 24 89 d8 e8 a8 74 e8 ff 83 c4 0c 5b 5e 5f 5d c3 9c 59 fa eb 02 f3 90 <8b> 15 cc 72 3b c0 8b 82 00 e3 ff ff f6 c4 10 75 ed c7 82 00 e3


(gdb) l *0xc02b6dd8
0xc02b6dd8 is in rthal_broadcast_to_local_timers (include/asm/apic.h:62).
57              xchg((volatile unsigned long *)(APIC_BASE+reg), v);
58      }
59
60      static __inline fastcall unsigned long native_apic_read(unsigned long reg)
61      {
62              return *((volatile unsigned long *)(APIC_BASE+reg));
63      }
64
65      static __inline__ void apic_wait_icr_idle(void)
66      {


--------------000404020906060106020507--

