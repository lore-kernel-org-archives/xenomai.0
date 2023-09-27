Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BF438F8D
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 14:00:54 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023092713504446dbe97914fe15b646
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 15:50:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Ey3xBw5FAh6p1PpVSHItCEc/DUVL6Ca+LH15gMr8JUU=;
 b=lHKc03JMY+4Q6MMOcN+7Iz28+1ptr+GUZhNrlH4DUIvofUGacxes3lBjvuznTimIaiJcYx
 D3P91DUphoNtAYisrXJPe0MFJQ8SLLS6sh9RSIpCt3p2A5us/CFdpcUBKvdgido3h5IognLh
 /btyTFR8V1oNxeDwj0HU7PFl+wRlg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 27 Sep 2023 15:50:20 +0200
Subject: [PATCH v2 7/9] y2038: testsuite/smokey: Add some function wrapping
 tests
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v2-7-05f710464d83@siemens.com>
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Function wrapping in combination with the weak symbols that Xenomai
uses is a complex beast, especially when parts of the wrapping
machinery are allowed to be overwriting by application code.

Let's try to detect basic mistakes by extending the smokey testsuite
a bit.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 3d4a9106b..91ef5258e 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1583,6 +1583,49 @@ out:
 	return test_pselect64_interruption();
 }
 
+static int test_function_wrapping(void)
+{
+#ifndef __USE_TIME_BITS64
+	/*
+	 * We're testing some functions here that are wrapped only for 32 bit
+	 * applications with y2038 support enabled. If that's not the case we
+	 * can simply bail out and simulate success.
+	 */
+	return 0;
+#else
+	struct timespec ts64 = { 0 };
+	int ret;
+
+	/*
+	 * If the nsec part of ts64 is still 0 it's a good indication that our
+	 * function wrapping does not work as expected. We retry up to three
+	 * times to avoid shaky test results.
+	 *
+	 * __STD(clock_gettime()) is replaced with
+	 * __real_clock_gettime() by the preprocessor. If
+	 * __real_clock_gettime() is not properly redirected by the use of
+	 * COBALT_DECL_TIME64() (linker magic) we will end up in the glibc
+	 * implementation with "native" time_t.
+	 */
+	for (int i = 0; i < 3; i++) {
+		ret = smokey_check_errno(
+			__STD(clock_gettime(CLOCK_REALTIME, &ts64)));
+		if (ret)
+			return ret;
+
+		if (ts64.tv_nsec != 0)
+			break;
+
+		if (i == 2) {
+			smokey_warning("Function wrapping seems broken.");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+#endif
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1692,5 +1735,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_function_wrapping();
+	if (ret)
+		return ret;
+
 	return 0;
 }

-- 
2.39.2

