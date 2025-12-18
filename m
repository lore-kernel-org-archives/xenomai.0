Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424E284888
	for <xenomai@lists.linux.dev>; Thu, 18 Dec 2025 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088141; cv=none; b=WaaeC8VDKn2m1ysAUSs48IM2Jyq2lPA2WGV1c0NY0fxM8PnFSG05r3dKvCZ8HWDtjLjr4aFG+5aZX/1z7U6q2VE+Rj68MK6ueTeYTOynQeJAWy9tYnIOMqVKRJ9O3dckEZ1JO1+dPlDy971qe2P2HCgU+5K/dLmzUBq62+LsOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088141; c=relaxed/simple;
	bh=7n6nm/6wfaq7YOxdBGcjruvrPnb7B7Z7Ua0kVv9J6Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhpZsHHE3gZFa8dLha7oforeu9j+Ja/DwjZctqloT35bMfIXK6x1+NIptTkjfcLRFK43Pql+fYlMmy9/juZz+7VsfBghOU0xakExw1n9lJPf+dFNZbf4UoBLtEBdZkdvdOr5HVyd3lBcL7vvqO7/x61ccp7JcwbbPJjuKXnRFQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FSNLDZxn; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FSNLDZxn"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20251218200211378ad6ab7600020723
        for <xenomai@lists.linux.dev>;
        Thu, 18 Dec 2025 21:02:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1vNDX1clbllXpsAbPeodDZl0ATXRBttz90k6nPdZXsM=;
 b=FSNLDZxnDJSOIrwdknm1SpSxy1gPs6TAQMeI+iae0gCererB4W1T2q2Eg26U6uVApSxR4y
 ff4XLK6bEGqcptzIjIck7pA7V5Hl65sMtlOZFXBj3m6y3QLerkh2zxyxTgurEktB0qKJ2pDO
 9ey7iJBuznttc6cKMHEC5pyXAEJMJL1sxGlqJp5nACBi8LY8ADnAXIdPYxymLe4d6/LwP3CH
 yhoMAJoq3FrRQimJMOZKUm96jW/Wo+OgesEgKtC+kaEipQ/Dwap5MLiAK/CawRZkZS0o0bjf
 HvlhJYEDOJ+V7cYHWrROZKzwW8DySNsF3UOTDU+gHW3cZSIT5uh4AW9g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Dec 2025 21:02:05 +0100
Subject: [PATCH v2 5/6] testsuite/smokey/posix-select: Move message queue
 test into own function
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-flo-fix-select-syscall-v2-5-f606e54e8d57@siemens.com>
References: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
In-Reply-To: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Andreas Ziegler <ziegler.andreas@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Preparation for extending the posix-select test suite.
Moving the content of run_posix_select() - the main entry point for the
posix_select tests - into a separate function.

No additional changes.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/posix-select/posix-select.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
index 713efa7b0..154b3d730 100644
--- a/testsuite/smokey/posix-select/posix-select.c
+++ b/testsuite/smokey/posix-select/posix-select.c
@@ -99,7 +99,7 @@ static void *mq_thread(void *cookie)
 	return NULL;
 }
 
-static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
+static int test_posix_select_with_mq(void)
 {
 	struct mq_attr qa;
 	pthread_t tcb;
@@ -142,3 +142,14 @@ out:
 
 	return ret;
 }
+
+static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
+{
+	int ret;
+
+	ret = test_posix_select_with_mq();
+	if (ret)
+		return ret;
+
+	return ret;
+}

-- 
2.39.5

