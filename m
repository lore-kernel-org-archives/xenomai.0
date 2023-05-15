Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4EC8E5
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 14:50:25 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023051514502214baf22ad63202a207
        for <xenomai@lists.linux.dev>;
        Mon, 15 May 2023 16:50:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jtLyFV1yWLsbbxLTh4Iasu9G3Vjvg2hFnV92dxZoqLc=;
 b=jR3KANefzp8JOMQOExLPUnrrIauKtkEJSuI2yV/sRy3FwmoHIL2MNGU24pqbnjRX+BrfxQ
 fy5JFXeOHGsnqpLSXqK4gD4BE5wNrjl0zC7+VLFc4vwVgTIDG7PUHCOYYu095qXgruZYeB4G
 X0Ntb7f6FzGsrG1tnr5WR/kSxwLOA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 15 May 2023 16:50:03 +0200
Subject: [PATCH v2 03/14] y2038: cobalt/posix/timer: Use timespec64_valid()
 for validation
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v2-3-a12f69d870d7@siemens.com>
References: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No need to re-code the timespec validation, we can just use the
available helper.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/timer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
index 09843bcfb..3c7579def 100644
--- a/kernel/cobalt/posix/timer.c
+++ b/kernel/cobalt/posix/timer.c
@@ -296,9 +296,8 @@ int __cobalt_timer_setval(struct xntimer *__restrict__ timer, int clock_flag,
 		return 0;
 	}
 
-	if ((unsigned long)value->it_value.tv_nsec >= ONE_BILLION ||
-	    ((unsigned long)value->it_interval.tv_nsec >= ONE_BILLION &&
-	     (value->it_value.tv_sec != 0 || value->it_value.tv_nsec != 0)))
+	if (!timespec64_valid(&value->it_interval) ||
+	    !timespec64_valid(&value->it_value))
 		return -EINVAL;
 
 	start = ts2ns(&value->it_value) + 1;

-- 
2.39.2

