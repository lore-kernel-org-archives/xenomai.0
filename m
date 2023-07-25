Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFD156F7
	for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 08:30:10 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-991da766865so885601966b.0
        for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690273809; x=1690878609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XcCLWC39+8QMjcUTvdz7glL5ZxbKtjyuZbxFizKY08=;
        b=gWK/Xy3MZynw1LLKXFM1CgSlrieP/P8yBl3GAVoKAoe0iEFCulu/tL+paDTqjyyXmC
         kXQz2IyfSuU0sxFmS73nF0Yk6GC9Pe1LAuVSMq46iSaVS5FkUHZDWgiHmcuU7DcrR+2H
         5ScXoZEtCxT/WHrUdlXPja/Ynvo8r/DseHMQ21y7bUrshkFLWU/QL2Ym6ijcYhbOkcD4
         wDYZZHZ2wGihbiY9I4mIGfNXmKVy18hJ8SVFMQ7GZOikcf7pZJTt/ANvyKln31I51jXJ
         hGjkUZcWd8pp/nVdWh9Ivs9isyqDZw7h/KchgMjLb9LQ96UknHpWnd2OUKgkbMt8yOsA
         yuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273809; x=1690878609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XcCLWC39+8QMjcUTvdz7glL5ZxbKtjyuZbxFizKY08=;
        b=TdXYxg972dxr2ptNU4D2hXS+LkTCB8IbKsDW1A2MfSIoLZMGRP/0mDe46NB74SnkH4
         no6QQIoUOq2WNdDdj/50YTVEAsRb6U8Gs9JJ4r82tOs7dwliknHNarB/4YejQb+3HT7x
         vVAKbgLfNzREh8CEPidk47XH9FBmLTG1hIYSzIVROGxYxKHC1u1DRGIuq79GftBcrdGR
         eXF85Snxc7+zJlUjfS4etnF4sZ8s7UyMW0r0Jkv6vHq8mqHgQ6sp7q93KL3doItV5CMt
         y5002IHlsnTyLTlrQ+8xA8gLtv91IVL2z9VoWfU9yQZKlhZsD4AsXTL9DVuZUc51XepJ
         zbYA==
X-Gm-Message-State: ABy/qLYqgqSvW4ptUc8sU0c93aQUqJmzcN8IZ4JmC1fWE7P7mpSvIOGx
	8Z1BRmXcRCrIUCzwy1bDR+zkHzB8WZQTQOmrNJQ=
X-Google-Smtp-Source: APBJJlGbodpMR8aLLriFuHebYBkCNg4wNJug0EQQK/sqt2elqbfsD7PeDr5Tc4INCADwX0cL3hZH0Q==
X-Received: by 2002:a17:907:2cd0:b0:997:e7d9:50f7 with SMTP id hg16-20020a1709072cd000b00997e7d950f7mr12718351ejc.66.1690273809202;
        Tue, 25 Jul 2023 01:30:09 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm7752080eja.121.2023.07.25.01.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:08 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 09/10] alchemytests: Fix task-5 logic
Date: Tue, 25 Jul 2023 10:29:58 +0200
Message-Id: <20230725082959.5144-10-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230725082959.5144-1-aaron@sigma-star.at>
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Semaphore call in wrong logical order, so that on the second
rt_task_set_priority call the task doesn't exist anymore and thus the
call fails with EINVAL.

This commit fixes the order so that the test passes again.

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/task-5.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testsuite/smokey/alchemytests/task-5.c b/testsuite/smokey/alchemytests/task-5.c
index b9075945d..2aecd8125 100644
--- a/testsuite/smokey/alchemytests/task-5.c
+++ b/testsuite/smokey/alchemytests/task-5.c
@@ -45,17 +45,17 @@ static void foreground_task(void *arg)
 
 	traceobj_mark(&trobj, 4);
 
-	ret = rt_sem_v(&sem);
-	traceobj_check(&trobj, ret, 0);
+	ret = rt_task_inquire(NULL, &info);
+	traceobj_assert(&trobj, ret == 0 && info.prio == 21);
 
 	traceobj_mark(&trobj, 5);
 
-	ret = rt_task_inquire(NULL, &info);
-	traceobj_assert(&trobj, ret == 0 && info.prio == 21);
+	ret = rt_task_set_priority(&t_bgnd, info.prio);
+	traceobj_check(&trobj, ret, 0);
 
 	traceobj_mark(&trobj, 6);
 
-	ret = rt_task_set_priority(&t_bgnd, info.prio);
+	ret = rt_sem_v(&sem);
 	traceobj_check(&trobj, ret, 0);
 
 	traceobj_mark(&trobj, 7);
-- 
2.35.3

