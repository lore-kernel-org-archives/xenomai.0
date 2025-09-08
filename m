Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321030B518
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338558; cv=none; b=mqFyRFJNX/FoBDVwx8IBWy6T7YbDSpzaOTvapP2eeiEZ9RXkYF3CcqKcnov0krpMaB9njDQXF0uNv6c8dJcEhDRDXY7UiEng4+l3KeGbAsGqLSZrjQ3B8jrbBmSqSWAQZ7QpKjwsNQAMjwB9EXez9NAr8O5C27Af9Kbz93al+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338558; c=relaxed/simple;
	bh=sCuc05zFnxlmgU7C7jTlOMK/WMr2vwVdVWVruJnagiQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=JJsncSlHoVFSzWwm64YGuq6rZGRAxDJUk4o/WJdQyoZTLbCdzgtBVGeHl33jNf7VbY7e193lnm2FMsJW/AnqT1FG0+bNYd4Km1G2AxhI7ijUuFqjVF0faCCBCOT/6yH8Cz38rm16UdDxbbRTagKDEsQWb0Y0VPYGI7670LtUrKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fKfkbLWT; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fKfkbLWT"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025090813354581a4b125010002073f
        for <xenomai@lists.linux.dev>;
        Mon, 08 Sep 2025 15:35:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=TRhKgWi+225D+OUzZ4qugpTEeY0k8B6WDCtuLiTra0k=;
 b=fKfkbLWTCKhsrIUKLKTVu8uYur/ntUATPmmbq5G5HepXjop/TqJQ6U2uRnIxn9q9xk1Wl8
 +v/gRJcMDCoWoCapnScSkAMZgxypZFQXbtXbrC7BDZVVw+iYFUCPfalkfcYE6v2fj3008Vri
 7wJyQHvS5V+igLRCVSVPATNCV7MfSfzy0I63QYE+HtqkMpHHES3yy7Yh4PA59JwwVQjLxJf8
 vqCepOwYqOYQU181MCZh8INFD17++c+NSTGc2++z1CD3Ne1rMGwLVBy+9FEIsrjdDtOzLFOW
 yPFhyME77T1oqTJvQSjLRwxW1eLn04W+TKML/ajZjpbSbNt3zs7xXbJQ==;
Message-ID: <2d7bbdc839cb0f78ddb979b35d491a8f4fb9d0c8.camel@siemens.com>
Subject: [RFC Dovetail 6.16]: Lockdep warning, IRQ while holding
 pci_config_lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Mon, 08 Sep 2025 15:35:43 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe,

from time to time I can see the following lockdep warning when testing
on qemu.

I'm not sure if my interpretation is correct. Should we convert
pci_config_lock into a hard_spin_lock_t?

Florian

