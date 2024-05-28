Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C89535C8
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879894; cv=none; b=bR4Ls6zddsQ37ZgLyZuT/Wt1biYzkvL6afEtD6yRG3zJazAOsz//2LdrKFs1A0ZISdMorq8bkmZEC339cPbLHMVerQMOP8EaA+W/PZd8N8RB8yyXLKmgVX/DgM2HWIX0nhh2BP6iI5dbvwC0DGs7gHhz2ZjizjsrGdep5QNiOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879894; c=relaxed/simple;
	bh=DljfzB3XYprTFJMDf8zg6IGbs3kOebpCSe8YaC/aQVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LICE123/Y0d+/QqGnTLVBoVGoY7P9cjsP+92u2JGG9/rswqg3mUPyqlH7GfQX+Mpk0U8PSW//QZftwYmiWE9XOfl6IgG4scMpC4YQiZgB87/VzgOK2dI7vC6DLZcxb30NFIagxs9wgxpNocAlbTHg/57qyY0rjsU6CnmhiOS3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Wbd9FaYh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Wbd9FaYh"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421140314d5so3092455e9.0
        for <xenomai@lists.linux.dev>; Tue, 28 May 2024 00:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1716879890; x=1717484690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkgkYhW9njoNFEfd8Y//ZAOdre4G0cNdJY8oqWvkVu8=;
        b=Wbd9FaYhAzBxiBfPiTBuNQeSJ8XsbSiZEV1ofRC6/8cg3y9uqDCXRR2+T2lwr6IE/D
         QzNF0LAEmjGDy+VutfCoYSSPs7e876cWjYXDvpYjIXSuiYPTEwmMv677s5psRZfaxrVf
         UD710SqWWHKjonVD7x/pSh72d7qZTb0zi63i5/E5z+Ai+2AhFgFqHO/1+5MyJaTIP/X4
         h8+ns4zlxmpO7cS0RiGxs2/CqBDEu6GopwEEF3EW2CxTU+4/ngd3DyokembWZTabgTk4
         ys7OoChY7m3/KYZ6MvEwtGqBWys0ca4MwCfppBLLQ7KPHu6q2e0ipIK1K0NedPW5qXNT
         bmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716879890; x=1717484690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkgkYhW9njoNFEfd8Y//ZAOdre4G0cNdJY8oqWvkVu8=;
        b=OSezcUd+flhHWr7/Fdmz9EDVHTf/4dXtV3IOA2oaHNbvACJSZ3WkXWW3h6Yi7eRBbM
         H5wNA98AtXulVtaq0AefElSMsIZ7cGrz18DoHLusyHKtXFYiDl/IMnp7m0SW17VcVP7N
         VOybjyUDhugOfUnFh92prPJ0kY6BuTUhYEADxbnWlbbK8LrCtuV51dO4/F81PhBwWUaR
         r7Z/X8wrj9pjbhQBmiP/c1GeSfVOguvhDPXpk24rkSxyZRdjGIC3yGHmthe3CjSBfk4A
         20hOMgcgSIrJy0w4JV1PczlsWFhcyZrBfN+gQK1I/nHpokPAlACfZe0Dl23kzzsznFp2
         kSgQ==
X-Gm-Message-State: AOJu0Yz+EVOGgmUBEaO6K45trrNqQqxmR92esJyqO3i3fUK5e9SAjcJz
	ubMlDhRaKKzY/IrCLXeApFmt131R5NHhv1GZptoJdUzgYNwssCWgoBwUybtMuOUkk0mxz8MIetv
	k
X-Google-Smtp-Source: AGHT+IF0zsiBmylkMKj0PLTu4gaDVhPgcEn2lxV7Wj/63MC6Yk4/TyXWXhNbufeqqB6wkW+gP5CyIA==
X-Received: by 2002:a05:600c:474d:b0:421:1e4d:75c5 with SMTP id 5b1f17b1804b1-4211e4d7810mr7242975e9.8.1716879890148;
        Tue, 28 May 2024 00:04:50 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100eecbd4sm164340355e9.8.2024.05.28.00.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 00:04:49 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH 3/4] lib/alchemy: Improve period adjusting support
Date: Tue, 28 May 2024 09:01:39 +0200
Message-ID: <20240528070432.6669-4-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
References: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using TM_NOW for idate on a periodic taks, make sure the
update affects the next period and the current period still
expires when it is supposed to.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 lib/alchemy/task.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index ed5f2f804..42fca5a31 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -799,7 +799,8 @@ undo:
  *
  * @param idate The initial (absolute) date of the first release
  * point, expressed in clock ticks (see note).  If @a idate is equal
- * to TM_NOW, the current system date is used.
+ * to TM_NOW, the end of the current period is used, or the current
+ * system date if the task was not periodic before.
  *
  * @param period The period of the task, expressed in clock ticks (see
  * note). Passing TM_INFINITE stops the task's periodic timer if
@@ -839,13 +840,22 @@ CURRENT_IMPL(int, rt_task_set_periodic,
 int rt_task_set_periodic(RT_TASK *task, RTIME idate, RTIME period)
 #endif
 {
-	struct timespec its, pts, now;
+	struct timespec its, old_its, pts, old_pts, now;
 	struct alchemy_task *tcb;
 	struct service svc;
 	int ret;
 
 	CANCEL_DEFER(svc);
 
+	tcb = get_alchemy_task_or_self(task, &ret);
+	if (tcb == NULL)
+		goto out;
+
+	if (!threadobj_local_p(&tcb->thobj)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (period == TM_INFINITE) {
 		pts.tv_sec = 0;
 		pts.tv_nsec = 0;
@@ -854,7 +864,13 @@ int rt_task_set_periodic(RT_TASK *task, RTIME idate, RTIME period)
 		clockobj_ticks_to_timespec(&alchemy_clock, period, &pts);
 		if (idate == TM_NOW) {
 			__RT(clock_gettime(CLOCK_COPPERPLATE, &now));
-			timespec_add(&its, &now, &pts);
+
+			if (threadobj_get_periodic(&tcb->thobj, &old_its,
+						   &old_pts) == 0) {
+				timespec_add(&its, &now, &old_its);
+			} else {
+				timespec_add(&its, &now, &pts);
+			}
 		} else
 			/*
 			 * idate is an absolute time specification
@@ -864,15 +880,6 @@ int rt_task_set_periodic(RT_TASK *task, RTIME idate, RTIME period)
 			clockobj_ticks_to_timespec(&alchemy_clock, idate, &its);
 	}
 
-	tcb = get_alchemy_task_or_self(task, &ret);
-	if (tcb == NULL)
-		goto out;
-
-	if (!threadobj_local_p(&tcb->thobj)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	ret = threadobj_set_periodic(&tcb->thobj, &its, &pts);
 	put_alchemy_task(tcb);
 out:
-- 
2.45.0

