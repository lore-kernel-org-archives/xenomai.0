Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C64A3ACA59
	for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274936; cv=none; b=WncadaBmfAEi/EZBB7m9csylyaFspY7fZECYKjIFsxMEZ3ixFVlXtqhn5HyhdAq5DaQ+aq82oGlzXZ06X1yFa9nrhzO3NTu2MNnDNaUC7cr3oYmJKNb3LvTMfhQGIphPKf5xwyAZn6Jm7haw5NDtagr3/0/24IY0uFGOQSM3zyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274936; c=relaxed/simple;
	bh=q0h9ZcIR6qKQ/XOC87j4NU5ti4QgVVG5Vip/YdKyUWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=La5eB7g1HAa+43OBxtGB8V4Qa1o32A1Q396cfgyq5DgIDcNYuYdTp1Qpf4iZrNNEF2WN4mJbsU74giu3Shh8DBO+4d1hfwMQb7OP6BQBckqVgdBToxe9T3GBBRMo3fVlmOopu+1RLj85sr0YC6EGM+Z7Ape2jO2qya99Lf+Pjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Ci7/3Pw8; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ci7/3Pw8"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260717074514f4ea5569360002071e
        for <xenomai@lists.linux.dev>;
        Fri, 17 Jul 2026 09:45:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ivigOGCCxKBXN7LGWK0m4quIaTOPfVr0E6Xfj5eTl3c=;
 b=Ci7/3Pw8O+nUgxOxdTf/l+FGiyAO4ILnjWDxbirn7zLxSdg4Sf7iSmwdn4fCI8o9AX93aR
 ntULn/dQUO1GCQZyFEnBw30DTIwNCxfAzQwLNxXmrZuc3wMXYzM/CyfuatPM5t3NbCBXwRsy
 vwSklPeUWXQ11e8syJp48UlqbZEFFXATV2PrBDmAYXm+64huciTXnJtzZe94k9vJhQ9HvoF5
 3DUe5/u4+90NSNRnHxRAzjkbEmffslrK6nBECzCIcmJvpzLoNcFriPpHIyRVPkPAB1FPZbHY
 wCiGv0w6ipaVNzQbZUOLesUnlE5NPvN23XFp5QaVbwY4zvbynrrukhkw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 17 Jul 2026 09:45:06 +0200
Subject: [PATCH v3 3/4] testsuite/smokey/vxworktests: Fix compile error
 seen with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-wip-flo-gcc-16-v3-3-5429c866bcca@siemens.com>
References: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
In-Reply-To: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Fixes the following error:

task-2.c: In function ‘backgroundTask’:
task-2.c:26:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
   26 |         unsigned int safety = 100000000, count = 0;
      |                                          ^~~~~
cc1: all warnings being treated as errors

The busy waiting loop is keeping the background task alive, so that
the foreground task is able to call taskSuspend() for the background
task.

Replacing the counting busy loop with a call to taskDelay(), which will
be time based. We will stay in the RT domain while waiting, so that
taskSuspend() is called for a task part of the RT domain.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/vxworkstests/task-2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index 0cbb9e18a13383418c4360241ef244b8a24da975..feda4ff7054346331de0b0cf8f6d53bd07e04c02 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -23,7 +23,6 @@ static SEM_ID sem_id, fdone_sem_id;
 
 static void backgroundTask(long arg, ...)
 {
-	unsigned int safety = 100000000, count = 0;
 	int ret;
 
 	traceobj_enter(&trobj);
@@ -35,8 +34,7 @@ static void backgroundTask(long arg, ...)
 
 	traceobj_mark(&trobj, 2);
 
-	while (--safety > 0)
-		count++;
+	taskDelay(5);
 
 	/*
 	 * Enter infinite pause so that any pending cancellation is

-- 
2.55.0

