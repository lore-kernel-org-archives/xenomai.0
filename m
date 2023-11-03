Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277831BDE8
	for <xenomai@lists.linux.dev>; Fri,  3 Nov 2023 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Xq+RdbbU"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231103152334da4485ed8a9c910c01
        for <xenomai@lists.linux.dev>;
        Fri, 03 Nov 2023 16:23:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DONo19MWVfzJyyQDn9YH4ilB3qRchI90Wx4PRtAdm/M=;
 b=Xq+RdbbUytjGuc5U78iOs1e1+kTvjmcDYDzEv12PVQT2tMrruzin2TdnMC6XZdCb2LcTAb
 FniyKSwpR6YdKK+oxYZ7rKuF/xJ+09zl4J1jpqAArNs3O2SRo5RER6v+9kaZ5EcDqBz4rydO
 m1HR4hSCYU9TvF+yYpxQthPnokLks=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 03 Nov 2023 16:23:30 +0100
Subject: [PATCH 1/4] boilerplate: Define ARRAY_LEN once inside
 ancillaries.h
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-flo-cleanup-testsuite-v1-1-628287f21b8d@siemens.com>
References: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
In-Reply-To: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Cleanup private definitions of ARRAY_LEN and re-use the new definition
in ancillaries.h where necessary.

We can use the definition from ancillaries.h inside the testsuite
as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/boilerplate/ancillaries.h            | 2 ++
 lib/analogy/calibration.c                    | 3 +--
 testsuite/smokey/alchemytests/alchemytests.c | 2 +-
 testsuite/smokey/psostests/psostests.c       | 2 +-
 testsuite/smokey/vxworkstests/vxworkstests.c | 2 +-
 utils/analogy/analogy_calibrate.h            | 2 --
 utils/analogy/calibration_ni_m.c             | 1 +
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/boilerplate/ancillaries.h b/include/boilerplate/ancillaries.h
index 319d22f66..e61a0fcfc 100644
--- a/include/boilerplate/ancillaries.h
+++ b/include/boilerplate/ancillaries.h
@@ -30,6 +30,8 @@ struct error_frame;
 
 void __namecpy_requires_character_array_as_destination(void);
 
+#define ARRAY_LEN(a) (sizeof(a) / sizeof(*(a)))
+
 #define namecpy(__dst, __src)						\
 	({								\
 		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
diff --git a/lib/analogy/calibration.c b/lib/analogy/calibration.c
index b50cb2f9c..83eda706a 100644
--- a/lib/analogy/calibration.c
+++ b/lib/analogy/calibration.c
@@ -27,6 +27,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include "iniparser/iniparser.h"
+#include "boilerplate/ancillaries.h"
 #include "boilerplate/list.h"
 #include "calibration.h"
 
@@ -37,8 +38,6 @@ do {										\
 		return -1;							\
 } while (0)
 
-#define ARRAY_LEN(a)  (sizeof(a) / sizeof((a)[0]))
-
 static lsampl_t data32_get(void *src)
 {
 	return (lsampl_t) * ((lsampl_t *) (src));
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index e3454074d..742f4d923 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -36,7 +36,7 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 	int ret = 0;
 	int tmp;
 
-	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+	for (size_t i = 0; i < ARRAY_LEN(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
 					 "--cpu-affinity=0", &test_ret);
 		if (test_ret)
diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index dc0fe1d39..be6443dbc 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -51,7 +51,7 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 	int ret = 0;
 	int tmp;
 
-	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+	for (size_t i = 0; i < ARRAY_LEN(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
 					 "--cpu-affinity=0", &test_ret);
 		if (test_ret)
diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index 2a816804b..fa158b4cd 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -28,7 +28,7 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 	int ret = 0;
 	int tmp;
 
-	for (size_t i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+	for (size_t i = 0; i < ARRAY_LEN(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
 					 "--cpu-affinity=0", &test_ret);
 		if (test_ret)
diff --git a/utils/analogy/analogy_calibrate.h b/utils/analogy/analogy_calibrate.h
index aeb6355d0..728ee1208 100644
--- a/utils/analogy/analogy_calibrate.h
+++ b/utils/analogy/analogy_calibrate.h
@@ -36,8 +36,6 @@ extern struct timespec calibration_start_time;
 extern a4l_desc_t descriptor;
 extern FILE *cal;
 
-#define ARRAY_LEN(a)  (sizeof(a) / sizeof((a)[0]))
-
 #define RETURN	 1
 #define CONT 	 0
 #define EXIT	-1
diff --git a/utils/analogy/calibration_ni_m.c b/utils/analogy/calibration_ni_m.c
index 6f9be6fc9..a243b5b03 100644
--- a/utils/analogy/calibration_ni_m.c
+++ b/utils/analogy/calibration_ni_m.c
@@ -23,6 +23,7 @@
 #include <rtdm/analogy.h>
 #include <math.h>
 
+#include "boilerplate/ancillaries.h"
 #include "calibration_ni_m.h"
 #include "calibration.h"
 struct listobj ai_calibration_list;

-- 
2.39.2

