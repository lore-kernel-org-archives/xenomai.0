Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BBF4C89
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:09 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202305050721064a11767e463cb0332c
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BZfqzB9DvUyGJAXEojdmVFNo3ViVAWUYdVCoI1i3p3w=;
 b=kssposGJ/cwCjUdD6LJ7DFRCQLaWtOUpBaonq+grU655xwy3A5rNtosBw+vWyKZVgvCLcU
 Qy/rLtdX4xBVx3WyDUmVSLvCi9LUWl6A6aS2H8wyB3PuPWCVN/VDPMlY4MetTN/0LSK53KjS
 OAggFPbmkeQmdZgNsowkSZIWIltE4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:11 +0200
Subject: [PATCH 16/17] y2038: cobalt/posix/clock: Use timespec64_valid()
 for validation
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-16-64a972ff2189@siemens.com>
References: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
In-Reply-To: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No need to re-code the timespec validation, we can just use the
available helper.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/clock.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 266ccef52..48cd87aef 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -286,10 +286,7 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 	    clock_id != CLOCK_REALTIME)
 		return -EOPNOTSUPP;
 
-	if (rqt->tv_sec < 0)
-		return -EINVAL;
-
-	if ((unsigned long)rqt->tv_nsec >= ONE_BILLION)
+	if (!timespec64_valid(rqt))
 		return -EINVAL;
 
 	if (flags & ~TIMER_ABSTIME)

-- 
2.39.2

