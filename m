Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525D10FE
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:38:36 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202307050638299688167c807ff6a5cd
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SIuRfKvwqFclIhTYADiuvdQnUChQDKtLqV8kPsVnItA=;
 b=AnKQB1Q4QQvluJsbiUaEGLBqbURBUqRAgGnd612IqQLwvfDgcjEN/XxNPgTPohVv+WbcQr
 JtS+B7e2u5053rh85rLXoS63BuuOktGEFyvmf+2Qm9KCzvWOz948/9Gms2dkjx1wxhc3fVnR
 2xkI0h1r9cFA4rYKUrcUS79dtgBwM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:34 +0200
Subject: [PATCH 12/12] testsuite/smokey: Fix unconditional unloads of the
 xeno_rtdmtest module
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-12-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The cpu-affinity and the rtdm test unloaded the xeno_rtdmtest module
even if it was not loaded by the test upfront. In addition, such tests
failed if the module was already loaded. That made partially re-running
the testsuite after a failed run harder.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/cpu-affinity/cpu-affinity.c | 13 +++++--------
 testsuite/smokey/rtdm/rtdm.c                 |  7 ++++---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/testsuite/smokey/cpu-affinity/cpu-affinity.c b/testsuite/smokey/cpu-affinity/cpu-affinity.c
index 4a59ff6f5..cbc877182 100644
--- a/testsuite/smokey/cpu-affinity/cpu-affinity.c
+++ b/testsuite/smokey/cpu-affinity/cpu-affinity.c
@@ -73,10 +73,10 @@ out:
 static int load_test_module(void)
 {
 	int fd, status;
-	
-	status = system("modprobe -q xeno_rtdmtest");
-	if (status < 0 || WEXITSTATUS(status))
-		return -ENOSYS;
+
+	status = smokey_modprobe("xeno_rtdmtest", true);
+	if (status)
+		return status;
 
 	/* Open the RTDM actor device. */
 	fd = open("/dev/rtdm/rtdmx", O_RDWR);
@@ -88,11 +88,8 @@ static int load_test_module(void)
 
 static void unload_test_module(int fd)
 {
-	int status;
-	
 	close(fd);
-	status = system("rmmod xeno_rtdmtest");
-	(void)status;
+	smokey_rmmod("xeno_rtdmtest");
 }
 
 static void *__run_cpu_affinity(void *arg)
diff --git a/testsuite/smokey/rtdm/rtdm.c b/testsuite/smokey/rtdm/rtdm.c
index 0b89228fc..6ad0d6d7a 100644
--- a/testsuite/smokey/rtdm/rtdm.c
+++ b/testsuite/smokey/rtdm/rtdm.c
@@ -153,8 +153,8 @@ static int run_rtdm(struct smokey_test *t, int argc, char *const argv[])
 {
 	int dev, dev2, status;
 
-	status = system("modprobe -q xeno_rtdmtest");
-	if (status < 0 || WEXITSTATUS(status))
+	status = smokey_modprobe("xeno_rtdmtest", true);
+	if (status)
 		return -ENOSYS;
 
 	if (access(devname, 0) < 0 && errno == ENOENT)
@@ -195,7 +195,8 @@ static int run_rtdm(struct smokey_test *t, int argc, char *const argv[])
 	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
 			     RTTST_RTDM_DEFER_CLOSE_CONTEXT), 0);
 	check("close", close(dev), 0);
-	check("rmmod", system("rmmod xeno_rtdmtest"), 0);
+
+	smokey_rmmod("xeno_rtdmtest");
 
 	return 0;
 }

-- 
2.39.2

