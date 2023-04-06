Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569528E1
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:26 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-4fa3ca4090fso1184200a12.3
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4FkQDQGvXeZt/XEzM0ekGaQnldSzBsGAXuXDogjIwk=;
        b=lkfQ/rnK2XW9IX4luEJ/2/0fm/V4Tg3PZjnt54JnpSaONJ+oqX4CmBu+aMaxWOyiKl
         1VrMyLxKpTGSaKSxuV2ZagiolHMlayzZ51QewDOxMBm5sGDGDI/jrCwjjynh6eOIvbHu
         zkSBkAqlrXJlrVRRj27xSKS8sQRsDGt8ZJB2ZRlfcuHvnjFlQNNPYGMxHoovplrVs4X1
         gRsTkoDpfLH5cWrcFjP/qtzH2zyv2oDaq7WYWW7sbJ9ymaQ+j1SQBApw05RGN0JQrJ1g
         shg8WAfc0CxUby2u4qu7kKS8cCGAWCKZMNFVwkj6w+y0wl+2eudCUfyXkPVy2FapfCui
         yTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4FkQDQGvXeZt/XEzM0ekGaQnldSzBsGAXuXDogjIwk=;
        b=eb5tAuLjtlR5sTbqd5pEz/nXFb3Xx4HlM0SJXPZ6Y2x8Ro95GQbMVj2130srgPaLuu
         5xFLpiWTE3sdkkVQS5M5P72o3t0qxgV6IdMsnU2bf53ksl9WH2QLeS/MOw1WJf2az0xK
         X0MW17b1f6aXMS/BUvP4wBSLxe/f+wzdQkDwoQ2qyEQVHT+CAgp8E4OtQTAosPt0saHL
         eB4eUlQxjCr+asKp5GGgP+RuHrsKlj5Ea7fu6tgN5NgnVANJtf3E+H+bd0kBxFiGm6hH
         LY+29sYAiVuzxoKsRfZZgVcOss/7BUaZMKiHUq+B+fbBgGYN4ZQuqolK+bcUVIddGHCf
         zn5A==
X-Gm-Message-State: AAQBX9enTZLRX+Q48Qk3BrvHFoknBbDho1yM/lM2hO84p9v0XqDJK2kE
	gIL9qwv5mPgBZniqu7zsRDjP0I2jOBcZHUWr54Y=
X-Google-Smtp-Source: AKy350biOiOfS/OSaPBZBRCa7tiT17Jwmc5Dzcl/6PABC+FepMANWAuRJ5+wkuyqQuIlQBqTMYsvYg==
X-Received: by 2002:aa7:ce15:0:b0:502:2148:2980 with SMTP id d21-20020aa7ce15000000b0050221482980mr4619999edv.30.1680777264707;
        Thu, 06 Apr 2023 03:34:24 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:24 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 05/11] alchemytests: Fix gcc warning in buffer-1
Date: Thu,  6 Apr 2023 12:33:35 +0200
Message-Id: <20230406103341.2914-6-aaron@sigma-star.at>
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
 testsuite/alchemytests/buffer-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/alchemytests/buffer-1.c b/testsuite/alchemytests/buffer-1.c
index d6d1d9ad72..807db1dcfe 100644
--- a/testsuite/alchemytests/buffer-1.c
+++ b/testsuite/alchemytests/buffer-1.c
@@ -49,7 +49,7 @@ static void background_task(void *arg)
 {
 	char c = 'A', s[3];
 	ssize_t ret;
-	int n = 0;
+	unsigned int n = 0;
 
 	traceobj_enter(&trobj);
 
-- 
2.35.3

