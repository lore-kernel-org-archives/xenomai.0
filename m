Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF9A5F
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:23 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5027e589e20so1243639a12.3
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXe93DTjj0i7l0Dv9iY1BfW7QXCXM6sj31c8aJ3zgis=;
        b=pPybKg5LA3CiuuCwNJDO7IVkb7g8lOU41652Lb35lfqHrg5i2jK6c7K/ohHyxJtYGj
         OnDzTiddR94ZOH4oR2l9TEIM0ZJhuSJ/fbbkW4gzWzYHYYRx520H9amERExD87xrz228
         KXX1gYRxsaZU+6yBwfX5QB9mpHLlr865RGhU8LDhFxlWOUnlYVxfyvzTLGxSttEvaIuv
         z0U6OUTaDFg+sLTdgpJ6V7PZiyydmz0BxWgnQqkw9FPEx9Zq9Xl6gA8lrrGS/kJcuZED
         zjeL7la0Eqj3uHai/mtdX1KNN2wrdE3T9gZLMsWpTH9n4cBdc+6XGcaq8v1ERGFkLjx/
         GE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXe93DTjj0i7l0Dv9iY1BfW7QXCXM6sj31c8aJ3zgis=;
        b=BrD0zr7uocJ7yxODU75gQcZclnktEG1aZGtc7tanx5+IL1xi37e4Ag3InCt46eFhOt
         OxVRsbTdE3LaUzXQZsYnKICYUxh30uxPhCEhW1mpjv1bwJibjfGN0nNLeSyhdPxr1/fN
         o9TDnP1C1H8YQuXVZ3G1u3lnm4HlsLMcYz2rw5ZYznxmiM0m4gdTUEhiPq5G5I9p17TO
         Cq6YqTLg9oCSA6tEf6wbnsmH6nX9mklLRrowBtMcNJ3vFlguEmsuYcMg1UdnTA8olQsc
         ZwySNq1gEQUf4JOUsT7C7b3yTix69pAw/bhICbpfYFmEx3tXHh3DGkkoXhcmNECmIiYn
         +XXw==
X-Gm-Message-State: AAQBX9dJvyVn+6upFSwPGfYjCa/WD4lxkuSpX+NKlbv8rytyRLfzbMoD
	KVPaeW+s1PWMO9QiArEHq5w5Rsobn1kJniTigNo=
X-Google-Smtp-Source: AKy350Z+NfOdVQlAwbqi/GMZfPpKBhhl0IrBwowBQHw3eZeOuYO8cZB+JSFNbUXumY31sOuIBpmhkQ==
X-Received: by 2002:a50:ee98:0:b0:502:91c9:4567 with SMTP id f24-20020a50ee98000000b0050291c94567mr4524668edr.12.1680777261955;
        Thu, 06 Apr 2023 03:34:21 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:21 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 01/11] testsuite: Move alchemy tests into testsuite/
Date: Thu,  6 Apr 2023 12:33:31 +0200
Message-Id: <20230406103341.2914-2-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230406103341.2914-1-aaron@sigma-star.at>
References: <20220413215819.22954-1-richard@nod.at>
 <20230406103341.2914-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

This is the very first step to have the alchemy tests embedded
into our testsuite.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 {lib/alchemy/testsuite => testsuite/alchemytests}/alarm-1.c  | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/buffer-1.c | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/event-1.c  | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/heap-1.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/heap-2.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/mq-1.c     | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/mq-2.c     | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/mq-3.c     | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/mutex-1.c  | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/pipe-1.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/sem-1.c    | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/sem-2.c    | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/task-1.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/task-10.c  | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/task-2.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/task-3.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/task-4.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/task-5.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/task-6.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/task-7.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/task-8.c   | 0
 {lib/alchemy/testsuite => testsuite/alchemytests}/task-9.c   | 0
 22 files changed, 0 insertions(+), 0 deletions(-)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/alarm-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/buffer-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/event-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/heap-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/heap-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/mq-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/mq-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/mq-3.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/mutex-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/pipe-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/sem-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/sem-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-10.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-3.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-4.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-5.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-6.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-7.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-8.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-9.c (100%)

