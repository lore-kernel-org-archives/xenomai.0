Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8549342AA9
	for <xenomai@lists.linux.dev>; Sun, 12 Apr 2026 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775979713; cv=none; b=mXcDe2Pv54kojRUUy0hFXRRKBdMj6gG99Vk1XimtxCFxwOy5uZ7PdllbhYZxMpIClTqhs8qS6WkXC0V8tG7v0GeWWu9HC1GdDg0Pf/kd3+Gvq4D7NAXnL9+IXc3/VneHTjl9ORvbfzuq1NL3Zx09aYSty9Rt8b/2HOhZzg+N8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775979713; c=relaxed/simple;
	bh=QXarwHgGKGkCMLmHbsAtMbvugRVusABs1qZVlaJ95gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFM9pqGqM3hrvG6NT3GIjoNEmXHd4BMKJ6d8I1PDYVrl2AxBAHD5/Uu8zrrhtJPGe3ycuhZnZ1cm8TnkX6gyl7HE5abFzhJq9Z5k4P1dLtz/W8NGe40IfltS7jFqHylVsFJcC+6uT84MIwqOz5krSiHRYHczznLvQuUKd2qm/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 69761298599;
	Sun, 12 Apr 2026 09:34:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rkPo6Q3hMhFr; Sun, 12 Apr 2026 09:34:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8C92629859E;
	Sun, 12 Apr 2026 09:34:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZNgTYBsKpaiB; Sun, 12 Apr 2026 09:34:38 +0200 (CEST)
Received: from nailgun.corp.sigma-star.at (089144206134.atnat0015.highway.bob.at [89.144.206.134])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id EC74B298599;
	Sun, 12 Apr 2026 09:34:37 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] xnsynch_requeue_sleeper: Return early when !XNSYNCH_PRIO
Date: Sun, 12 Apr 2026 09:34:25 +0200
Message-ID: <20260412073425.956320-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the synch object is not of type XNSYNCH_PRIO, this function needs to r=
eturn
before it manipulates the pend queue.
Otherwise we face subtle follow up issues due to linked list corruptions.
With CONFIG_XENO_OPT_DEBUG_COBALT enabled, the issue can get caught earli=
er.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
Here you can find a modified version of xddp-echo to reproduce the issue.=
:

https://gitlab.com/Xenomai/legacy/xenomai-hacker-space/-/tree/rw/xnsynch_=
pi

