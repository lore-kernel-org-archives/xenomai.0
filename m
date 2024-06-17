Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98799192B7A
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615946; cv=none; b=MfqxRjmXO+5Y6jhr8v8TF5Q3Ak04I0s+ceozjicfRyvhe1ahgjsE0ofvc0ASemiHDT3JJIXRrBhYZi7keyaHw0+KaDnCqXd5VskvUKCJ3/Z/9WGIS+WBCkRFB7/dIq7NRphZ5TuVAS6Qs9fsI1Ngd+Bdq5gTwycUrJigP4UCS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615946; c=relaxed/simple;
	bh=D30xRV0WpHK+FSq0YXeEk6i1jYuBv1Hyw+hgLTKz3Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJt3r0YlVly45Hu8VvduLwPZsERILMVRKE11NTJBT8Whom6+ny0tZWrdCUL71VKrEuRMVHHZhSHH2bcz6YSAE6qtEHgUFEt19wohKOuvPG2MILUvNkoM/+4L/3+RZKEwcoV4/fOMk8bgQQR9siyBQ21eaJlSwNoDFg1QLhaeI7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=TFW0ghvM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="TFW0ghvM"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec1620a956so36816961fa.1
        for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 02:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1718615941; x=1719220741; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TEjhj1wnavYAjcFm2qOZIgc0N9IeYaC67m4xBL2GVY=;
        b=TFW0ghvMuepEc8+kUH3sJimEqu1yVzC8YOKrGIFRakTIoRkQT4GDu84dLk1NOTpims
         t3Vw+KwKgJVjW4Wa04A/H5Oo2MtKq7zb10o2qxCCOWSjkVh/oBcAbDQt9zjgJNv9pfTe
         gANglFJm/y34H3Vll5rI0agez4zictDV2wmzV60gN7HCvDCMXrVY2j+JwLqiwK/GBNqR
         e50e4e2B4XRzNadOtCvWHHoF65fhjFaIF19R9hXvea5ZvQMva5V9g/mMcztMFJKWTtId
         EtKKRfRdLugD7mPBGCgbfO60RDMV2lAiQL2dHQu7Hqphi2vrRfmOT2bEy72zRl7AGK/R
         12Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615941; x=1719220741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TEjhj1wnavYAjcFm2qOZIgc0N9IeYaC67m4xBL2GVY=;
        b=CkfdTLQvMBByHL6VaYfKEbUCmwqXNaUNRpAdm4JI4b1FMkFx1qw3ubHKlACe+fwvnq
         +k9UugE1Lmtm6Cylvz2n96LLfUKho9IZ4EFUS4n2/CG6i0h1oTLqRy3rCXuV/C2HyS2l
         K3jzfF7o5QXtUV30ve8GlzHNkP7WJYVYCuRtXBF852F0WwuhbWbXVYpWiIr8TWIZlve9
         GRMzzfX7w5ScoH8v+OON5ilTHR1Oo0/cuh5+j/8a+OUNudZ2csa3g1+aoaj4hmmdLsMO
         PrIiHwON+zen0GrE64SlddhQnuhR1DjZB65gOllTqduvoKj1C2nfo4uw8vO75R8erHQi
         Pf8A==
X-Gm-Message-State: AOJu0YxE1FFculDrquWOKQXy0MQdWlPJxJxscq5jmVuD+wyOCLul4wRY
	KW+PYxukXtYKfFcaM7rGdB1wnGgOvJt9x6B8ixDrFGFNn5oC2iH/sFCPfvo8CRJV7omRi+KuF4F
	P
X-Google-Smtp-Source: AGHT+IGZ9YmKV5QcOTZGBtTkU8Ip6JRzr19RxbDnSlvzBL430wkKBuyk+dEH3qkOILs4EOAKasouWw==
X-Received: by 2002:a2e:a548:0:b0:2ec:165a:224a with SMTP id 38308e7fff4ca-2ec165a242cmr74005021fa.36.1718615941694;
        Mon, 17 Jun 2024 02:19:01 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855eeff53sm75591125ad.181.2024.06.17.02.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:19:01 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v3 3/4] lib/alchemy: Improve period adjusting support
Date: Mon, 17 Jun 2024 11:16:53 +0200
Message-ID: <20240617091654.66342-4-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
References: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
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
2.45.1

