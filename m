Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B31D6A8
	for <xenomai@lists.linux.dev>; Sat,  8 Jun 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717876428; cv=none; b=KNgBky+qogtVRm6rXam21i6gmCqIRWQaINFj5NINCRVk2a1E92uFiTvB1s7CUc/fy/U96maxjc8Czqhf9eHgnRXqPn6SvtOZbVdDbTDm6LXJ8Am72G436EXf9R0sJfIevl6pJyvPlWAH0ks73QiPmzsxdepLuG40jrz8h2GsIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717876428; c=relaxed/simple;
	bh=DljfzB3XYprTFJMDf8zg6IGbs3kOebpCSe8YaC/aQVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItCQf3MCrQNB5bIZlXiUpaOGc+Xxv52WPOjv7Kk/svNwW47pUuDH2jfFH+Y3PJj+QFW11Xho/dt2sstrN/NNBec3hPzTNJbNoz79f37ar/BjQhVm56uKsITXk0bShpaYSn0RbVCPYyxKR17BD5OVrOdqivs0D2e/0FE0YccHNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=JArzigYc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="JArzigYc"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dceef4227so2853160f8f.0
        for <xenomai@lists.linux.dev>; Sat, 08 Jun 2024 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1717876424; x=1718481224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkgkYhW9njoNFEfd8Y//ZAOdre4G0cNdJY8oqWvkVu8=;
        b=JArzigYcGlI6K2qODn25exFDlzIxGvEPSDGTPWvhdr/WrKqkIpIk77nSCFZBLkUrLs
         OQ7qD3VTuzdBNyCPUVXADqNbFnxcLyXkT6aEhSTZwTeKxEr1eqatuxZJdIDjkErr/0uH
         XU2cCy/qtaP5iiC6QOB3Kfd7hQC5wojQmnrjojF/WzFcGlY/fh1zIBQ1uTewHk4yIkeZ
         DUfE0kJFF5I1hW5g3CE7pUpHhYdoW8W6rQxGEAYSJgp2nzoj2GPzxP0UNrx2UQs+wrAU
         OQsJWU99e/uXlL2wgINOh8lZoYp27hFjj+ogODdv34Tv8XfK3IOpUbpwhp7t7qmvKmQP
         Bluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717876424; x=1718481224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkgkYhW9njoNFEfd8Y//ZAOdre4G0cNdJY8oqWvkVu8=;
        b=L0Rdv5kiZHp21UkgaIzLlL+hIXcwuujvIjkbx+6BeGrNxyM58T4xgwwwxeJBbTMxvG
         mS8Zhg0KprmAFmevOKHeUb0okMlqewS2D2s71vGCiLFkbW4/HLuN2j5lW/PZ4glhbVv5
         7Dk3j0Ei1aF5OTAZBOyB8hb8+LPr28dK9j0fuilSH2zpBm54QGDuWr/fzVP2f59auBFv
         hmE/5uyc4jb/sFgkMHnvOpOHhaZjn5Zpz4srghEW23FLXwTCq5Ge+oYP4S+1H9WT2URP
         Ixnitm8+QcV6k4oVZGGGo4BesTYHzISEvVqPm2s9vT0plO/Eckr3QlmyjDVYeT9Z0llZ
         54/w==
X-Gm-Message-State: AOJu0Yyug7wq2Nl2ezAsL39kfSTMAzRvQhqJ6aSLO2xzvPS13LmtdyBM
	vcTGhn0gQSiSx23h/qXcDOtWu9r2ftzGYNfSfvp99V+bSR5I6xhkF2jh1KLKIKEsS2u5AhTymQJ
	K
X-Google-Smtp-Source: AGHT+IG4P3PNt8FOYTId+KNaCfONlscXlgvFrx5D4UfTAcVMZyW8v5yaGYc3leBdjUxlNsrf6W7V/Q==
X-Received: by 2002:a05:6000:1842:b0:35f:195f:bbe5 with SMTP id ffacd0b85a97d-35f195fbd17mr1635429f8f.64.1717876424400;
        Sat, 08 Jun 2024 12:53:44 -0700 (PDT)
Received: from localtoast.asozial.it-syndikat.org (212-186-38-205.cable.dynamic.surfer.at. [212.186.38.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c423932sm1149608f8f.114.2024.06.08.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 12:53:44 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v2 3/4] lib/alchemy: Improve period adjusting support
Date: Sat,  8 Jun 2024 21:52:51 +0200
Message-ID: <20240608195337.11137-4-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240608195337.11137-1-david.oberhollenzer@sigma-star.at>
References: <20240608195337.11137-1-david.oberhollenzer@sigma-star.at>
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

