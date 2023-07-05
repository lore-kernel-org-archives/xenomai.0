Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A9136C
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:48:35 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202307050638263b395188a86a2cde6c
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kgAuvjKFETo+3RM7rlwO+Tjpg0zCU0AmLjX+Z1QzLn8=;
 b=fR5NejhgxZrGfLujsB32R1SX8xwWp8/sqNt6JZcVUoysGKSFmW8EAVsJjOiRQ1cCjD9Gxo
 mU5szfkqIHdmkLGuoYhCWvwYCJnf+pKQ5ykcO/GUIbNgpGhDNJmhxEDNYIMzE8Pn6fxbwOie
 KeRKH+2j+xrXblS9djQ8ZEjmh9SrA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:27 +0200
Subject: [PATCH 05/12] y2038: cobalt/uapi: Introduce xntimespec for struct
 sched_param_ex API
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-5-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

We have to deal with several aspects that come together here:
  - We are at uapi level here, so contract between Cobalt (Xenomai
    kernel part) and libcobalt (userspace)

  - Both worlds include this header file. The kernel is not allowed to
    use any type definition coming from libc (struct timespec included).
    For userspace we have to use struct timespec because we want to
    turn on y2038 support with compile time switches.

    To fulfill this requirement the xntimespec macro is introduced.
    For userland it's struct timespec, for kernel space it's struct
    __kernel_old_timespec, which is binary compatible to the previously
    used struct __user_old_timespec.

    struct __user_old_timespec is a Xenomai specific type and will be
    removed and cleaned up as a follow-up.

  - All struct sched_param_ex related types are not usable for time64
    related services (kernel part). Related entry points are using types
    around struct sched_param_ex64 already.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/sched.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
index 14095870f..730456d89 100644
--- a/include/cobalt/uapi/sched.h
+++ b/include/cobalt/uapi/sched.h
@@ -31,17 +31,23 @@
 #define sched_ss_max_repl	sched_u.ss.__sched_max_repl
 #endif	/* !SCHED_SPORADIC */
 
+#ifdef __KERNEL__
+#define xntimespec	__kernel_old_timespec
+#else
+#define xntimespec	timespec
+#endif
+
 struct __sched_ss_param {
 	int __sched_low_priority;
-	struct __user_old_timespec __sched_repl_period;
-	struct __user_old_timespec __sched_init_budget;
+	struct xntimespec __sched_repl_period;
+	struct xntimespec __sched_init_budget;
 	int __sched_max_repl;
 };
 
 #define sched_rr_quantum	sched_u.rr.__sched_rr_quantum
 
 struct __sched_rr_param {
-	struct __user_old_timespec __sched_rr_quantum;
+	struct xntimespec __sched_rr_quantum;
 };
 
 #ifndef SCHED_TP
@@ -54,8 +60,8 @@ struct __sched_tp_param {
 };
 
 struct sched_tp_window {
-	struct __user_old_timespec offset;
-	struct __user_old_timespec duration;
+	struct xntimespec offset;
+	struct xntimespec duration;
 	int ptid;
 };
 

-- 
2.39.2

