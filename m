Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3632003DE
	for <xenomai@lists.linux.dev>; Tue, 15 Oct 2024 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027990; cv=none; b=b5EhDwf/+7W5euAgI54nqHI+tFNg7GijPoCYOJfmDlfAFgbc+Voi8Vqzv8NmPw0y2dzxjL7AbuwMRVZz5Fj3wNjXqxp2oYCbGFWtzjqieyhRuWio27U75SRqfy0ML7fVxabSMrCVkqcL1nD5IAA02a+7UdCTS9vt0FrlvfOx2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027990; c=relaxed/simple;
	bh=YZ/28jR9hGONj35Lf/5rvR3z1/R5jNDkFqYW7o1nnI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l8t7FxHOT0JVW250h8b3A/PHYyRciJDC/9BfQ8FRGEp2GHmNotCXXb9BXPdrWuy0aLrR3qeufUPmPuTWi+swk1Yrdg/XET1Hql8b0fvLfd/SQej0CVLzj1IZzAeg9mMi5nSTx4lWUxlwsiWnlAawDf/HnnKKKWW8HmzmSUSi1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=nNI2laV8; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="nNI2laV8"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241015213255d2f4de90df6c67acd4
        for <xenomai@lists.linux.dev>;
        Tue, 15 Oct 2024 23:32:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=XVaI+3al4inn3HDo7Mn6DUJxboqryQgXTLIhp+gPnag=;
 b=nNI2laV82xZjRAMBPxFx325RX35+lsm4+CqmkoikV9nav2TlOTYZnoyv8cTAi6/s9sFbPC
 nwOTsyRgDdxjvytiaS1LBtPUYMy0yK5Z14JRwYtddgb/M6SWpQQvRZDVj/lu1c/c0j1D7frt
 u2zTNVH7wL1x5Juw7/jMq2GdYy07WpqF02LJbkkkFVEtkX1iFCz/0tkFn+Ws/5va9FL6rp2v
 rYuPeq5IS3cf8a7wwkdz5K0uhWYZ0Iw7jt9M3T1WQQQpHu8ilKtKBllyjqnNFIhl4Y5Osryk
 GlC2/OgN9vmdMy6SLHeZt0WSFKT45ThJFCWeZ8szKnZxvn6Q8YabMMoQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] cobalt/x86/smi: Let setup_smi_state() return the workaround state
Date: Tue, 15 Oct 2024 23:32:51 +0200
Message-Id: <20241015213251.2022553-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No functional change. Rework the static SMI workaround state into a
non-static variable.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/x86/smi.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/kernel/cobalt/arch/x86/smi.c b/kernel/cobalt/arch/x86/smi.c
index 87a2a3c4f..1ecbbb7d5 100644
--- a/kernel/cobalt/arch/x86/smi.c
+++ b/kernel/cobalt/arch/x86/smi.c
@@ -39,7 +39,6 @@
 
 #define SMI_CTRL_ADDR	0x30
 
-static int smi_state;
 static char smi_state_arg[16] = "detect";
 module_param_string(smi, smi_state_arg, sizeof(smi_state_arg), 0444);
 
@@ -111,7 +110,7 @@ static const char *smi_state_labels[] = {
 	"enabled",
 };
 
-static void setup_smi_state(void)
+static int setup_smi_state(void)
 {
 	static char warn_bad_state[] =
 		XENO_WARNING "invalid SMI state '%s'\n";
@@ -120,27 +119,25 @@ static void setup_smi_state(void)
 
 	/* Backward compat with legacy state specifiers. */
 	n = simple_strtol(smi_state_arg, &p, 10);
-	if (*p == '\0') {
-		smi_state = n;
-		return;
-	}
+	if (*p == '\0')
+		return n;
 
 	for (n = 0; n < ARRAY_SIZE(smi_state_labels); n++)
-		if (strcmp(smi_state_labels[n], smi_state_arg) == 0) {
-			smi_state = n - 1;
-			return;
-		}
+		if (strcmp(smi_state_labels[n], smi_state_arg) == 0)
+			return n - 1;
 
 	printk(warn_bad_state, smi_state_arg);
+
+	return -1;
 }
 
 void mach_x86_smi_init(void)
 {
 	struct pci_dev *dev = NULL;
+	int state;
 
-	setup_smi_state();
-
-	if (smi_state < 0)
+	state = setup_smi_state();
+	if (state < 0)
 		return;
 
 	/*
@@ -154,7 +151,7 @@ void mach_x86_smi_init(void)
 		return;
 	}
 
-	if (smi_state == 0) {
+	if (state == 0) {
 		printk(XENO_WARNING "SMI-enabled chipset found, but SMI workaround disabled\n"
 		       "          (see xenomai.smi parameter). You might encounter\n"
 		       "          high latencies!\n");
-- 
2.39.5

