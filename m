Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7643D92
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:08 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230903150501b8edb912098659ee49
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wg+MWAeN6OJrYd++cBksy5qW/8PtA6Q/7paKoydEU78=;
 b=U10/1IrvAJVAsYN8QrMLyspQJ7weoSTnXEpneOupysQ14ah/Y+TafJUxyRc6q41+CowhxQ
 0B8NAJyCXaxMLBBqoF0P/BFe6V+Zxt1GUKK1VlANBUAVoNqrzvNhDCR1r1CGwqVwW9ZAko63
 6n7SOjKCiKyrOdclQT8fYSeGCEawI=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 14/20] testsuite/smokey/rtdm: Remove dead code
Date: Sun,  3 Sep 2023 17:04:51 +0200
Message-Id: <86909f9e63a176a50c62c467b3e45d1121b2f4fa.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

This was left unused behind by e945350051d4.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/rtdm/rtdm.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/testsuite/smokey/rtdm/rtdm.c b/testsuite/smokey/rtdm/rtdm.c
index 6ad0d6d7ad..785132a147 100644
--- a/testsuite/smokey/rtdm/rtdm.c
+++ b/testsuite/smokey/rtdm/rtdm.c
@@ -18,18 +18,6 @@ smokey_test_plugin(rtdm,
 		   "Check core interface to RTDM services."
 );
 
-#define NS_PER_MS (1000000)
-
-static inline unsigned long long timer_get_tsc(void)
-{
-	return clockobj_get_tsc();
-}
-
-static inline unsigned long long timer_tsc2ns(unsigned long long tsc)
-{
-	return clockobj_tsc_to_ns(tsc);
-}
-
 static void check_inner(const char *fn, int line, const char *msg,
 			int status, int expected)
 {
-- 
2.35.3

