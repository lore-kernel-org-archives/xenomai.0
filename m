Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D238DE8
	for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 13:53:14 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c00df105f8so53841101fa.2
        for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695217993; x=1695822793; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1xs8t4NEM9AEbIP/mcPujuz1OoARfiarufHJA1qY7w=;
        b=ju4ukLlOu1oPkt1XnRToDpLwpSSeZRcuUGE5FkbWBERkoKQE6XwJCB23E0UUswaujL
         ofRlb9mkckRcoJJcB0zi4fX4W1rq3rR9zJwzIOrPEXeUe2kpsoLejydu6aSXeYH9FHzH
         X19u34FqbBqy1ZEoTtF+smpIOUKVGoF9tFlNSg+l8FeptwnJHsCdWkXP2gttKM8VS8Oo
         iSVzY17SOoOahCYK60QwoJt4cAOpZKDuzEzaVbU8vOZNraHLaTSSJ2R3DcAW9NZqsZ5/
         gIsB/22wIadyTgsMuX2vzRdB7/51zPtaCk8FaaGxwdFTiqmIH7MgAWuF5w1WCMi+QO5G
         mcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217993; x=1695822793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1xs8t4NEM9AEbIP/mcPujuz1OoARfiarufHJA1qY7w=;
        b=Rqg2qKymehbG+515O63VSpR6Irnw9/hKjQjdtpLdgR5/Q8myyP9Ke4i8pG0N0sY3C0
         YE2by1glAqGLXISNnSbOs3F0qZkfbnitmh5lTQe91whsMI9e/VkX1Eq/9BcB3dVDUlSY
         iOleIZTTmgRlaXAX2bwLcFgTYoqUMeWl7w5Yepjrd7LnLU2zSCVrXejrspVuHsXKyfbv
         WLVgNAmmuZkwHDrBjwYMJMWDpEX5hZTZJ/0g0ycLalfK7TbYhPLGlYFJ37KF3wN5Xp8A
         n6SRWVais4uG93Ogugf3VnhBRgrx7q2mAFlHDPVPO2p+yeMW1e7SAmZo5qLtNf271WRT
         59Ow==
X-Gm-Message-State: AOJu0YxXgeEhGyRgPVKurJ0xHpVboRKIi9cxPFotwNQwhNU0h1Z6BXm9
	tMRQ3QHoTIGhcjcR/3Lgb6H/Ap3pVUcZnSYuEqc=
X-Google-Smtp-Source: AGHT+IHO4LYHKxazaGpYuHIbVcS6RgcfDapbnLIB1MPZ8tM6MMTkH1/ZBr6SqBYQfDfxJ9oIrTODcA==
X-Received: by 2002:a2e:b2cf:0:b0:2bd:10ee:7d22 with SMTP id 15-20020a2eb2cf000000b002bd10ee7d22mr1936155ljz.51.1695217992741;
        Wed, 20 Sep 2023 06:53:12 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id mc17-20020a170906eb5100b0098733a40bb7sm9324008ejb.155.2023.09.20.06.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:53:12 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 4/5] testsuite: Merge vxworkstests in a single smokey case
Date: Wed, 20 Sep 2023 15:52:52 +0200
Message-Id: <20230920135253.5842-5-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230920135253.5842-1-aaron@sigma-star.at>
References: <901c80cc-d506-445e-add9-00aa0e536803@siemens.com>
 <20230920135253.5842-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleans up includes

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/vxworkstests/vxworkstests.c | 66 ++++++++++----------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index 183df3509..d3ac891ae 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -1,45 +1,47 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <error.h>
-#include <libgen.h>
-#include <smokey/smokey.h>
-#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
-
-#define TEST(name)								   \
-	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
-	static int run_##name(struct smokey_test *t, int argc, char *const argv[]) \
-	{									   \
-		return __run_extprog(t, argc, argv);				   \
-	}
+#include <smokey/smokey.h>
 
-static int __run_extprog(struct smokey_test *t, int argc, char *const argv[])
+static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 {
-	int ret;
-	char *tst_path;
+	int ret = 0;
+
+	char *tests[] = {
+		"vxworkstests",
+		"vxworkstests_lst1",
+		"vxworkstests_msgQ1",
+		"vxworkstests_msgQ2",
+		"vxworkstests_msgQ3",
+		"vxworkstests_rng1",
+		"vxworkstests_sem1",
+		"vxworkstests_sem2",
+		"vxworkstests_sem3",
+		"vxworkstests_sem4",
+		"vxworkstests_wd1",
+		"vxworkstests_task1",
+		"vxworkstests_task2"
+	};
 
-	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", XENO_TEST_DIR, t->name);
-	if (ret == -1)
-		return -ENOMEM;
+	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
+	{
+		int fails = 0;
 
-	ret = system(tst_path);
-	free(tst_path);
+		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t], argc, argv);
+		if (ret) {
+			fails++;
+			if (smokey_keep_going)
+				continue;
+			if (smokey_verbose_mode)
+				error(1, -ret, "test %s failed", tests[t]);
+			return 1;
+		}
+		smokey_note("%s OK", tests[t]);
+	}
 
 	return ret;
 }
+smokey_test_plugin(vxworkstests, SMOKEY_NOARGS, "Run external vxworkstests");
 
-TEST(vxworkstests)
-TEST(vxworkstests_lst1)
-TEST(vxworkstests_msgQ1)
-TEST(vxworkstests_msgQ2)
-TEST(vxworkstests_msgQ3)
-TEST(vxworkstests_rng1)
-TEST(vxworkstests_sem1)
-TEST(vxworkstests_sem2)
-TEST(vxworkstests_sem3)
-TEST(vxworkstests_sem4)
-TEST(vxworkstests_wd1)
-TEST(vxworkstests_task1)
-TEST(vxworkstests_task2)
-- 
2.35.3

