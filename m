Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC542B742
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676623; cv=none; b=SRWk/B8lXJc9DGJIzCBFRBNOuSqxt8aq4mDL6O+crgjt2s3zBLhTMBy5iaQUG93lPWHNI2Efi347u0MbOBBto0RnOlE9448E1f35lw3V4D17d0nphmKTvZEYENove+n+XHlxaeQIJpzfyTtyUm2Gyt7gwNYUDsRLzFabS/SvBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676623; c=relaxed/simple;
	bh=oe9fj/GQG2f7UKdmy3DrDRAnnNlby/7GNeEsjYgdFbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7IzGK5qUvRdbN7fojh07eKFJtFvYFkE7j3cZr+ULmBVgbzj8cLTwiIZomruKQVkZX+6Q2Yy2Qk7OpRqJ3d00nZBKYij5dhlOUCgOcwpgSuKE1o+Ber2RBm8swn7deevTq20MkcTsswwv/3pIK8d2qx/EDQhQ5DHTGvK1DfxJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=eQq0V+zJ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="eQq0V+zJ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202605131250133e5eac3ae10002079f
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 14:50:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wB/5moPCM/BJ15kaJWzW2y8JYTN2w8VHwyEwwa0HPcM=;
 b=eQq0V+zJwqaylPmzpIduFIvOkB28L/eWYsbRtZxgwrBkjpnN3G8lO9Os17zD2IIVWBlEM1
 YeBOCHs/Ir+yy8zGHWmftITKpPmJTo//TzMU59gPdSVLo0X0xeuhhCiwz29OOXhoJiu5xJdb
 aBvu/1UAqdgU1meHZFB4gG8pvti1JVkplpU0/lNvKQS8Ah0kb1GvuoJMqECsRfkGSFaLdqbW
 JLXhfwOLqDUgJ5wsnXt7AcNbaTBGosymfgqvpuz/rIl23StTEJxt1Uy3NtX96Ca8mqQCdvmo
 eGf1xCsUkkicyyg3baapDhP4KwLJLjVbSaNBwzIiZXDc0cORyvkk1MvQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 13 May 2026 14:50:10 +0200
Subject: [PATCH 3/5] testsuite/smokey/vxworktests: Fix compile error seen
 with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260513-wip-flo-gcc-16-v1-3-120ae1287401@siemens.com>
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
In-Reply-To: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
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

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/vxworkstests/task-2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index 0cbb9e18a13383418c4360241ef244b8a24da975..ed3e31806baad930bb30edc53d2dc6b6e51d6277 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -23,7 +23,7 @@ static SEM_ID sem_id, fdone_sem_id;
 
 static void backgroundTask(long arg, ...)
 {
-	unsigned int safety = 100000000, count = 0;
+	unsigned int safety = 100000000;
 	int ret;
 
 	traceobj_enter(&trobj);
@@ -35,8 +35,7 @@ static void backgroundTask(long arg, ...)
 
 	traceobj_mark(&trobj, 2);
 
-	while (--safety > 0)
-		count++;
+	while (--safety > 0) {}
 
 	/*
 	 * Enter infinite pause so that any pending cancellation is

-- 
2.54.0

