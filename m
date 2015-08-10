From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 10 Aug 2015 10:29:07 -0400
Message-ID: <20150810142907.GE29198@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Bad pointer in __ipipe_pin_range_globally
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Seeing occational crashes in the function __ipipe_pin_range_globally,
and wondering what that might be caused by.

Kernel is 3.14.47 on AM5726 CPU (Dual cortex-A15), with the 3 level page
table LPAE support enabled.  Xenomai 2.6.4.  Ipipe patch
ipipe-core-3.14.39-arm-10.

I see a few things in the ipipe git tree that are since
ipipe-core-3.14.39-arm-10 is before some more recent 3.14.x merges
were done, so perhaps I will give the git tree updates a try to see if
that helps.

Does anyone have any idea what this might be:

[  599.214919] Internal error: Oops: a06 [#1] SMP ARM
[  599.224536] Modules linked in: qcserial usb_wwan usbserial qmi_wwan usbnet mii 8021q garp stp mrp llc rcksapi_layer2(O) iptable_nat ip_tables nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_co5
[  599.291686] CPU: 0 PID: 3188 Comm: serloop Tainted: G        W  O 3.14-2-am5726 #1 Debian 3.14.47-0.1RR2
[  599.310718] task: ea6f5900 ti: ea6b6000 task.ti: ea6b6000
[  599.321562] PC is at __ipipe_pin_range_globally+0xf0/0x14c
[  599.332570] LR is at 0xea71fc98
[  599.338870] pc : [<c002e2ac>]    lr : [<ea71fc98>]    psr: a0000013
[  599.338870] sp : ea6b7be0  ip : c0003000  fp : c0759b68
[  599.361914] r10: 00000d68  r9 : ee617000  r8 : fffff000
[  599.372398] r7 : 00000000  r6 : ae314003  r5 : 00000018  r4 : 00000000
[  599.385499] r3 : 2e617d68  r2 : 2e617000  r1 : c074051c  r0 : ea71f704
[  599.398601] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  599.412924] Control: 30c5387d  Table: ae2e36c0  DAC: fffffffd
[  599.424455] Process serloop (pid: 3188, stack limit = 0xea6b6240)
[  599.436683] Stack: (0xea6b7be0 to 0xea6b8000)
[  599.445429] 7be0: c0788540 f5a05000 80007003 00800000 ee617000 00000090 f5a05000 f5a04fff
[  599.461848] 7c00: 00000001 c0743710 c081adc0 aa6d0000 00000000 f5a05000 f5a05000 00000003
[  599.478268] 7c20: f5a05000 c0156588 aa6d0000 00000000 00000010 c0733e78 ee801f00 ee2e3640
[  599.494686] 7c40: 00000000 00000000 0000071f 00c00000 f5a05000 c0007d70 f5a05000 f5a04fff
[  599.511105] 7c60: c0003020 f5a05000 f5a04fff f5a02000 ee2e39c0 ea6b7cc4 000002d2 0000071f
[  599.527524] 7c80: 00800000 ee2e39c0 000000d2 ffffffff 0000228c c0156a94 ee2e3640 ee2e39c0
[  599.543944] 7ca0: 000000d2 ffffffff 00000003 c01571e8 ea6b7cc4 000000d2 c02cd070 c07cdc40
[  599.560363] 7cc0: c07cdc40 ee2e3640 ee2e3b80 0000071f 00c00000 0000071f 00800000 00400046
[  599.576783] 7ce0: ee980348 00101001 00000000 c0157338 000000d2 0000000a 0000071f 00c00000
[  599.593201] 7d00: ffffffff c02cd070 00009501 0000071f 00c00000 c0157380 0000071f 00c00000
[  599.609620] 7d20: ffffffff c02cd070 ee163c00 ed5a2400 ed5a2550 ed5a2400 00000000 c02cd070
[  599.626040] 7d40: c02cd060 ed5a2400 ed5a2550 ee2e3b80 00000000 c02d14fc ee2e3b80 ed5a2400
[  599.642459] 7d60: 00000006 c02d1c68 ee83c5b8 ed5a2400 ee0f0880 00000006 00000000 c02ca570
[  599.658878] 7d80: 00000000 ee980348 00400046 ee239240 00000000 ee0f0880 ee0f0880 c02cb048
[  599.675296] 7da0: 00000001 00000006 c04c7798 00000000 c04f8064 eeac3968 ee980348 ee239240
[  599.691716] 7dc0: ee239248 c0170b90 ee426000 c0170c54 ee239248 00000000 ee426000 ee239240
[  599.708134] 7de0: ee980348 00000000 00000000 ed5aaa80 c0170b90 c016afac ea6b7eac ea6b7f74
[  599.724554] 7e00: 00000000 00101001 ea6b7eb0 00000000 00000000 c016b780 ea6b7ef0 c017a578
[  599.740972] 7e20: ee974000 00000000 ee974000 c0176db4 2e884000 c0733e78 ee239240 00000022
[  599.757390] 7e40: 00000000 00000000 ee9539d0 ee426000 ee953d90 ea6b7ef0 ef45184a ee980348
[  599.773809] 7e60: ee9539d0 ee426000 ea6b6000 00000000 ea6b7ef0 ea470600 ea6b7f74 ea6b7eb0
[  599.790227] 7e80: ea6b7f74 ea6b6000 00000000 c017aed8 ea6b7eac ee2a8000 ee22b6c0 ea6b7eb8
[  599.806646] 7ea0: ee239240 ee2a8000 00000000 00000000 ee9539d0 ee525880 ee9539d0 ee69b088
[  599.823065] 7ec0: 00000000 ea6b7f74 00000001 ee2a8000 ffffff9c c0021048 ea6b6000 00000000
[  599.839484] 7ee0: 00000000 c017b43c 00000041 ee2a8000 ee9539d0 ee525880 ef45184a 00000005
[  599.855903] 7f00: ea470605 ea6b7f74 ee953d90 ee617660 ee980348 00000101 00000004 00000060
[  599.872322] 7f20: 00000000 00000000 ea470600 ea6b6000 0000000f ea471800 ea471808 00000000
[  599.888741] 7f40: 00000400 c0187694 00101001 ffffff9c ee2a8000 0000000f ffffff9c ee2a8000
[  599.905160] 7f60: 00000005 c016c2d4 ea6b6000 00000000 be8e6d48 00101001 c0020000 00000022
[  599.921579] 7f80: 00000100 00000001 ea6b6000 00000000 be8e6c88 00008999 00000005 c0021048
[  599.937998] 7fa0: 00000000 c0020e60 00000000 be8e6c88 be8e6ece 00101001 78fefdf8 be8e6ece
[  599.954418] 7fc0: 00000000 be8e6c88 00008999 00000005 00000000 00000000 b6f44000 00000000
[  599.970837] 7fe0: be8e59e0 be8e59d8 00008aa7 b6f16eac 40000010 be8e6ece 00000000 00000000
[  599.987265] [<c002e2ac>] (__ipipe_pin_range_globally) from [<c0156588>] (vmap_page_range_noflush+0x230/0x2e8)
[  600.007177] [<c0156588>] (vmap_page_range_noflush) from [<c0156a94>] (map_vm_area+0x24/0x68)
[  600.024121] [<c0156a94>] (map_vm_area) from [<c01571e8>] (__vmalloc_node_range+0xf8/0x204)
[  600.040716] [<c01571e8>] (__vmalloc_node_range) from [<c0157338>] (__vmalloc_node+0x44/0x4c)
[  600.057660] [<c0157338>] (__vmalloc_node) from [<c0157380>] (vmalloc+0x40/0x48)
[  600.072336] [<c0157380>] (vmalloc) from [<c02cd070>] (n_tty_open+0x10/0x11c)
[  600.086492] [<c02cd070>] (n_tty_open) from [<c02d14fc>] (tty_ldisc_open+0x3c/0x78)
[  600.101693] [<c02d14fc>] (tty_ldisc_open) from [<c02d1c68>] (tty_ldisc_setup+0x18/0x5c)
[  600.117764] [<c02d1c68>] (tty_ldisc_setup) from [<c02ca570>] (tty_init_dev+0x94/0x184)
[  600.133661] [<c02ca570>] (tty_init_dev) from [<c02cb048>] (tty_open+0x450/0x53c)
[  600.148512] [<c02cb048>] (tty_open) from [<c0170c54>] (chrdev_open+0xc4/0x184)
[  600.163018] [<c0170c54>] (chrdev_open) from [<c016afac>] (do_dentry_open+0x230/0x298)
[  600.178742] [<c016afac>] (do_dentry_open) from [<c016b780>] (finish_open+0x34/0x4c)
[  600.194116] [<c016b780>] (finish_open) from [<c017a578>] (do_last+0x784/0xcd4)
[  600.208616] [<c017a578>] (do_last) from [<c017aed8>] (path_openat+0x410/0x670)
[  600.223115] [<c017aed8>] (path_openat) from [<c017b43c>] (do_filp_open+0x2c/0x80)
[  600.238137] [<c017b43c>] (do_filp_open) from [<c016c2d4>] (do_sys_open+0x110/0x1d4)
[  600.253508] [<c016c2d4>] (do_sys_open) from [<c0020e60>] (ret_fast_syscall+0x0/0x3c)
[  600.269056] Code: e24664c0 e18660da e24924c0 e082300a (e18260fa)
[  600.285316] ---[ end trace 0abb10bfd60c1adf ]---

