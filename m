Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6318659
	for <xenomai@lists.linux.dev>; Thu,  2 Nov 2023 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="P5dRrTNH"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20231102144144bf2d6204763508cdb2
        for <xenomai@lists.linux.dev>;
        Thu, 02 Nov 2023 15:41:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4TwCVhXtHw1ajvOpRZZsWBrpNOZc+Q+i/Docdmbr0nI=;
 b=P5dRrTNHKp8VfrKDLiktL0iLG4AcHpkACBlZBlOF7LGQxpLEEuPCl+6aGDDpUmq37KU1Cn
 n/yXSgdD9Icf84zcN3p5C4PChD3DXDP6t57ZmpZqLfCTsNCKnoGVDP12GBKtbbxu7wVgbWAh
 obIRBLEi5x+KgXVWSOOnqq6NF9e0w=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 02 Nov 2023 15:41:43 +0100
Subject: [PATCH 2/6] testsuite: smokey: Refactor smokey_run_extprog()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-flo-cleanup-testsuite-v1-2-0fb7bbd2d45f@siemens.com>
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
In-Reply-To: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

smokey_run_extprog() and all affected call sights had the following
problems:

  - There is already a variable named t, so the loop variables were
    shadowing an existing variable (did no harm but triggered a warning
    of my linter)

  - The combination of --verbose and --keep-going was broken
    --verbose stopped the test run due to error() usage.

  - The reporting of the test result was broken. If a failing test was
    followed by a successful one the failure was never reported.

  - There was duplicated code at all call sights with the same problems
    mentioned above and an unused variable (fails)

  - Checkpatch complained that the test list should move out of the
    function and that it should be static.

All users of smokey_run_extprog()
  - should abort the execution / the test run when the return code is
    non zero
  - should use the value of the last parameter for error reporting.
    An error happened when the value is non zero.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/smokey/smokey.h                      |   3 +-
 lib/smokey/helpers.c                         |  14 +++-
 testsuite/smokey/alchemytests/alchemytests.c |  74 +++++++++----------
 testsuite/smokey/psostests/psostests.c       | 103 ++++++++++++---------------
 testsuite/smokey/vxworkstests/vxworkstests.c |  57 +++++++--------
 5 files changed, 118 insertions(+), 133 deletions(-)

diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
index 3623ba18c..0c20f5d69 100644
--- a/include/smokey/smokey.h
+++ b/include/smokey/smokey.h
@@ -259,7 +259,8 @@ int smokey_modprobe(const char *name, bool silent);
 
 int smokey_rmmod(const char *name);
 
-int smokey_run_extprog(const char *dir, const char *name, const char *args);
+int smokey_run_extprog(const char *dir, const char *name, const char *args,
+		       int *test_ret);
 
 #ifdef __cplusplus
 }
diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index 4c90a513d..bc4b3f9bb 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -411,10 +411,11 @@ int smokey_rmmod(const char *name)
 	return err;
 }
 
-int smokey_run_extprog(const char *dir, const char *name, const char *args)
+int smokey_run_extprog(const char *dir, const char *name, const char *args,
+		       int *test_ret)
 {
-	int ret;
 	char *tst_path;
+	int ret;
 
 	ret = asprintf(&tst_path, "%s/%s %s", dir, name, args ? : "");
 	if (ret == -1)
@@ -423,5 +424,12 @@ int smokey_run_extprog(const char *dir, const char *name, const char *args)
 	ret = system(tst_path);
 	free(tst_path);
 
-	return ret;
+	*test_ret = ret;
+
+	if (ret)
+		smokey_note("test %s failed: %d", name, ret);
+	else
+		smokey_note("%s OK", name);
+
+	return smokey_keep_going ? 0 : ret;
 }
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index b9e84ac1e..e3454074d 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -5,50 +5,44 @@
 #include <string.h>
 #include <smokey/smokey.h>
 
