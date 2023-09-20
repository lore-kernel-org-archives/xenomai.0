Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA4636AEE
	for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 13:53:09 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so8630356a12.0
        for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695217988; x=1695822788; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy6R/BEag+NNxETtgRyidjohRhJdp+3HG7LI6dsEqiI=;
        b=gtCQ26yydygkMh2AohzE6BL0oNz9cBAvsDKjGqCW0yIolSGBLnLXfiLFvSrEHJ8RHG
         my3LY51XJd9t7hA3VMAYAn2syG817q1yUuM3E4bVyMIl0YYHAXdxuC+u4VjuoND5XF9g
         TPJ31jnXw+YDgmPX2CLuEWmPcC8jCMrY3pRi7izxUWvGkeVQ0MT2tL65sfAUIeCS3k1A
         hDBnkF6xvWZGxY0jCqWQXK97j2Caph0+Eb2siA7k21JY10wQtlOXEC7D3wF7AKvNKOE9
         RXqvt/QCfrimCvynQgYihdlsPEMxp4ZOjfVYodXbWM4t4IkZIZepVykFg4RbRz5HFPhU
         Vn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217988; x=1695822788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy6R/BEag+NNxETtgRyidjohRhJdp+3HG7LI6dsEqiI=;
        b=OekmV2x3ynzd32ENO7Y2uKliDLaOUtH30dGVmiLQMgzB8TDrwwz+zI2sgNvkgWAysQ
         yfpHcJ8tqPXl1BJMPCz0h2bV3LsY3SdjQdj17rV52+GW8nxyUiXo/X2yYzXXG5qjT3tc
         Y5bPJM7ZS5fA/J69H/CrgRIP/9KTZI0EYYuVnDx0LHE2oXU6OjiJ0kNJtH6p8qsfMVwK
         V+KC5PuA1bghm8ihoVh0j/+K+UklAeWH3lah1NMp6UKtRUaVOyf7iGcXImSetwypyrYW
         QREKvOrR8NH3LIw1IvNwowijNgVdRPS+BG+ZxEXEVgTA+B2EqO8CiT6H950LMZox6XMh
         P3JA==
X-Gm-Message-State: AOJu0YwKZtpWaso6AL3tFeObHETCFFwAJKsJSGWdEidFfLfdCvNSS9yo
	D2oRZK28czdcp7n8301EII2jV3aVqRMxuqYgM8Y=
X-Google-Smtp-Source: AGHT+IEbp0QXdQMHMReK69bi0RWKvhOvfve7m33fhG2I7qNwQEJYrTBjCH0mx70M0uHlLWknqnsPJQ==
X-Received: by 2002:a17:906:301a:b0:992:7295:61c9 with SMTP id 26-20020a170906301a00b00992729561c9mr2157692ejz.69.1695217988309;
        Wed, 20 Sep 2023 06:53:08 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id mc17-20020a170906eb5100b0098733a40bb7sm9324008ejb.155.2023.09.20.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:53:08 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 2/5] testsuite: Merge alchemytests in single smokey case
Date: Wed, 20 Sep 2023 15:52:50 +0200
Message-Id: <20230920135253.5842-3-aaron@sigma-star.at>
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

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/alchemytests.c | 85 ++++++++++----------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index 19989cc09..5753af423 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -1,55 +1,56 @@
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
+static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 {
-	int ret;
-	char *tst_path;
+	int ret = 0;
+
+	char *tests[] = {
+		"alchemytests_alarm1",
+		"alchemytests_buffer1",
+		"alchemytests_event1",
+		"alchemytests_heap1",
+		"alchemytests_heap2",
+		"alchemytests_mq1",
+		"alchemytests_mq2",
+		"alchemytests_mq3",
+		"alchemytests_mutex1",
+		"alchemytests_pipe1",
+		"alchemytests_sem1",
+		"alchemytests_sem2",
+		"alchemytests_task1",
+		"alchemytests_task2",
+		"alchemytests_task3",
+		"alchemytests_task4",
+		"alchemytests_task5",
+		"alchemytests_task6",
+		"alchemytests_task7",
+		"alchemytests_task8",
+		"alchemytests_task9",
+		"alchemytests_task10"
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
+smokey_test_plugin(alchemytests, SMOKEY_NOARGS, "Run external alchemytests");
 
-TEST(alchemytests)
-TEST(alchemytests_alarm1)
-TEST(alchemytests_buffer1)
-TEST(alchemytests_event1)
-TEST(alchemytests_heap1)
-TEST(alchemytests_heap2)
-TEST(alchemytests_mq1)
-TEST(alchemytests_mq2)
-TEST(alchemytests_mq3)
-TEST(alchemytests_mutex1)
-TEST(alchemytests_pipe1)
-TEST(alchemytests_sem1)
-TEST(alchemytests_sem2)
-TEST(alchemytests_task1)
-TEST(alchemytests_task2)
-TEST(alchemytests_task3)
-TEST(alchemytests_task4)
-TEST(alchemytests_task5)
-TEST(alchemytests_task6)
-TEST(alchemytests_task7)
-TEST(alchemytests_task8)
-TEST(alchemytests_task9)
-TEST(alchemytests_task10)
-- 
2.35.3

