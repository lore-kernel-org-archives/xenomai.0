Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553292D12F3
	for <xenomai@lists.linux.dev>; Tue, 27 Jan 2026 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549991; cv=none; b=m58ZR2b5myTc2QaC+z0Hnhp0x6ErfrOvK0qIhcp8QVA5sz/kMnkqE/MqyETlkooLF0IrxahnzwmKKIO3iF6RtZipk9gNYG4Cjtn6EGiNss6Aj/ClEXNzWBcTS2rMOpY41XQD/F2TYvlvDxCUjEfyMOXQqWbW26vhhZEZM0kiIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549991; c=relaxed/simple;
	bh=DKuhFUIW1SIBm7Y/b+E/OFfhc5wlJUjN/wvmU0/yF4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTrCp0HsKNLq5d1dsTEzSo/fAG8F+B7vh+MYat6aKNQl8xMNskvjblAOWRjbHiAR+SZnXoWTAU/RM79/zv4y6XisB8p+nV3JQNQ7/2zh/vMIlUpT2uDozd4r/J+7fF+q3E/DLVJFaGVWuefzilLcWuGxczShqiA0oGomV4WMyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 09B0D2CFC87;
	Tue, 27 Jan 2026 22:39:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id eYAMMBQZh0H8; Tue, 27 Jan 2026 22:39:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3C03D2CFCAB;
	Tue, 27 Jan 2026 22:39:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gBk7hB6fyowc; Tue, 27 Jan 2026 22:39:39 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 0280D2CFC87;
	Tue, 27 Jan 2026 22:39:38 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] Fix race between RTDM task termination and xnthread_join
Date: Tue, 27 Jan 2026 22:39:27 +0100
Message-ID: <20260127213927.26960-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ensure that the task structure remains valid until the join operation is =
complete.
Previously, a race condition could cause the structure to be freed before
xnthread_join() accessed it, leading to a use-after-free scenario.

