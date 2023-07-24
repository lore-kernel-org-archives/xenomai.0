Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF03BA47
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 13:52:58 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso6526457e87.1
        for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690206777; x=1690811577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2tdJw75Ts4gCdVzjLnyrB8gmBNg/Xm5slKYV2C+wpk=;
        b=Kneo0FshftMSY1n51AeIrRjOwRJYHKovAj2eieq7QlPh2/CVMiU1RMohMQe2qQBeVW
         A09JlCUc8QgQa3SRxDb+bhKgAtf8AzfEj0ZaNHUT1vTqN+dgnZixHmzwyhO5ikZm0xOa
         xNaccQNqDeACBUgCoy3nW7NOYbyOJeWWAy+tJaf7pYuX3ra34tMsLyF6AWkG1UJ098Jh
         xFOOBXXqeCxFCJ1jyJrZhRPZnTYmBKwnt7U6BVFE49/up8RU3qmNw/RX5KKFPYflhtAd
         +RrwtNNd2Elr3gRxX83AqmIho2d5DkTGiBwSf1uvo+DaBOxnoEEuf7p2mqs2f9suhpIv
         KNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206777; x=1690811577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2tdJw75Ts4gCdVzjLnyrB8gmBNg/Xm5slKYV2C+wpk=;
        b=STIAB1CIbo7lz78l6a0VaBswANFrMd1M60Zq00o16gVphtBVNGq1sgcl6HwAmWKnQP
         ylH1KfDmKdwXBcESSX/o1X+0pyoSziA0/xm0byiQdzRhzwobnrNJXYiEnMlooJG5/Y+y
         r2+XKk31PWIju8Tf+XT2YxuuuOmjIDspaYgyXCfKJBvS+kQW6cfCO3+itRcowTr4X+cJ
         rmUSc3EenAnjkLkBHOzjaoD/l16EqLR6zvA+7nZpSCNHVV/5C0wavK5Za89e/uVgQEDp
         igfaCYtyRQQc+MsKjru76oDbDhF44o/dd5EhSvWuKsIEaL4JMWVj9etbHwxVudyWGKaH
         dPnw==
X-Gm-Message-State: ABy/qLb7CRt4Ij7i9ZaErH6QhaB2vuL1/SH7AXVrxlXXUWar6RGBYNMp
	g+iClQD8tDnrB0Giv8sWSagk3rVNtBIH9u+tRBI=
X-Google-Smtp-Source: APBJJlH6+YCJALTy10matyhfePP5DrxxovX+Vp5NLpQ+Fj41xsr/dJ1uquCuHP+8R5RglX07iE0aew==
X-Received: by 2002:a19:914d:0:b0:4f8:77f1:299a with SMTP id y13-20020a19914d000000b004f877f1299amr4968021lfj.42.1690206776826;
        Mon, 24 Jul 2023 06:52:56 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7cd42000000b0051bed498851sm6239100edw.54.2023.07.24.06.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:52:56 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 05/10] alchemytests: Fix gcc warning in buffer-1
Date: Mon, 24 Jul 2023 15:52:34 +0200
Message-Id: <20230724135239.10579-6-aaron@sigma-star.at>
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