$ /usr/xenomai/demo/xddp-echo
[   15.888383] ------------[ cut here ]------------
[   15.889018] kernel BUG at kernel/xenomai/synch.c:966!
[   15.889021] [Xenomai] switching xddp-echo to secondary mode after exce=
ption #6 in kernel-space at xnsynch_requeue_sleeper+0x18f/0x1a0 (pid 290)
[   15.892919] Oops: invalid opcode: 0000 [#1] SMP PTI IRQ_PIPELINE
[   15.892927] CPU: 3 UID: 0 PID: 290 Comm: xddp-echo Not tainted 6.19.0-=
g2fa4f147d5ae-dirty #115 PREEMPT(voluntary)
[   15.892930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[   15.892931] IRQ stage: Linux
[   15.892934] RIP: 0010:xnsynch_requeue_sleeper+0x18f/0x1a0
[   15.892940] Code: 49 28 e9 20 ff ff ff 49 8b 81 88 00 00 00 4c 89 50 0=
8 48 89 79 10 4c 89 cf 48 89 41 08 4d 89 91 88 00 00 00 e9 02 fd ff ff 90=
 <0f> 0b 0f 1f 40 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[   15.892943] RSP: 0018:ffff976f00b17d78 EFLAGS: 00010046
[   15.892956] RAX: ffff8f233bce6bc0 RBX: ffff976f006cf830 RCX: ffffffffb=
b83c290
[   15.892958] RDX: ffff8f233bce6bc0 RSI: ffff976f006cee08 RDI: ffff976f0=
06cee08
[   15.892959] RBP: 000000000000000e R08: 00000003c88a9ddc R09: ffffffffb=
a421a40
[   15.892961] R10: ffff976f006cda08 R11: 0000000000000000 R12: ffff976f0=
06cf808
[   15.892963] R13: ffff976f00ba4e20 R14: 000000000000000c R15: ffff976f0=
06cee08
[   15.892968] FS:  00007f5f4f41e6c0(0000) GS:ffff8f2380525000(0000) knlG=
S:0000000000000000
[   15.892970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.892971] CR2: 00007f5f4ff28000 CR3: 0000000108832000 CR4: 000000000=
00006f0
[   15.892973] Call Trace:
[   15.893671]  <TASK>
[   15.893674]  xnsynch_acquire+0x4b0/0x8e0
[   15.893680]  __cobalt_mutex_acquire_unchecked+0x6f/0x80
[   15.893686]  __cobalt_mutex_timedlock_break+0x392/0x3c0
[   15.893690]  ? __pfx_CoBaLt_mutex_lock+0x10/0x10
[   15.893694]  CoBaLt_mutex_lock+0xd/0x20
[   15.893698]  handle_head_syscall+0x147/0x4a0
[   15.893703]  pipeline_syscall+0x89/0xf0
[   15.893707]  do_syscall_64+0x96/0x3f0
[   15.894348]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   15.894352] RIP: 0033:0x7f5f4ff02a8b
[   15.894355] Code: 45 e8 8b 40 04 8d 50 01 48 8b 45 e8 89 50 04 b8 00 0=
0 00 00 eb 6a 90 48 8b 45 e8 48 89 45 d8 48 8b 7d d8 b8 1d 00 00 10 0f 05=
 <48> 89 45 d0 48 8b 45 d0 89 45 f4 83 7d f4 00 75 0b 48 8b 45 e8 c7
[   15.894358] RSP: 002b:00007f5f4f41dd40 EFLAGS: 00000206 ORIG_RAX: 0000=
00001000001d
[   15.894361] RAX: ffffffffffffffda RBX: 00007ffc37f4aa20 RCX: 00007f5f4=
ff02a8b
[   15.894362] RDX: 00007f5f4fceee20 RSI: 000000000000000e RDI: 000055d87=
35f0260
[   15.894364] RBP: 00007f5f4f41dd80 R08: 00007f5f4f41de08 R09: 00007f5f4=
f41e6c0
[   15.894365] R10: 0000000000000000 R11: 0000000000000206 R12: 000000000=
0000020
[   15.894367] R13: 0000000000000000 R14: 00007ffc37f4a4b0 R15: 00007f5f4=
f40e000
[   15.894369]  </TASK>
[   15.894370] Modules linked in:
[   15.894374] ---[ end trace 0000000000000000 ]---
[   15.894376] RIP: 0010:xnsynch_requeue_sleeper+0x18f/0x1a0
[   15.894382] Code: 49 28 e9 20 ff ff ff 49 8b 81 88 00 00 00 4c 89 50 0=
8 48 89 79 10 4c 89 cf 48 89 41 08 4d 89 91 88 00 00 00 e9 02 fd ff ff 90=
 <0f> 0b 0f 1f 40 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[   15.894384] RSP: 0018:ffff976f00b17d78 EFLAGS: 00010046
[   15.894386] RAX: ffff8f233bce6bc0 RBX: ffff976f006cf830 RCX: ffffffffb=
b83c290
[   15.894387] RDX: ffff8f233bce6bc0 RSI: ffff976f006cee08 RDI: ffff976f0=
06cee08
[   15.894389] RBP: 000000000000000e R08: 00000003c88a9ddc R09: ffffffffb=
a421a40
[   15.894390] R10: ffff976f006cda08 R11: 0000000000000000 R12: ffff976f0=
06cf808
[   15.894391] R13: ffff976f00ba4e20 R14: 000000000000000c R15: ffff976f0=
06cee08
[   15.894395] FS:  00007f5f4f41e6c0(0000) GS:ffff8f2380525000(0000) knlG=
S:0000000000000000
[   15.894397] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.894398] CR2: 00007f5f4ff28000 CR3: 0000000108832000 CR4: 000000000=
00006f0
[   15.894400] note: xddp-echo[290] exited with irqs disabled

---
 kernel/cobalt/synch.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
index 70c05c1f4..0a0b8e80f 100644
--- a/kernel/cobalt/synch.c
+++ b/kernel/cobalt/synch.c
@@ -963,7 +963,9 @@ void xnsynch_requeue_sleeper(struct xnthread *thread)
 	struct xnsynch *synch =3D thread->wchan;
 	struct xnthread *owner;
=20
-	XENO_BUG_ON(COBALT, !(synch->status & XNSYNCH_PRIO));
+	/* Only PI-enabled objects are of interest here. */
+	if ((synch->status & XNSYNCH_PI) =3D=3D 0)
+		return;
=20
 	/*
 	 * Update the position in the pend queue of a thread waiting
@@ -974,10 +976,6 @@ void xnsynch_requeue_sleeper(struct xnthread *thread=
)
 	list_add_priff(thread, &synch->pendq, wprio, plink);
 	owner =3D synch->owner;
=20
-	/* Only PI-enabled objects are of interest here. */
-	if ((synch->status & XNSYNCH_PI) =3D=3D 0)
-		return;
-
 	synch->wprio =3D thread->wprio;
 	if (synch->status & XNSYNCH_CLAIMED)
 		list_del(&synch->next);
--=20
2.51.0

