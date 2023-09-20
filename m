Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF338DEA
	for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 13:53:11 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9a64619d8fbso915712066b.0
        for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695217989; x=1695822789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnWtuRkzJWj0w35dUrDcuNna9o00bcPjEz88O0MP2MY=;
        b=WOnHzGMCUSQ9KTz1kUcIUEfQ7jkUa3VcTXzRFOwVdWFVFRn46SnSlz/QM6XxAVGyo8
         Y0NRKkSxe5Pz2di0GkFZjATh34RsWKWu8jZpLq5Zhpk/isDcXTwIWSQLa+kWIF8pnveW
         2CY/3kjebk1hI+/BPRY9MD7e1rOv68RJh4u+jbpoyyFMqvADCK8sF0sRBrk9SzNLswNJ
         XHqcHWcLAERzfuNrKUARDQ4RY9vE/xthaACjBSAdkclbWWu6kj8/NrZBVlSRZ3XhvkJx
         QijeKIsQ64gMbETfH2Cfk8S3T0QlNaferBCleOTyfZ/8X85kY8j+h491mLuutKDh4K95
         rpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217989; x=1695822789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnWtuRkzJWj0w35dUrDcuNna9o00bcPjEz88O0MP2MY=;
        b=TfAxRD7Vrdmvak15MGNDHOHPUicniUNn6/DjBFqJxkrSz8LHM8v15MCSRZFUJW07k/
         UC5znMYb4CgoK20sQr9dQ1TMhKKyYm6udK4/X1guNFdlNkVUN6V9iv/azS9gbaBcIfmQ
         66np8rDZL1IiDGC95KX2YMA7JsfYAzQOaD/hBdT2SyUuQpPIxKFVxOimvZF5Af86/LQP
         T9H+orTrC3QwKHu5VWG30TmQ8/kxEPFCsmzOoZPTsWWiVTz/DLoOj+Q07RlEl3Fh3kOL
         ZCwa7sLilZfW2sdcJWJshLXs77+rPbI78A4dlRxiM0SErs5CzDsNFMWIj4Qd2XE33Suh
         0paA==
X-Gm-Message-State: AOJu0YxNYD8UZO0jkv5xW1tDehM0iIqQA4CZ9uBQKO28pPzzhB05zpx0
	XvtW8X7bcoJdUt2OhDG2Cp7SczGRnBW8IMdd/dk=
X-Google-Smtp-Source: AGHT+IGAgpfj64bFHI35Lc755h+B2Z7q9dwfArOlabzuv61InQw9Y6PTYe+qkZM6auW7jZK8Ra3jUw==
X-Received: by 2002:a17:907:6087:b0:99e:1201:48bc with SMTP id ht7-20020a170907608700b0099e120148bcmr2118614ejc.64.1695217989717;
        Wed, 20 Sep 2023 06:53:09 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id mc17-20020a170906eb5100b0098733a40bb7sm9324008ejb.155.2023.09.20.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:53:09 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 3/5] testsuite: Merge psostests in a single smokey case
Date: Wed, 20 Sep 2023 15:52:51 +0200
Message-Id: <20230920135253.5842-4-aaron@sigma-star.at>
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
 testsuite/smokey/psostests/psostests.c | 111 +++++++++++++------------
 1 file changed, 56 insertions(+), 55 deletions(-)

diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index 13397894d..a54e6ea31 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -1,68 +1,69 @@
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
+static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 {
-	int ret;
-	char *tst_path;
+	int ret = 0;
+
+	char *tests[] = {
+		"psostests_mq1",
+		"psostests_mq2",
+		"psostests_mq3",
+		"psostests_pt1",
+		// 0"000.679| BUG in __traceobj_assert_failed(): [rn1] trace assertion failed:
+		// testsuite/psostests/rn-1.c:46
+		// => "ret == 0"
+		//"psostests_rn1"
+		"psostests_sem1",
+		"psostests_sem2",
+		"psostests_task1",
+		// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
+		//		../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
+		//"psostests_task2",
+		"psostests_task3",
+		"psostests_task4",
+		"psostests_task5",
+		// 0"011.370| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
+		//		testsuite/psostests/task-6.c:62
+		// => "ret == 0 && oldprio == myprio"
+		//"psostests_task6",
+		"psostests_task7",
+		// Runs forever (100% CPU)
+		//"psostests_task8"
+		// 0"002.198| WARNING: [main] lack of resources for core thread, EBUSY
+		// 0"003.421| BUG in __traceobj_assert_failed(): [root] trace assertion failed:
+		//	   ../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-9.c:29 => "ret == 0"
+		//"psostests_task9",
+		"psostests_tm1",
+		"psostests_tm2",
+		"psostests_tm3",
+		"psostests_tm4",
+		"psostests_tm5",
+		"psostests_tm6",
+		"psostests_tm7"
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
+smokey_test_plugin(psostests, SMOKEY_NOARGS, "Run external psostests");
 
-TEST(psostests)
-TEST(psostests_mq1)
-TEST(psostests_mq2)
-TEST(psostests_mq3)
-TEST(psostests_pt1)
-// 0"000.679| BUG in __traceobj_assert_failed(): [rn1] trace assertion failed:
-//            testsuite/psostests/rn-1.c:46
-// => "ret == 0"
-//TEST(psostests_rn1)
-TEST(psostests_sem1)
-TEST(psostests_sem2)
-TEST(psostests_task1)
-// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
-//            ../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
-//TEST(psostests_task2)
-TEST(psostests_task3)
-TEST(psostests_task4)
-TEST(psostests_task5)
-// 0"011.370| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
-//            testsuite/psostests/task-6.c:62
-// => "ret == 0 && oldprio == myprio"
-// TEST(psostests_task6)
-TEST(psostests_task7)
-// runs forever (100% CPU)
-//TEST(psostests_task8)
-// 0"002.198| WARNING: [main] lack of resources for core thread, EBUSY
-// 0"003.421| BUG in __traceobj_assert_failed(): [root] trace assertion failed:
-//           ../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-9.c:29 => "ret == 0"
-//TEST(psostests_task9)
-TEST(psostests_tm1)
-TEST(psostests_tm2)
-TEST(psostests_tm3)
-TEST(psostests_tm4)
-TEST(psostests_tm5)
-TEST(psostests_tm6)
-TEST(psostests_tm7)
-- 
2.35.3

