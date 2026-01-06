Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243DB19E992
	for <xenomai@lists.linux.dev>; Tue,  6 Jan 2026 04:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767673389; cv=none; b=JWak5Ym+uvcStgHtu59diH9ItcOSJqC9Lf2INh1e25AMHgxyXZrVxz5IfpDjoCo41PVmaae95rYD/beFmtGjLvCPiMhUouzGx1AeaOrBGwAwVsGFdUgRlutaBQjO0ZVhos0hot6YZhxU3x98ir0FGCbAg6gKYO6k++AXil1ENo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767673389; c=relaxed/simple;
	bh=hsUeP2TvMz5gQ2BLSwWjnbMt0cegW0dRtjrgn7oTrIY=;
	h=Content-Type:Message-Id:To:Cc:Subject:Date:From:Mime-Version; b=b5PQT1jnmJS5Mm4WcgkrUb87MoVN/sMZRC0kwMc9rdU0DRbdgy4Upoch09FuATeTK/JJZZZUwMeMKxxxKSC0zaIWaN3Feu7FijsXHDdvZQ+1874ORR68GNrK/ktcHStYSsJPNCZqUvRn9we2mgiNytIYdcjfAskQFmkc4Wu6WYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.g.0G87E_1767669702 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 06 Jan 2026 11:21:43 +0800
Content-Type: text/plain; charset=UTF-8
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.4e05857e.625a.49c0.b295.72fa87a282f1@feishu.cn>
To: "xenomai" <xenomai@lists.linux.dev>
Cc: =?utf-8?q?=E9=83=AD=E5=8F=8C=E6=8B=B4?= <guoshuangshuan@sinsegye.com.cn>, 
	=?utf-8?q?=E5=AE=8B=E5=81=A5=E7=8E=AE?= <songjianwei@sinsegye.com.cn>
