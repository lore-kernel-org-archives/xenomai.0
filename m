Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94C2BE033
	for <xenomai@lists.linux.dev>; Sun, 12 Jul 2026 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783887050; cv=none; b=bUp3SLXdnEFxMgyO7cnmhijtzTkdDPYRSsXe15zB0TE6YrUqhmS5Icchf+LXfhvxQBzCYQ1FHpAuD0y98YKm977BmcyhpdH3l3knEgDFOhRCjCbISu4Bb6O/wtzRJkxEYrUK/VrxqCgGl2gjnOju4fs2W06Lp4NLRG/D8zr6mck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783887050; c=relaxed/simple;
	bh=wy5TXaEQMA9mVSgOOcgvWaJaZnRWnmDpUOQrNXlOEj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcvoGFQnz9pN82w0uPssUEBKvI/bm+nXy83JotASSBGgtSHjAFCj5ty9coJOG4eGL/b2etvRcsRO1YjZeNwHNI7UDT/m/s5blVUehihEdDMEupHFJYRQXVVbZm9e/fvVJDFXyw3AmP8Ix3RawWjYsD6dmCajFrqaw76MLCRfJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKt6zF+X; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKt6zF+X"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493f60208a5so20106525e9.3
        for <xenomai@lists.linux.dev>; Sun, 12 Jul 2026 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783887047; x=1784491847; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqpUXocUBZqy8WwKD2L7eQDMhQn0BdtervpbCwQlPiU=;
        b=DKt6zF+XBEbM4KNs+33VDIrm3Un96ahzDMxgYZy4TKgiNXxMCDHkrPEJ7NNz2mscrF
         rM/B9l9rxWgm8i98VRZ8PwrGph3LlzglQ+EDSWgfIDClPAJoWi1um5lAT4yRthKMB4Mb
         cedEtf+FrcuBJYRcL0DM67U27FRKqk/oYc2JdoXc58UviGOSkOAnLWUsWaJlTCydlCuJ
         lCJcCt+0ZM6V6TZ5zu3C+R7qXj1lVKjv1jkrtZZXCdn1SlMdoCLH8k0m+yTKIqnYo+Ys
         SzQWXnxsDGS0PIRYpGCLj46ZXsCqU4dV3aTsbx10CSFJ9Zk8Rol3u4hvIIlv16ikU0/i
         xOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783887047; x=1784491847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yqpUXocUBZqy8WwKD2L7eQDMhQn0BdtervpbCwQlPiU=;
        b=hQcN8521Fkn+b4Ilf2YqRdBZoSkdWSmVIIx8CBOJWWoip2Efv/wAolmeESAhBNOFvi
         3uC8fqaUaNcGRRxE7z+tw/TjNHQWeiVXErRknCBSmKjZsKsX3fSa4BtP9wgC3omocmel
         q1yqjXoJJP3a7QA5FnUmqNGzdl7ppx+BxdYVZT67auFjk5JbD9HYA+oZYxy361qmQ5DV
         Ykn+fxx4G439Dhh8/ODHTONjuQRzJ0oR+EkXEQKMKVQhroXM5ToH+HWI2yYKBbqdfYN7
         Mkldi9Tc5vuTZ5RvTfJJw1b4yvUihHWnX+CveOXY4RTNNrln/0gUtxQIPK9hLxx0z10L
         XI1Q==
X-Gm-Message-State: AOJu0YzAZXHD7OzNCXwlRlb9H7Sdnl9GqgMmUyYtnpPv/c+ikBcapdSh
	kQY0kOmdIG82nRv6n5E6qKoiUVVtJYY4LcD8Q/O2osvPRepC0XLo7+YyBGJC8xPQ
X-Gm-Gg: AfdE7cmqPb1gI7kFkbtBNQEVj6xzqcloEftIBikyk2I4vAoFF/lK90Q0+4XAg455VHx
	SJgbo6qAyBs8bwEbPT0KJMDf2W/by+G1Z4IdRLphhemC7FndMcX8H04vtIy9atH0kOFDPiRnRo6
	c1Tra5TDgJMNsut2cxnW+vNkvbbepcBx50mDjfQ0z95m56iFwJrsG6tU4cSacGf/9tNgDwyNomB
	zB3q2IYGnCUd9HRra9pFnKDUibUFyeEoM46NbRaEpfl8oO26QqR9fEi4vDqWpP1IT9vNOYni10U
	FpbNud0MJOUFbopPbDWhk+rvkRJCZkz78aIMGmxSmeMWKW2QBOK02qWd9I0shVYzmwxpActS3XN
	z0iZDz2PU8Ppj3qNj874J4nljdDoPdCrrvru08QHH5fYaXvplqHLtQ9gRYUh+12qZHuzLMEC276
	UuOMDw2DUaQkWFoY4=
