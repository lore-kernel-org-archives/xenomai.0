Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F71D52B
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 14:50:29 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305151450240f2e352657656385e4
        for <xenomai@lists.linux.dev>;
        Mon, 15 May 2023 16:50:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sORxsgI/5yUUdgWYdnvchSSsrSb8vyNRJvbQ7OeHcdw=;
 b=T5x+OUEIsPJN/eXy+Qx7ONFc50MkaYPZusENiZ4y563s3Ht5Kdrh4eWfsiVOLQDVFuWjWl
 hl7Yp4GP0u72gs8svLgUvc1my3KN2exJ5nosqgJmD7UxTpERRBCz8ocOYegeMvsLdwiyckyX
 VtmvGYtaij/wU7+xj6kowmxp4tRIY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 15 May 2023 16:50:06 +0200
Subject: [PATCH v2 06/14] y2038: cobalt/posix/timer: Adding timer_gettime64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v2-6-a12f69d870d7@siemens.com>
References: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Add a syscall specific for timer_gettime with 64bit time_t.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/timer.c        | 13 +++++++++++++
 kernel/cobalt/posix/timer.h        |  3 +++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 77184bd22..24e759eef 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -137,6 +137,7 @@
 #define sc_cobalt_recvmmsg64			114
 #define sc_cobalt_cond_wait_prologue64		115
 #define sc_cobalt_timer_settime64		116
+#define sc_cobalt_timer_gettime64		117
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
index 3c7579def..0f111a42c 100644
--- a/kernel/cobalt/posix/timer.c
+++ b/kernel/cobalt/posix/timer.c
@@ -534,6 +534,19 @@ COBALT_SYSCALL(timer_gettime, current,
 	return cobalt_put_u_itimerspec(u_val, &val);
 }
 
+COBALT_SYSCALL(timer_gettime64, current,
+	       (timer_t tm, struct __kernel_itimerspec __user *u_val))
+{
+	struct itimerspec64 val;
+	int ret;
+
+	ret = __cobalt_timer_gettime(tm, &val);
+	if (ret)
+		return ret;
+
+	return cobalt_put_itimerspec64(u_val, &val);
+}
+
 COBALT_SYSCALL(timer_getoverrun, current, (timer_t timerid))
 {
 	struct cobalt_timer *timer;
diff --git a/kernel/cobalt/posix/timer.h b/kernel/cobalt/posix/timer.h
index 16d3a572a..864c780e8 100644
--- a/kernel/cobalt/posix/timer.h
+++ b/kernel/cobalt/posix/timer.h
@@ -86,6 +86,9 @@ COBALT_SYSCALL_DECL(timer_settime64,
 COBALT_SYSCALL_DECL(timer_gettime,
 		    (timer_t tm, struct __user_old_itimerspec __user *u_val));
 
+COBALT_SYSCALL_DECL(timer_gettime64,
+		    (timer_t tm, struct __kernel_itimerspec __user *u_val));
+
 COBALT_SYSCALL_DECL(timer_getoverrun, (timer_t tm));
 
 #endif /* !_COBALT_POSIX_TIMER_H */
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 5f99b1162..dc4f53a5a 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -169,7 +169,8 @@
 		__cobalt_symbolic_syscall(event_wait64),		\
 		__cobalt_symbolic_syscall(recvmmsg64),			\
 		__cobalt_symbolic_syscall(cond_wait_prologue64),	\
-		__cobalt_symbolic_syscall(timer_settime64))
+		__cobalt_symbolic_syscall(timer_settime64),		\
+		__cobalt_symbolic_syscall(timer_gettime64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),

-- 
2.39.2

