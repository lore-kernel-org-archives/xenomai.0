Message-ID: <491955B7.4080805@domain.hid>
Date: Tue, 11 Nov 2008 10:51:51 +0100
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060808000202060500040705"
Subject: [Adeos-main] [BUG] boot failure with
	adeos-ipipe-2.6.27-x86-2.1-01.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------060808000202060500040705
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello Philippe,

here comes a more serious bug than the one from yesterday. When I try to 
  boot a system patched with the latest ipipe on a PIII the attached 
boot log will show up. config also attached.

-- 
Sebastian

--------------060808000202060500040705
Content-Type: text/plain;
 name="ipipe-x86-2.6.27-2.1-01.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe-x86-2.6.27-2.1-01.log"

Linux version 2.6.27 (smolorz@domain.hid) (gcc version 4.2.1 (SUSE Linux)) #4 PREEMPT Mon Nov 10 16:37:13 CET 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000c8000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
last_pfn = 0x10000 max_arch_pfn = 0x100000
DMI not present or invalid.
256MB LOWMEM available.
  mapped low ram: 0 - 10000000
  low ram: 00000000 - 10000000
  bootmap 00001000 - 00003000
(6 early reservations) ==> bootmem [0000000000 - 0010000000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000100000 - 000036514c]    TEXT DATA BSS ==> [0000100000 - 000036514c]
  #2 [0000366000 - 0000368000]    INIT_PG_TABLE ==> [0000366000 - 0000368000]
  #3 [000009ec00 - 0000100000]    BIOS reserved ==> [000009ec00 - 0000100000]
  #4 [0000007000 - 0000008000]          PGTABLE ==> [0000007000 - 0000008000]
  #5 [0000001000 - 0000003000]          BOOTMAP ==> [0000001000 - 0000003000]
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x0000009e
    0: 0x00000100 -> 0x00010000
Allocating PCI resources starting at 20000000 (gap: 10000000:effc0000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64926
Kernel command line: root=/dev/hda1 ro vga=773 console=ttyS0,115200PN
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
TSC: Using PIT calibration value
Detected 698.463 MHz processor.
I-pipe 2.1-01: pipeline enabled.
start_kernel(): bug: interrupts were enabled early
Console: colour dummy device 80x25
console [ttyS0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256848k/262144k available (1485k kernel code, 4724k reserved, 656k data, 148k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffffa000 - 0xfffff000   (  20 kB)
    vmalloc : 0xd0800000 - 0xffff8000   ( 759 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
      .init : 0xc031a000 - 0xc033f000   ( 148 kB)
      .data : 0xc0273410 - 0xc0317780   ( 656 kB)
      .text : 0xc0100000 - 0xc0273410   (1485 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
Calibrating delay loop (skipped), value calculated using timer frequency.. 1396.92 BogoMIPS (lpj=2793852)
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 0k freed
BUG: scheduling while atomic: swapper/0/0x0000002e
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c026b9e3>] rest_init+0x4f/0x5e
 [<c031a945>] start_kernel+0x25d/0x260
 =======================
net_namespace: 288 bytes
initcall net_ns_init+0x0/0x105 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000003
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c03248b1>] ksysfs_init+0x0/0x92
 [<c011a100>] uids_user_create+0x51/0x58
 [<c032490c>] ksysfs_init+0x5b/0x92
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall ksysfs_init+0x0/0x92 returned with preemption imbalance 
NET: Registered protocol family 16
BUG: scheduling while atomic: swapper/1/0x00000007
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c022a79f>] rtnl_dump_all+0x0/0x98
 [<c01dc1e5>] __class_create+0x3c/0x53
 [<c0326521>] bdi_class_init+0x0/0x20
 [<c0326532>] bdi_class_init+0x11/0x20
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall bdi_class_init+0x0/0x20 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000000b
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0327e76>] pcibus_class_init+0x0/0xf
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c0327d00>] kobject_uevent_init+0x0/0x3b
 [<c0327e76>] pcibus_class_init+0x0/0xf
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall pcibus_class_init+0x0/0xf returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000000d
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01db622>] bus_register+0x7d/0x1a2
 [<c03282af>] pci_driver_init+0x0/0xa
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall pci_driver_init+0x0/0xa returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000000f
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c01dc1e5>] __class_create+0x3c/0x53
 [<c0328fc9>] tty_class_init+0x0/0x28
 [<c0328fda>] tty_class_init+0x11/0x28
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall tty_class_init+0x0/0x28 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000013
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c01dc1e5>] __class_create+0x3c/0x53
 [<c0329975>] vtconsole_class_init+0x0/0x9b
 [<c0329987>] vtconsole_class_init+0x12/0x9b
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000003d
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f86>] device_initialize+0x77/0x9f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0329975>] vtconsole_class_init+0x0/0x9b
 [<c01da71d>] device_create+0x24/0x28
 [<c03299d3>] vtconsole_class_init+0x5e/0x9b
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall vtconsole_class_init+0x0/0x9b returned with preemption imbalance 
PCI: PCI BIOS revision 2.10 entry at 0xfd930, last bus=0
PCI: Using configuration type 1 for base access
initcall pci_arch_init+0x0/0x3f returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000017
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01dac8b>] sysdev_register+0x86/0x8e
 [<c0321e6c>] topology_init+0x0/0xf
 [<c0331885>] register_cpu+0x1b/0x27
 [<c0321e78>] topology_init+0xc/0xf
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall topology_init+0x0/0xf returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000001b
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000003f
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000065
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000089
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000000ad
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000000d3
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000000f9
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000011d
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000141
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000167
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000018d
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000001b1
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000001d7
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000001fb
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000021f
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000245
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000026b
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000028f
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000002b3
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000002d9
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324707>] param_sysfs_init+0xf1/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000002ff
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324753>] param_sysfs_init+0x13d/0x148
 [<c0324616>] param_sysfs_init+0x0/0x148
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall param_sysfs_init+0x0/0x148 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000001f
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f86>] device_initialize+0x77/0x9f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c03264c6>] readahead_init+0x0/0x29
 [<c013d310>] bdi_register+0x25/0x37
 [<c03264e8>] readahead_init+0x22/0x29
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall readahead_init+0x0/0x29 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000023
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011013f>] check_preempt_wakeup+0x10d/0x115
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0121c6c>] kthread_create+0x7d/0xb0
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f49a>] create_workqueue_thread+0x26/0x37
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f592>] __create_workqueue_key+0xca/0xea
 [<c0327bcd>] genhd_device_init+0x0/0x3d
 [<c0327b1a>] blk_dev_init+0x12/0x8a
 [<c0327c06>] genhd_device_init+0x39/0x3d
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall genhd_device_init+0x0/0x3d returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000027
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c015062f>] exact_lock+0x0/0xd
 [<c01dc1e5>] __class_create+0x3c/0x53
 [<c03283b5>] fbmem_init+0x0/0x74
 [<c0328403>] fbmem_init+0x4e/0x74
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall fbmem_init+0x0/0x74 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000029
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c01dc1e5>] __class_create+0x3c/0x53
 [<c0329519>] misc_init+0x0/0x7e
 [<c0329540>] misc_init+0x27/0x7e
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall misc_init+0x0/0x7e returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000002b
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c032aea3>] init_scsi+0x0/0x7e
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c032b08b>] scsi_init_devinfo+0x54/0x76
 [<c032aea3>] init_scsi+0x0/0x7e
 [<c032aeca>] init_scsi+0x27/0x7e
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000057
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01db622>] bus_register+0x7d/0x1a2
 [<c032aea3>] init_scsi+0x0/0x7e
 [<c01fd633>] scsi_sysfs_register+0xb/0x34
 [<c032aee0>] init_scsi+0x3d/0x7e
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000007f
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c032aea3>] init_scsi+0x0/0x7e
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c032aea3>] init_scsi+0x0/0x7e
 [<c01fd648>] scsi_sysfs_register+0x20/0x34
 [<c032aee0>] init_scsi+0x3d/0x7e
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
SCSI subsystem initialized
initcall init_scsi+0x0/0x7e returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000002f
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01db622>] bus_register+0x7d/0x1a2
 [<c032b1e6>] serio_init+0x0/0x7b
 [<c032b1f3>] serio_init+0xd/0x7b
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000055
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011013f>] check_preempt_wakeup+0x10d/0x115
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c032b1e6>] serio_init+0x0/0x7b
 [<c0121c6c>] kthread_create+0x7d/0xb0
 [<c0206c67>] serio_thread+0x0/0x308
 [<c01db59f>] bus_create_file+0x2b/0x31
 [<c032b217>] serio_init+0x31/0x7b
 [<c0206c67>] serio_thread+0x0/0x308
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall serio_init+0x0/0x7b returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000033
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c032b365>] input_init+0x0/0xdc
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c032b365>] input_init+0x0/0xdc
 [<c032b375>] input_init+0x10/0xdc
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall input_init+0x0/0xdc returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000035
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c01dc1e5>] __class_create+0x3c/0x53
 [<c032b53b>] hwmon_init+0x0/0x33
 [<c032b54c>] hwmon_init+0x11/0x33
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall hwmon_init+0x0/0x33 returned with preemption imbalance 
PCI: Probing PCI hardware
BUG: scheduling while atomic: swapper/1/0x00000039
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f86>] device_initialize+0x77/0x9f
 [<c01afa05>] pci_create_bus+0x10a/0x192
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c026d1c2>] pci_scan_bus_parented+0xa/0x1f
 [<c0270ad6>] pcibios_scan_root+0x63/0x79
 [<c032c741>] pci_subsys_init+0x42/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
