Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CF636
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:38:33 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202307050638283e2fbf991eb7bbf632
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=u30U2hmJTB4JSsy7xOWtZ6CNRu8zfOfAdeSMP7oMdyg=;
 b=g9Vkxfg3S7/3BnNnMTzvY5SMWTVgaEfAc5GxnKqHoJM0UxR3embBBqm9ujoZ3tDcTH2iPU
 xRs3gynLVWmnEOMyan/M6Hd/k/nijKpvbHzISuGK4wFRWngz3Yvr081pmQXTtx5GnLJY8bIe
 WxLG8VQ5sFR9Rd12qYrWb5Owy2mFg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:33 +0200
Subject: [PATCH 11/12] y2038: testsuite/smokey/y2038: Fix normalization of
 struct xn_timespec64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-11-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

We have to increment the seconds if the nanosecond field got too big.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 0ee0bc48c..0b908f3ac 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -69,7 +69,7 @@ struct xn_timex64 {
 static void ts_normalise(struct xn_timespec64 *ts)
 {
 	while (ts->tv_nsec >= NSEC_PER_SEC) {
-		ts->tv_nsec += 1;
+		ts->tv_sec += 1;
 		ts->tv_nsec -= NSEC_PER_SEC;
 	}
 

-- 
2.39.2

