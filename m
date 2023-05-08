Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E5154B9
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 08:13:38 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023050808132885dac2497c66f15cce
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 10:13:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7HhdOZspP6hN75sX6vNOSoepsLtSCMJelGYKwE5Q1LM=;
 b=nwBcEK4AJJB0p2LVmLji/apWqMTgkV2J1Wvw70cYiXjTQt5LRotqsozjMnc/3aNaPnZTH7
 MOKn45k9ma8YuQNpw8ccBEc7qWhYcZ0+Gjuh+8FaAmyQi9jsWTK1A72afBKduIteLspmcDGX
 0SxdP4UjLKX0JEGLZTb6ZjLVAkepo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 08 May 2023 10:13:30 +0200
Subject: [PATCH 08/13] y2038: cobalt/posix/timerfd: Adding
 timerfd_settime64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v1-8-a417812fba85@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Add a syscall specific for timerfd_settime with 64bit time_t.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/timerfd.c      | 29 ++++++++++++++++++++++++++++-
 kernel/cobalt/posix/timerfd.h      |  5 +++++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 24e759eef..b8271618f 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -138,6 +138,7 @@
 #define sc_cobalt_cond_wait_prologue64		115
 #define sc_cobalt_timer_settime64		116
 #define sc_cobalt_timer_gettime64		117
+#define sc_cobalt_timerfd_settime64		118
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/timerfd.c b/kernel/cobalt/posix/timerfd.c
index 2fbe152a5..9b2683ad9 100644
--- a/kernel/cobalt/posix/timerfd.c
+++ b/kernel/cobalt/posix/timerfd.c
@@ -18,6 +18,7 @@
 
 #include <linux/timerfd.h>
 #include <linux/err.h>
+#include <cobalt/kernel/time.h>
 #include <cobalt/kernel/timer.h>
 #include <cobalt/kernel/select.h>
 #include <rtdm/fd.h>
@@ -295,7 +296,33 @@ COBALT_SYSCALL(timerfd_settime, primary,
 		return ret;
 
 	if (old_value) {
-		ret = cobalt_copy_to_user(old_value, &ovalue, sizeof(ovalue));
+		ret = cobalt_put_u_itimerspec(old_value, &ovalue);
+		value.it_value.tv_sec = 0;
+		value.it_value.tv_nsec = 0;
+		__cobalt_timerfd_settime(fd, flags, &value, NULL);
+	}
+
+	return ret;
+}
+
+COBALT_SYSCALL(timerfd_settime64, primary,
+	       (int fd, int flags,
+		const struct __kernel_itimerspec __user *new_value,
+		struct __kernel_itimerspec __user *old_value))
+{
+	struct itimerspec64 ovalue, value;
+	int ret;
+
+	ret = cobalt_get_itimerspec64(&value, new_value);
+	if (ret)
+		return ret;
+
+	ret = __cobalt_timerfd_settime(fd, flags, &value, &ovalue);
+	if (ret)
+		return ret;
+
+	if (old_value) {
+		ret = cobalt_put_itimerspec64(old_value, &ovalue);
 		value.it_value.tv_sec = 0;
 		value.it_value.tv_nsec = 0;
 		__cobalt_timerfd_settime(fd, flags, &value, NULL);
diff --git a/kernel/cobalt/posix/timerfd.h b/kernel/cobalt/posix/timerfd.h
index 245b8698b..ae9945152 100644
--- a/kernel/cobalt/posix/timerfd.h
+++ b/kernel/cobalt/posix/timerfd.h
@@ -36,6 +36,11 @@ COBALT_SYSCALL_DECL(timerfd_settime,
 		     const struct __user_old_itimerspec __user *new_value,
 		     struct __user_old_itimerspec __user *old_value));
 
+COBALT_SYSCALL_DECL(timerfd_settime64,
+		    (int fd, int flags,
+		     const struct __kernel_itimerspec __user *new_value,
+		     struct __kernel_itimerspec __user *old_value));
+
 COBALT_SYSCALL_DECL(timerfd_gettime,
 		    (int fd, struct __user_old_itimerspec __user *curr_value));
 
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index dc4f53a5a..3d396674c 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -170,7 +170,8 @@
 		__cobalt_symbolic_syscall(recvmmsg64),			\
 		__cobalt_symbolic_syscall(cond_wait_prologue64),	\
 		__cobalt_symbolic_syscall(timer_settime64),		\
-		__cobalt_symbolic_syscall(timer_gettime64))
+		__cobalt_symbolic_syscall(timer_gettime64),		\
+		__cobalt_symbolic_syscall(timerfd_settime64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),

-- 
2.39.2