[    6.455365]=20
[    6.455368] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    6.455370] WARNING: possible circular locking dependency detected
[    6.455371] 6.16.0-hyprv-xenomai-0-00115-gce017d4675a5-dirty #375 not ta=
inted
[    6.455374] ------------------------------------------------------
[    6.455374] (udev-worker)/234 is trying to acquire lock:
[    6.455376] ffff8880059020e0 (&irq_desc_lock_class){-.-.}-{0:0}, at: han=
dle_edge_irq+0x2c/0x300
[    6.455387]=20
[    6.455387] but task is already holding lock:
[    6.455388] ffffffff830e9158 (pci_config_lock){....}-{2:2}, at: pci_conf=
1_read+0x4a/0xf0
[    6.455394]=20
[    6.455394] which lock already depends on the new lock.
[    6.455394]=20
[    6.455395]=20
[    6.455395] the existing dependency chain (in reverse order) is:
[    6.455396]=20
[    6.455396] -> #2 (pci_config_lock){....}-{2:2}:
[    6.455399]        _raw_spin_lock_irqsave+0x42/0x60
[    6.455403]        pci_conf1_read+0x4a/0xf0
[    6.455405]        pci_bus_read_config_word+0x48/0x80
[    6.455409]        __pci_write_msi_msg+0x11c/0x1e0
[    6.455413]        msi_set_affinity+0x205/0x250
[    6.455416]        irq_do_set_affinity+0xcd/0x200
[    6.455419]        irq_setup_affinity+0x152/0x180
[    6.455421]        irq_startup+0x12a/0x140
[    6.455431]        __setup_irq+0x7c8/0x7f0
[    6.455433]        request_threaded_irq+0x10c/0x180
[    6.455435]        devm_request_threaded_irq+0x6d/0xd0
[    6.455438]        ata_host_activate+0x87/0x150
[    6.455441]        ahci_init_one+0xd8b/0xfd0
[    6.455444]        local_pci_probe+0x41/0x90
[    6.455447]        pci_device_probe+0xd2/0x230
[    6.455450]        really_probe+0xd6/0x380
[    6.455453]        __driver_probe_device+0x78/0x150
[    6.455456]        driver_probe_device+0x1f/0x90
[    6.455458]        __driver_attach+0xd2/0x1c0
[    6.455460]        bus_for_each_dev+0x86/0xd0
[    6.455463]        bus_add_driver+0x111/0x240
[    6.455465]        driver_register+0x55/0x100
[    6.455467]        do_one_initcall+0x75/0x3e0
[    6.455470]        kernel_init_freeable+0x3c3/0x5b0
[    6.455474]        kernel_init+0x16/0x1c0
[    6.455477]        ret_from_fork+0x28f/0x310
[    6.455480]        ret_from_fork_asm+0x1a/0x30
[    6.455482]=20
[    6.455482] -> #1 (mask_lock){....}-{2:2}:
[    6.455486]        _raw_spin_lock+0x2c/0x40
[    6.455487]        irq_setup_affinity+0x54/0x180
[    6.455490]        irq_startup+0x12a/0x140
[    6.455491]        __setup_irq+0x7c8/0x7f0
[    6.455493]        request_threaded_irq+0x10c/0x180
[    6.455496]        acpi_os_install_interrupt_handler+0xb3/0x110
[    6.455499]        acpi_ev_install_xrupt_handlers+0x1e/0x90
[    6.455502]        acpi_init+0x75/0x570
[    6.455506]        do_one_initcall+0x75/0x3e0
[    6.455508]        kernel_init_freeable+0x3c3/0x5b0
[    6.455510]        kernel_init+0x16/0x1c0
[    6.455513]        ret_from_fork+0x28f/0x310
[    6.455515]        ret_from_fork_asm+0x1a/0x30
[    6.455517]=20
[    6.455517] -> #0 (&irq_desc_lock_class){-.-.}-{0:0}:
[    6.455520]        __lock_acquire+0x1231/0x1950
[    6.455523]        lock_acquire+0xc9/0x2d0
[    6.455525]        handle_edge_irq+0x48/0x300
[    6.455528]        generic_pipeline_irq_desc+0xc2/0x220
[    6.455531]        arch_handle_irq+0x5d/0x180
[    6.455534]        arch_pipeline_entry+0x38/0xf0
[    6.455536]        asm_common_interrupt+0x22/0x40
[    6.455538]        pci_conf1_read+0x7d/0xf0
[    6.455540]        pci_user_read_config_dword+0x6e/0xf0
[    6.455543]        pci_read_config+0x10d/0x2e0
[    6.455545]        kernfs_fop_read_iter+0xb5/0x1c0
[    6.455549]        vfs_read+0x29d/0x370
[    6.455552]        ksys_read+0x6f/0xf0
[    6.455554]        do_syscall_64+0x113/0x580
[    6.455557]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    6.455560]=20
[    6.455560] other info that might help us debug this:
[    6.455560]=20
[    6.455560] Chain exists of:
[    6.455560]   &irq_desc_lock_class --> mask_lock --> pci_config_lock
[    6.455560]=20
[    6.455564]  Possible unsafe locking scenario:
[    6.455564]=20
[    6.455565]        CPU0                    CPU1
[    6.455565]        ----                    ----
[    6.455566]   lock(pci_config_lock);
[    6.455568]                                lock(mask_lock);
[    6.455569]                                lock(pci_config_lock);
[    6.455571]   lock(&irq_desc_lock_class);
[    6.455573]=20
[    6.455573]  *** DEADLOCK ***
[    6.455573]=20
[    6.455573] 4 locks held by (udev-worker)/234:
[    6.455575]  #0: ffff8880083d5688 (&of->mutex#2){+.+.}-{4:4}, at: kernfs=
_fop_read_iter+0x6c/0x1c0
[    6.455581]  #1: ffff888005853bb8 (kn->active#14){.+.+}-{0:0}, at: kernf=
s_fop_read_iter+0x74/0x1c0
[    6.455588]  #2: ffffffff8305e478 (pci_lock){....}-{2:2}, at: pci_user_r=
ead_config_dword+0x42/0xf0
[    6.455594]  #3: ffffffff830e9158 (pci_config_lock){....}-{2:2}, at: pci=
_conf1_read+0x4a/0xf0
[    6.455599]=20
[    6.455599] stack backtrace:
[    6.455602] CPU: 2 UID: 0 PID: 234 Comm: (udev-worker) Not tainted 6.16.=
0-hyprv-xenomai-0-00115-gce017d4675a5-dirty #375 PREEMPT(voluntary)=20
[    6.455605] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
6.2-debian-1.16.2-1 04/01/2014
[    6.455606] IRQ stage: Xenomai
[    6.455608] Call Trace:
[    6.455610]  <TASK>
[    6.455612]  dump_stack_lvl+0x75/0xe0
[    6.455618]  print_circular_bug+0x26e/0x350
[    6.455625]  check_noncircular+0x14c/0x170
[    6.455636]  __lock_acquire+0x1231/0x1950
[    6.455647]  lock_acquire+0xc9/0x2d0
[    6.455650]  ? handle_edge_irq+0x2c/0x300
[    6.455657]  ? srso_return_thunk+0x5/0x5f
[    6.455661]  ? register_lock_class+0x3b/0x500
[    6.455667]  handle_edge_irq+0x48/0x300
[    6.455670]  ? handle_edge_irq+0x2c/0x300
[    6.455675]  generic_pipeline_irq_desc+0xc2/0x220
[    6.455680]  arch_handle_irq+0x5d/0x180
[    6.455685]  arch_pipeline_entry+0x38/0xf0
[    6.455689]  asm_common_interrupt+0x22/0x40
[    6.455692] RIP: 0010:pci_conf1_read+0x7d/0xf0
[    6.455695] Code: c6 89 d8 81 e2 fc 00 00 00 c1 e0 08 09 d0 44 89 e2 c1 =
e2 10 44 09 e8 81 e2 00 00 00 0f 09 d0 ba f8 0c 00 00 0d 00 00 00 80 ef <41=
> 83 fe 02 74 27 41 83 fe 04 74 4c 41 83 fe 01 74 31 48 c7 c7 40
[    6.455697] RSP: 0018:ffffc90000c2bac8 EFLAGS: 00000286
[    6.455699] RAX: 0000000080001000 RBX: 0000000000000010 RCX: 00000000000=
00001
[    6.455701] RDX: 0000000000000cf8 RSI: 0000000000000000 RDI: ffffffff830=
e9140
[    6.455702] RBP: ffffc90000c2bafc R08: 0000000000000001 R09: ffff8880082=
4b2b0
[    6.455704] R10: 9168bf2834dbb3ce R11: 0000000000000000 R12: 00000000000=
00000
[    6.455705] R13: 0000000000000000 R14: 0000000000000004 R15: ffff8880054=
7bd80
[    6.455718]  ? pci_conf1_read+0x4a/0xf0
[    6.455723]  pci_user_read_config_dword+0x6e/0xf0
[    6.455729]  pci_read_config+0x10d/0x2e0
[    6.455739]  kernfs_fop_read_iter+0xb5/0x1c0
[    6.455745]  vfs_read+0x29d/0x370
[    6.455757]  ksys_read+0x6f/0xf0
[    6.455763]  do_syscall_64+0x113/0x580
[    6.455776]  ? srso_return_thunk+0x5/0x5f
[    6.455779]  ? __do_sys_newfstatat+0x4d/0x80
[    6.455794]  ? srso_return_thunk+0x5/0x5f
[    6.455799]  ? srso_return_thunk+0x5/0x5f
[    6.455801]  ? do_syscall_64+0x221/0x580
[    6.455811]  ? srso_return_thunk+0x5/0x5f
[    6.455813]  ? ksys_read+0x6f/0xf0
[    6.455816]  ? srso_return_thunk+0x5/0x5f
[    6.455820]  ? srso_return_thunk+0x5/0x5f
[    6.455823]  ? do_syscall_64+0x221/0x580
[    6.455827]  ? srso_return_thunk+0x5/0x5f
[    6.455829]  ? srso_return_thunk+0x5/0x5f
[    6.455836]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    6.455838] RIP: 0033:0x7f574e0a325d
[    6.455841] Code: Unable to access opcode bytes at 0x7f574e0a3233.
[    6.455842] RSP: 002b:00007fffc800e9f8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[    6.455845] RAX: ffffffffffffffda RBX: 000055d3f84fca00 RCX: 00007f574e0=
a325d
[    6.455846] RDX: 0000000000000010 RSI: 000055d3f84fca00 RDI: 00000000000=
00006
[    6.455847] RBP: 0000000000000006 R08: 00007f574e17dc60 R09: 00000000000=
00075
[    6.455849] R10: 0000000000001000 R11: 0000000000000246 R12: 00000000000=
00010
[    6.455850] R13: 000000000000000f R14: 000000000000000f R15: 00000000000=
00002
[    6.455862]  </TASK>
