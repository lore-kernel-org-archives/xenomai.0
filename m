Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE761465A5
	for <xenomai@lists.linux.dev>; Sun, 12 Jan 2025 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678922; cv=none; b=oU2e+loTdAiVNeZpQFxLzY5ImPzAhNNmxS/mHTHSiX7ghigE+bZg0UQOvtRNyGoDYgCNi90uqSj/NM2mJLBzhQv8mjThQeKQiCT7HZ+eOMyj+L9c1tibIBe/AqF8CcpmL8YUGsZcVBdjZybkxw+XHXGPYtdU8d+l8eD2FcePyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678922; c=relaxed/simple;
	bh=tYlX8l7xA7N7nk2C21VaNTkTq8ET1bqN9JkMl6ztaOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szlEQ6XoyC5VQwS1Hy2/ZbsU7LU0XvLaC+4qk4EWvLEuoQowYctKqNeERmzUV0MRtc3DuWUEBwa8QpTSPYSQrFRdZoZYMmLPkVG3IQL/T61PoEKC/Z5J5nAUE6uS0a3h11d2j9OqbK5xf4Y3uZlLhrpTSkWkpxAXaf+SpTZAqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=lm4ab0hs; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="lm4ab0hs"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2025011210483089bf2c59f0117958db
        for <xenomai@lists.linux.dev>;
        Sun, 12 Jan 2025 11:48:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=p5dwdodM3z66e/luZdQ+ZnpEfe+QlJRbxmYWd2AatCE=;
 b=lm4ab0hsKOKzSGy7hpfNzylU6ePRJaUrF7SbRFp01QZJWvJ8ynNDJ0hYG9pMp3sQ71UYQe
 3pPLdISyBOSbnwbM/D4xVsylbnMToXaJ/73m68zm5b10QBHEURyxzkFKzTO9WKw2W6jL30BP
 Kj4YJOnatBRiyhf4MUE5djV83czDfgux5ChkcByb2jweAOsmc3f4aQr3QBOJ1YfFgCel6eun
 V85lbFUtruIfyIqB2erL/Uu3pMbtUcVOrot2kttBpPrWrF7gEpYx0WeMNNGR04FTQIsCZ3OE
 XRVxbiY6kTxIfDLRW5imMr9lRpKRWEEZ9ynPryWJz6w67EMbWLCsO4dQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/3] testsuite/smokey/y2038: Always present valid u_ret to monitor_wait64
Date: Sun, 12 Jan 2025 11:48:27 +0100
Message-ID: <f996e24f7864308e9a213c822794a7aaaf4d0254.1736678909.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1736678909.git.jan.kiszka@siemens.com>
References: <cover.1736678909.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

So far, this parameter was not check for validity, but this will change,
and checking that is not in scope for this test case.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index b452b642bc..29e9c66c0a 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -831,7 +831,7 @@ static int test_sc_cobalt_monitor_wait64(void)
 		return -errno;
 
 	/* Make sure we don't crash because of NULL pointers */
-	ret = XENOMAI_SYSCALL4(sc_nr, NULL, NULL, NULL, NULL);
+	ret = XENOMAI_SYSCALL4(sc_nr, NULL, NULL, NULL, &opret);
 	if (ret == -ENOSYS) {
 		smokey_note("monitor_wait64: skipped. (no kernel support)");
 		return 0; // Not implemented, nothing to test, success
@@ -841,14 +841,14 @@ static int test_sc_cobalt_monitor_wait64(void)
 
 	/* Providing an invalid address has to deliver EFAULT */
 	ret = XENOMAI_SYSCALL4(sc_nr, &mon, COBALT_MONITOR_WAITGRANT,
-			       (void *)0xdeadbeefUL, NULL);
+			       (void *)0xdeadbeefUL, &opret);
 	if (!smokey_assert(ret == -EFAULT))
 		return ret ? ret : -EINVAL;
 
 	/* providing an invalid timeout has to deliver EINVAL */
 	t1.tv_sec = -1;
 	ret = XENOMAI_SYSCALL4(sc_nr, &mon, COBALT_MONITOR_WAITGRANT, &t1,
-			       NULL);
+			       &opret);
 	if (!smokey_assert(ret == -EINVAL))
 		return ret ? ret : -EINVAL;
 
-- 
2.43.0

