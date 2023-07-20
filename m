Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566EB18AE7
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:52:12 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e6113437cso1189206a12.2
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689864730; x=1690469530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHQJQj+NK2+ZHGzkyXhC9xok+EabiDqcjCBc4SM1vxw=;
        b=Ia1WvAknmFYcfSA1zO5/OBWe45HtWys4lcknCI2DNDPz8gO/L3kD8D/OEx26Xc3eAZ
         vFP4mEkYAHn2VSuvpNUyO0E4zAO8EunftE29FcPlKcFh8aTC7dxAOHmWldDhd6L7hbUh
         eTL3Jbl1ATYPNzw3qNFBazm0kXWvSwHOMtKOzfcfAinxFChRNRaDyj3PyP2CnMARmDqL
         XxtlGp/r42NsaCiFvVub9X1Fzmch9bOJn8deDMm5BrNFaaTafTJxSn6kU1B/xSGxJDmj
         IY42EOWGWH9xHuaKWM2a6/5suQi936pXCOVwCzz5g86IGj5pcaPMSSANSiIOMZ2mfWRY
         Ll7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864730; x=1690469530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHQJQj+NK2+ZHGzkyXhC9xok+EabiDqcjCBc4SM1vxw=;
        b=L/+8rgY5nLP2n1QdPeAeqegf+z9D2fmHzZGwss+FKWnsZA7tOC/yWOgRMWg9QzKTKG
         ABsBTO6t2ZRlwhmhjQj2Q31PF8qFWJZ7+Def1Y9D26gE+RA9ZbyarJDjMLT7d/nyzRmv
         YGY8/toRePbV/1PlnttaY67pry2a4vdWln9DZAu4y629QBy6WV3PTFaq3yupM12KJDZW
         NCg1pYgf8dgURrSACZECKl3HchRHPVgL8EmWyfQgNav3+YurT8FE6roOyUOGrdDtMCVU
         DNirU4yPrLs6wkKM4rnyertuz1MY1Uvbzt769zu4XIQqZ5U80HUzkb4vLK7ULHFY8rqJ
         0Gdw==
X-Gm-Message-State: ABy/qLYVf76wTzr3opcJKajoW/JQzZhlt/PhFK97Bgb0Ye7R7eE0qG+Z
	/RR/Bp81vptcVxXVrYHRsBGhtaiHxgJeuzcmETE=
X-Google-Smtp-Source: APBJJlGPlcDDWRvlhsSQ+zGE2yPIyjd/0qIKdqfC9arx249Q6K6ZiWnQ3JT5ZJRDU+ZLAv2YjhCk1w==
X-Received: by 2002:a17:906:6499:b0:997:e8b8:8d6 with SMTP id e25-20020a170906649900b00997e8b808d6mr5294074ejm.28.1689864730541;
        Thu, 20 Jul 2023 07:52:10 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906854d00b0099290e2c163sm793462ejy.204.2023.07.20.07.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:52:10 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 07/10] alchemytests: Check pipe-1 asprintf ret value
Date: Thu, 20 Jul 2023 16:51:47 +0200
Message-Id: <20230720145150.24607-8-aaron@sigma-star.at>
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

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/pipe-1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/alchemytests/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
index 4202be2ba..da5fbf999 100644
--- a/testsuite/smokey/alchemytests/pipe-1.c
+++ b/testsuite/smokey/alchemytests/pipe-1.c
@@ -48,11 +48,13 @@ static void realtime_task(void *arg)
 static void *regular_thread(void *arg)
 {
 	struct pipe_message m;
-	int fd, seq = 0;
+	int fd, res, seq = 0;
 	ssize_t ret;
 	char *rtp;
 
-	asprintf(&rtp, "/dev/rtp%d", minor);
+	res = asprintf(&rtp, "/dev/rtp%d", minor);
+	if (res < 0)
+		return NULL;
 
 	fd = open(rtp, O_RDWR);
 	free(rtp);
-- 
2.35.3