pci 0000:00:07.3: quirk: region 1000-103f claimed by PIIX4 ACPI
pci 0000:00:07.3: quirk: region 1040-104f claimed by PIIX4 SMB
pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:12.0: PME# disabled
BUG: scheduling while atomic: swapper/1/0x00000071
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c026d179>] pci_scan_child_bus+0x30/0x6f
 [<c01af5a0>] pci_bus_add_device+0xc/0x2c
 [<c01af5de>] pci_bus_add_devices+0x1e/0x134
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c750>] pci_subsys_init+0x51/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000009d
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c026d179>] pci_scan_child_bus+0x30/0x6f
 [<c01af5a0>] pci_bus_add_device+0xc/0x2c
 [<c01af5de>] pci_bus_add_devices+0x1e/0x134
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c750>] pci_subsys_init+0x51/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000000c9
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c026d179>] pci_scan_child_bus+0x30/0x6f
 [<c01af5a0>] pci_bus_add_device+0xc/0x2c
 [<c01af5de>] pci_bus_add_devices+0x1e/0x134
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c750>] pci_subsys_init+0x51/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000000f5
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c026d179>] pci_scan_child_bus+0x30/0x6f
 [<c01af5a0>] pci_bus_add_device+0xc/0x2c
 [<c01af5de>] pci_bus_add_devices+0x1e/0x134
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c750>] pci_subsys_init+0x51/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000123
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c026d179>] pci_scan_child_bus+0x30/0x6f
 [<c01af5a0>] pci_bus_add_device+0xc/0x2c
 [<c01af5de>] pci_bus_add_devices+0x1e/0x134
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c750>] pci_subsys_init+0x51/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000014f
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c026d179>] pci_scan_child_bus+0x30/0x6f
 [<c01af5a0>] pci_bus_add_device+0xc/0x2c
 [<c01af5de>] pci_bus_add_devices+0x1e/0x134
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c750>] pci_subsys_init+0x51/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000017b
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c026d179>] pci_scan_child_bus+0x30/0x6f
 [<c01af5a0>] pci_bus_add_device+0xc/0x2c
 [<c01af5de>] pci_bus_add_devices+0x1e/0x134
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c750>] pci_subsys_init+0x51/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:107 pci_find_next_bus+0x22/0x52()
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01133f0>] vprintk+0x282/0x28e
 [<c01133f0>] vprintk+0x282/0x28e
 [<c01031fa>] print_trace_address+0x0/0x32
 [<c0113818>] printk+0x7e/0xf0
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 [<c01031fa>] print_trace_address+0x0/0x32
 [<c010320c>] print_trace_address+0x12/0x32
 [<c0120237>] __kernel_text_address+0x18/0x23
 [<c01033c6>] dump_trace+0xb2/0xbd
 [<c010e1e6>] update_curr+0x41/0x65
 [<c010e3d6>] __dequeue_entity+0x1f/0x71
 [<c010e439>] set_next_entity+0x11/0x38
 [<c010e518>] pick_next_task_fair+0x99/0xb1
 [<c01b2a55>] pci_find_next_bus+0x22/0x52
 [<c01b2b0e>] pci_find_bus+0x27/0x35
 [<c032cd0b>] pcibios_irq_init+0x14c/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:107 pci_find_next_bus+0x22/0x52()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01133f0>] vprintk+0x282/0x28e
 [<c01133f0>] vprintk+0x282/0x28e
 [<c01031fa>] print_trace_address+0x0/0x32
 [<c0113818>] printk+0x7e/0xf0
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 [<c01031fa>] print_trace_address+0x0/0x32
 [<c010320c>] print_trace_address+0x12/0x32
 [<c0120237>] __kernel_text_address+0x18/0x23
 [<c01033c6>] dump_trace+0xb2/0xbd
 [<c010e1e6>] update_curr+0x41/0x65
 [<c010e3d6>] __dequeue_entity+0x1f/0x71
 [<c010e439>] set_next_entity+0x11/0x38
 [<c010e518>] pick_next_task_fair+0x99/0xb1
 [<c01b2a55>] pci_find_next_bus+0x22/0x52
 [<c01b2b0e>] pci_find_bus+0x27/0x35
 [<c032cd0b>] pcibios_irq_init+0x14c/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:107 pci_find_next_bus+0x22/0x52()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c0112ab0>] warn_on_slowpath+0x45/0x63
 [<c01133f0>] vprintk+0x282/0x28e
 [<c01133f0>] vprintk+0x282/0x28e
 [<c01031fa>] print_trace_address+0x0/0x32
 [<c0113818>] printk+0x7e/0xf0
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 [<c01031fa>] print_trace_address+0x0/0x32
 [<c010320c>] print_trace_address+0x12/0x32
 [<c0120237>] __kernel_text_address+0x18/0x23
 [<c01033c6>] dump_trace+0xb2/0xbd
 [<c010e1e6>] update_curr+0x41/0x65
 [<c01b2a55>] pci_find_next_bus+0x22/0x52
 [<c01b2b0e>] pci_find_bus+0x27/0x35
 [<c01af949>] pci_create_bus+0x4e/0x192
 [<c010e518>] pick_next_task_fair+0x99/0xb1
 [<c026d1c2>] pci_scan_bus_parented+0xa/0x1f
 [<c02707b6>] pci_scan_bus_on_node+0x3f/0x5b
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cd1d>] pcibios_irq_init+0x15e/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:107 pci_find_next_bus+0x22/0x52()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c0112ab0>] warn_on_slowpath+0x45/0x63
 [<c01133f0>] vprintk+0x282/0x28e
 [<c01133f0>] vprintk+0x282/0x28e
 [<c01031fa>] print_trace_address+0x0/0x32
 [<c0113818>] printk+0x7e/0xf0
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 [<c01031fa>] print_trace_address+0x0/0x32
 [<c010320c>] print_trace_address+0x12/0x32
 [<c0120237>] __kernel_text_address+0x18/0x23
 [<c01033c6>] dump_trace+0xb2/0xbd
 [<c010e1e6>] update_curr+0x41/0x65
 [<c01b2a55>] pci_find_next_bus+0x22/0x52
 [<c01b2b0e>] pci_find_bus+0x27/0x35
 [<c01af949>] pci_create_bus+0x4e/0x192
 [<c010e518>] pick_next_task_fair+0x99/0xb1
 [<c026d1c2>] pci_scan_bus_parented+0xa/0x1f
 [<c02707b6>] pci_scan_bus_on_node+0x3f/0x5b
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cd1d>] pcibios_irq_init+0x15e/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
BUG: scheduling while atomic: swapper/1/0x00000291
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f86>] device_initialize+0x77/0x9f
 [<c01afa05>] pci_create_bus+0x10a/0x192
 [<c026d1c2>] pci_scan_bus_parented+0xa/0x1f
 [<c02707b6>] pci_scan_bus_on_node+0x3f/0x5b
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cd1d>] pcibios_irq_init+0x15e/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
PCI: Discovered primary peer bus 01 [IRQ]
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d3b24>] uart_console_write+0x2a/0x33
 [<c01a9539>] delay_tsc+0x23/0x5a
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c01b29d2>] pci_get_bus_and_slot+0x2d/0x38
 [<c032cd9d>] pcibios_irq_init+0x1de/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d3b24>] uart_console_write+0x2a/0x33
 [<c01a9539>] delay_tsc+0x23/0x5a
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c01b29d2>] pci_get_bus_and_slot+0x2d/0x38
 [<c032cd9d>] pcibios_irq_init+0x1de/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:400 pci_dev_present+0x22/0x50()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c01b298c>] pci_get_subsys+0x4b/0x56
 [<c01b28b8>] pci_dev_present+0x22/0x50
 [<c032ca3c>] intel_router_probe+0x10/0x193
 [<c032cdc7>] pcibios_irq_init+0x208/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b28c3>] pci_dev_present+0x2d/0x50
 [<c032ca3c>] intel_router_probe+0x10/0x193
 [<c032cdc7>] pcibios_irq_init+0x208/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b69c>] klist_next+0x29/0x80
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b28c3>] pci_dev_present+0x2d/0x50
 [<c032ca3c>] intel_router_probe+0x10/0x193
 [<c032cdc7>] pcibios_irq_init+0x208/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
