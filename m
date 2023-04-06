Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEA9321D
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:28 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9476e2fa157so100609266b.3
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtqQwc+IUXYq8OrwecYBW2jC6rLV4kxBRkxaIyhtthY=;
        b=oLyxyilB8dRvov6DELvuH05/8s/G7JDu2U+qbL1Ow5Oq4sfXMe6PTpBZx3mKBXBKsz
         9JyilovtvPxBI95iYCGmHSAvSBNSqlk6ibcf5X4bhznPyxrDIq9NNUjhWcOrtIObOoIy
         iOIC6Y4NNfi0XFb3AyDEYSFZDmhVS59VGUjn0C9jDxw5SXJx/FLa3WZrTB1J03d+maNA
         7y6brgdBd6xNVHsxSLXwmZRecrvdJwRuCbAU7yGdnrt9efyvxsgGB9nbIglxepEcl86n
         HO2oL3ANAN8Vcy7jR7Kb58HEavbCZYJVB+pS+sb8zvqFjdgLV8GbCt4NeCoDJ4L/SlKr
         2h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtqQwc+IUXYq8OrwecYBW2jC6rLV4kxBRkxaIyhtthY=;
        b=6jCZeL/GJyt+oCCeIns1+ariHDd0y+hAstaCPzK02qnQltw3Lrya8tA0G7gmMErzRi
         Ze74iMTj1CDs1ZA+bmJaDdE64lbjJCMrk3oLgARsadKxFabfALxYNfDVs6ORIiWLG2ri
         AUyo/3AB0QAlXBzYdxfFmEJyYDt2rue4M1Z2sorEj02hg1gfxsaquo5uViatbMvJD765
         7FaVGMRZm/VNOQmATNahAAPuwiKJ2gC12rlA55k1Ez8RXogV4jLoZc9qjbo1k/Gc2GdV
         gekkC0hLxrrmPqfPVXlxGAOeoh8CEc3SNJohBdCqJ0iOmJWL2pHCwe79CJFFta1PKRE1
         UBbw==
X-Gm-Message-State: AAQBX9d/0H1Dufh0p1o2QjMzH8dY0QyFqjGeMMFTIHVRP8tlpF30+Pzz
	DJE0fgB1U5V2hrVdUYV+HUje5GVObp7vc4RZmQ4=
X-Google-Smtp-Source: AKy350YDKbX+mPsudNm1eNKULeO32YNsTsBJP9e4LE49bYVcHU9mAg+HzH8oga0yUId3WvR1VqnZdw==
X-Received: by 2002:a05:6402:216:b0:4fb:ec6a:2357 with SMTP id t22-20020a056402021600b004fbec6a2357mr4327422edv.34.1680777268191;
        Thu, 06 Apr 2023 03:34:28 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:28 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 10/11] alchemytests: check pipe-1 asprintf ret value
Date: Thu,  6 Apr 2023 12:33:40 +0200
Message-Id: <20230406103341.2914-11-aaron@sigma-star.at>
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

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/alchemytests/pipe-1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testsuite/alchemytests/pipe-1.c b/testsuite/alchemytests/pipe-1.c
index 4202be2bac..da5fbf999f 100644
--- a/testsuite/alchemytests/pipe-1.c
+++ b/testsuite/alchemytests/pipe-1.c
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

