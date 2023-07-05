Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADF137E
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:48:36 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230705063827604a8fc06df408fb0b
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KS/zQtFgDIox9hLo5qXUsB0wSoLD7PQlMRakpngYaUQ=;
 b=N556Xz0p8vkykJzvHyx7S42++z+xnlKOV2R3lMIRT+kyMX0ZS10yL5uOoOZDXnpZw8fg2K
 Khk59bHIj3zWSXpjgOpKcGyltFQqN8/3PQrdAV7r+XTbGVjw6+O1dOCojNt9c9rz58TOou6a
 juYeU1k+NKYYvgI7mMUwNKKhX87a0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:30 +0200
Subject: [PATCH 08/12] y2038: testsuite/smokey/y2038: Fix reporting of
 thread return status
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-8-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

run_thread was not reporting back the thread exit status but the result
of pthread_join, which is normally a success, even if the thread itself
was not successful.

That revealed some wrong exit status checks inside the y2038 tests.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index af27f2bce..d5ab2e8b1 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -155,7 +155,7 @@ static int run_thread(void *(*thread)(void *), void *arg, int exp_result)
 
 	res = (long)status;
 
-	return (res == exp_result) ? 0 : ret;
+	return (res == exp_result) ? 0 : res;
 }
 
 static int test_sc_cobalt_sem_timedwait64(void)
@@ -528,13 +528,13 @@ static int test_sc_cobalt_mutex_timedlock64(void)
 		return ret;
 
 	/*
-	 * mutex still locked, second thread has to fail with -EINVAL when
+	 * mutex still locked, second thread has to fail with -EFAULT when
 	 * submitting NULL as timeout
 	 */
 	ctx.sc_nr = sc_nr;
 	ctx.mutex = &mutex;
 	ctx.ts = NULL;
-	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EINVAL)))
+	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EFAULT)))
 		return ret;
 
 	/*
@@ -546,12 +546,12 @@ static int test_sc_cobalt_mutex_timedlock64(void)
 		return ret;
 
 	/*
-	 * mutex still locked, second thread has to fail with -EFAULT when
+	 * mutex still locked, second thread has to fail with -EINVAL when
 	 * submitting an invalid timeout (while the address is valid)
 	 */
 	ts64.tv_sec = -1;
 	ctx.ts = &ts64;
-	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EFAULT)))
+	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EINVAL)))
 		return ret;
 
 	/*

-- 
2.39.2

