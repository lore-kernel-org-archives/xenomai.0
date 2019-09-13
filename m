From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 03/11] drivers: Remove unneeded realtime_core_enabled checks
Date: Fri, 13 Sep 2019 15:18:52 +0200
Message-Id: <ee8d1da55cba6c0b741ce190276a55b1effd316f.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

It's not a good idea to load a driver module without functionality when
the core is not available. Better fail with an error code so that the
user gets proper feedback.

In several cases, this makes the existing realtime_core_enabled checks
obviously superfluous because rtdm_dev_register already performs it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/autotune/autotune.c  | 6 ------
 kernel/drivers/gpiopwm/gpiopwm.c    | 3 ---
 kernel/drivers/testing/heapcheck.c  | 3 ---
 kernel/drivers/testing/rtdmtest.c   | 3 ---
 kernel/drivers/testing/switchtest.c | 6 ------
 kernel/drivers/testing/timerbench.c | 6 ------
 6 files changed, 27 deletions(-)

diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune/autotune.c
index 77ec9a1a21..e0420aa0e1 100644
--- a/kernel/drivers/autotune/autotune.c
+++ b/kernel/drivers/autotune/autotune.c
@@ -784,17 +784,11 @@ static struct rtdm_device device = {
 
 static int __init autotune_init(void)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
 	return rtdm_dev_register(&device);
 }
 
 static void __exit autotune_exit(void)
 {
-	if (!realtime_core_enabled())
-		return;
-
 	rtdm_dev_unregister(&device);
 }
 
diff --git a/kernel/drivers/gpiopwm/gpiopwm.c b/kernel/drivers/gpiopwm/gpiopwm.c
index 114afa7583..ed42e08731 100644
--- a/kernel/drivers/gpiopwm/gpiopwm.c
+++ b/kernel/drivers/gpiopwm/gpiopwm.c
@@ -272,9 +272,6 @@ static int __init __gpiopwm_init(void)
 {
 	int i, ret;
 
-	if (!realtime_core_enabled())
-		return -ENODEV;
-
 	for (i = 0; i < ARRAY_SIZE(device); i++) {
 		ret = rtdm_dev_register(device + i);
 		if (ret)
diff --git a/kernel/drivers/testing/heapcheck.c b/kernel/drivers/testing/heapcheck.c
index bed5a05a6f..447cc13fec 100644
--- a/kernel/drivers/testing/heapcheck.c
+++ b/kernel/drivers/testing/heapcheck.c
@@ -500,9 +500,6 @@ static struct rtdm_device heapcheck_device = {
 
 static int __init heapcheck_init(void)
 {
-	if (!realtime_core_enabled())
-		return -ENODEV;
-
 	return rtdm_dev_register(&heapcheck_device);
 }
 
diff --git a/kernel/drivers/testing/rtdmtest.c b/kernel/drivers/testing/rtdmtest.c
index bd1ae6b4d5..6abf76b567 100644
--- a/kernel/drivers/testing/rtdmtest.c
+++ b/kernel/drivers/testing/rtdmtest.c
@@ -265,9 +265,6 @@ static int __init rtdm_test_init(void)
 {
 	int i, ret;
 
-	if (!realtime_core_enabled())
-		return -ENODEV;
-
 	for (i = 0; i < ARRAY_SIZE(device); i++) {
 		ret = rtdm_dev_register(device + i);
 		if (ret)
diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index 3a2e0d5a08..d955c2b65f 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -738,9 +738,6 @@ static struct rtdm_device device = {
 
 int __init __switchtest_init(void)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
 	fp_features = fp_detect();
 
 	return rtdm_dev_register(&device);
@@ -748,9 +745,6 @@ int __init __switchtest_init(void)
 
 void __switchtest_exit(void)
 {
-	if (!realtime_core_enabled())
-		return;
-
 	rtdm_dev_unregister(&device);
 }
 
diff --git a/kernel/drivers/testing/timerbench.c b/kernel/drivers/testing/timerbench.c
index 2efa14e759..1b4c413b7e 100644
--- a/kernel/drivers/testing/timerbench.c
+++ b/kernel/drivers/testing/timerbench.c
@@ -517,17 +517,11 @@ static struct rtdm_device device = {
 
 static int __init __timerbench_init(void)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
 	return rtdm_dev_register(&device);
 }
 
 static void __timerbench_exit(void)
 {
-	if (!realtime_core_enabled())
-		return;
-
 	rtdm_dev_unregister(&device);
 }
 
-- 
2.16.4