pci 0000:00:07.0: PIIX/ICH IRQ router [8086/7110]
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032ceb8>] pcibios_irq_init+0x2f9/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032ceb8>] pcibios_irq_init+0x2f9/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032ceb8>] pcibios_irq_init+0x2f9/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032ceb8>] pcibios_irq_init+0x2f9/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032ceb8>] pcibios_irq_init+0x2f9/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032ceb8>] pcibios_irq_init+0x2f9/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032ceb8>] pcibios_irq_init+0x2f9/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032ceb8>] pcibios_irq_init+0x2f9/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01133db>] vprintk+0x26d/0x28e
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01d899e>] serial8250_console_write+0x114/0x15c
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0112b85>] __call_console_drivers+0x34/0x40
 [<c0124df4>] up+0x48/0x60
 [<c0112fc7>] release_console_sem+0x1ae/0x1de
 [<c01133db>] vprintk+0x26d/0x28e
 [<c02172f1>] pci_conf1_read+0xd1/0xf1
 [<c02182dd>] raw_pci_read+0x4d/0x55
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c7cd>] pci_subsys_init+0xce/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c08d>] pcibios_allocate_bus_resources+0xac/0xc8
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c1eb>] pcibios_resource_survey+0x11/0x1b
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c1eb>] pcibios_resource_survey+0x11/0x1b
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c1eb>] pcibios_resource_survey+0x11/0x1b
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c1eb>] pcibios_resource_survey+0x11/0x1b
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c1eb>] pcibios_resource_survey+0x11/0x1b
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c1eb>] pcibios_resource_survey+0x11/0x1b
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c1eb>] pcibios_resource_survey+0x11/0x1b
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032c1eb>] pcibios_resource_survey+0x11/0x1b
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c026b69c>] klist_next+0x29/0x80
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
------------[ cut here ]------------
WARNING: at drivers/pci/search.c:272 pci_get_dev_by_id+0x25/0x59()
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0112aab>] warn_on_slowpath+0x40/0x63
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032cf04>] pcibios_irq_init+0x345/0x358
 [<c01daf6b>] klist_devices_put+0x0/0x8
 [<c026b56d>] klist_del+0x1a/0x46
 [<c026b5a8>] klist_iter_exit+0xf/0x18
 [<c01db311>] bus_find_device+0x51/0x5a
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c01b2862>] pci_get_dev_by_id+0x25/0x59
 [<c01b2983>] pci_get_subsys+0x42/0x56
 [<c01b29a2>] pci_get_device+0xb/0xe
 [<c032c1c8>] pcibios_allocate_resources+0x11f/0x131
 [<c032c6ff>] pci_subsys_init+0x0/0xda
 [<c032cf66>] pcibios_init+0x4f/0x60
 [<c032c7d2>] pci_subsys_init+0xd3/0xda
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
---[ end trace 4eaa2a86a8e2da22 ]---
initcall pci_subsys_init+0x0/0xda returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000039
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c032d3c2>] net_dev_init+0x0/0x103
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c032d297>] dev_proc_net_init+0x5e/0x91
 [<c032d3c2>] net_dev_init+0x0/0x103
 [<c032d3e6>] net_dev_init+0x24/0x103
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall net_dev_init+0x0/0x103 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000003b
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c01d888a>] serial8250_console_write+0x0/0x15c
 [<c0124df4>] up+0x48/0x60
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c01133db>] vprintk+0x26d/0x28e
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c01200d2>] synchronize_rcu+0x2a/0x2f
 [<c01200ef>] wakeme_after_rcu+0x0/0x8
 [<c022faf7>] netlink_change_ngroups+0x9d/0xaf
 [<c022fa38>] netlink_kernel_create+0x103/0x125
 [<c0230c34>] genl_register_mc_group+0xbc/0x107
 [<c032d83d>] genl_init+0x0/0xaa
 [<c032d8c8>] genl_init+0x8b/0xaa
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/0/0x0000003a
Modules linked in:
Pid: 0, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0101918>] cpu_idle+0x54/0x59
 [<c031a945>] start_kernel+0x25d/0x260
 =======================