+static const char * const tests[] = {
+	"alchemytests_alarm1",
+	"alchemytests_buffer1",
+	"alchemytests_event1",
+	"alchemytests_heap1",
+	"alchemytests_heap2",
+	"alchemytests_mq1",
+	"alchemytests_mq2",
+	"alchemytests_mq3",
+	"alchemytests_mutex1",
+	"alchemytests_pipe1",
+	"alchemytests_sem1",
+	"alchemytests_sem2",
+	"alchemytests_task1",
+	"alchemytests_task2",
+	"alchemytests_task3",
+	"alchemytests_task4",
+	"alchemytests_task5",
+	"alchemytests_task6",
+	"alchemytests_task7",
+	"alchemytests_task8",
+	"alchemytests_task9",
+	"alchemytests_task10"
+};
+
 static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 {
+	int test_ret = 0;
 	int ret = 0;
+	int tmp;
 
-	char *tests[] = {
-		"alchemytests_alarm1",
-		"alchemytests_buffer1",
-		"alchemytests_event1",
-		"alchemytests_heap1",
-		"alchemytests_heap2",
-		"alchemytests_mq1",
-		"alchemytests_mq2",
-		"alchemytests_mq3",
-		"alchemytests_mutex1",
-		"alchemytests_pipe1",
-		"alchemytests_sem1",
-		"alchemytests_sem2",
-		"alchemytests_task1",
-		"alchemytests_task2",
-		"alchemytests_task3",
-		"alchemytests_task4",
-		"alchemytests_task5",
-		"alchemytests_task6",
-		"alchemytests_task7",
-		"alchemytests_task8",
-		"alchemytests_task9",
-		"alchemytests_task10"
-	};
-
-	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
-	{
-		int fails = 0;
-
-		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t],
-					 "--cpu-affinity=0");
-		if (ret) {
-			fails++;
-			if (smokey_keep_going)
-				continue;
-			if (smokey_verbose_mode)
-				error(1, -ret, "test %s failed", tests[t]);
-			return 1;
-		}
-		smokey_note("%s OK", tests[t]);
+	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
+					 "--cpu-affinity=0", &test_ret);
+		if (test_ret)
+			ret = test_ret; /* Return the last failed test result */
+		if (tmp)
+			break;
 	}
 
 	return ret;
diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index e35dd82c5..27896d8fa 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -1,67 +1,58 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <error.h>
-#include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 #include <smokey/smokey.h>
 
