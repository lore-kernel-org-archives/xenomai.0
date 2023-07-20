Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E8182D7
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:52:10 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-992b2249d82so152866066b.1
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689864729; x=1690469529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC3S8FMlHib4P39OfvMKIsafAJ/8Xh2tny6cdNFvYUY=;
        b=HY3/1ClQUZENv3yMpzow1fo/OT2DLUPJFLJ6QBJGR8RelCIzGe9xsEGkUgN7MAHuof
         wNxDHA4pnT9z5S5LhFL0NIUU6e72OVk8XX19bKlVzZBEHBQmTeykyGXVrHgGld9V2RGp
         7ygSUyeGW5UroWMxQv3bcjhUP/0d4fv69Tw/mOhq0d9P4U27JYjehYxd7p+/jr00KOM7
         4xtshTso4aIzI25iWLVWEAgpzgI5hZCSisiCkGlFfcqQ04i0/kVkxEGf8TjqyM1pbuEY
         E+RyssOkv5sx5jJfhY0/4NOFM8KyaEbc+xpERI5HSuUS6fZRVo9cLfFdg4sCPZ8S8NOM
         jVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864729; x=1690469529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CC3S8FMlHib4P39OfvMKIsafAJ/8Xh2tny6cdNFvYUY=;
        b=Wixl8bHEjPpIn/+UWcCzqiraFdffsiSaSbDmL9rWregz5CHBRBfv3Pa4R2rx07i9NJ
         cR/kQwZxQIL9J9stZHczDu8wVtOWQKvNgYSdNlE4MnSY8TOGtSs0vRq8gj+n1d+WQcZH
         wWzVDuXSnWIhbS3TjiEodkbyC0tv49lgagvvgS3u0DMEsXDx3TaORTDoDkYHWFl3xwyG
         7jorV1Ev0+sH4CeXM9U6YFGa0azCrbuPSJAD6/1v7ZzDuv9EWze2VMsg/zD4qHCyE71z
         TfbZCIHlLNqeELVP9D6KjgWwzHs/COeXnduYis4vHe77HjpO4SPrTgeKKogbBA/nQvuk
         Hesw==
X-Gm-Message-State: ABy/qLaneA7o3KFk0D1VamOWHc8jeDH5ATCV8CCRb9UL76XMQt57Gby9
	sRUREBdP+VZqXbT7MAfdAznQ+SHFadXuYdI0dKw=
X-Google-Smtp-Source: APBJJlHZPISP/8HKElj6wvhH6AV8QvtDdDkfT2hMaxGXwVA7+0/3G0EfzwPhzO3lyZIVZvCOHRcb4A==
X-Received: by 2002:a17:906:d7:b0:994:4f1c:d769 with SMTP id 23-20020a17090600d700b009944f1cd769mr2303592eji.3.1689864729311;
        Thu, 20 Jul 2023 07:52:09 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906854d00b0099290e2c163sm793462ejy.204.2023.07.20.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:52:09 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 06/10] alchemytests: Fix gcc warning in task-9
Date: Thu, 20 Jul 2023 16:51:46 +0200
Message-Id: <20230720145150.24607-7-aaron@sigma-star.at>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

Make it static, no prototype needed anymore.

Fixes:
task-9.c:13:6: error: no previous prototype for ‘sighandler’ [-Werror=missing-prototypes]
 void sighandler(int sig)

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/task-9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/task-9.c b/testsuite/smokey/alchemytests/task-9.c
index e358154c5..4b62a17be 100644
--- a/testsuite/smokey/alchemytests/task-9.c
+++ b/testsuite/smokey/alchemytests/task-9.c
@@ -10,7 +10,7 @@ static RT_TASK t_test;
 
 #define ONE_SECOND  1000000000ULL
 
-void sighandler(int sig)
+static void sighandler(int sig)
 {
 	/* nop */
 }
-- 
2.35.3