initcall genl_init+0x0/0xaa returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000003d
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c01dc1e5>] __class_create+0x3c/0x53
 [<c0328f39>] chr_dev_init+0x0/0x86
 [<c0328f84>] chr_dev_init+0x4b/0x86
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000069
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f00>] device_add_groups+0x40/0x4f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0328f39>] chr_dev_init+0x0/0x86
 [<c01da71d>] device_create+0x24/0x28
 [<c0328fac>] chr_dev_init+0x73/0x86
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000095
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f00>] device_add_groups+0x40/0x4f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0328f39>] chr_dev_init+0x0/0x86
 [<c01da71d>] device_create+0x24/0x28
 [<c0328fac>] chr_dev_init+0x73/0x86
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000000c1
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f00>] device_add_groups+0x40/0x4f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0328f39>] chr_dev_init+0x0/0x86
 [<c01da71d>] device_create+0x24/0x28
 [<c0328fac>] chr_dev_init+0x73/0x86
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
note: khelper[61] exited with preempt_count 2
BUG: scheduling while atomic: swapper/1/0x000000ed
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f00>] device_add_groups+0x40/0x4f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0328f39>] chr_dev_init+0x0/0x86
 [<c01da71d>] device_create+0x24/0x28
 [<c0328fac>] chr_dev_init+0x73/0x86
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000117
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f00>] device_add_groups+0x40/0x4f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0328f39>] chr_dev_init+0x0/0x86
 [<c01da71d>] device_create+0x24/0x28
 [<c0328fac>] chr_dev_init+0x73/0x86
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000143
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f00>] device_add_groups+0x40/0x4f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0328f39>] chr_dev_init+0x0/0x86
 [<c01da71d>] device_create+0x24/0x28
 [<c0328fac>] chr_dev_init+0x73/0x86
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000171
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f00>] device_add_groups+0x40/0x4f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0328f39>] chr_dev_init+0x0/0x86
 [<c01da71d>] device_create+0x24/0x28
 [<c0328fac>] chr_dev_init+0x73/0x86
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000019d
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f00>] device_add_groups+0x40/0x4f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0328f39>] chr_dev_init+0x0/0x86
 [<c01da71d>] device_create+0x24/0x28
 [<c0328fac>] chr_dev_init+0x73/0x86
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000001c9
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d0031>] set_palette+0x2e/0x39
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0328f39>] chr_dev_init+0x0/0x86
 [<c01da71d>] device_create+0x24/0x28
 [<c0328fac>] chr_dev_init+0x73/0x86
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall chr_dev_init+0x0/0x86 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000041
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c032a2da>] firmware_class_init+0x0/0x5b
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c01dc13b>] __class_register+0xa1/0x10f
 [<c032a2da>] firmware_class_init+0x0/0x5b
 [<c032a2ea>] firmware_class_init+0x10/0x5b
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall firmware_class_init+0x0/0x5b returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000043
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01a81ce>] strlcpy+0x14/0x3e
 [<c032a59c>] loopback_init+0x0/0xa
 [<c02230c8>] register_netdevice+0x1f4/0x25d
 [<c0223160>] register_netdev+0x2f/0x3b
 [<c032a5d1>] loopback_net_init+0x2b/0x56
 [<c0220e9b>] register_pernet_operations+0x10/0x11
 [<c0220ef3>] register_pernet_device+0x1a/0x41
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall loopback_init+0x0/0xa returned with preemption imbalance 
bus: 00 index 0 io port: [0, ffff]
bus: 00 index 1 mmio: [0, ffffffff]
bus: 01 index 0 io port: [0, ffff]
bus: 01 index 1 mmio: [0, ffffffff]
initcall pcibios_assign_resources+0x0/0x72 returned with preemption imbalance 
NET: Registered protocol family 2
BUG: scheduling while atomic: swapper/1/0x0000004d
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c032e4c8>] inet_init+0x0/0x1bc
 [<c01200d2>] synchronize_rcu+0x2a/0x2f
 [<c01200ef>] wakeme_after_rcu+0x0/0x8
 [<c032e5bf>] inet_init+0xf7/0x1bc
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/0/0x00000046
Modules linked in:
Pid: 0, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0101918>] cpu_idle+0x54/0x59
 [<c031a945>] start_kernel+0x25d/0x260
 =======================
