Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D51BDC4
	for <xenomai@lists.linux.dev>; Fri,  3 Nov 2023 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Fe14MsaH"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202311031523345c1b730e0017c496a2
        for <xenomai@lists.linux.dev>;
        Fri, 03 Nov 2023 16:23:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=T0Ezi7x/vgYyaJ3KeqMShvayBjrpmOUIrfUUEHkbLqY=;
 b=Fe14MsaHJgUCc5wguPbqH+Ht4FIGp7w7aPg62QYRwLa7vZz9IX3BL8CCaY9apawGa2nnZV
 nZmkecLkOmgfCjR7rQmanxCqUAgSYt2pZcE3ryN+N/yL76uavKcTkQKA5SKKq05w6Kkx69Ld
 /yZWzYtNhAKJ/2Iv4wL5wBNclqoDw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 03 Nov 2023 16:23:31 +0100
Subject: [PATCH 2/4] boilerplate: Rename ARRAY_LEN to ARRAY_SIZE
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-flo-cleanup-testsuite-v1-2-628287f21b8d@siemens.com>
References: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
In-Reply-To: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

I think most of Xenomai developers have some background in Linux
development, so used to ARRAY_SIZE.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/boilerplate/ancillaries.h            | 2 +-
 lib/analogy/calibration.c                    | 2 +-
 testsuite/smokey/alchemytests/alchemytests.c | 2 +-
 testsuite/smokey/psostests/psostests.c       | 2 +-
 testsuite/smokey/vxworkstests/vxworkstests.c | 2 +-
 utils/analogy/calibration_ni_m.c             | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/boilerplate/ancillaries.h b/include/boilerplate/ancillaries.h
index e61a0fcfc..c8c209deb 100644
--- a/include/boilerplate/ancillaries.h
+++ b/include/boilerplate/ancillaries.h
@@ -30,7 +30,7 @@ struct error_frame;
 
 void __namecpy_requires_character_array_as_destination(void);
 
-#define ARRAY_LEN(a) (sizeof(a) / sizeof(*(a)))
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof(*(a)))
 
 #define namecpy(__dst, __src)						\
 	({								\
diff --git a/lib/analogy/calibration.c b/lib/analogy/calibration.c
index 83eda706a..9fa3ff5a6 100644
--- a/lib/analogy/calibration.c
+++ b/lib/analogy/calibration.c
@@ -220,7 +220,7 @@ int a4l_read_calibration_file(char *name, struct a4l_calibration_data *data)
 	CHK(read_str, &data->driver_name, d, PLATFORM_STR, DRIVER_STR);
 	CHK(read_str, &data->board_name, d, PLATFORM_STR, BOARD_STR);
 
-	for (k = 0; k < ARRAY_LEN(subdevice); k++) {
+	for (k = 0; k < ARRAY_SIZE(subdevice); k++) {
 		read_int(&nb_elements, d, subdevice[k], -1, ELEMENTS_STR);
 		if (nb_elements < 0 ) {
 			/* AO is optional */
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index 742f4d923..b2a3ec4ff 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -36,7 +36,7 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 	int ret = 0;
 	int tmp;
 
-	for (size_t i = 0; i < ARRAY_LEN(tests); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
 					 "--cpu-affinity=0", &test_ret);
 		if (test_ret)
diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index be6443dbc..9d9639d44 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -51,7 +51,7 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 	int ret = 0;
 	int tmp;
 
-	for (size_t i = 0; i < ARRAY_LEN(tests); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
 					 "--cpu-affinity=0", &test_ret);
 		if (test_ret)
diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index fa158b4cd..26cd58c69 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -28,7 +28,7 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 	int ret = 0;
 	int tmp;
 
-	for (size_t i = 0; i < ARRAY_LEN(tests); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
 					 "--cpu-affinity=0", &test_ret);
 		if (test_ret)
diff --git a/utils/analogy/calibration_ni_m.c b/utils/analogy/calibration_ni_m.c
index a243b5b03..4ce20166c 100644
--- a/utils/analogy/calibration_ni_m.c
+++ b/utils/analogy/calibration_ni_m.c
@@ -429,7 +429,7 @@ const char *ni_m_boards[] = {
 	"pci-6229", "pci-6250", "pci-6251", "pci-6254", "pci-6259", "pcie-6259",
 	"pci-6280", "pci-6281", "pxi-6281", "pci-6284", "pci-6289"};
 
-const int nr_ni_m_boards = ARRAY_LEN(ni_m_boards);
+const int nr_ni_m_boards = ARRAY_SIZE(ni_m_boards);
 
 static inline int pwm_period_ticks(void)
 {
@@ -973,7 +973,7 @@ static int ni_m_calibrate_ai(void)
 	/*
 	 * calibrate low, medium and high gain ranges
 	 */
-	for (i = 0; i < ARRAY_LEN(cal_info); i++) {
+	for (i = 0; i < ARRAY_SIZE(cal_info); i++) {
 		__debug("Calibrating AI: %s \n", cal_info[i].message);
 
 		if (cal_info[i].range >= 0)

-- 
2.39.2

