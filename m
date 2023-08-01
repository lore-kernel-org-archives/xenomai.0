Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123311F955
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 09:29:51 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202308010929430f46b0d0f574f2f9b9
        for <xenomai@lists.linux.dev>;
        Tue, 01 Aug 2023 11:29:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2vHiC4dswiZLYbxQgzbRbmUdp+60dZ4HFowG2WEQUKo=;
 b=jdRYsqOIgdlqm/VtxQo81v7EeB6Fh0zgZSfi0QVS64MAlRb0TY5KUjU2okEp0JakuT3xWs
 qd8RF7HdrxtEad3ASQA0dSOdMc/cd83bigWWTN9Q+LSLLGcuI27OywFDwIGrSagn/zj7Le6X
 dcbr3jdEKoJ868nwC0v2piEBWkEz0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 01 Aug 2023 11:29:35 +0200
Subject: [PATCH v3 1/7] cobalt/posix/syscall32: Remove unused
 mq_fetch_timeout
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v3-1-2aea39ad909a@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
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