+static const char * const tests[] = {
+	"psostests_mq1",
+	"psostests_mq2",
+	"psostests_mq3",
+	"psostests_pt1",
+	// 0"000.679| BUG in __traceobj_assert_failed(): [rn1] trace assertion failed:
+	// testsuite/psostests/rn-1.c:46
+	// => "ret == 0"
+	//"psostests_rn1"
+	"psostests_sem1",
+	"psostests_sem2",
+	"psostests_task1",
+	// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
+	//		../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
+	//"psostests_task2",
+	"psostests_task3",
+	"psostests_task4",
+	"psostests_task5",
+	// 0"011.370| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
+	//		testsuite/psostests/task-6.c:62
+	// => "ret == 0 && oldprio == myprio"
+	//"psostests_task6",
+	"psostests_task7",
+	// Runs forever (100% CPU)
+	//"psostests_task8"
+	// 0"002.198| WARNING: [main] lack of resources for core thread, EBUSY
+	// 0"003.421| BUG in __traceobj_assert_failed(): [root] trace assertion failed:
+	//	   ../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-9.c:29 => "ret == 0"
+	//"psostests_task9",
+	"psostests_tm1",
+	"psostests_tm2",
+	"psostests_tm3",
+	"psostests_tm4",
+	"psostests_tm5",
+	"psostests_tm6",
+	"psostests_tm7"
+};
+
 static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 {
+	int test_ret = 0;
 	int ret = 0;
+	int tmp;
 
-	char *tests[] = {
-		"psostests_mq1",
-		"psostests_mq2",
-		"psostests_mq3",
-		"psostests_pt1",
-		// 0"000.679| BUG in __traceobj_assert_failed(): [rn1] trace assertion failed:
-		// testsuite/psostests/rn-1.c:46
-		// => "ret == 0"
-		//"psostests_rn1"
-		"psostests_sem1",
-		"psostests_sem2",
-		"psostests_task1",
-		// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
-		//		../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
-		//"psostests_task2",
-		"psostests_task3",
-		"psostests_task4",
-		"psostests_task5",
-		// 0"011.370| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
-		//		testsuite/psostests/task-6.c:62
-		// => "ret == 0 && oldprio == myprio"
-		//"psostests_task6",
-		"psostests_task7",
-		// Runs forever (100% CPU)
-		//"psostests_task8"
-		// 0"002.198| WARNING: [main] lack of resources for core thread, EBUSY
-		// 0"003.421| BUG in __traceobj_assert_failed(): [root] trace assertion failed:
-		//	   ../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-9.c:29 => "ret == 0"
-		//"psostests_task9",
-		"psostests_tm1",
-		"psostests_tm2",
-		"psostests_tm3",
-		"psostests_tm4",
-		"psostests_tm5",
-		"psostests_tm6",
-		"psostests_tm7"
-	};
-
-	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
-	{
-		int fails = 0;
-
-		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t],
-					 "--cpu-affinity=0");
-		if (ret) {
-			fails++;
-			if (smokey_keep_going)
-				continue;
-			if (smokey_verbose_mode)
-				error(1, -ret, "test %s failed", tests[t]);
-			return 1;
-		}
-		smokey_note("%s OK", tests[t]);
+	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
+					 "--cpu-affinity=0", &test_ret);
+		if (test_ret)
+			ret = test_ret; /* Return the last failed test result */
+		if (tmp)
+			break;
 	}
 
 	return ret;
diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index f7974cb5d..298bb3d1d 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -1,44 +1,35 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <error.h>
-#include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 #include <smokey/smokey.h>
 
+static const char * const tests[] = {
+	"vxworkstests_lst1",
+	"vxworkstests_msgQ1",
+	"vxworkstests_msgQ2",
+	"vxworkstests_msgQ3",
+	"vxworkstests_rng1",
+	"vxworkstests_sem1",
+	"vxworkstests_sem2",
+	"vxworkstests_sem3",
+	"vxworkstests_sem4",
+	"vxworkstests_wd1",
+	"vxworkstests_task1",
+	"vxworkstests_task2",
+};
+
 static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 {
+	int test_ret = 0;
 	int ret = 0;
+	int tmp;
 
-	char *tests[] = {
-		"vxworkstests_lst1",
-		"vxworkstests_msgQ1",
-		"vxworkstests_msgQ2",
-		"vxworkstests_msgQ3",
-		"vxworkstests_rng1",
-		"vxworkstests_sem1",
-		"vxworkstests_sem2",
-		"vxworkstests_sem3",
-		"vxworkstests_sem4",
-		"vxworkstests_wd1",
-		"vxworkstests_task1",
-		"vxworkstests_task2"
-	};
-
-	for (size_t t = 0; t < sizeof(tests) / sizeof(tests[0]); t++)
-	{
-		int fails = 0;
-
-		ret = smokey_run_extprog(XENO_TEST_DIR, tests[t],
-					 "--cpu-affinity=0");
-		if (ret) {
-			fails++;
-			if (smokey_keep_going)
-				continue;
-			if (smokey_verbose_mode)
-				error(1, -ret, "test %s failed", tests[t]);
-			return 1;
-		}
-		smokey_note("%s OK", tests[t]);
+	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
+					 "--cpu-affinity=0", &test_ret);
+		if (test_ret)
+			ret = test_ret; /* Return the last failed test result */
+		if (tmp)
+			break;
 	}
 
 	return ret;

-- 
2.39.2

