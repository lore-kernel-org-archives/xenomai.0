Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256A244670
	for <xenomai@lists.linux.dev>; Fri,  5 Dec 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764926016; cv=none; b=BOU6Uw2CriA+BDrLuZU64kOTYc7+odQyxVVGy+vPlL5MiH2V6CQvnFZcQ6EBZM9Ka2ueRS6sv8gp0rnTt1kdoYS7/9S/8B3fuCM0tLn/iYEZ1S0socREQcPWSU5yptA6uxfmhpCQh7RPz1AGXy8Ga1VGkLHzCH+LJBAVTqni39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764926016; c=relaxed/simple;
	bh=7n6nm/6wfaq7YOxdBGcjruvrPnb7B7Z7Ua0kVv9J6Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mf9/a2tqJNxFf9woxDcriWaoTQ0OJJBQgNhxI0WHCn/m1NuB1iLM8xFjJDVHPjBEMTCsv1rIMcGQXzzsBT0h6QOUpcMYTXmOstfFLpmP46hRUqMoRpnbbSWZO3ZK3IgjhlhZGrDdTalW7Ljbkjg9Mht/8XvWLgRcGmTzUqBeSdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=OgyGTAy3; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="OgyGTAy3"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251205090314612c64802100020788
        for <xenomai@lists.linux.dev>;
        Fri, 05 Dec 2025 10:03:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1vNDX1clbllXpsAbPeodDZl0ATXRBttz90k6nPdZXsM=;
 b=OgyGTAy37D8fRKOxDG1voPd0VU+uXT/e669VeSA4/jjry50gdW2mkSubkM14t+vJjQG57d
 GSDmGD4tbNKfAQbZO+YF+OblumG2q6t1LKRpIZjOlBnCg2sKSPrFv8RTiqUNdBDvzxggU8cY
 Tzn2Nlw7nNILScyiPzf/k1kvQcBEG5e+2dzqU3WEgVxBJG/GbJt5kACxvl9Fxki45687yYBE
 xgmx1zQVO3eUe1zV7VEpwCFTH9C0LxvuKEdDj07TDZ6YruztCUqRbz8FakqnXkcfhSt2cZbN
 7CKbM+3OqRJZcJH3AgvYTf45MT4xHwvgidGh/SnA35HP06OF9sH8aEJA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 Dec 2025 10:03:15 +0100
Subject: [PATCH 5/6] testsuite/smokey/posix-select: Move message queue test
 into own function
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-flo-fix-select-syscall-v1-5-7f9c545a63ce@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
In-Reply-To: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
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

