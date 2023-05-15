Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32FC8E5
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 15:00:35 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230515145027a2455409ed02bfdfa2
        for <xenomai@lists.linux.dev>;
        Mon, 15 May 2023 16:50:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2+tdYfgsc/wK/GmWqw/1TdK0aojCA2MPcjNs1ByxzWs=;
 b=Oo2+58bTPeBhj2NMtKuETVmI6WaDvxVaja4u0EgKrmZxFoo+He+bWF0pEhlCnQIU64F6TU
 GLc23JzQjQDx+OjKTmUEnouTBFRgZpDAQ3eCETMImSDJ402BB8TN3ZFBWL1zTOh5h5tAGwzs
 JECNoh9BwtZHDCdWSeK8+po+I1OrE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 15 May 2023 16:50:12 +0200
Subject: [PATCH v2 12/14] y2038: cobalt/posix/timerfd: Adding
 timerfd_gettime64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v2-12-a12f69d870d7@siemens.com>
References: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Add a syscall specific for timerfd_gettime with 64bit time_t.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/timerfd.c      | 11 +++++++++++
 kernel/cobalt/posix/timerfd.h      |  3 +++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index b8271618f..2dca90071 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -139,6 +139,7 @@
 #define sc_cobalt_timer_settime64		116
 #define sc_cobalt_timer_gettime64		117
 #define sc_cobalt_timerfd_settime64		118
+#define sc_cobalt_timerfd_gettime64		119
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/timerfd.c b/kernel/cobalt/posix/timerfd.c
index 9b2683ad9..ae7578d29 100644
--- a/kernel/cobalt/posix/timerfd.c
+++ b/kernel/cobalt/posix/timerfd.c
@@ -359,3 +359,14 @@ COBALT_SYSCALL(timerfd_gettime, current,
 
 	return ret ?: cobalt_put_u_itimerspec(curr_value, &value);
 }
+
+COBALT_SYSCALL(timerfd_gettime64, current,
+	       (int fd, struct __kernel_itimerspec __user *curr_value))
+{
+	struct itimerspec64 value;
+	int ret;
+
+	ret = __cobalt_timerfd_gettime(fd, &value);
+
+	return ret ?: cobalt_put_itimerspec64(curr_value, &value);
+}
diff --git a/kernel/cobalt/posix/timerfd.h b/kernel/cobalt/posix/timerfd.h
index ae9945152..b82dac748 100644
--- a/kernel/cobalt/posix/timerfd.h
+++ b/kernel/cobalt/posix/timerfd.h
@@ -44,4 +44,7 @@ COBALT_SYSCALL_DECL(timerfd_settime64,
 COBALT_SYSCALL_DECL(timerfd_gettime,
 		    (int fd, struct __user_old_itimerspec __user *curr_value));
 
+COBALT_SYSCALL_DECL(timerfd_gettime64,
+		    (int fd, struct __kernel_itimerspec __user *curr_value));
+
 #endif /* TIMERFD_H */
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 3d396674c..f2ffdb3a2 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -171,7 +171,8 @@
 		__cobalt_symbolic_syscall(cond_wait_prologue64),	\
 		__cobalt_symbolic_syscall(timer_settime64),		\
 		__cobalt_symbolic_syscall(timer_gettime64),		\
-		__cobalt_symbolic_syscall(timerfd_settime64))
+		__cobalt_symbolic_syscall(timerfd_settime64),		\
+		__cobalt_symbolic_syscall(timerfd_gettime64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),

-- 
2.39.2