diff --git a/lib/alchemy/testsuite/alarm-1.c b/testsuite/alchemytests/alarm-1.c
similarity index 100%
rename from lib/alchemy/testsuite/alarm-1.c
rename to testsuite/alchemytests/alarm-1.c
diff --git a/lib/alchemy/testsuite/buffer-1.c b/testsuite/alchemytests/buffer-1.c
similarity index 100%
rename from lib/alchemy/testsuite/buffer-1.c
rename to testsuite/alchemytests/buffer-1.c
diff --git a/lib/alchemy/testsuite/event-1.c b/testsuite/alchemytests/event-1.c
similarity index 100%
rename from lib/alchemy/testsuite/event-1.c
rename to testsuite/alchemytests/event-1.c
diff --git a/lib/alchemy/testsuite/heap-1.c b/testsuite/alchemytests/heap-1.c
similarity index 100%
rename from lib/alchemy/testsuite/heap-1.c
rename to testsuite/alchemytests/heap-1.c
diff --git a/lib/alchemy/testsuite/heap-2.c b/testsuite/alchemytests/heap-2.c
similarity index 100%
rename from lib/alchemy/testsuite/heap-2.c
rename to testsuite/alchemytests/heap-2.c
diff --git a/lib/alchemy/testsuite/mq-1.c b/testsuite/alchemytests/mq-1.c
similarity index 100%
rename from lib/alchemy/testsuite/mq-1.c
rename to testsuite/alchemytests/mq-1.c
diff --git a/lib/alchemy/testsuite/mq-2.c b/testsuite/alchemytests/mq-2.c
similarity index 100%
rename from lib/alchemy/testsuite/mq-2.c
rename to testsuite/alchemytests/mq-2.c
diff --git a/lib/alchemy/testsuite/mq-3.c b/testsuite/alchemytests/mq-3.c
similarity index 100%
rename from lib/alchemy/testsuite/mq-3.c
rename to testsuite/alchemytests/mq-3.c
diff --git a/lib/alchemy/testsuite/mutex-1.c b/testsuite/alchemytests/mutex-1.c
similarity index 100%
rename from lib/alchemy/testsuite/mutex-1.c
rename to testsuite/alchemytests/mutex-1.c
diff --git a/lib/alchemy/testsuite/pipe-1.c b/testsuite/alchemytests/pipe-1.c
similarity index 100%
rename from lib/alchemy/testsuite/pipe-1.c
rename to testsuite/alchemytests/pipe-1.c
diff --git a/lib/alchemy/testsuite/sem-1.c b/testsuite/alchemytests/sem-1.c
similarity index 100%
rename from lib/alchemy/testsuite/sem-1.c
rename to testsuite/alchemytests/sem-1.c
diff --git a/lib/alchemy/testsuite/sem-2.c b/testsuite/alchemytests/sem-2.c
similarity index 100%
rename from lib/alchemy/testsuite/sem-2.c
rename to testsuite/alchemytests/sem-2.c
diff --git a/lib/alchemy/testsuite/task-1.c b/testsuite/alchemytests/task-1.c
similarity index 100%
rename from lib/alchemy/testsuite/task-1.c
rename to testsuite/alchemytests/task-1.c
diff --git a/lib/alchemy/testsuite/task-10.c b/testsuite/alchemytests/task-10.c
similarity index 100%
rename from lib/alchemy/testsuite/task-10.c
rename to testsuite/alchemytests/task-10.c
diff --git a/lib/alchemy/testsuite/task-2.c b/testsuite/alchemytests/task-2.c
similarity index 100%
rename from lib/alchemy/testsuite/task-2.c
rename to testsuite/alchemytests/task-2.c
diff --git a/lib/alchemy/testsuite/task-3.c b/testsuite/alchemytests/task-3.c
similarity index 100%
rename from lib/alchemy/testsuite/task-3.c
rename to testsuite/alchemytests/task-3.c
diff --git a/lib/alchemy/testsuite/task-4.c b/testsuite/alchemytests/task-4.c
similarity index 100%
rename from lib/alchemy/testsuite/task-4.c
rename to testsuite/alchemytests/task-4.c
diff --git a/lib/alchemy/testsuite/task-5.c b/testsuite/alchemytests/task-5.c
similarity index 100%
rename from lib/alchemy/testsuite/task-5.c
rename to testsuite/alchemytests/task-5.c
diff --git a/lib/alchemy/testsuite/task-6.c b/testsuite/alchemytests/task-6.c
similarity index 100%
rename from lib/alchemy/testsuite/task-6.c
rename to testsuite/alchemytests/task-6.c
diff --git a/lib/alchemy/testsuite/task-7.c b/testsuite/alchemytests/task-7.c
similarity index 100%
rename from lib/alchemy/testsuite/task-7.c
rename to testsuite/alchemytests/task-7.c
diff --git a/lib/alchemy/testsuite/task-8.c b/testsuite/alchemytests/task-8.c
similarity index 100%
rename from lib/alchemy/testsuite/task-8.c
rename to testsuite/alchemytests/task-8.c
diff --git a/lib/alchemy/testsuite/task-9.c b/testsuite/alchemytests/task-9.c
similarity index 100%
rename from lib/alchemy/testsuite/task-9.c
rename to testsuite/alchemytests/task-9.c
-- 
2.35.3

