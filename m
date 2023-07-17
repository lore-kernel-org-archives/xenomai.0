Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBCA92D
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 09:20:30 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230717091014640706431204ba3b54
        for <xenomai@lists.linux.dev>;
        Mon, 17 Jul 2023 11:10:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2vHiC4dswiZLYbxQgzbRbmUdp+60dZ4HFowG2WEQUKo=;
 b=E030O/SQU+QjZ3C2ZlilQUlR+IKwqOBQS/bZzy0zRZCUoeVQnz8w88u4T2kRCmPEQGKy1v
 PdUtpgMzdmcvigK0rsUEuavubMxqxv/JsjsjWXsntpMRrHOLhOrYwR7JLQUZd4rZ7fYPBzpE
 W88nHEdm0gR84Jke07J2O8MEle7xE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 17 Jul 2023 11:10:13 +0200
Subject: [PATCH v2 1/4] cobalt/posix/syscall32: Remove unused
 mq_fetch_timeout
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v2-1-b4e888eca2d9@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Removal of unused (and broken) code. Using cobalt_get_u_timespec would
have been wrong and sys32_fetch_timespec would have been correct.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/syscall32.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 780d276b1..c82cc60a2 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -318,12 +318,6 @@ COBALT_SYSCALL32emu(mq_timedreceive64, primary,
 	return ret ?: cobalt_copy_to_user(u_len, &clen, sizeof(*u_len));
 }
 
-static inline int mq_fetch_timeout(struct timespec64 *ts,
-				   const void __user *u_ts)
-{
-	return u_ts == NULL ? -EFAULT : cobalt_get_u_timespec(ts, u_ts);
-}
-
 COBALT_SYSCALL32emu(mq_notify, primary,
 		    (mqd_t fd, const struct compat_sigevent *__user u_cev))
 {

-- 
2.39.2

