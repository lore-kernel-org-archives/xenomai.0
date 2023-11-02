Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3791B29E
	for <xenomai@lists.linux.dev>; Thu,  2 Nov 2023 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="lhhfG15B"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20231102144146d51b81673c2dfa0364
        for <xenomai@lists.linux.dev>;
        Thu, 02 Nov 2023 15:41:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=D7UWAzaUWbFDotk1tf+1RE79hr7kLkWoVxkWX/0dzt8=;
 b=lhhfG15BU6wYUiJufPFJYw7heWbw8M/hZwnnbnE9vrVUK+f+/YcRCz97mOeTMSUKSg00rg
 VVlQRYwjj817B5hVVK3aSguQVQZ33iumpfXqdx22mbTULY9kcoD/oBsW0C4RkRKYSm497ZOp
 JgAxeKhU1PuA6ZmQM9lkz8pzjifh4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 02 Nov 2023 15:41:46 +0100
Subject: [PATCH 5/6] testsuite: vxworkstests: Skip tests if low resolution
 clock not enabled
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-flo-cleanup-testsuite-v1-5-0fb7bbd2d45f@siemens.com>
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
In-Reply-To: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The initialization of all the vxworkstests will fail inside
vxworks_init() when --enable-lores-clock was not supplied during the
configure step.

The exit value from the failed sub-test is out of control smokey-wise
at the init phase so tests are skipped in that case.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/vxworkstests/vxworkstests.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testsuite/smokey/vxworkstests/vxworkstests.c b/testsuite/smokey/vxworkstests/vxworkstests.c
index 298bb3d1d..2a816804b 100644
--- a/testsuite/smokey/vxworkstests/vxworkstests.c
+++ b/testsuite/smokey/vxworkstests/vxworkstests.c
@@ -19,6 +19,11 @@ static const char * const tests[] = {
 
 static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 {
+#ifdef CONFIG_XENO_LORES_CLOCK_DISABLED
+	(void)tests;
+	smokey_note("vxworkstest skipped. --enable-lores-clock missing.");
+	return 0;
+#else
 	int test_ret = 0;
 	int ret = 0;
 	int tmp;
@@ -33,6 +38,7 @@ static int run_vxworkstests(struct smokey_test *t, int argc, char *const argv[])
 	}
 
 	return ret;
+#endif
 }
 smokey_test_plugin(vxworkstests, SMOKEY_NOARGS, "Run external vxworkstests");
 

-- 
2.39.2

