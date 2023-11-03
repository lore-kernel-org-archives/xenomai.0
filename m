Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916C1BDCC
	for <xenomai@lists.linux.dev>; Fri,  3 Nov 2023 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Y88pUz6p"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20231103152335c15608729289d3c5b1
        for <xenomai@lists.linux.dev>;
        Fri, 03 Nov 2023 16:23:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AwTQgnbKKcC+5WI0pts+wUmPdw2hyeLCKqZB/BQGNdc=;
 b=Y88pUz6pWWPvObRMhDnCvy/45B+MORJ0mTycO40BrwFNxlgGBpl18Ayok7UQtUoLMGVhxO
 ISbeWdANFMCbZOevaxdhWhzUSyRd1usNVEK56cCi1QNuxv2QjIvUspPLVE64g54Ab7CoL27r
 vz3Let8Bs2Kk4UmOACNab4sZ4RN+Y=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 03 Nov 2023 16:23:32 +0100
Subject: [PATCH 3/4] testsuite: alchemytests: Try loading the xeno_rtipc
 module
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-flo-cleanup-testsuite-v1-3-628287f21b8d@siemens.com>
References: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
In-Reply-To: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The pipe test depends on the xeno_rtipc kernel module with XDDP
support enabled. We can not be sure that XDDP support is really
available after loading the module, but loading the module is a good
first step.

The test will later be skipped if XDDP support is still not available.

As the pipe test itself is running outside smokey we do not have the
infrastructure around smokey_modprobe() and smokey_rmmod() available.
We have to load/unload the module from smokey.

While at it: Cleaning up some unused includes.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/alchemytests/alchemytests.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index b2a3ec4ff..9a937f3a0 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <error.h>
-#include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 #include <smokey/smokey.h>
 
@@ -32,10 +29,16 @@ static const char * const tests[] = {
 
 static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 {
+	const char *const mod = "xeno_rtipc";
 	int test_ret = 0;
 	int ret = 0;
 	int tmp;
 
+	/* Try loading the xeno_rtipc module as the pipe test depends on it */
+	tmp = smokey_modprobe(mod, true);
+	if (tmp)
+		smokey_note("Loading the %s module failed.", mod);
+
 	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
 					 "--cpu-affinity=0", &test_ret);
@@ -45,7 +48,8 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 			break;
 	}
 
+	smokey_rmmod(mod);
+
 	return ret;
 }
 smokey_test_plugin(alchemytests, SMOKEY_NOARGS, "Run external alchemytests");
-

-- 
2.39.2

