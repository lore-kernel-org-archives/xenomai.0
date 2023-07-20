Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37618AE7
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:52:14 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-521dc8ae899so815511a12.3
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689864732; x=1690469532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXWTF3uxCUhjKaD5xrpBOAFx7wrAKp/50m8RzAA8SJU=;
        b=vN1tj90my+qVpi7lTgQts0NiN67VcPtBgKj2m+vFBFiD4x7mGQfGpZVsWgfCgQm3C+
         kNBcPAWTitd3yzlr/xp5vVyZx5xi+wOZ0DU/5kRSC5VykA2Jmr/PMT0BS8benvNDEh4i
         6QPSy4CKr9n0wVCN5XGK1yDqa2rThrL1sJJbfCPo+NWrWXq6zcMXOSdYo16hRKIsfbAw
         db/qbZwiRYVth5CkFndoFyohRKTDHL8Q2QpUrbhihoGIvLW+ZZRptDEbytCucE1kOWW9
         XEt0818fNUbTsLaWnV5U8ZWXE+/TX2wCW75GbAfctj+9qd5E4tJ1smekSNsI0I/iJIBs
         BklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864732; x=1690469532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXWTF3uxCUhjKaD5xrpBOAFx7wrAKp/50m8RzAA8SJU=;
        b=PQS8dhOfNyS/ZnET81fYEa71XJyJxj1wd6vi92lJ1vsK1s8Lk3VSBMwKzcsthL/CIj
         ac7Mo79ZHqb7pATupnE/CpcoBx17Fcn0tKVesIIwGgbAZVqMZI7Wh1f0gsSe7bPx4q9B
         R+G6HfAAguupTSRrXcaQGFWCfXJy3UmCiR2zlDWv8Y8QK5F3ARP0aVUnfQu+aJ7sqoMC
         TLkbRnCBG541ORDlfVzV5dQvoETN+vtnqrFiUSbc6kK/uC6jY34FOL8N/bWqK8hP4qnm
         jpJQhznQ/dZgY+Q5SaVSSOCG7Hloq/1fjY2pbVAbzlTRHvbWnPwaiO0/Fr063LqOY09x
         h7BA==
X-Gm-Message-State: ABy/qLZlgvwVvFY6ChZp/nc78TF+txaOdzW7idk8aOaEbE01hO5h5+zL
	nYpsBidpmVw3FZnQ7dvgbOnVmlEUVxC5cUq+l/Q=
X-Google-Smtp-Source: APBJJlEykgNHiKFrRy4EmD7Jgf5p7kHd/PSXnbu2FrcCDSKCQMcUQNrVQVaf3B2VawhOAy4XdyL9cw==
X-Received: by 2002:a17:906:73dc:b0:993:d88e:41ed with SMTP id n28-20020a17090673dc00b00993d88e41edmr5228980ejl.3.1689864732648;
        Thu, 20 Jul 2023 07:52:12 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906854d00b0099290e2c163sm793462ejy.204.2023.07.20.07.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:52:12 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 09/10] alchemytests: Fix task-5 logic
Date: Thu, 20 Jul 2023 16:51:49 +0200
Message-Id: <20230720145150.24607-10-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230720145150.24607-1-aaron@sigma-star.at>
References: <20230406103341.2914-1-aaron@sigma-star.at>
 <20230720145150.24607-1-aaron@sigma-star.at>
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
index 3c0fa427c..c402de22e 100644
--- a/testsuite/smokey/alchemytests/task-5.c
+++ b/testsuite/smokey/alchemytests/task-5.c
@@ -44,17 +44,17 @@ static void foreground_task(void *arg)
 
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