X-Received: by 2002:a05:600c:4ed4:b0:493:e946:c0fb with SMTP id 5b1f17b1804b1-493f87804fcmr76254745e9.0.1783887046942;
        Sun, 12 Jul 2026 13:10:46 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493eb6d5055sm305591695e9.5.2026.07.12.13.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 13:10:46 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH] test: hectic: sem_post task_init on failure
Date: Sun, 12 Jul 2026 22:07:49 +0200
Message-ID: <20260712200749.9210-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87h5max6sb.fsf@xenomai.org>
References: <87h5max6sb.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the issue where hectic doesn't exit on init failure when
there are for example not enough resources due to to many available
CPU's.

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 tests/hectic.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/tests/hectic.c b/tests/hectic.c
index af8f988..b07e074 100644
--- a/tests/hectic.c
+++ b/tests/hectic.c
@@ -270,6 +270,7 @@ static void *sleeper_switcher(void *cookie)
 	CPU_SET(param->cpu->index, &cpu_set);
 	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
 		perror("sleeper: sched_setaffinity");
+		sem_post(&task_init);
 		clean_exit(EXIT_FAILURE);
 	}
 
@@ -379,6 +380,7 @@ static void *fpu_stress(void *cookie)
 	CPU_SET(param->cpu->index, &cpu_set);
 	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
 		perror("sleeper: sched_setaffinity");
+		sem_post(&task_init);
 		clean_exit(EXIT_FAILURE);
 	}
 
@@ -399,19 +401,14 @@ static void *fpu_stress(void *cookie)
 	return NULL;
 }
 
-static void attach_thread(struct task_params *param)
+static int attach_thread(struct task_params *param)
 {
 	char buffer[64];
-	int efd;
 
 	task_name(buffer, sizeof(buffer), param->cpu,param->swt.index);
 
 	/* Make it a public thread only for demo purpose. */
-	efd = evl_attach_self("/%s:%d", buffer, getpid());
-	if (efd < 0) {
-		perror("evl_attach()");
-		clean_exit(EXIT_FAILURE);
-	}
+	return evl_attach_self("/%s:%d", buffer, getpid());
 }
 
 static void *rtup(void *cookie)
@@ -423,12 +420,17 @@ static void *rtup(void *cookie)
 	cpu_set_t cpu_set;
 	unsigned i = 0;
 
-	attach_thread(param);
+	if (attach_thread(param) < 0) {
+		perror("evl_attach()");
+		sem_post(&task_init);
+		clean_exit(EXIT_FAILURE);
+	}
 
 	CPU_ZERO(&cpu_set);
 	CPU_SET(param->cpu->index, &cpu_set);
 	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
 		perror("rtup: sched_setaffinity");
+		sem_post(&task_init);
 		clean_exit(EXIT_FAILURE);
 	}
 
@@ -503,12 +505,17 @@ static void *rtus(void *cookie)
 	cpu_set_t cpu_set;
 	unsigned i = 0;
 
-	attach_thread(param);
+	if (attach_thread(param) < 0) {
+		perror("evl_attach()");
+		sem_post(&task_init);
+		clean_exit(EXIT_FAILURE);
+	}
 
 	CPU_ZERO(&cpu_set);
 	CPU_SET(param->cpu->index, &cpu_set);
 	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
 		perror("rtus: sched_setaffinity");
+		sem_post(&task_init);
 		clean_exit(EXIT_FAILURE);
 	}
 
@@ -600,12 +607,17 @@ static void *rtuo(void *cookie)
 	cpu_set_t cpu_set;
 	unsigned i = 0;
 
-	attach_thread(param);
+	if (attach_thread(param) < 0) {
+		perror("evl_attach()");
+		sem_post(&task_init);
+		clean_exit(EXIT_FAILURE);
+	}
 
 	CPU_ZERO(&cpu_set);
 	CPU_SET(param->cpu->index, &cpu_set);
 	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set)) {
 		perror("rtuo: sched_setaffinity");
+		sem_post(&task_init);
 		clean_exit(EXIT_FAILURE);
 	}
 
-- 
2.47.3