BUG: scheduling while atomic: swapper/1/0x0000006d
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c032e4c8>] inet_init+0x0/0x1bc
 [<c01200d2>] synchronize_rcu+0x2a/0x2f
 [<c01200ef>] wakeme_after_rcu+0x0/0x8
 [<c032e5bf>] inet_init+0xf7/0x1bc
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/0/0x00000050
Modules linked in:
Pid: 0, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0101918>] cpu_idle+0x54/0x59
 [<c031a945>] start_kernel+0x25d/0x260
 =======================
BUG: scheduling while atomic: swapper/1/0x0000008d
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c032e4c8>] inet_init+0x0/0x1bc
 [<c01200d2>] synchronize_rcu+0x2a/0x2f
 [<c01200ef>] wakeme_after_rcu+0x0/0x8
 [<c032e5bf>] inet_init+0xf7/0x1bc
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/0/0x0000005a
Modules linked in:
Pid: 0, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0101918>] cpu_idle+0x54/0x59
 [<c031a945>] start_kernel+0x25d/0x260
 =======================
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
BUG: scheduling while atomic: swapper/1/0x000000bb
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c014c830>] do_tune_cpucache+0x1a4/0x1fc
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c014cd59>] kmem_cache_create+0x34f/0x35a
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c032e4c8>] inet_init+0x0/0x1bc
 [<c01200d2>] synchronize_rcu+0x2a/0x2f
 [<c01200ef>] wakeme_after_rcu+0x0/0x8
 [<c032e023>] udplite4_register+0x30/0x6c
 [<c032e5e5>] inet_init+0x11d/0x1bc
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/0/0x00000064
Modules linked in:
Pid: 0, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0101918>] cpu_idle+0x54/0x59
 [<c031a945>] start_kernel+0x25d/0x260
 =======================
