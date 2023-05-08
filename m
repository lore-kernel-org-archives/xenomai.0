Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8FC154B9
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 08:13:34 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230508081326a6474a9f0113184491
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 10:13:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=50nMXzQeB43ywJHYRlkgJwE1NxAa9SgYKN7ACr3kR98=;
 b=cq9UN9gUNgBx/PiQ7MDwyU6628ig8RBIpIB+gXQyt1AuwsHbdryyjkzW1m9cOgZYEBHv63
 Jak/OHAuEk3Z4LoOY1q93/zJeYdG0JFWN7Mmnm/gZoTFRlOPIi0mbNeGkUqCM4IfLamBAEGm
 Dc3pjnjxmHUO/QacHsYfmWDWpN3mg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 08 May 2023 10:13:24 +0200
Subject: [PATCH 02/13] y2038: cobalt/posix/timer: Adding timer_settime64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v1-2-a417812fba85@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Add a syscall specific for timer_settime with 64bit time_t.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/timer.c        | 32 +++++++++++++++++++++++++++++---
 kernel/cobalt/posix/timer.h        |  5 +++++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 9646a0d97..77184bd22 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -136,6 +136,7 @@
 #define sc_cobalt_event_wait64			113
 #define sc_cobalt_recvmmsg64			114
 #define sc_cobalt_cond_wait_prologue64		115
+#define sc_cobalt_timer_settime64		116
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
index a115ded53..3c7579def 100644
--- a/kernel/cobalt/posix/timer.c
+++ b/kernel/cobalt/posix/timer.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#include <cobalt/kernel/time.h>
 #include <linux/module.h>
 #include <linux/cred.h>
 #include <linux/err.h>
@@ -295,9 +296,8 @@ int __cobalt_timer_setval(struct xntimer *__restrict__ timer, int clock_flag,
 		return 0;
 	}
 
-	if ((unsigned long)value->it_value.tv_nsec >= ONE_BILLION ||
-	    ((unsigned long)value->it_interval.tv_nsec >= ONE_BILLION &&
-	     (value->it_value.tv_sec != 0 || value->it_value.tv_nsec != 0)))
+	if (!timespec64_valid(&value->it_interval) ||
+	    !timespec64_valid(&value->it_value))
 		return -EINVAL;
 
 	start = ts2ns(&value->it_value) + 1;
@@ -495,6 +495,32 @@ COBALT_SYSCALL(timer_settime, primary,
 	return 0;
 }
 
+COBALT_SYSCALL(timer_settime64, primary,
+	       (timer_t tm, int flags,
+		const struct __kernel_itimerspec __user *u_newval,
+		struct __kernel_itimerspec __user *u_oldval))
+{
+	struct itimerspec64 newv, oldv, *oldvp = &oldv;
+	int ret;
+
+	if (u_oldval == NULL)
+		oldvp = NULL;
+
+	if (cobalt_get_itimerspec64(&newv, u_newval))
+		return -EFAULT;
+
+	ret = __cobalt_timer_settime(tm, flags, &newv, oldvp);
+	if (ret)
+		return ret;
+
+	if (oldvp && cobalt_put_itimerspec64(u_oldval, oldvp)) {
+		__cobalt_timer_settime(tm, flags, oldvp, NULL);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 COBALT_SYSCALL(timer_gettime, current,
 	       (timer_t tm, struct __user_old_itimerspec __user *u_val))
 {
diff --git a/kernel/cobalt/posix/timer.h b/kernel/cobalt/posix/timer.h
index 3b580d470..16d3a572a 100644
--- a/kernel/cobalt/posix/timer.h
+++ b/kernel/cobalt/posix/timer.h
@@ -78,6 +78,11 @@ COBALT_SYSCALL_DECL(timer_settime,
 		     const struct __user_old_itimerspec __user *u_newval,
 		     struct __user_old_itimerspec __user *u_oldval));
 
+COBALT_SYSCALL_DECL(timer_settime64,
+		    (timer_t tm, int flags,
+		     const struct __kernel_itimerspec __user *u_newval,
+		     struct __kernel_itimerspec __user *u_oldval));
+
 COBALT_SYSCALL_DECL(timer_gettime,
 		    (timer_t tm, struct __user_old_itimerspec __user *u_val));
 
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index c7eef7fba..5f99b1162 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -168,7 +168,8 @@
 		__cobalt_symbolic_syscall(monitor_wait64),		\
 		__cobalt_symbolic_syscall(event_wait64),		\
 		__cobalt_symbolic_syscall(recvmmsg64),			\
-		__cobalt_symbolic_syscall(cond_wait_prologue64))
+		__cobalt_symbolic_syscall(cond_wait_prologue64),	\
+		__cobalt_symbolic_syscall(timer_settime64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),

-- 
2.39.2

