Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52F18AE7
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:52:09 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51e57874bfdso1238951a12.0
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689864728; x=1690469528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8wyq5zlbwmBl2z5r15EjCpmgvXiFhSWkqekXZ9l2jc=;
        b=KoaMncTkJauMR1wU4KPfhIgDogmrHtJIBzcVRxL8zLVAqAKx39Mg87hFBuxc6UjU2m
         LIqn8K/yp6L+91cwfHwB94+qzsciRCEVtBuyfqlkOzLemGcgiVccsBx2j7RlH269n1ua
         yOJIIzP/0ZGpK55Eyz6zb9huao+wlm75/WybSPDVsnjoOp+V9BbecwP3d+ePmVipsyg+
         rJ+QXK1r/nK0TfgLN963YfXnz4iOCi+qpjHJGY787y7Gg6WbVvzViqHjhQoSv56hek4x
         l6SuObZl2869paAgQQ8TOkriQPzd0+7wy33LTkazvaobLX5Hi57QhWLn8S+SBxbYy16r
         HkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864728; x=1690469528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8wyq5zlbwmBl2z5r15EjCpmgvXiFhSWkqekXZ9l2jc=;
        b=EfMCdIbDspzWBlcq7wkSFmzNfZxexlMyI7ZXJZc5CybsfUg/WBkRykCO5GnT5JyaxI
         JPMquew2c4grOBZpVqaxXoaemAMur/AEdRPpvPOgQrFZJwFfCy3F99ZV6U5icxEH48r8
         aZFer5Ts91NDAtYyZR4IwL5cCkRHJVDQ+aby6sttdL3xhhN+u0UQNb8z6zvikJEBJ2SU
         Nledf++AYnv74egTKN0Kg49QRrjXA+wReVOerwDaz9eSRY7lANkSi0lYzO6FNlOjCLBz
         gfnbRnCbNMzAZqqwTJRkw4X1vculPDUhFxi+HBp6rCwhfAn1wa9w06Ex+rTYDvq416qh
         mLkg==
X-Gm-Message-State: ABy/qLb7hB8+Bp7oiKwWOViBDnOwCoV3k7h04iyzIjw+4EWzGsNomsVt
	/wnIsO23YoNyyRMkJWrCMzIUko9p1zZe9IoCEZw=
X-Google-Smtp-Source: APBJJlGVZUJKt8PWpDMO1ElI3lkBN0oohudYDcfZq7eaSWFsFAPzLAXRg8Dm/BaX6f2vPmpi+ZOkwQ==
X-Received: by 2002:a17:906:519a:b0:994:5396:e322 with SMTP id y26-20020a170906519a00b009945396e322mr2861997ejk.1.1689864728153;
        Thu, 20 Jul 2023 07:52:08 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906854d00b0099290e2c163sm793462ejy.204.2023.07.20.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:52:07 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 05/10] alchemytests: Fix gcc warning in buffer-1
Date: Thu, 20 Jul 2023 16:51:45 +0200
Message-Id: <20230720145150.24607-6-aaron@sigma-star.at>
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

Make n an unsigned integer, such that gcc realizes that "%.2d" cannot
become negative and will fit into our 3 bytes buffer.

Fixes:
buffer-1.c:64:15: error: ‘%.2d’ directive writing between 2 and 10 bytes into a region of size 3 [-Werror=format-overflow=]
   sprintf(s, "%.2d", 11 * n);
               ^~~~

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/buffer-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/buffer-1.c b/testsuite/smokey/alchemytests/buffer-1.c
index d6d1d9ad7..807db1dcf 100644
--- a/testsuite/smokey/alchemytests/buffer-1.c
+++ b/testsuite/smokey/alchemytests/buffer-1.c
@@ -49,7 +49,7 @@ static void background_task(void *arg)
 {
 	char c = 'A', s[3];
 	ssize_t ret;
-	int n = 0;
+	unsigned int n = 0;
 
 	traceobj_enter(&trobj);
 
-- 
2.35.3

