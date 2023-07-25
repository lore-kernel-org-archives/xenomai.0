Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07715487
	for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 08:30:09 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-991fe70f21bso835124166b.3
        for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690273807; x=1690878607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E12tIPWQZobmS9Ba1mxCBzhoG5gC91Qrn4LIKrnywm8=;
        b=pLT7L1zKaSI1oZQEPT5jsMS9mVnmdurDb8hB4QJZcOLu2GNcedDv7LmtJ0W+U+QGEo
         Ec0cXMZDQBIrgVvR+E20VK7xnplFCw7eUjlDeZzC7Pz1zT9JQhFve3fMDIbGxyuMKjBI
         a+BKqJG8csP03z0gCKZMzSBEKR9Tmr0SJrrKRx8xwDyljzUHIfq9vsDILBuPWw/jNcZJ
         fogyOJYS7TeLeBrStjquJQoM8UHtQoTdTCzo+eNmTGqvkE521vSaOLFfo+jM1cAV3VJV
         PTVRyCw96oRCMc6e7ZgteYaWMdMmjn2FHBNbrJfL4CWaR9tugBoLKwmTzu6zxNlhNnwP
         g9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273807; x=1690878607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E12tIPWQZobmS9Ba1mxCBzhoG5gC91Qrn4LIKrnywm8=;
        b=cGbn7p9qAJvdunI4fglQ/KLBpEP0gJRZmi2cEYqxBVlfoxsaugSJ2ULJVG4xCMYY59
         emGe29cQWB3CZlhDOtsvkpgEJG188BYXBmOiFLawP9iYXWpAEW4JThZT7O/jzKMqmrHF
         tCPcoA5R+HhaXGYx1fuoxdgv+h1T7G9XuG+3LHIdXOywtvVOii+7X0rynQQClJEF+hsR
         ee2K5+BHw1npIZ3MaroUyNiwyoatxTTuLaWmYnBoxdARimBozSsVf2Vn0QKohLYCgfCT
         eGbt07o+QTaoUErapzCgJpcbLxPf+i2YbUC6kk3BaHJb0z/4FFfWEHsVkLLv8vBc++17
         qS1w==
X-Gm-Message-State: ABy/qLa1Lh9H22hEYYYc0kCgHdk6bJ+d9RR3l2iGi/7MgKaCSFamat8I
	MssWMs1hOvrtWBG/EiX/yVfynGHwwxexajPdXmE=
X-Google-Smtp-Source: APBJJlEDBueyxjeTvHY4JyQ590tru34M+jHTAoXRFJzeyR4fT4mvKlMpzPOUb4eMXZAPfX8qPm7ijw==
X-Received: by 2002:a17:906:2253:b0:973:d1ce:dbe8 with SMTP id 19-20020a170906225300b00973d1cedbe8mr12138858ejr.46.1690273807847;
        Tue, 25 Jul 2023 01:30:07 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm7752080eja.121.2023.07.25.01.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:07 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 07/10] alchemytests: Check pipe-1 asprintf ret value
Date: Tue, 25 Jul 2023 10:29:56 +0200
Message-Id: <20230725082959.5144-8-aaron@sigma-star.at>
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

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/pipe-1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/alchemytests/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
index 4011f9c8a..488c0ee3b 100644
--- a/testsuite/smokey/alchemytests/pipe-1.c
+++ b/testsuite/smokey/alchemytests/pipe-1.c
@@ -49,11 +49,13 @@ static void realtime_task(void *arg)
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