Also saw a similar one:

[    8.473733] Unable to handle kernel paging request at virtual address 00069c00
[    8.488374] pgd = ee1a1f80, hw pgd = ee1a1f80
[    8.497206] [00069c00] *pgd=00000000
[    8.504462] Internal error: Oops: a05 [#1] SMP ARM
[    8.514074] Modules linked in:
[    8.520214] CPU: 0 PID: 1556 Comm: modprobe Tainted: G        W    3.14-2-am5726 #1 Debian 3.14.47-0.1RR1
[    8.539420] task: eea34a00 ti: ee2f4000 task.ti: ee2f4000
[    8.550263] PC is at __ipipe_pin_range_globally+0xf0/0x14c
[    8.561269] LR is at 0xee24d518
[    8.567568] pc : [<c002e2ac>]    lr : [<ee24d518>]    psr: a0000013
[    8.567568] sp : ee2f5df0  ip : c0003000  fp : c0759b68
[    8.590610] r10: 00000c00  r9 : c0069000  r8 : fffff000
[    8.601093] r7 : 00000000  r6 : ae8dd003  r5 : 00000018  r4 : 00000000
[    8.614193] r3 : 00069c00  r2 : 00069000  r1 : c074051c  r0 : ee24d8c4
[    8.627293] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[    8.641614] Control: 30c5387d  Table: ae1a1f80  DAC: fffffffd
[    8.653143] Process modprobe (pid: 1556, stack limit = 0xee2f4240)
[    8.665546] Stack: (0xee2f5df0 to 0xee2f6000)
[    8.674288] 5de0:                                     c0788540 f011b000 80007003 00800000
[    8.690706] 5e00: c0069000 00000007 f011b000 f011afff 00000001 c0743710 c081adc0 bf807000
[    8.707123] 5e20: 00000000 f011b000 f011b000 00000004 f011b000 c0156588 bf807000 00000000
[    8.723540] 5e40: 00000010 c0733e78 ee801f00 ee2c61c0 00000000 00000000 0000071f 00c00000
[    8.739958] 5e60: f011b000 c0007c08 f011b000 f011afff c0003020 f011b000 f011afff f0117000
[    8.756376] 5e80: ee2c6140 ee2f5ed4 000002d2 0000071f 00800000 ee2c6140 000000d2 ffffffff
[    8.772793] 5ea0: 00003350 c0156a94 ee2c61c0 ee2c6140 000000d2 ffffffff 00000004 c01571e8
[    8.789210] 5ec0: ee2f5ed4 000000d2 c00ad8d4 00000000 00000001 ee2c61c0 80000207 0000071f
[    8.805627] 5ee0: 00c00000 0000071f 00800000 c0021048 ee2f4000 00000000 00000000 c0157338
[    8.822044] 5f00: 000000d2 c0008844 0000071f 00c00000 ffffffff c00ad8d4 00000001 0000071f
[    8.838462] 5f20: 00c00000 c0157380 0000071f 00c00000 ffffffff c00ad8d4 eea34a00 00003350
[    8.854879] 5f40: b6f98000 b6f75d50 00000080 c00ad8d4 ee2f5f5c 00000000 00000000 00003350
[    8.871295] 5f60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    8.887711] 5f80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 b7432250
[    8.904130] 5fa0: b7432278 c0020e60 00000000 b7432250 b6f98000 00003350 b6f75d50 00000002
[    8.920548] 5fc0: 00000000 b7432250 b7432278 00000080 00000000 b6f75d50 00003350 00000000
[    8.936964] 5fe0: 00060000 be860954 b6f6fb07 b6ef3264 80000010 b6f98000 97bf2bf7 d6b115fd
[    8.953392] [<c002e2ac>] (__ipipe_pin_range_globally) from [<c0156588>] (vmap_page_range_noflush+0x230/0x2e8)
[    8.973301] [<c0156588>] (vmap_page_range_noflush) from [<c0156a94>] (map_vm_area+0x24/0x68)
[    8.990243] [<c0156a94>] (map_vm_area) from [<c01571e8>] (__vmalloc_node_range+0xf8/0x204)
[    9.006836] [<c01571e8>] (__vmalloc_node_range) from [<c0157338>] (__vmalloc_node+0x44/0x4c)
[    9.023778] [<c0157338>] (__vmalloc_node) from [<c0157380>] (vmalloc+0x40/0x48)
[    9.038454] [<c0157380>] (vmalloc) from [<c00ad8d4>] (SyS_init_module+0x70/0x120)
[    9.053480] [<c00ad8d4>] (SyS_init_module) from [<c0020e60>] (ret_fast_syscall+0x0/0x3c)
[    9.069724] Code: e24664c0 e18660da e24924c0 e082300a (e18260fa)

They don't seem to happen very often.

-- 
Len Sorensen

