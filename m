Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B642980C
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582920; cv=none; b=WleyXk/aeviyaGVB/zwtpr+KTcqyR01mWB14HiyYIUOpmc19s7JdMtaeTTinhoqdlYw0MDu14Qr0RT6uNWW4w0YMi7JLnfrnYhktV+cHBX7ogDQoMQhX/HbCTJkGMysbDLO8PXC3bLKHlgjZ1GgYzZyqRJZElhd5D6o28epwIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582920; c=relaxed/simple;
	bh=A31Iwr88sXWq+C0eOf64yF9hBMBJTiteoVzZjvMdypI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q53zfC6/ry7G7dfqwj2jaFVJnsuuQHUiCwu/WP67wzQDkYHGydDQzh4dZZtmniLLq1FA87jeT/PEK4QcKNJNd8PDCOTzYBAx7oq1wnt4wmN/Rv/JG5xqU0VMJxj8CsnsWHH7Mff7/dd+UHXteNUhyTU818l2uqfOGe/x4Hxf/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=RuU3R6hc; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="RuU3R6hc"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026072021282604e2e56e9100020782
        for <xenomai@lists.linux.dev>;
        Mon, 20 Jul 2026 23:28:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=18ea+pI79gkp/Wgg7BS6f0Wv1Z1QJ1cwGuOvc032saQ=;
 b=RuU3R6hcVXiu9DUXbNGN8+IQ54557Jj7ho8et0fACLUQK6mFUJIZx5eh+Vq6bFx5dGvwN1
 WIOrhoaJ6Cjl67g3Vm+4KwU5vRAkNMHUd4HnonBQOMlTODPZhR6VpXwmbW6r5jS2KYPpwZBU
 ZvsfuD5stMASBwxYivfjDjNjPZEh5/udzc+IdWGn6o55Tztt/cvjfGMBz7/XI0ZGyhoC+nP/
 oGbeY1ZSHjl9VxDLQ0wxKJYqLoS9g/jj9KzCVCr4gXntNvVRoSEARXQc8srvicIf7K2HN1wV
 BnqXrvEOhuWrAPU0VyJEUzz/+KOdN4v85LHbkOR4jyHfAkLzH0K5fPWQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 20 Jul 2026 23:28:27 +0200
Subject: [PATCH v4 3/3] testsuite/smokey/psostests: Enable psostests_task2
 test
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-wip-flo-gcc-16-v4-3-f281a1f0cbd4@siemens.com>
References: <20260720-wip-flo-gcc-16-v4-0-f281a1f0cbd4@siemens.com>
In-Reply-To: <20260720-wip-flo-gcc-16-v4-0-f281a1f0cbd4@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

It seems the test was disabled because it failed in the past as the
active waiting loop was not enough for keeping the background task
alive.

As the real issue has been fixed now we can re-enable the test at
smokey level.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/psostests/psostests.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index 289d563ac3595f0e2d21bc5f5746772fd51234b8..31347ba45ea430ac4b2e62be4c1e437519f2fb37 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -15,9 +15,7 @@ static const char * const tests[] = {
 	"psostests_sem1",
 	"psostests_sem2",
 	"psostests_task1",
-	// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
-	//		../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
-	//"psostests_task2",
+	"psostests_task2",
 	"psostests_task3",
 	"psostests_task4",
 	"psostests_task5",

-- 
2.55.0

