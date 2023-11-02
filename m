Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD971B29F
	for <xenomai@lists.linux.dev>; Thu,  2 Nov 2023 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="l0/bpzqt"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202311021441460d2cef829f47b9a31b
        for <xenomai@lists.linux.dev>;
        Thu, 02 Nov 2023 15:41:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZqT4XRZlw+qGz4UumfQ+7q67Ic46eKsvmFqg6lzqBlk=;
 b=l0/bpzqt2bckt+LKsvX1o4ceZmHZpwI06kTqXrWcyvIMTXuR+mGQaGcuFTTmshiFwk59H7
 3iwJQxi6Lg+Gc5OT+50kr7TtQ3RsUUb4zrPKgkBhcFTbPnOlzZ2iq1bsDfdSNY1aheLbwBCE
 gTi2DG0uQ/gYv1ODiStzBWtAcJ6JA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 02 Nov 2023 15:41:47 +0100
Subject: [PATCH 6/6] testsuite: psostests: Skip tests if low resolution
 clock not enabled
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-flo-cleanup-testsuite-v1-6-0fb7bbd2d45f@siemens.com>
References: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
In-Reply-To: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The initialization of all the psostests will fail inside
psos_init() when --enable-lores-clock was not supplied during the
configure step.

The exit value from the failed sub-test is out of control smokey-wise
at the init phase so tests are skipped in that case.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/psostests/psostests.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index 27896d8fa..dc0fe1d39 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -42,6 +42,11 @@ static const char * const tests[] = {
 
 static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 {
+#ifdef CONFIG_XENO_LORES_CLOCK_DISABLED
+	(void)tests;
+	smokey_note("psostests skipped. --enable-lores-clock missing.");
+	return 0;
+#else
 	int test_ret = 0;
 	int ret = 0;
 	int tmp;
@@ -56,6 +61,7 @@ static int run_psostests(struct smokey_test *t, int argc, char *const argv[])
 	}
 
 	return ret;
+#endif
 }
 smokey_test_plugin(psostests, SMOKEY_NOARGS, "Run external psostests");
 

-- 
2.39.2

