Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E9313E39
	for <xenomai@lists.linux.dev>; Fri,  5 Dec 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927829; cv=none; b=uO9uXBJzeKfQ5QaygMgtZHwg2JLkjSFMZK2jvC1OSBDQ2+57wbe4ImalEHimS5rA/ccjPxGrkY7kubq5wPf38Icv3mTkA+3/DzRc/I9yIdm6D+RJGrQ0PK/p/UE5qh6/lKhxkFCM9Rg6lc7JsmTu6ReNc9GJsxhk5cZh9s/aoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927829; c=relaxed/simple;
	bh=p/Z3a1HErX0Fzm6pp1GpJKnFUqQQBOsAKgbR1aKS3zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bW7QHO87RDT1gf4WEdZs0nreS1/xCKC4dhgjH0oJ28vBluaVFSGMBjFsJhJ9senBnOKG01VrQNrIxjqGq7vEhblgTJShT4qCbe91hYjk+QvEw0TnOicIuMXcE26uNpJDF0sq+ZtSuyG6qqsqtI+BrZt+Dqh+DSv927XV+FpHzfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FfiCRNCS; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FfiCRNCS"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251205090314386ea8f2a0000207bf
        for <xenomai@lists.linux.dev>;
        Fri, 05 Dec 2025 10:03:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LDep6MKaCg4hTvQZFc3WAbHWG8p0R/hEm4ezM6PZ2zo=;
 b=FfiCRNCS0gy/9rOwIzdV8+Zc+OarSJ4TqzYJcjrFaDt9eZ3IgW7dpK0cd0K18ZeTZfK2OY
 zYCI7J2fSZvDzCQt/nSpndiRw7fI8pV0S59mUZaEibJX0HBhZ52LJujlXOCXr/RYNYgifi0q
 2wKlXIVdxvZtRKGaxLEz9Ro+sOsad8Lunx/7LvsczGZlDPlGvLZU8CELHxZZAwjN7g/b7TQK
 gCj3absll5R9VSggSD78UAWX0zntzq19adFEVoYaIWvKyBEnru0TzN0SFil1kMhQ9Hytlivl
 Zzunedd8Pwvx5qv59EQcqBlJT5l35t6d8S9OpfSq213CLnoy8QmiDihw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 Dec 2025 10:03:16 +0100
Subject: [PATCH 6/6] testsuite/smokey/posix-select: Extend the testsuite by
 invalid timeouts
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-flo-fix-select-syscall-v1-6-7f9c545a63ce@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
In-Reply-To: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
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
 testsuite/smokey/posix-select/posix-select.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
index 154b3d730..6d1fcaa0d 100644
--- a/testsuite/smokey/posix-select/posix-select.c
+++ b/testsuite/smokey/posix-select/posix-select.c
@@ -143,6 +143,30 @@ out:
 	return ret;
 }
 
+static int test_select_timeout(void)
+{
+	struct timeval tv;
+	int ret;
+
+	/* Invalid timeval, usec too big, normalization to 1 sec, 1 usec */
+	tv.tv_sec = 0;
+	tv.tv_usec = 1000 * 1000 + 1;
+
+	/* y2038 speciality ahead:
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
+	return 0;
+}
+
 static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
@@ -151,5 +175,9 @@ static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
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

