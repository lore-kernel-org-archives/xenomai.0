Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43891C8E5
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 13:53:00 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fb7589b187so6499326e87.1
        for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690206778; x=1690811578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E12tIPWQZobmS9Ba1mxCBzhoG5gC91Qrn4LIKrnywm8=;
        b=geyc1cGs9UDPdM7S9qxkrL2V/hbhxms85srX1K4dUlK2X1nFU01urOXMXEEmbMr2Kf
         rii4Fu6xxIwpcCoUWeDS5GkGvoJOWW5rlsHiTa8gyickJTa2P7R3PWc1OZ3Xz0ax8CQC
         Qk+St8zKOeWp6l6KbqJ2zZI1W0p/X0qGk0PivaF+8zZZiw6kgxuQnEImVOIB7Q16xOui
         pMIkl5r9DjZ16nAZNWPPE02HWHrfk7QKRJmHT8LqsNTsn5BcPz6/cGI1FqIPR2qsdx0I
         nqhQm2WUHcgC7exUjij6yc3t81RLMMbnAwBdiyJuxOl168xr4EXal5CdLiJUvgLE+CMb
         8I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206778; x=1690811578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E12tIPWQZobmS9Ba1mxCBzhoG5gC91Qrn4LIKrnywm8=;
        b=UZDbyzf/6Yv0rMmpaMIn17gCxQnUm7E/3kAoTCPHB5vQOS9gkvpquR0f0ZGz9Abz3O
         vL0YI158Kew79b8TYmqBa17rT0DVbWlN4/KD7lq/l0/N0FJc4zPkQ+W3j1s9LxTm54kw
         tapNANunl83sj+03sHc4w0J12jXG0gDCPVmYinVIrzb5ojjzaSihQbce/zTQyee4aZXg
         wesEIDHBnE3prv3EZnhDOx1SGbt+r3AXmvCxKkVvJwr1g3+PRwTOMmL81o+ZnnhUkFUL
         XvtQ2NG2cmHEEH1FRuG41nroNC+Ru2szQhT4rFoz809ELQgYvii1tvnLsGu67/Hi0rEH
         waJQ==
X-Gm-Message-State: ABy/qLabnGaiFpouBNw4UFClpcuOZOd3Od2Oo3hKwEN3KrMxq912VSej
	30TQH2bOgFWItIeLEco2etVnqypqd+1ABUW3pGU=
X-Google-Smtp-Source: APBJJlEQ9asYQkMJ5DDMirndXstgk2zw1CBA8X4hm7OHuus0LPWvZvD7kv+VqbFqIVoZUdbLbjlxfQ==
X-Received: by 2002:a05:6512:31ca:b0:4fd:d078:2e3f with SMTP id j10-20020a05651231ca00b004fdd0782e3fmr5477009lfe.42.1690206778287;
        Mon, 24 Jul 2023 06:52:58 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7cd42000000b0051bed498851sm6239100edw.54.2023.07.24.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:52:57 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 07/10] alchemytests: Check pipe-1 asprintf ret value
Date: Mon, 24 Jul 2023 15:52:36 +0200
Message-Id: <20230724135239.10579-8-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230724135239.10579-1-aaron@sigma-star.at>
References: <20230720145150.24607-1-aaron@sigma-star.at>
 <20230724135239.10579-1-aaron@sigma-star.at>
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