[   21.643656] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   21.643667] BUG: KASAN: slab-use-after-free in xnthread_join+0x7a9/0x8=
f0
[   21.643710] Read of size 4 at addr ffff888108929550 by task rmmod/249
[   21.643715]
[   21.643730] CPU: 1 UID: 0 PID: 249 Comm: rmmod Not tainted 6.18.2-g768=
d3d5bf800-dirty #60 PREEMPT(voluntary)
[   21.643736] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[   21.643740] IRQ stage: Linux
[   21.643743] Call Trace:
[   21.643748]  <TASK>
[   21.643751]  dump_stack_lvl+0x94/0xd0
[   21.643762]  print_report+0xcb/0x610
[   21.643769]  ? __timer_delete_sync+0x120/0x1b0
[   21.643776]  ? __virt_addr_valid+0x1dd/0x2d0
[   21.643790]  ? xnthread_join+0x7a9/0x8f0
[   21.643795]  kasan_report+0x96/0xd0
[   21.643801]  ? xnthread_join+0x7a9/0x8f0
[   21.643807]  xnthread_join+0x7a9/0x8f0
[   21.643812]  ? __pfx_xnthread_join+0x10/0x10
[   21.643817]  ? mutex_unlock+0x7d/0xd0
[   21.643826]  rtpc_cleanup+0x2b/0x60 [rtnet]
[   21.643844]  rtnet_release+0xe/0xd00 [rtnet]
[   21.643858]  __do_sys_delete_module+0x315/0x4e0
[   21.643864]  ? __pfx___do_sys_delete_module+0x10/0x10
[   21.643869]  ? fput_close_sync+0xd8/0x190
[   21.643874]  ? __pfx_fput_close_sync+0x10/0x10
[   21.643879]  ? pipeline_syscall+0x9b/0x210
[   21.643885]  do_syscall_64+0xea/0x3b0
[   21.643892]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   21.643898] RIP: 0033:0x7fca2bc38b77
[   21.643903] Code: 73 01 c3 48 8b 0d 89 92 0c 00 f7 d8 64 89 01 48 83 c=
8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 08
[   21.643908] RSP: 002b:00007ffdb96b9bd8 EFLAGS: 00000206 ORIG_RAX: 0000=
0000000000b0
[   21.643916] RAX: ffffffffffffffda RBX: 00005634eb2f1490 RCX: 00007fca2=
bc38b77
[   21.643919] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005634e=
b2f14f8
[   21.643923] RBP: 0000000000000000 R08: 1999999999999999 R09: 000000000=
0000000
[   21.643926] R10: 00007fca2bcacac0 R11: 0000000000000206 R12: 00007ffdb=
96b9e20
[   21.643929] R13: 00007ffdb96baebb R14: 00005634eb2f02a0 R15: 00007ffdb=
96b9e28
[   21.643934]  </TASK>
[   21.643936]
[   21.643938] Allocated by task 2:
[   21.643941]  kasan_save_stack+0x24/0x50
[   21.643946]  kasan_save_track+0x14/0x30
[   21.643950]  __kasan_slab_alloc+0x59/0x70
[   21.643955]  kmem_cache_alloc_node_noprof+0x12b/0x540
[   21.643960]  copy_process+0x345/0x66c0
[   21.643966]  kernel_clone+0xba/0x6e0
[   21.643970]  kernel_thread+0xc6/0x100
[   21.643974]  kthreadd+0x397/0x570
[   21.643979]  ret_from_fork+0x232/0x290
[   21.643986]  ret_from_fork_asm+0x1a/0x30
[   21.643993]
[   21.643994] Freed by task 0:
[   21.643996]  kasan_save_stack+0x24/0x50
[   21.644000]  kasan_save_track+0x14/0x30
[   21.644004]  __kasan_save_free_info+0x3a/0x60
[   21.644010]  __kasan_slab_free+0x43/0x70
[   21.644014]  kmem_cache_free+0xd6/0x470
[   21.644018]  rcu_core+0x56d/0x1a10
[   21.644023]  handle_softirqs+0x186/0x570
[   21.644027]  irq_exit_rcu+0xb3/0xe0
[   21.644031]  arch_do_IRQ_pipelined+0x10e/0x550
[   21.644038]  sync_current_irq_stage+0x353/0x410
[   21.644044]  irq_pipeline_can_idle+0x6d/0xc0
[   21.644048]  do_idle+0x337/0x4d0
[   21.644053]  cpu_startup_entry+0x4f/0x60
[   21.644057]  start_secondary+0x1c9/0x250
[   21.644062]  common_startup_64+0x13e/0x148
[   21.644067]
[   21.644069] Last potentially related work creation:
[   21.644070]  kasan_save_stack+0x24/0x50
[   21.644074]  kasan_record_aux_stack+0x89/0xa0
[   21.644078]  __call_rcu_common.constprop.0+0x70/0x8a0
[   21.644086]  rcu_core+0x56d/0x1a10
[   21.644089]  handle_softirqs+0x186/0x570
[   21.644092]  irq_exit_rcu+0xb3/0xe0
[   21.644095]  arch_do_IRQ_pipelined+0x10e/0x550
[   21.644100]  sync_current_irq_stage+0x353/0x410
[   21.644103]  irq_pipeline_can_idle+0x6d/0xc0
[   21.644107]  do_idle+0x337/0x4d0
[   21.644111]  cpu_startup_entry+0x4f/0x60
[   21.644114]  start_secondary+0x1c9/0x250
[   21.644118]  common_startup_64+0x13e/0x148
[   21.644122]
[   21.644123] Second to last potentially related work creation:
[   21.644124]  kasan_save_stack+0x24/0x50
[   21.644128]  kasan_record_aux_stack+0x89/0xa0
[   21.644132]  __call_rcu_common.constprop.0+0x70/0x8a0
[   21.644136]  finish_task_switch+0x47f/0x610
[   21.644143]  __schedule+0xf4b/0x2b50
[   21.644147]  schedule_idle+0x5c/0x90
[   21.644151]  do_idle+0x26d/0x4d0
[   21.644154]  cpu_startup_entry+0x4f/0x60
[   21.644157]  start_secondary+0x1c9/0x250
[   21.644161]  common_startup_64+0x13e/0x148
[   21.644165]
[   21.644166] The buggy address belongs to the object at ffff888108928f8=
0
[   21.644166]  which belongs to the cache task_struct of size 3840
[   21.644170] The buggy address is located 1488 bytes inside of
[   21.644170]  freed 3840-byte region [ffff888108928f80, ffff888108929e8=
0)
[   21.644174]
[   21.644176] The buggy address belongs to the physical page:
[   21.644180] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0x0 pfn:0x108928
[   21.644185] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped=
:0 pincount:0
[   21.644188] flags: 0x200000000000040(head|node=3D0|zone=3D2)
[   21.644195] page_type: f5(slab)
[   21.644201] raw: 0200000000000040 ffff8881001d8dc0 dead000000000122 00=
00000000000000
[   21.644205] raw: 0000000000000000 0000000080080008 00000000f5000000 00=
00000000000000
[   21.644209] head: 0200000000000040 ffff8881001d8dc0 dead000000000122 0=
000000000000000
[   21.644213] head: 0000000000000000 0000000080080008 00000000f5000000 0=
000000000000000
[   21.644216] head: 0200000000000003 ffffea0004224a01 00000000ffffffff 0=
0000000ffffffff
[   21.644220] head: 0000000000000000 0000000000000000 00000000ffffffff 0=
000000000000000
[   21.644222] page dumped because: kasan: bad access detected
[   21.644223]
[   21.644224] Memory state around the buggy address:
[   21.644227]  ffff888108929400: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
[   21.644230]  ffff888108929480: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
[   21.644233] >ffff888108929500: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
[   21.644235]                                                  ^
[   21.644237]  ffff888108929580: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
[   21.644240]  ffff888108929600: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
[   21.644242] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   21.644244] Disabling lock debugging due to kernel taint
[   22.758097] RTnet: unloaded

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/cobalt/thread.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index e9baf38e1..dfa5108b9 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -228,6 +228,7 @@ static inline int spawn_kthread(struct xnthread *thre=
ad)
 	if (IS_ERR(p))
 		return PTR_ERR(p);
=20
+	get_task_struct(p);
 	wait_for_completion(&done);
=20
 	return 0;
@@ -1675,8 +1676,12 @@ int xnthread_join(struct xnthread *thread, bool un=
interruptible)
 		goto out;
 	}
=20
-	if (xnthread_test_info(thread, XNDORMANT))
+	if (xnthread_test_info(thread, XNDORMANT)) {
+		if (!xnthread_test_state(thread, XNUSER | XNROOT))
+			put_task_struct(xnthread_host_task(thread));
+
 		goto out;
+	}
=20
 	trace_cobalt_thread_join(thread);
=20
@@ -1748,6 +1753,9 @@ int xnthread_join(struct xnthread *thread, bool uni=
nterruptible)
=20
 	put_pid(pid);
 done:
+	if (!xnthread_test_state(thread, XNUSER | XNROOT))
+		put_task_struct(xnthread_host_task(thread));
+
 	ret =3D 0;
 	if (switched)
 		ret =3D xnthread_harden();
--=20
2.51.0

