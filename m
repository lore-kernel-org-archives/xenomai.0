Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD33B0AE1
	for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274936; cv=none; b=Yun7N5XfJNVC9lIRnyxW3q3IqIly6/A40bRSTLBk+/QshRSz9KrNpXqh8P9ea52/qYI/9PAjY+3zaGJlkMJz9BJFW/QzbICfgeWhFdpHE3v3ceH16SvLusE3arum3QmUITF1u1PQYfhUY1UxJhGGPxRIJasfmi3lGkW4IB6zLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274936; c=relaxed/simple;
	bh=GTQwnvEYh1cczC1OiEkNaBFxgAi+Buy2g4XCKwDZXX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGEGJEEttAtWA1smWDlzjHfRVSdN/jAunk6UPD4txjTW3Sgrx0nBzoxbeqyac4KpRE+cYVQhmmEZBCyFnHIjdnDx2IPhcCyzUPI9aohuJuzROvJxaBqov4z4GW0D0spni0YeUbpA4iGmrkjQsEmBqwRDIUeUX/JSebpl/puwz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=jB1eEJoB; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="jB1eEJoB"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202607170745143c21480eb500020785
        for <xenomai@lists.linux.dev>;
        Fri, 17 Jul 2026 09:45:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7qBpOs5rfYnmAGUqiLoOPHdSw3x/bu+srEAbs97lJj0=;
 b=jB1eEJoBsJ1kxAqIcrPI4zTJrVUQxF7LMNaOwpIz83wK0SrzpNAI3NWHwUofHd/G9QEOxD
 1ZzmyFNrSsJ6NwUAYFb7THI/TIFQkzpvqSXMNAljdBNlR3poap++SiayMD3UGueFDsPk5bDv
 eM3DRoxCcJ0uzZTBRF4EZDlqmi3uKvfyDlx5TndtlXGOmhevyANMurZ1mbXJJzVp+81Q8SQe
 XHb7JXA82TbWrshmhJIn3UvProAyIsTOlxBHZ8Zy1IT1uyGSLUSjtDrUu+EHOWTOXwyy/9CH
 Rb6YRrCm5hSm/XhiEkKVc2+VoNaK0j2mV5/IyU3Nc7zwfoavD8Y24UpA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 17 Jul 2026 09:45:04 +0200
Subject: [PATCH v3 1/4] utils/autotune: Fix compile error seen with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-wip-flo-gcc-16-v3-1-5429c866bcca@siemens.com>
References: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
In-Reply-To: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
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

The variable n was write-only. Removing the variable entirely as it
never contributed to the test.

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
2.55.0

