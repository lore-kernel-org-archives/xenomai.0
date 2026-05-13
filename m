Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7437C0F8
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676618; cv=none; b=WAYLNQYF/nTla231+AHtMW4E4iwFX8tx42PPJ9aqJCz91OPyYAtOVMxhcrmxFk2HQ7T3U9B3leemMjXee20NQD41s11jECzKlkMnTARFNTPgZTR6xx4OsKVgCb8SfWvntjx6+H4LIEADBfAbjyYrLfy5Ci7wLlVjb90A1CJkFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676618; c=relaxed/simple;
	bh=AvDSi9ppdMqSr6Vbee86Hq3gYNK4PhX+0EmB0inYRFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAWJymX0qwEfS5QPUwBLkeFXEoab8AQGYIN15ck0xjAjoulYkeHiXlJxgwxYykSEbcb1LlJR5Noz915p0WsEbNFcJyeNHb8bPvNhJ9HaJ0Wpok9egofWl6k5qaoMsj0jmzKyvaUMgXnOUjxoqiSX1MVJUZ2fxW2H5p/BufaYqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=UbTisTol; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UbTisTol"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260513125012ec9f18ec31000207cb
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 14:50:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QBF+whlYBcGVCptAGFvqhVgWjWFhBrJOiJ/sYI3QAdw=;
 b=UbTisTol6NViUzqieNbQSjEovbXe/47UJYohGGLaEp93AFpMMX+kiBmpMD4svUYvdCp/Lw
 Hq8ekrRn8Sgr+tHuCE/+u4Tramkw+YvBaur6j5eHggGyvLjBB4Flb1ZhqtyZBsKCtopI40XB
 QecLJg+e8sRVlxb5jEdGsDIebwyFlv84ElJFhWxulRpgNQFVFoZWb2HS0LQJXENBculIkIMn
 nWwW3Lo7s4p0M+lNpcMtcBOGmIQdxXHaYk7zjJIbSgW6tSNDgEC1h2tWYkkG5LLFMrwgo0pv
 6WccXq4LM+P7YLSWW0IgFmUljqQamD/SbDpfVelePRi27K2zSAyy/0Hg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 13 May 2026 14:50:08 +0200
Subject: [PATCH 1/5] utils/autotune: Fix compile error seen with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260513-wip-flo-gcc-16-v1-1-120ae1287401@siemens.com>
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
In-Reply-To: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This fixes the following compile errror seen when using gcc 16 as
compiler:

autotune.c: In function ‘sampler_thread’:
autotune.c:95:34: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
   95 |         int fd = (long)arg, ret, n = 0;
      |                                  ^
cc1: all warnings being treated as errors

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 utils/autotune/autotune.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/utils/autotune/autotune.c b/utils/autotune/autotune.c
index f52733b7ae1d5a920fc7ad79c7288001dfeb8f21..2e25daef964beb96a8744e50f5ae9c62c04b64b2 100644
--- a/utils/autotune/autotune.c
+++ b/utils/autotune/autotune.c
@@ -92,7 +92,7 @@ static const struct option base_options[] = {
 
 static void *sampler_thread(void *arg)
 {
-	int fd = (long)arg, ret, n = 0;
+	int fd = (long)arg, ret;
 	__u64 timestamp = 0;
 	struct timespec now;
 
@@ -102,9 +102,7 @@ static void *sampler_thread(void *arg)
 			if (errno != EPIPE)
 				error(1, errno, "pulse failed");
 			timestamp = 0; /* Next tuning period. */
-			n = 0;
 		} else {
-			n++;
 			clock_gettime(CLOCK_MONOTONIC, &now);
 			timestamp = (__u64)now.tv_sec * 1000000000 + now.tv_nsec;
 		}

-- 
2.54.0