initcall inet_init+0x0/0x1bc returned with preemption imbalance 
NET: Registered protocol family 1
initcall af_unix_init+0x0/0x41 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000051
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c031fdc5>] i8259A_init_sysfs+0x0/0x19
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c031fdcf>] i8259A_init_sysfs+0xa/0x19
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000003
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x0000002e/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000045
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000077
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01dac8b>] sysdev_register+0x86/0x8e
 [<c031fdc5>] i8259A_init_sysfs+0x0/0x19
 [<c031fdc5>] i8259A_init_sysfs+0x0/0x19
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x0000005b
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x00000086/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x0000009d
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall i8259A_init_sysfs+0x0/0x19 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000055
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0321e53>] i8237A_init_sysfs+0x0/0x19
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c0321e5d>] i8237A_init_sysfs+0xa/0x19
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x000000b3
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x000000de/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x000000f5
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000007b
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01dac8b>] sysdev_register+0x86/0x8e
 [<c0321e53>] i8237A_init_sysfs+0x0/0x19
 [<c0321e53>] i8237A_init_sysfs+0x0/0x19
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x0000010b
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x00000136/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x0000014d
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall i8237A_init_sysfs+0x0/0x19 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000059
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c0116d02>] __insert_resource+0x11/0x9a
 [<c01dc69e>] platform_device_add+0xcf/0xfa
 [<c03222aa>] add_rtc_cmos+0x0/0xd
 [<c03222b4>] add_rtc_cmos+0xa/0xd
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000163
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x0000018e/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x000001a5
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall add_rtc_cmos+0x0/0xd returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000005b
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01a81ce>] strlcpy+0x14/0x3e
 [<c01d9f86>] device_initialize+0x77/0x9f
 [<c01dc69e>] platform_device_add+0xcf/0xfa
 [<c0322c07>] add_pcspkr+0x0/0x31
 [<c0322c26>] add_pcspkr+0x1f/0x31
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x000001bb
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x000001e6/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x000001fd
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall add_pcspkr+0x0/0x31 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000005d
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324991>] timekeeping_init_device+0x0/0x19
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c032499b>] timekeeping_init_device+0xa/0x19
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000213
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x0000023e/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000255
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000085
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01dac8b>] sysdev_register+0x86/0x8e
 [<c0324991>] timekeeping_init_device+0x0/0x19
 [<c0324991>] timekeeping_init_device+0x0/0x19
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x0000026b
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x00000296/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x000002ad
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall timekeeping_init_device+0x0/0x19 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000005f
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c0324b41>] init_clocksource_sysfs+0x0/0x3f
 [<c01a5a55>] kset_register+0x2b/0x30
 [<c0324b4b>] init_clocksource_sysfs+0xa/0x3f
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x000002c3
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x000002ee/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000305
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x00000087
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01dac8b>] sysdev_register+0x86/0x8e
 [<c0324b41>] init_clocksource_sysfs+0x0/0x3f
 [<c0324b59>] init_clocksource_sysfs+0x18/0x3f
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x0000031b
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x00000346/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x0000035d
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall init_clocksource_sysfs+0x0/0x3f returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000063
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0117363>] lookup_header_list+0x5/0x6
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011013f>] check_preempt_wakeup+0x10d/0x115
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c03264b4>] pdflush_init+0x0/0x12
 [<c0121c6c>] kthread_create+0x7d/0xb0
 [<c0139825>] pdflush+0x0/0x1ba
 [<c0136df7>] calculate_totalreserve_pages+0x57/0x7b
 [<c0139815>] start_one_pdflush_thread+0x11/0x21
 [<c0139825>] pdflush+0x0/0x1ba
 [<c03264bd>] pdflush_init+0x9/0x12
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x0000008b
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0117363>] lookup_header_list+0x5/0x6
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011013f>] check_preempt_wakeup+0x10d/0x115
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c03264b4>] pdflush_init+0x0/0x12
 [<c0121c6c>] kthread_create+0x7d/0xb0
 [<c0139825>] pdflush+0x0/0x1ba
 [<c010f9ef>] try_to_wake_up+0x9f/0xa6
 [<c0139815>] start_one_pdflush_thread+0x11/0x21
 [<c0139825>] pdflush+0x0/0x1ba
 [<c03264bd>] pdflush_init+0x9/0x12
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall pdflush_init+0x0/0x12 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x00000067
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011013f>] check_preempt_wakeup+0x10d/0x115
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0326512>] kswapd_init+0x0/0xf
 [<c0121c6c>] kthread_create+0x7d/0xb0
 [<c013c503>] kswapd+0x0/0x35d
 [<c011013f>] check_preempt_wakeup+0x10d/0x115
 [<c013af28>] kswapd_run+0x24/0x65
 [<c013c503>] kswapd+0x0/0x35d
 [<c032651e>] kswapd_init+0xc/0xf
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall kswapd_init+0x0/0xf returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000006b
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011013f>] check_preempt_wakeup+0x10d/0x115
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0121c6c>] kthread_create+0x7d/0xb0
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f49a>] create_workqueue_thread+0x26/0x37
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f592>] __create_workqueue_key+0xca/0xea
 [<c0326f90>] aio_setup+0x0/0x5d
 [<c0326fe2>] aio_setup+0x52/0x5d
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall aio_setup+0x0/0x5d returned with preemption imbalance 
msgmni has been set to 502
initcall ipc_init+0x0/0x1c returned with preemption imbalance 
io scheduler noop registered
initcall noop_init+0x0/0xd returned with preemption imbalance 
io scheduler anticipatory registered (default)
initcall as_init+0x0/0xd returned with preemption imbalance 
io scheduler deadline registered
initcall deadline_init+0x0/0xd returned with preemption imbalance 
io scheduler cfq registered
initcall cfq_init+0x0/0x84 returned with preemption imbalance 
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:12.0: Firmware left e100 interrupts enabled; disabling
initcall pci_init+0x0/0x28 returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000007b
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d9f86>] device_initialize+0x77/0x9f
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c0328698>] fb_console_init+0x0/0xee
 [<c01da71d>] device_create+0x24/0x28
 [<c03286bf>] fb_console_init+0x27/0xee
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000373
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x00000372/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000373
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
initcall fb_console_init+0x0/0xee returned with preemption imbalance 
BUG: scheduling while atomic: swapper/1/0x0000007f
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01db8a8>] bus_add_driver+0x161/0x195
 [<c0328d46>] vesafb_init+0x0/0x1f3
 [<c01dbdb1>] driver_register+0x6d/0xc2
 [<c0328d46>] vesafb_init+0x0/0x1f3
 [<c0328ef3>] vesafb_init+0x1ad/0x1f3
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000373
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x0000039c/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x000003b3
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: swapper/1/0x000000a9
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01a91da>] snprintf+0x1c/0x1f
 [<c01dc617>] platform_device_add+0x48/0xfa
 [<c01dc69e>] platform_device_add+0xcf/0xfa
 [<c0328d46>] vesafb_init+0x0/0x1f3
 [<c0328f18>] vesafb_init+0x1d2/0x1f3
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x000003c9
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x000003f2/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000409
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
vesafb: framebuffer at 0xfd000000, mapped to 0xd0880000, using 1536k, total 4096k
vesafb: mode is 1024x768x8, linelength=1024, pages=0
vesafb: protected mode interface info at c000:7ae0
vesafb: pmi: set display start = c00c7b38, set palette = c00c7b57
vesafb: pmi: ports = 3c0 3d4 3d5 3d6 3d7 3d8 3d9 3da 3c7 3c8 3c9 
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
BUG: scheduling while atomic: swapper/1/0x000000e7
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c011ee7a>] call_usermodehelper_exec+0x4f/0x63
 [<c01a61d3>] kobject_uevent_env+0x2d9/0x30f
 [<c01da51a>] device_add+0x361/0x497
 [<c01d0030>] set_palette+0x2d/0x39
 [<c01da6d8>] device_create_vargs+0x78/0x99
 [<c01da71d>] device_create+0x24/0x28
 [<c01b5a37>] register_framebuffer+0x98/0x1bc
 [<c0113818>] printk+0x7e/0xf0
 [<c014c036>] kmem_cache_alloc+0x57/0x8d
 [<c014c55f>] __kmalloc+0x86/0xbc
 [<c01b79b4>] fb_alloc_cmap+0x91/0xa6
 [<c0328ce9>] vesafb_probe+0x563/0x5c0
 [<c01dc4ad>] platform_drv_probe+0xc/0xd
 [<c01dbb07>] driver_probe_device+0x9c/0x112
 [<c01db287>] bus_for_each_drv+0x34/0x5c
 [<c01dbc40>] device_attach+0x4e/0x5e
 [<c01dbbd2>] __device_attach+0x0/0x5
 [<c01db124>] bus_attach_device+0x1e/0x46
 [<c01da521>] device_add+0x368/0x497
 [<c01a91da>] snprintf+0x1c/0x1f
 [<c01dc617>] platform_device_add+0x48/0xfa
 [<c01dc69e>] platform_device_add+0xcf/0xfa
 [<c0328d46>] vesafb_init+0x0/0x1f3
 [<c0328f18>] vesafb_init+0x1d2/0x1f3
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x0000041f
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011ffe2>] alloc_pid+0x268/0x2c4
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c02712c0>] wait_for_common+0xbe/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c0112089>] do_fork+0x1a2/0x1cd
 [<c01018bc>] kernel_thread+0x77/0x7f
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c011f017>] ____call_usermodehelper+0x0/0xed
 [<c0102fa0>] kernel_thread_helper+0x0/0x10
 [<c011edc6>] __call_usermodehelper+0x0/0x4b
 [<c011edf6>] __call_usermodehelper+0x30/0x4b
 [<c011f2e1>] run_workqueue+0x8d/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: workqueue leaked lock or atomic: khelper/0x0000044a/5
    last function: __call_usermodehelper+0x0/0x4b
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c011f338>] run_workqueue+0xe4/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f905>] worker_thread+0x7a/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
BUG: scheduling while atomic: khelper/5/0x00000461
Modules linked in:
Pid: 5, comm: khelper Tainted: G        W 2.6.27 #4
 [<c0270ddf>] schedule+0x7d/0x307
 [<c011f366>] run_workqueue+0x112/0x130
 [<c011f88b>] worker_thread+0x0/0x85
 [<c011f8ec>] worker_thread+0x61/0x85
 [<c0121d8a>] autoremove_wake_function+0x0/0x2b
 [<c011f88b>] worker_thread+0x0/0x85
 [<c0121cd5>] kthread+0x36/0x5d
 [<c0121c9f>] kthread+0x0/0x5d
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
------------[ cut here ]------------
kernel BUG at kernel/printk.c:1052!
invalid opcode: 0000 [#1] PREEMPT 
Modules linked in:
Pid: 1, comm: swapper Tainted: G        W (2.6.27 #4)
EIP: 0060:[<c0113020>] EFLAGS: 00010206 CPU: 0
EIP is at acquire_console_sem+0x10/0x46
EAX: cf820000 EBX: 00000000 ECX: 0000003e EDX: 00000000
ESI: c0285d58 EDI: 00000000 EBP: 00000000 ESP: cf821cb0
 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Process swapper (pid: 1, ti=cf820000 task=cf81fbc0 task.ti=cf820000)<0>
I-pipe domain Linux
Stack: c01d0739 0000003e 00000000 00000000 c0285d58 00000000 00000000 c01d2c30 
       00000000 0000003e c010e439 c0346c88 cf81ee2c c010e518 cf81ee34 4b61dbed 
       00000003 56062abc 00000003 00000000 0000003e 00000000 00000000 c01bc5ee 
Call Trace:
 [<c01d0739>] register_con_driver+0x56/0x116
 [<c01d2c30>] take_over_console+0x14/0x306
 [<c010e439>] set_next_entity+0x11/0x38
 [<c010e518>] pick_next_task_fair+0x99/0xb1
 [<c01bc5ee>] fbcon_takeover+0x61/0x96
 [<c01bdeb2>] fbcon_event_notify+0x2b0/0x5d0
 [<c010ddca>] __wake_up_common+0x2d/0x52
 [<c0271448>] schedule_timeout+0x13/0x8f
 [<c011021d>] __wake_up+0x2f/0x5f
 [<c0110231>] __wake_up+0x43/0x5f
 [<c027130c>] wait_for_common+0x10a/0x129
 [<c010f9f6>] default_wake_function+0x0/0x8
 [<c01a4e9e>] idr_get_empty_slot+0x173/0x237
 [<c01a5076>] ida_get_new_above+0x114/0x18d
 [<c017f5fb>] sysfs_ilookup_test+0x0/0xd
 [<c015de05>] ifind+0x15/0x7b
 [<c017fa85>] sysfs_addrm_finish+0x15/0x1b7
 [<c017f852>] __sysfs_add_one+0x53/0x5b
 [<c0125060>] notifier_call_chain+0x2a/0x47
 [<c01251c4>] __blocking_notifier_call_chain+0x36/0x49
 [<c01251e0>] blocking_notifier_call_chain+0x9/0xc
 [<c01b5b41>] register_framebuffer+0x1a2/0x1bc
 [<c0328ce9>] vesafb_probe+0x563/0x5c0
 [<c01dc4ad>] platform_drv_probe+0xc/0xd
 [<c01dbb07>] driver_probe_device+0x9c/0x112
 [<c01db287>] bus_for_each_drv+0x34/0x5c
 [<c01dbc40>] device_attach+0x4e/0x5e
 [<c01dbbd2>] __device_attach+0x0/0x5
 [<c01db124>] bus_attach_device+0x1e/0x46
 [<c01da521>] device_add+0x368/0x497
 [<c01a91da>] snprintf+0x1c/0x1f
 [<c01dc617>] platform_device_add+0x48/0xfa
 [<c01dc69e>] platform_device_add+0xcf/0xfa
 [<c0328d46>] vesafb_init+0x0/0x1f3
 [<c0328f18>] vesafb_init+0x1d2/0x1f3
 [<c0101037>] _stext+0x37/0x110
 [<c017a6ce>] proc_register+0x117/0x170
 [<c017a819>] create_proc_entry+0x69/0x7b
 [<c031a69d>] kernel_init+0x63/0xae
 [<c031a63a>] kernel_init+0x0/0xae
 [<c0102fa7>] kernel_thread_helper+0x7/0x10
 =======================
Code: 5d c3 83 3d 80 22 30 c0 00 74 0f c7 05 60 75 34 c0 00 00 00 00 e9 0a fe ff ff c3 89 e0 25 00 e0 ff ff f7 40 14 00 ff ff 0f 74 04 <0f> 0b eb fe 83 3d 60 75 34 c0 00 74 0a b8 b4 22 30 c0 e9 93 1e 
EIP: [<c0113020>] acquire_console_sem+0x10/0x46 SS:ESP 0068:cf821cb0
Kernel panic - not syncing: Fatal exception in interrupt

--------------060808000202060500040705
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.27
# Mon Nov 10 16:35:13 2008
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
# CONFIG_X86_64 is not set
CONFIG_X86=y
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
# CONFIG_GENERIC_LOCKBREAK is not set
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_FAST_CMPXCHG_LOCAL=y
CONFIG_MMU=y
CONFIG_ZONE_DMA=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
# CONFIG_GENERIC_GPIO is not set
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
# CONFIG_GENERIC_TIME_VSYSCALL is not set
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
# CONFIG_HAVE_CPUMASK_OF_CPU_MAP is not set
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# CONFIG_ZONE_DMA32 is not set
CONFIG_ARCH_POPULATES_NODE_MAP=y
# CONFIG_AUDIT_ARCH is not set
CONFIG_ARCH_SUPPORTS_AOUT=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_CGROUPS is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_GROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_USER_SCHED=y
# CONFIG_CGROUP_SCHED is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
# CONFIG_RELAY is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
# CONFIG_EMBEDDED is not set
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_COMPAT_BRK=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
# CONFIG_MARKERS is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
# CONFIG_HAVE_ARCH_TRACEHOOK is not set
# CONFIG_HAVE_DMA_ATTRS is not set
# CONFIG_USE_GENERIC_SMP_HELPERS is not set
# CONFIG_HAVE_CLK is not set
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_INTEGRITY is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"
CONFIG_CLASSIC_RCU=y

#
# Real-time sub-system
#
# CONFIG_XENOMAI is not set
CONFIG_XENO_GENERIC_STACKPOOL=y

#
# Processor type and features
#
# CONFIG_TICK_ONESHOT is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
# CONFIG_SMP is not set
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_VSMP is not set
# CONFIG_X86_RDC321X is not set
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
# CONFIG_MEMTEST is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CPU=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_XADD=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_TSC=y
CONFIG_X86_MINIMUM_CPU_FAMILY=4
# CONFIG_HPET_TIMER is not set
CONFIG_DMI=y
# CONFIG_IOMMU_HELPER is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_RCU is not set
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
# CONFIG_IPIPE_COMPAT is not set
# CONFIG_IPIPE_DELAYED_ATOMICSW is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
# CONFIG_X86_PAE is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_SCHED_HRTICK is not set
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x100000
CONFIG_COMPAT_VDSO=y

#
# Power management options
#
# CONFIG_PM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
CONFIG_PCI_LEGACY=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
# CONFIG_IP_PIMSM_V1 is not set
# CONFIG_IP_PIMSM_V2 is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
# CONFIG_INET_LRO is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
CONFIG_WIRELESS_EXT=y
CONFIG_WIRELESS_EXT_SYSFS=y
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE="atmel_at76c505-rfmd2958.bin"
CONFIG_EXTRA_FIRMWARE_DIR="firmware"
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_PARPORT is not set
# CONFIG_PNP is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=32000
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_MISC_DEVICES=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_TIMINGS=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_PCIBUS_ORDER=y
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set

#
# Other IDE chipsets support
#

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_QD65XX is not set
# CONFIG_BLK_DEV_UMC8672 is not set
# CONFIG_BLK_DEV_IDEDMA is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_HPTIOP is not set
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_FLASHPOINT is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SRP is not set
# CONFIG_SCSI_DH is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# Enable only one of the two stacks, unless you know what you are doing
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_OHCI_DEBUG=y
CONFIG_FIREWIRE_SBP2=y
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m

#
# PCILynx controller requires I2C
#
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
# CONFIG_IEEE1394_ETH1394_ROM_ENTRY is not set
# CONFIG_IEEE1394_ETH1394 is not set
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_DV1394=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_VETH is not set
# CONFIG_ARCNET is not set
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_MDIO_BITBANG is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
# CONFIG_3C515 is not set
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
CONFIG_ULTRA=m
CONFIG_SMC9194=m
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
CONFIG_HP100=m
CONFIG_NET_ISA=y
# CONFIG_E2100 is not set
# CONFIG_EWRK3 is not set
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
# CONFIG_HPLAN_PLUS is not set
# CONFIG_HPLAN is not set
# CONFIG_LP486E is not set
# CONFIG_ETH16I is not set
CONFIG_NE2000=m
# CONFIG_ZNET is not set
# CONFIG_SEEQ8005 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
CONFIG_EEPRO100=m
CONFIG_E100=m
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_R6040 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_SC92031 is not set
CONFIG_NETDEV_1000=y
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
CONFIG_E1000E=y
# CONFIG_IP1000 is not set
# CONFIG_IGB is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_TIGON3=m
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
CONFIG_NETDEV_10000=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_NIU is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_TEHUTI is not set
# CONFIG_BNX2X is not set
# CONFIG_SFC is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
CONFIG_WLAN_PRE80211=y
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
CONFIG_WLAN_80211=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_LIBERTAS is not set
# CONFIG_AIRO is not set
CONFIG_HERMES=m
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
# CONFIG_NORTEL_HERMES is not set
# CONFIG_PCI_HERMES is not set
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m
# CONFIG_PRISM54 is not set
# CONFIG_USB_ZD1201 is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_IWLWIFI_LEDS is not set
# CONFIG_HOSTAP is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_DEVKMEM=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_I2C is not set
# CONFIG_SPI is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_HWMON_DEBUG_CHIP is not set
# CONFIG_THERMAL is not set
# CONFIG_THERMAL_HWMON is not set
# CONFIG_WATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_TMIO is not set

#
# Multimedia devices
#

#
# Multimedia core support
#
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2_COMMON=m
CONFIG_VIDEO_ALLOW_V4L1=y
CONFIG_VIDEO_V4L1_COMPAT=y
# CONFIG_DVB_CORE is not set
CONFIG_VIDEO_MEDIA=m

#
# Multimedia drivers
#
# CONFIG_MEDIA_ATTACH is not set
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L1=m
CONFIG_VIDEO_CAPTURE_DRIVERS=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
# CONFIG_VIDEO_VIVI is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_CPIA2 is not set
# CONFIG_VIDEO_STRADIS is not set
CONFIG_V4L_USB_DRIVERS=y
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
# CONFIG_USB_GSPCA is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_QUICKCAM_MESSENGER is not set
# CONFIG_USB_ET61X251 is not set
CONFIG_USB_OV511=m
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_ZC0301 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_ZR364XX is not set
# CONFIG_USB_STKWEBCAM is not set
# CONFIG_USB_S2255 is not set
# CONFIG_SOC_CAMERA is not set
# CONFIG_VIDEO_SH_MOBILE_CEU is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_SI470X is not set
# CONFIG_DAB is not set

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
CONFIG_VGASTATE=m
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB_DDC is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_DEBUG=y
# CONFIG_HIDRAW is not set

#
# USB Input Devices
#
CONFIG_USB_HID=m
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_DEVICE_CLASS=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set

#
# Enable Host or Gadget support to see Inventra options
#

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_BERRY_CHARGE is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGET is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set
# CONFIG_UIO is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
# CONFIG_ISCSI_IBFT_FIND is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4DEV_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_DNOTIFY=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
CONFIG_ROMFS_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_IPIPE_DEBUG is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_LATENCYTOP is not set
CONFIG_SYSCTL_SYSCALL_CHECK=y
CONFIG_HAVE_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
# CONFIG_FTRACE is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SYSPROF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_CONTEXT_SWITCH_TRACER is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_FIREWIRE_OHCI_REMOTE_DMA is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_4KSTACKS is not set
CONFIG_DOUBLEFAULT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_OPTIMIZE_INLINING is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_MANAGER=y
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set

#
# Digest
#
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_HW is not set
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y

--------------060808000202060500040705--

