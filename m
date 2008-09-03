Date: Tue, 2 Sep 2008 23:24:53 -0700 (PDT)
From: Yasser Kashfi <yasser_kashfi@domain.hid>
In-Reply-To: <971398.39540.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <491471.74668.qm@domain.hid>
Subject: Re: [Xenomai-core] RT_HEAP Problem
Reply-To: yasser_kashfi@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--- On Mon, 9/1/08, Yasser Kashfi <yasser_kashfi@domain.hid> wrote:

> From: Yasser Kashfi <yasser_kashfi@domain.hid>
> Subject: [Xenomai-core] RT_HEAP Problem
> To: xenomai@xenomai.org
> Date: Monday, September 1, 2008, 10:15 PM
> Hi
> I have a problem with rt_heap; I write a simple program:
> ############################
> #include <sys/mman.h>
> #include <native/heap.h>
> 
> RT_HEAP M_HEAP;
> int main(void) {
> 	int ret;
> 	int * tmp;
> 	
> 	/* no memory-swapping for this programm */
> 	mlockall(MCL_CURRENT | MCL_FUTURE);
> 	
> 	ret = rt_heap_create(&M_HEAP, "M_HEAP", 5 *
> 1024 * 1024 , 0);
> 	if (ret) {
> 		fprintf(stderr, "fail to create heap, code
> %d\n", ret);
> 		return ret;
> 	}
> 
> 	sleep(10);
> 
> 	ret = rt_heap_delete(&M_HEAP);
> 	if (ret) {
> 		fprintf(stderr, "fail to delete heap, code
> %d\n", ret);
> 		return;
> 	}
> 	
> 	return 0;
> 
> }
> #######################
> this program previously worked on another PC. but now when
> I execute it on the new PC, It cause the kernel panic (
> Unable to handle null pointer reference ...). same kernel is
> run on two PC, and not seems any difference.  but now I
> print memory status (/proc/meminfo). a huge difference is
> found! 
> in first pc ( that program worked ) total vmalloc = totol
> memory = 510 M and highmem = 0, but on second pc ( that
> kernel panic ) total vmalloc = 119M but total memory = 1 G
> and highmem = 122.
> have everyone any idea? 
> 
> I glade to see your comments.
> 
> 

Hi everyone
Thank Gilles for your reply. It's usefull for everyone to see kernel log befor system crash. you can see a port of /var/log/boot.msg and /var/log/message below:
/var/log/boot.msg:
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
<4> BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000003f7f0000 (usable)
<4> BIOS-e820: 000000003f7f0000 - 000000003f7f3000 (ACPI NVS)
<4> BIOS-e820: 000000003f7f3000 - 000000003f800000 (ACPI data)
<4> BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
<5>119MB HIGHMEM available.
<5>896MB LOWMEM available.

<6>Memory: 1023132k/1040320k available (1953k kernel code, 16360k reserved, 1676k data, 264k init, 122816k highmem)
<6>virtual kernel memory layout:
<4>    fixmap  : 0xff8b2000 - 0xfffff000   (7476 kB)
<4>    pkmap   : 0xff400000 - 0xff600000   (2048 kB)
<4>    vmalloc : 0xf8800000 - 0xff3fe000   ( 107 MB)
<4>    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
<4>      .init : 0xc0493000 - 0xc04d5000   ( 264 kB)
<4>      .data : 0xc02e845a - 0xc048b784   (1676 kB)
<4>      .text : 0xc0100000 - 0xc02e845a   (1953 kB)

/var/log/message:
Sep  2 19:13:42 IPE-120 kernel: general protection fault: beb4 [#1] PREEMPT 
Sep  2 19:13:42 IPE-120 kernel: Modules linked in: iptable_filter ip_tables ip6table_filter ip6_tables x_tables ipv6 ext2 loop dm_mod iTCO_wdt e100 mii i2c_i801 rtc_cmos intel_agp iTCO_vendor_support shpchp sr_mod rtc_core button pci_hotplug agpgart cdrom rtc_lib i2c_core sg sd_mod ehci_hcd uhci_hcd usbcore edd ext3 mbcache jbd fan ata_piix libata scsi_mod dock
Sep  2 19:13:42 IPE-120 kernel: 
Sep  2 19:13:42 IPE-120 kernel: Pid: 13, comm: pdflush Not tainted (2.6.25-7 #1)
Sep  2 19:13:42 IPE-120 kernel: EIP: 0060:[<c17f0759>] EFLAGS: 00010287 CPU: 0
Sep  2 19:13:42 IPE-120 kernel: EIP is at 0xc17f0759
Sep  2 19:13:42 IPE-120 kernel: EAX: c0112221 EBX: c17f0754 ECX: 00000000 EDX: 00000003
Sep  2 19:13:42 IPE-120 kernel: ESI: c17f0754 EDI: 00000001 EBP: f765be88 ESP: f765be6c
Sep  2 19:13:42 IPE-120 kernel:  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Sep  2 19:13:42 IPE-120 kernel: Process pdflush (pid: 13, ti=f765a000 task=f74fc020 task.ti=f765a000)<0>
Sep  2 19:13:42 IPE-120 kernel: I-pipe domain Linux
Sep  2 19:13:42 IPE-120 kernel: Stack: f765beb4 00000003 c17f0360 c17f0750 00000200 00000001 00000003 f765bea8 
Sep  2 19:13:42 IPE-120 kernel:        c01146cb 00000000 f765beb4 c17f0360 c17f0360 f71358e8 00000008 f765bec0 
Sep  2 19:13:42 IPE-120 kernel:        c0129e5e f765beb4 f71358e8 00000008 c03bf938 f765bed4 c0129ec0 00000000 
Sep  2 19:13:42 IPE-120 kernel: Call Trace:
Sep  2 19:13:42 IPE-120 kernel:  [<c01146cb>] ? __wake_up+0x40/0x78
Sep  2 19:13:42 IPE-120 kernel:  [<c0129e5e>] ? __wake_up_bit+0x28/0x2e
Sep  2 19:13:42 IPE-120 kernel:  [<c0129ec0>] ? wake_up_bit+0x5c/0x61
Sep  2 19:13:42 IPE-120 kernel:  [<c01a1b3a>] ? __writeback_single_inode+0x32c/0x337
Sep  2 19:13:42 IPE-120 kernel:  [<c011236f>] ? __dequeue_entity+0x73/0x7b
Sep  2 19:13:42 IPE-120 kernel:  [<c01e79ac>] ? _atomic_dec_and_lock+0x28/0x44
Sep  2 19:13:42 IPE-120 kernel:  [<c01a1f18>] ? sync_sb_inodes+0x20c/0x317
Sep  2 19:13:42 IPE-120 kernel:  [<c01a221d>] ? writeback_inodes+0x85/0xfe
Sep  2 19:13:42 IPE-120 kernel:  [<c016f564>] ? wb_kupdate+0x6d/0xd0
Sep  2 19:13:42 IPE-120 kernel:  [<c016fc91>] ? pdflush+0x0/0x1bb
Sep  2 19:13:42 IPE-120 kernel:  [<c016fd99>] ? pdflush+0x108/0x1bb
Sep  2 19:13:42 IPE-120 kernel:  [<c016f4f7>] ? wb_kupdate+0x0/0xd0
Sep  2 19:13:42 IPE-120 kernel:  [<c0129b0f>] ? kthread+0x39/0x5e
Sep  2 19:13:42 IPE-120 kernel:  [<c0129ad6>] ? kthread+0x0/0x5e
Sep  2 19:13:42 IPE-120 kernel:  [<c0103e77>] ? kernel_thread_helper+0x7/0x10
Sep  2 19:13:42 IPE-120 kernel:  =======================
Sep  2 19:13:42 IPE-120 kernel: Code: 7f c1 30 07 7f c1 30 07 7f c1 38 07 7f c1 38 07 7f c1 40 07 7f c1 40 07 7f c1 48 07 7f c1 48 07 7f c1 50 07 7f c1 50 07 7f c1 58 <07> 7f c1 58 07 7f c1 60 07 7f c1 60 07 7f c1 68 07 7f c1 68 07 
Sep  2 19:13:42 IPE-120 kernel: EIP: [<c17f0759>] 0xc17f0759 SS:ESP 0068:f765be6c
Sep  2 19:13:42 IPE-120 kernel: ---[ end trace f7a37c98e4d03c27 ]---
Sep  2 19:13:42 IPE-120 kernel: note: pdflush[13] exited with preempt_count 2
Sep  2 19:14:19 IPE-120 kernel: general protection fault: 2220 [#2] PREEMPT 
Sep  2 19:14:19 IPE-120 kernel: Modules linked in: iptable_filter ip_tables ip6table_filter ip6_tables x_tables ipv6 ext2 loop dm_mod iTCO_wdt e100 mii i2c_i801 rtc_cmos intel_agp iTCO_vendor_support shpchp sr_mod rtc_core button pci_hotplug agpgart cdrom rtc_lib i2c_core sg sd_mod ehci_hcd uhci_hcd usbcore edd ext3 mbcache jbd fan ata_piix libata scsi_mod dock
Sep  2 19:14:19 IPE-120 kernel: 
Sep  2 19:14:19 IPE-120 kernel: Pid: 2412, comm: postmaster Tainted: G      D  (2.6.25-7 #1)
Sep  2 19:14:19 IPE-120 kernel: EIP: 0060:[<c17f07bd>] EFLAGS: 00010287 CPU: 0
Sep  2 19:14:19 IPE-120 kernel: EIP is at 0xc17f07bd
Sep  2 19:14:19 IPE-120 kernel: EAX: b8c17f07 EBX: c17f07b4 ECX: 00000000 EDX: 00000003
Sep  2 19:14:19 IPE-120 kernel: ESI: c17f07b4 EDI: 00000001 EBP: f765bbd8 ESP: f765bbb8
Sep  2 19:14:19 IPE-120 kernel:  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Sep  2 19:14:19 IPE-120 kernel: Process postmaster (pid: 2412, ti=f765a000 task=f6d4e020 task.ti=f765a000)<0>
Sep  2 19:14:19 IPE-120 kernel: I-pipe domain Linux
Sep  2 19:14:19 IPE-120 kernel: Stack: c0112221 f765bc04 00000003 c17f03c0 c17f07b0 00000200 00000001 00000003 
Sep  2 19:14:19 IPE-120 kernel:        f765bbf8 c01146cb 00000000 f765bc04 c17f03c0 c17f03c0 00000000 f7a7c384 
Sep  2 19:14:19 IPE-120 kernel:        f765bc10 c0129e5e f765bc04 c16fe460 00000000 c16fe460 f765bc1c c01699b2 
Sep  2 19:14:19 IPE-120 kernel: Call Trace:
Sep  2 19:14:19 IPE-120 kernel:  [<c0112221>] ? __wake_up_common+0x2e/0x54
Sep  2 19:14:19 IPE-120 kernel:  [<c01146cb>] ? __wake_up+0x40/0x78
Sep  2 19:14:19 IPE-120 kernel:  [<c0129e5e>] ? __wake_up_bit+0x28/0x2e
Sep  2 19:14:19 IPE-120 kernel:  [<c01699b2>] ? unlock_page+0x4a/0x4d
Sep  2 19:14:19 IPE-120 kernel:  [<c0175639>] ? __do_fault+0x2df/0x317
Sep  2 19:14:19 IPE-120 kernel:  [<c01765df>] ? handle_mm_fault+0x299/0x5f5
Sep  2 19:14:19 IPE-120 kernel:  [<c02e1028>] ? do_page_fault+0x2b7/0x656
Sep  2 19:14:19 IPE-120 kernel:  [<c027acef>] ? sock_queue_rcv_skb+0x10f/0x118
Sep  2 19:14:19 IPE-120 kernel:  [<c016cf83>] ? __rmqueue+0x16/0x1aa
Sep  2 19:14:19 IPE-120 kernel:  [<c0169b10>] ? find_lock_page+0x9f/0xb9
Sep  2 19:14:19 IPE-120 kernel:  [<c0182ddb>] ? shmem_getpage+0x58/0x766
Sep  2 19:14:19 IPE-120 kernel:  [<c0170599>] ? activate_page+0x9c/0xb2
Sep  2 19:14:19 IPE-120 kernel:  [<c01705ca>] ? mark_page_accessed+0x1b/0x2c
Sep  2 19:14:19 IPE-120 kernel:  [<c010eb5e>] ? __ipipe_handle_exception+0x105/0x14e
Sep  2 19:14:19 IPE-120 kernel:  [<c02df93b>] ? error_code+0x6f/0x7c
Sep  2 19:14:19 IPE-120 kernel:  [<c0169477>] ? file_read_actor+0x3f/0xbf
Sep  2 19:14:19 IPE-120 kernel:  [<c016b787>] ? generic_file_aio_read+0x2d7/0x527
Sep  2 19:14:19 IPE-120 kernel:  [<c0190c6c>] ? path_walk+0x8d/0x96
Sep  2 19:14:19 IPE-120 kernel:  [<c0187c36>] ? do_sync_read+0xaa/0xe8
Sep  2 19:14:19 IPE-120 kernel:  [<c01862b0>] ? generic_file_open+0x0/0x56
Sep  2 19:14:19 IPE-120 kernel:  [<c0129ec5>] ? autoremove_wake_function+0x0/0x33
Sep  2 19:14:19 IPE-120 kernel:  [<c0145f2e>] ? __ipipe_restore_root+0x26/0x28
Sep  2 19:14:19 IPE-120 kernel:  [<c01d7fbb>] ? security_file_permission+0xf/0x11
Sep  2 19:14:19 IPE-120 kernel:  [<c0187b8c>] ? do_sync_read+0x0/0xe8
Sep  2 19:14:19 IPE-120 kernel:  [<c01885af>] ? vfs_read+0x87/0x129
Sep  2 19:14:19 IPE-120 kernel:  [<c01886ea>] ? sys_read+0x3b/0x60
Sep  2 19:14:19 IPE-120 kernel:  [<c0103935>] ? sysenter_past_esp+0x6e/0x72
Sep  2 19:14:19 IPE-120 kernel:  =======================
Sep  2 19:14:19 IPE-120 kernel: Code: 7f c1 90 07 7f c1 98 07 7f c1 98 07 7f c1 a0 07 7f c1 a0 07 7f c1 a8 07 7f c1 a8 07 7f c1 b0 07 7f c1 b0 07 7f c1 b8 07 7f c1 b8 <07> 7f c1 c0 07 7f c1 c0 07 7f c1 c8 07 7f c1 c8 07 7f c1 d0 07 
Sep  2 19:14:19 IPE-120 kernel: EIP: [<c17f07bd>] 0xc17f07bd SS:ESP 0068:f765bbb8
Sep  2 19:14:19 IPE-120 kernel: ---[ end trace f7a37c98e4d03c27 ]---
Sep  2 19:14:19 IPE-120 kernel: note: postmaster[2412] exited with preempt_count 1
Sep  2 19:14:20 IPE-120 kernel: general protection fault: 2220 [#3] PREEMPT 
Sep  2 19:14:20 IPE-120 kernel: Modules linked in: iptable_filter ip_tables ip6table_filter ip6_tables x_tables ipv6 ext2 loop dm_mod iTCO_wdt e100 mii i2c_i801 rtc_cmos intel_agp iTCO_vendor_support shpchp sr_mod rtc_core button pci_hotplug agpgart cdrom rtc_lib i2c_core sg sd_mod ehci_hcd uhci_hcd usbcore edd ext3 mbcache jbd fan ata_piix libata scsi_mod dock
Sep  2 19:14:20 IPE-120 kernel: 
Sep  2 19:14:20 IPE-120 kernel: Pid: 2127, comm: postmaster Tainted: G      D  (2.6.25-7 #1)
Sep  2 19:14:20 IPE-120 kernel: EIP: 0060:[<c17f07bd>] EFLAGS: 00010287 CPU: 0
Sep  2 19:14:20 IPE-120 kernel: EIP is at 0xc17f07bd
Sep  2 19:14:20 IPE-120 kernel: EAX: b8c17f07 EBX: c17f07b4 ECX: 00000000 EDX: 00000003
Sep  2 19:14:20 IPE-120 kernel: ESI: c17f07b4 EDI: 00000001 EBP: f78f3d68 ESP: f78f3d48
Sep  2 19:14:20 IPE-120 kernel:  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Sep  2 19:14:20 IPE-120 kernel: Process postmaster (pid: 2127, ti=f78f2000 task=f6934020 task.ti=f78f2000)<0>
Sep  2 19:14:20 IPE-120 kernel: I-pipe domain Linux
Sep  2 19:14:20 IPE-120 kernel: Stack: c0112221 f78f3d94 00000003 c17f03c0 c17f07b0 00000200 00000001 00000003 
Sep  2 19:14:20 IPE-120 kernel:        f78f3d88 c01146cb 00000000 f78f3d94 c17f03c0 c17f03c0 00000009 00000151 
Sep  2 19:14:20 IPE-120 kernel:        f78f3da0 c0129e5e f78f3d94 c16fe460 00000000 c16fe460 f78f3dac c01699b2 
Sep  2 19:14:20 IPE-120 kernel: Call Trace:
Sep  2 19:14:20 IPE-120 kernel:  [<c0112221>] ? __wake_up_common+0x2e/0x54
Sep  2 19:14:20 IPE-120 kernel:  [<c01146cb>] ? __wake_up+0x40/0x78
Sep  2 19:14:20 IPE-120 kernel:  [<c0129e5e>] ? __wake_up_bit+0x28/0x2e
Sep  2 19:14:20 IPE-120 kernel:  [<c01699b2>] ? unlock_page+0x4a/0x4d
Sep  2 19:14:20 IPE-120 kernel:  [<c017134c>] ? truncate_inode_pages_range+0xbb/0x27b
Sep  2 19:14:20 IPE-120 kernel:  [<c0182282>] ? shmem_delete_inode+0x0/0xc8
Sep  2 19:14:20 IPE-120 kernel:  [<c0171518>] ? truncate_inode_pages+0xc/0x10
Sep  2 19:14:20 IPE-120 kernel:  [<c01822b5>] ? shmem_delete_inode+0x33/0xc8
Sep  2 19:14:20 IPE-120 kernel:  [<c0182282>] ? shmem_delete_inode+0x0/0xc8
Sep  2 19:14:20 IPE-120 kernel:  [<c0199f4a>] ? generic_delete_inode+0xa8/0x12d
Sep  2 19:14:20 IPE-120 kernel:  [<c0199361>] ? iput+0x63/0x66
Sep  2 19:14:20 IPE-120 kernel:  [<c019708d>] ? dentry_iput+0xa3/0xe4
Sep  2 19:14:20 IPE-120 kernel:  [<c0197148>] ? d_kill+0x2d/0x47
Sep  2 19:14:20 IPE-120 kernel:  [<c0197811>] ? dput+0x129/0x131
Sep  2 19:14:20 IPE-120 kernel:  [<c0188e17>] ? __fput+0x138/0x158
Sep  2 19:14:20 IPE-120 kernel:  [<c0188e4d>] ? fput+0x16/0x18
Sep  2 19:14:20 IPE-120 kernel:  [<c01d125c>] ? shm_destroy+0x8b/0xab
Sep  2 19:14:20 IPE-120 kernel:  [<c01d1386>] ? do_shm_rmid+0x55/0x57
Sep  2 19:14:20 IPE-120 kernel:  [<c01d1dc2>] ? sys_shmctl+0x574/0x856
Sep  2 19:14:20 IPE-120 kernel:  [<c018538c>] ? kfree+0xa3/0xa9
Sep  2 19:14:20 IPE-120 kernel:  [<c01e79ac>] ? _atomic_dec_and_lock+0x28/0x44
Sep  2 19:14:20 IPE-120 kernel:  [<c019c6de>] ? mntput_no_expire+0x16/0x92
Sep  2 19:14:20 IPE-120 kernel:  [<c0145f2e>] ? __ipipe_restore_root+0x26/0x28
Sep  2 19:14:20 IPE-120 kernel:  [<c0184d96>] ? kmem_cache_free+0x5d/0x63
Sep  2 19:14:20 IPE-120 kernel:  [<c0178840>] ? remove_vma+0x34/0x3a
Sep  2 19:14:20 IPE-120 kernel:  [<c01795de>] ? do_munmap+0x1cc/0x1e6
Sep  2 19:14:20 IPE-120 kernel:  [<c01d11c7>] ? sys_shmdt+0xec/0xf6
Sep  2 19:14:20 IPE-120 kernel:  [<c0105c27>] ? sys_ipc+0x130/0x149
Sep  2 19:14:20 IPE-120 kernel:  [<c010eb76>] ? __ipipe_handle_exception+0x11d/0x14e
Sep  2 19:14:20 IPE-120 kernel:  [<c0103935>] ? sysenter_past_esp+0x6e/0x72
Sep  2 19:14:20 IPE-120 kernel:  =======================
Sep  2 19:14:20 IPE-120 kernel: Code: 7f c1 90 07 7f c1 98 07 7f c1 98 07 7f c1 a0 07 7f c1 a0 07 7f c1 a8 07 7f c1 a8 07 7f c1 b0 07 7f c1 b0 07 7f c1 b8 07 7f c1 b8 <07> 7f c1 c0 07 7f c1 c0 07 7f c1 c8 07 7f c1 c8 07 7f c1 d0 07 
Sep  2 19:14:20 IPE-120 kernel: EIP: [<c17f07bd>] 0xc17f07bd SS:ESP 0068:f78f3d48
Sep  2 19:14:20 IPE-120 kernel: ---[ end trace f7a37c98e4d03c27 ]---
Sep  2 19:14:20 IPE-120 kernel: note: postmaster[2127] exited with preempt_count 1

Best regards.


      


