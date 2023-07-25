Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3D14AB6
	for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 08:30:08 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-992b66e5affso882305766b.3
        for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690273806; x=1690878606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2tdJw75Ts4gCdVzjLnyrB8gmBNg/Xm5slKYV2C+wpk=;
        b=f6c8oy4LaMfMzsspA5d6UcMqmq5fLhEsICOVILOK+6bfYcB9yWIb3XJopdVCQ2L9Dp
         jYcheI2nqfrfIIYZScK3jM0S4Ao88e//WiCroo6nEbdw4510aIV8O4ezysZasfhgqYJU
         oBsk9Uup2jFFRHv0V+SQOhqLgDQ+xAiAx3nNIOYKeOtlD7ix+9WbwWBMBlpwrSFOC3gy
         ravZ43auqPiL0KYFwQG9X+sFY3juMvgPOOSxJjX/xTJh6iK94QdQyWQ/r5JuIdJGZFM0
         999LbPG5UX1xuQYtvLZRvaDHys88E4wXYGejjOYld7n6ULL6sSS0139hkDSRKsaF16ca
         rDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273806; x=1690878606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2tdJw75Ts4gCdVzjLnyrB8gmBNg/Xm5slKYV2C+wpk=;
        b=gkaNPm6GrkUlHVZW38Cc4sAeN2K/96MCiauXXd21oyqRkng9En86iPrmV/VRnw1nbf
         7TKiIcc1hIJeCieSZKLUOmLK9gnnu6J5zdpDfB+YAqt25zrNX0PUTCzFz2Whw7M05W1O
         7JA0wOkLmYY+J9kPBIdwC2vRABOSgwQVCWg7VUnQzCsdpAS/vVktTjXnrNuH3+jFpCQA
         WKGY6Q54N0s2h3WwkDHS/Sd2P94DE1Y85mjAbPYNFu28T08LnTETvDq6zKgUzFa1rRao
         DF2AbEozc0gZwlGnmQuYxt+iBxXSwBZ6WErgXwsK8tIB8rmWuXb1rb841KqX+c4aOy6n
         rg1Q==
X-Gm-Message-State: ABy/qLaKa+y60tvYVX/alKU3LC+8hAU/f3ovOuTGcQiinmmuKk5ebjhw
	yzBDHOvG1xD95uD5rS4fN2jZV1HdXE+QK/8Xqso=
X-Google-Smtp-Source: APBJJlGu/ov0nAGa4X4ndm/7L+ZbG9GHd7F0H5CwjROizV8e4+jEDXRLYxRTxCDjC1bt8hU0hMsI7w==
X-Received: by 2002:a17:906:31d2:b0:994:3037:c1f with SMTP id f18-20020a17090631d200b0099430370c1fmr12377302ejf.24.1690273806582;
        Tue, 25 Jul 2023 01:30:06 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm7752080eja.121.2023.07.25.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:06 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 05/10] alchemytests: Fix gcc warning in buffer-1
Date: Tue, 25 Jul 2023 10:29:54 +0200
Message-Id: <20230725082959.5144-6-aaron@sigma-star.at>
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
index fdcb5e8d7..008797827 100644
--- a/testsuite/smokey/alchemytests/buffer-1.c
+++ b/testsuite/smokey/alchemytests/buffer-1.c
@@ -50,7 +50,7 @@ static void background_task(void *arg)
 {
 	char c = 'A', s[3];
 	ssize_t ret;
-	int n = 0;
+	unsigned int n = 0;
 
 	traceobj_enter(&trobj);
 
-- 
2.35.3