Subject: System crash: Interaction between KVM (Intel) and Dovetail when sharing CPU cores
X-Lms-Return-Path: <lba+1695c7fc4+a34cc6+lists.linux.dev+liuyang@sinsegye.com.cn>
Date: Tue, 06 Jan 2026 11:21:40 +0800
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi developers,
I am encountering a system hang issue when running Xenomai 3.3.1 with Kerne=
l 6.12.55 on an Intel platform.=C2=A0 (alse test with linux 5.15.51 + cobal=
t 3.2.3)
Issue Summary:=C2=A0The system works fine if I use isolcpus to separate KVM=
 VCPUs and Xenomai applications. However, if they share the same CPU (witho=
ut isolation),=C2=A0
the entire host hangs at the moment the VM starts loading the OS (right aft=
er OVMF finishes).
Hardware/Software:
=E2=80=A2 CPU: Intel (VMX enabled)
=E2=80=A2 Kernel: 6.12.55 + Dovetail
=E2=80=A2 QEMU/KVM: CPU Host-Passthrough
This issue only occurs on Intel. I performed the same tests on an AMD platf=
orm (SVM), and it works perfectly without any hangs.
By setting kvm-intel.preemption_timer=3D0, I can occasionally avoid the imm=
ediate hang and capture some error logs (see attached).
###########################################################################=
#######################
[=C2=A0 181.519260] Oops: double fault: 0000 [#1] PREEMPT SMP NOPTI IRQ_PIP=
ELINE
[=C2=A0 181.519265] CPU: 0 UID: 0 PID: 4405 Comm: Schedule Not tainted 6.12=
.55-rkernel-s1.7 #metaOS
[=C2=A0 181.519268] Hardware name: Sinsegye SP7022-7231/SP7022-7231, BIOS S=
P70220720250618B 02/10/2025
[=C2=A0 181.519269] IRQ stage: Xenomai
[=C2=A0 181.519270] RIP: 0000:0x0
[=C2=A0 181.519279] ------------[ cut here ]------------
[=C2=A0 181.519280] kernel BUG at arch/x86/kernel/traps.c:1055!
[=C2=A0 181.521244] Oops: invalid opcode: 0000 [#2] PREEMPT SMP NOPTI IRQ_P=
IPELINE
[=C2=A0 181.521249] CPU: 0 UID: 0 PID: 4405 Comm: Schedule Not tainted 6.12=
.55-rkernel-s1.7 #metaOS
[=C2=A0 181.521252] Hardware name: Sinsegye SP7022-7231/SP7022-7231, BIOS S=
P70220720250618B 02/10/2025
[=C2=A0 181.521253] IRQ stage: Linux
[=C2=A0 181.521254] RIP: 0010:fixup_bad_iret+0xb3/0xc0
[=C2=A0 181.521260] Code: f6 43 e0 03 74 24 48 8b 4d e0 65 48 33 0c 25 28 0=
0 00 00 4c 89 e8 75 14 48 81 c4 b0 00 00 00 5b 41 5c 41 5d 5d c3 cc cc cc c=
c <0f> 0b e8 b6 34 00 00 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
[=C2=A0 181.521262] RSP: 0008:fffffe1e46ae5ba8 EFLAGS: 00010046
[=C2=A0 181.521266] RAX: fffffe1e46addf58 RBX: fffffe1e46ade000 RCX: 000000=
0000000000
[=C2=A0 181.521267] RDX: 00000000000000a8 RSI: fffffe1e46ae5c50 RDI: fffffe=
1e46ade000
[=C2=A0 181.521268] RBP: fffffe1e46ae5c70 R08: 0000000000000000 R09: 000000=
0000000000
[=C2=A0 181.521270] R10: 0000000000000000 R11: 0000000000000000 R12: fffffe=
1e46ae5c88
[=C2=A0 181.521271] R13: fffffe1e46addf58 R14: 0000000000000000 R15: 000000=
0000000000
[=C2=A0 181.521272] FS:=C2=A0 00007f13a1c59640(0000) GS:ffff8baf2ec00000(00=
00) knlGS:ffff8baf2ec00000
[=C2=A0 181.521273] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[=C2=A0 181.521274] CR2: ffffffffffffffd6 CR3: 000000011decc004 CR4: 000000=
0000f72ef0
[=C2=A0 181.521275] PKRU: 55555554
[=C2=A0 181.521276] Call Trace:
[=C2=A0 181.521278]=C2=A0 <#DF>
[=C2=A0 181.521282]=C2=A0 ? copy_from_kernel_nofault+0x74/0x110
[=C2=A0 181.521288]=C2=A0 error_entry+0x138/0x140
[=C2=A0 181.521291] RIP: 0010:native_irq_return_iret+0x0/0x2
[=C2=A0 181.521294] Code: df 58 5f e9 6e ff ff ff 41 5f 41 5e 41 5d 41 5c 5=
d 5b 41 5b 41 5a 41 59 41 58 58 59 5a 5e 5f 48 83 c4 08 f6 44 24 20 04 75 0=
2 <48> cf 57 0f 01 f8 eb 12 0f 20 df 48 0f ba ef 3f 48 81 e7 ff e7 ff
[=C2=A0 181.521295] RSP: 0008:fffffe1e46ae5d38 EFLAGS: 00010046 ORIG_RAX: 0=
000000000000008
[=C2=A0 181.521296] RAX: 0000000000000000 RBX: ffffffffffffffd6 RCX: ffffff=
fffffffff2
[=C2=A0 181.521297] RDX: fffffe1e46ae5dc8 RSI: 0000000000000000 RDI: fffffe=
1e46ae5d88
[=C2=A0 181.521298] RBP: fffffe1e46ae5d78 R08: fffffe1e46ae5dc8 R09: ffff8b=
abd1b44d40
[=C2=A0 181.521298] R10: 0000000000000001 R11: fffffe1e46ae5b00 R12: fffffe=
1e46ae5d88
[=C2=A0 181.521299] R13: 0000000000000040 R14: fffffe1e46ae5f58 R15: 000000=
0000000000
[=C2=A0 181.521300]=C2=A0 ? asm_exc_general_protection+0xd/0x30
[=C2=A0 181.521303]=C2=A0 ? copy_from_kernel_nofault+0x74/0x110
[=C2=A0 181.521306]=C2=A0 show_opcodes+0xd4/0xe0
[=C2=A0 181.521309]=C2=A0 ? _printk+0x5c/0x80
[=C2=A0 181.521312]=C2=A0 ? vprintk_deferred+0x21/0x30
[=C2=A0 181.521314]=C2=A0 show_ip+0x3b/0x50
[=C2=A0 181.521316]=C2=A0 show_iret_regs+0x1b/0x50
[=C2=A0 181.521319]=C2=A0 __show_regs+0x2b/0x340
[=C2=A0 181.521321]=C2=A0 ? dump_stack_print_info+0xfc/0x150
[=C2=A0 181.521323]=C2=A0 show_regs+0x3c/0x70
[=C2=A0 181.521325]=C2=A0 __die_body+0x23/0x70
[=C2=A0 181.521328]=C2=A0 die+0x41/0x70
[=C2=A0 181.521330]=C2=A0 exc_double_fault+0xc7/0x180
[=C2=A0 181.521333]=C2=A0 asm_exc_double_fault+0x23/0x30
[=C2=A0 181.521335] RIP: 0000:0x0
[=C2=A0 181.521337] Code: Unable to access opcode bytes at 0xffffffffffffff=
d6.
[=C2=A0 181.521338] RSP: 0008:00007f13a1c58bd0 EFLAGS: 00010202
[=C2=A0 181.521340] RAX: 0000000010000019 RBX: 0000000000000001 RCX: 00007f=
13cf09a2dc
[=C2=A0 181.521341] RDX: 00007f13901de790 RSI: 0000000000000001 RDI: 000000=
0000000001
[=C2=A0 181.521342] RBP: 0000000000000001 R08: 000d2714bb43ad11 R09: 00007f=
13cf0b8080
[=C2=A0 181.521343] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f=
13901de790
[=C2=A0 181.521344] R13: 0000000000000000 R14: 0000000000000000 R15: 00007f=
13cc1845c8
[=C2=A0 181.521346]=C2=A0 </#DF>
[=C2=A0 181.521346] Modules linked in: vhost_net vhost vhost_iotlb tap can_=
raw can xt_CHECKSUM ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chai=
n_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink=
 bridge stp llc binfmt_misc nls_iso8859_1 intel_rapl_msr intel_rapl_common =
intel_uncore_frequency intel_uncore_frequency_common x86_pkg_temp_thermal c=
oretemp mei_hdcp kvm_intel kvm iTCO_wdt rapl intel_cstate rt_igb intel_pmc_=
bxt mei_me serio_raw wmi_bmof iTCO_vendor_support ee1004 rtnet mei acpi_tad=
 mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc ipmi_devintf ip=
mi_msghandler scsi_dh_alua msr drm efi_pstore ip_tables x_tables autofs4 bt=
rfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq =
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 linear crct10dif_pclm=
ul crc32_pclmul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 i2=
c_i801 e1000e igb i2c_mux i2c_smbus dca i2c_algo_bit video wmi pinctrl_alde=
rlake aesni_intel crypto_simd cryptd
[=C2=A0 181.521457] ---[ end trace 0000000000000000 ]---
[=C2=A0 181.584206] RIP: 0000:0x0
[=C2=A0 181.584210] Code: Unable to access opcode bytes at 0xffffffffffffff=
d6.
[=C2=A0 181.584211] RSP: 0008:00007f13a1c58bd0 EFLAGS: 00010202
[=C2=A0 181.584213] RAX: 0000000010000019 RBX: 0000000000000001 RCX: 00007f=
13cf09a2dc
[=C2=A0 181.584214] RDX: 00007f13901de790 RSI: 0000000000000001 RDI: 000000=
0000000001
[=C2=A0 181.584215] RBP: 0000000000000001 R08: 000d2714bb43ad11 R09: 00007f=
13cf0b8080
[=C2=A0 181.584216] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f=
13901de790
[=C2=A0 181.584217] R13: 0000000000000000 R14: 0000000000000000 R15: 00007f=
13cc1845c8
[=C2=A0 181.584218] FS:=C2=A0 00007f13a1c59640(0000) GS:ffff8baf2ec00000(00=
00) knlGS:ffff8baf2ec00000
[=C2=A0 181.584220] CS:=C2=A0 0000 DS: 0000 ES: 0000 CR0: 0000000080050033
[=C2=A0 181.584221] CR2: ffffffffffffffd6 CR3: 000000011decc004 CR4: 000000=
0000f72ef0
[=C2=A0 181.584222] PKRU: 55555554
[=C2=A0 181.584223] note: Schedule[4405] exited with irqs disabled
[=C2=A0 181.584497] ------------[ cut here ]------------
[=C2=A0 181.584500] WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:128=
 ct_kernel_exit.constprop.10+0xd2/0xe0
[=C2=A0 181.584506] Modules linked in: vhost_net vhost vhost_iotlb tap can_=
raw can xt_CHECKSUM ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chai=
n_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink=
 bridge stp llc binfmt_misc nls_iso8859_1 intel_rapl_msr intel_rapl_common =
intel_uncore_frequency intel_uncore_frequency_common x86_pkg_temp_thermal c=
oretemp mei_hdcp kvm_intel kvm iTCO_wdt rapl intel_cstate rt_igb intel_pmc_=
bxt mei_me serio_raw wmi_bmof iTCO_vendor_support ee1004 rtnet mei acpi_tad=
 mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc ipmi_devintf ip=
mi_msghandler scsi_dh_alua msr drm efi_pstore ip_tables x_tables autofs4 bt=
rfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq =
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 linear crct10dif_pclm=
ul crc32_pclmul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 i2=
c_i801 e1000e igb i2c_mux i2c_smbus dca i2c_algo_bit video wmi pinctrl_alde=
rlake aesni_intel crypto_simd cryptd
[=C2=A0 181.584567] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G =C2=A0 =
=C2=A0=C2=A0 D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-rkernel-s1.=
7 #metaOS
[=C2=A0 181.584572] Tainted: [D]=3DDIE
[=C2=A0 181.584574] Hardware name: Sinsegye SP7022-7231/SP7022-7231, BIOS S=
P70220720250618B 02/10/2025
[=C2=A0 181.584576] IRQ stage: Linux
[=C2=A0 181.584578] RIP: 0010:ct_kernel_exit.constprop.10+0xd2/0xe0
[=C2=A0 181.584582] Code: b7 24 ff 48 c7 43 10 00 00 00 00 44 89 e7 e8 65 f=
c ff ff e8 50 05 00 00 41 89 85 ac 08 00 00 5b 41 5c 41 5d 5d c3 cc cc cc c=
c <0f> 0b e9 6d ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
[=C2=A0 181.584587] RSP: 0018:ffffffff98803e28 EFLAGS: 00010202
[=C2=A0 181.584590] RAX: 4000000000000000 RBX: ffff8baf2ec61760 RCX: 000000=
0000000000
[=C2=A0 181.584592] RDX: 239ca7eb0002000f RSI: ffffffff985d6b39 RDI: ffffff=
ff985a419b
[=C2=A0 181.584595] RBP: ffffffff98803e40 R08: 00000000000a9b20 R09: 000000=
0000000000
[=C2=A0 181.584597] R10: 000000647744b41d R11: 0000000000000000 R12: 000000=
0000000005
[=C2=A0 181.584599] R13: ffffffff98b3b260 R14: ffffffff98810940 R15: ffff8b=
af3f7cff4e
[=C2=A0 181.584602] FS:=C2=A0 0000000000000000(0000) GS:ffff8baf2ec00000(00=
00) knlGS:0000000000000000
[=C2=A0 181.584605] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[=C2=A0 181.584607] CR2: ffffffffffffffd6 CR3: 000000011decc004 CR4: 000000=
0000f72ef0
[=C2=A0 181.584610] PKRU: 55555554
[=C2=A0 181.584611] Call Trace:
[=C2=A0 181.584613]=C2=A0 <TASK>
[=C2=A0 181.584615]=C2=A0 ct_idle_enter+0x12/0x20
[=C2=A0 181.584619]=C2=A0 cpu_idle_poll+0x10/0x100
[=C2=A0 181.584623]=C2=A0 do_idle+0x50/0x140
[=C2=A0 181.584627]=C2=A0 cpu_startup_entry+0x2d/0x30
[=C2=A0 181.584630]=C2=A0 rest_init+0xe5/0xf0
[=C2=A0 181.584634]=C2=A0 start_kernel+0x75f/0xab0
[=C2=A0 181.584638]=C2=A0 ? load_ucode_intel_bsp+0x2f/0x90
[=C2=A0 181.584642]=C2=A0 x86_64_start_reservations+0x1c/0x30
[=C2=A0 181.584645]=C2=A0 x86_64_start_kernel+0x96/0xa0
[=C2=A0 181.584649]=C2=A0 common_startup_64+0x13e/0x141
[=C2=A0 181.584653]=C2=A0 </TASK>
[=C2=A0 181.584655] ---[ end trace 0000000000000000 ]---


Has anyone encountered similar issues on Intel with recent Dovetail kernels=
? Any suggestions on where to look in the VMX/Dovetail entry code would be =
greatly appreciated.
Thanks,=C2=A0
liuyang
