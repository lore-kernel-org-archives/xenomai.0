Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005DA2248A4
	for <xenomai@lists.linux.dev>; Thu, 18 Dec 2025 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088138; cv=none; b=Bo+JqKQk8ouXfq6acvIxBBcu8yx7slMU/PRErtGnYgybaCdPXZGgfaF9eNy94W8Gz548MwUjvA7EGwW83zIt/wJhvrIJPYOpzmJ5N0/1JJqmjgZmIHeJcu4JqK26FMN6kBbT5oUtZRAiNnORQs2V5LEZ+mGE/EyxZdy8EGd5/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088138; c=relaxed/simple;
	bh=e/6fJD0QaDHpAOvJ0UCXwe1HAEtxAV2zNDcWlQvSx/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qeL1bRp0iRp16sFQ3Vb9dACKTd6scp42i/Ztc/tJDvvaIkGrRnKb1ElCXon9kfJiiP3c6A5BVqV8eOTg8Gh9l++viX7rrGWfZWgMEwnnDrLapcBn5/bmeOL8myXoD7rloJ+3Dln02btENOtQD0tWzlv8EaURQGYc/qGnowGhprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=UZl1o5gM; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UZl1o5gM"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202512182002112155cdac38000207da
        for <xenomai@lists.linux.dev>;
        Thu, 18 Dec 2025 21:02:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bthg5fSJo9qdE+oEiao9BIngH1CGNEAztxmBafJCmog=;
 b=UZl1o5gMUIAoGgVI8QKL6juH4AKOJ+FjBCI0OztVyMOBbmekzxMVGUgxsImorA7KQXbo6J
 toqWlhtO9TmzUB8wwT4YQxieRbmwKJBO2ioZOyxIFZzceEu7+Uc28yIJvkE4mF/RoEsL0Zx8
 U0y9IIVH3T4ieCPEcFtdqHie8Ttvb43KP4ndwWHpytv+vOgm4K9zxtINDV6SGARLd4sHnr03
 VbRQxRLNOrk8irQGg4j6wxUtJnhh0cRNBz352rNjY8la3ta7ZqSPUOFPLNEz5HAKvncMQj/n
 aZwmGeWj8D/Z9sQI4RSOocbSA2sTcmYY4z8aKtdYZuhWhxbrUe9TosRQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Dec 2025 21:02:06 +0100
Subject: [PATCH v2 6/6] testsuite/smokey/posix-select: Extend the testsuite
 by invalid timeouts
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-flo-fix-select-syscall-v2-6-f606e54e8d57@siemens.com>
References: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
In-Reply-To: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Andreas Ziegler <ziegler.andreas@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

One corner case was missing a normalization about the timeout value
supplied to select(). Extending the testsuite to make sure we cover
that case as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/posix-select/posix-select.c | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
index 154b3d730..620b677da 100644
--- a/testsuite/smokey/posix-select/posix-select.c
+++ b/testsuite/smokey/posix-select/posix-select.c
@@ -143,6 +143,54 @@ out:
 	return ret;
 }
 
+static int test_select_timeout(void)
+{
+	unsigned long diff_in_nsec;
+	struct timespec ts1, ts2;
+	struct timeval tv;
+	int ret;
+
+	/* Invalid timeval, usec too big, normalization to 1 sec, 1 usec */
+	tv.tv_sec = 0;
+	tv.tv_usec = 1000 * 1000 + 1;
+
+	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts1));
+	if (ret)
+		return ret;
+
+	/*
+	 * y2038 speciality ahead:
+	 * select() services provided by Linux and Cobalt both normalize the
+	 * timeout value before using it. pselect() services do not do that.
+	 *
+	 * As the select() service of libcobalt is routed to the pselect() of
+	 * Cobalt we have to do the normalization in userspace. The test below
+	 * is exactly stressing that case.
+	 */
+	ret = select(0, NULL, NULL, NULL, &tv);
+	if (!smokey_assert(ret == 0))
+		return ret;
+
+	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts2));
+	if (ret)
+		return ret;
+
+	/*
+	 * Check that the writeback happened as expected. This makes also sure
+	 * that the normalization took place.
+	 */
+	smokey_assert(tv.tv_sec == 1);
+	smokey_assert(tv.tv_usec == 1);
+
+	diff_in_nsec = (ts2.tv_sec * 1000 * 1000 * 1000) + ts2.tv_nsec;
+	diff_in_nsec -= (ts1.tv_sec * 1000 * 1000 * 1000) + ts1.tv_nsec;
+
+	/* Check that at least 1sec has passed */
+	smokey_assert(diff_in_nsec > 1 * 1000 * 1000 * 1000); // 1sec
+
+	return 0;
+}
+
 static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -151,5 +199,9 @@ static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_select_timeout();
+	if (ret)
+		return ret;
+
 	return ret;
 }

-- 
2.39.5

