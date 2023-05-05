Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE64C7C
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:10 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230505072104c0aa49651f5d3d3777
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9YnKgDE4qW2ZSfBXwSmN8zMiBJwhvBovyo5uam1EcTM=;
 b=QGd420RRIAPPxlRtWQG88wGaEFUr1a8hVdT0cN0aYsrJAlgxUf1KGNQou2dofBhKpm4HSs
 bdcNN9ZgFAlIbWnPu3ZWcNEEIpEzaeWSN8cwzimgEpQLdfObv2JS1/yB2bwCTJIAWWsUnaPJ
 zWABWnDXRU5+x9sMYxjnEIz73qZ7A=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:07 +0200
Subject: [PATCH 12/17] y2038: cobalt: Cleanup code style of time.{c,h}
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-12-64a972ff2189@siemens.com>
References: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
In-Reply-To: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No functional changes. Fixing some code style issues.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/time.h | 2 +-
 kernel/cobalt/time.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/cobalt/kernel/time.h b/include/cobalt/kernel/time.h
index e48022f87..a55398068 100644
--- a/include/cobalt/kernel/time.h
+++ b/include/cobalt/kernel/time.h
@@ -26,6 +26,6 @@ int cobalt_get_timespec64(struct timespec64 *ts,
  * @return 0 on success, -EFAULT otherwise
  */
 int cobalt_put_timespec64(const struct timespec64 *ts,
-			   struct __kernel_timespec __user *uts);
+			  struct __kernel_timespec __user *uts);
 
 #endif //_COBALT_KERNEL_TIME_H
diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
index cb152fc7a..27dbf8290 100644
--- a/kernel/cobalt/time.c
+++ b/kernel/cobalt/time.c
@@ -27,11 +27,11 @@ int cobalt_get_timespec64(struct timespec64 *ts,
 }
 
 int cobalt_put_timespec64(const struct timespec64 *ts,
-		   struct __kernel_timespec __user *uts)
+			  struct __kernel_timespec __user *uts)
 {
 	struct __kernel_timespec kts = {
 		.tv_sec = ts->tv_sec,
-		.tv_nsec = ts->tv_nsec
+		.tv_nsec = ts->tv_nsec,
 	};
 
 	return cobalt_copy_to_user(uts, &kts, sizeof(kts)) ? -EFAULT : 0;

-- 
2.39.2

