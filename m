Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309427FBBF
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626720; cv=none; b=SyFfTql0WnrA9PhuJyNFG/Ov+sLMRM2AH4X5pbK7Ang7UgP1VOE+hXztEJBmCc8SK4YoSHMh9GFjRYKNrQjEdiAYJs7uRtZco070kAB9kU6ijdTLZ80qAww6LfKzHgIZ3j5UB3IdkTAEdaGzrQQCsjCbu5ViGqmMIzCfL/TlimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626720; c=relaxed/simple;
	bh=LrmDlDfJkyMKDs86Xsa9kMyxdu76Yt9Nna751y3Czk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hz+vGxuvrJtnHYmIQIUmW1ccv3+rwsp5OE/NSTOmktHce1bTvK0fRlb3veBrSsmXIHUejapd6QiUHpGtzc2qzOIjvMn3qT9Lfz5kwmGG2n60+zJ+k302qPi+Hetmb/hqyUtQK4mKJ0ihgY7YGr+ajBdZ7biJ6wXkAgQ427G9CbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 046B364103E5
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 09:18:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id r525CanC-j3Q; Tue,  5 Mar 2024 09:18:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8C91364103FE;
	Tue,  5 Mar 2024 09:18:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mrORSI4Oq7tw; Tue,  5 Mar 2024 09:18:28 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 56B4564103E5;
	Tue,  5 Mar 2024 09:18:28 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH] cobalt: Print symbolic code location upon mode switch
Date: Tue,  5 Mar 2024 09:18:15 +0100
Message-Id: <20240305081815.10560-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These days the raw program counter is close to useless, do it like
the rest of the kernel and print fn+offset [module name].

Example log output after this change:
[Xenomai] switching testx to secondary mode after exception #0 in kernel-=
space at test_ioctl_rt+0x14/0x20 [maptest] (pid 879)

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/cobalt/dovetail/kevents.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/ke=
vents.c
index 817aa954dc01..f78abbdc792f 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -65,9 +65,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct =
pt_regs *regs)
 	if (!user_mode(regs)) {
 		printk(XENO_WARNING
 		       "switching %s to secondary mode after exception #%u in "
-		       "kernel-space at 0x%lx (pid %d)\n", thread->name,
+		       "kernel-space at %pS (pid %d)\n", thread->name,
 		       trapnr,
-		       xnarch_fault_pc(regs),
+		       (void *)xnarch_fault_pc(regs),
 		       xnthread_host_pid(thread));
 	} else if (xnarch_fault_notify(trapnr)) /* Don't report debug traps */
 		printk(XENO_WARNING
--=20
2.26.2

