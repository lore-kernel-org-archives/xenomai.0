Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF010FE
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:48:34 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230705063825813d8c6ffc0fcf6514
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2M6pdvk3IoHXvgVDeK7nkHulnA7zo3YMFOLV2+V0tYw=;
 b=PVEjrlMyvHzs5c93XaVKZu5ist3u4wY/44or/u//c37I7SYBbemvf/gfbw1hC2jbtpm9KS
 9501FwmBywpxKWViGAW035udVl+8wRDi4/SEifP/2qlUl8i96sAqaHgBVAJs8FFuDeSQmjDF
 ntypsED+bgEPq1x/RSdEvj45lCSDQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:25 +0200
Subject: [PATCH 03/12] y2038: cobalt/posix/{sched,thread}: Add time64_t
 based syscalls
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-3-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The following syscalls have been added, they are all necessary to make
the cobalt thread and sched implementation y2038 safe:
  - thread_create64
  - thread_setschedparam_ex64
  - thread_getschedparam_ex64
  - sched_setconfig_np64
  - sched_getconfig_np64
  - sched_setscheduler_ex64
  - sched_getscheduler_ex64

All services are dealing with the struct sched_param(64) data structure
which is affected due to nested struct timespecs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  7 ++++
 kernel/cobalt/posix/sched.c        | 82 ++++++++++++++++++++++++++++++++++++++
 kernel/cobalt/posix/sched.h        | 17 ++++++++
 kernel/cobalt/posix/thread.c       | 50 +++++++++++++++++++++++
 kernel/cobalt/posix/thread.h       | 13 ++++++
 kernel/cobalt/trace/cobalt-posix.h |  9 ++++-
 6 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 3e65efaab..15ad88fa7 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -141,6 +141,13 @@
 #define sc_cobalt_timerfd_settime64		118
 #define sc_cobalt_timerfd_gettime64		119
 #define sc_cobalt_pselect64			120
+#define sc_cobalt_thread_create64		121
+#define sc_cobalt_thread_setschedparam_ex64	122
+#define sc_cobalt_thread_getschedparam_ex64	123
+#define sc_cobalt_sched_setconfig_np64		124
+#define sc_cobalt_sched_getconfig_np64		125
+#define sc_cobalt_sched_setscheduler_ex64	126
+#define sc_cobalt_sched_getscheduler_ex64	127
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index 5163863c2..11920faff 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -705,6 +705,32 @@ static ssize_t sched_put_config(int policy, void __user *u_config, size_t u_len,
 	return ret ?: u_len;
 }
 
+static ssize_t sched_put_config64(int policy, void __user *u_config,
+				  size_t u_len, const union sched_config64 *cfg,
+				  size_t len)
+{
+	union sched_config64 *u_cfg = u_config;
+	int ret;
+
+	if (u_cfg == NULL)
+		return -EFAULT;
+
+	if (policy == SCHED_QUOTA) {
+		if (u_len < sizeof(cfg->quota))
+			return -EINVAL;
+		return cobalt_copy_to_user(&u_cfg->quota.info, &cfg->quota.info,
+					   sizeof(u_cfg->quota.info)) ?:
+			       sizeof(u_cfg->quota.info);
+	}
+
+	if (u_len < len)
+		return -ENOSPC;
+
+	ret = cobalt_copy_to_user(u_cfg, cfg, len);
+
+	return ret ?: u_len;
+}
+
 int __cobalt_sched_setconfig_np(int cpu, int policy,
 				void __user *u_config,
 				size_t len,
@@ -758,6 +784,15 @@ COBALT_SYSCALL(sched_setconfig_np, conforming,
 					   sched_fetch_config, sched_ack_config);
 }
 
+COBALT_SYSCALL(sched_setconfig_np64, conforming,
+	       (int cpu, int policy, union sched_config64 __user *u_config,
+		size_t len))
+{
+	return __cobalt_sched_setconfig_np(cpu, policy, u_config, len,
+					   sched_fetch_config64,
+					   sched_ack_config);
+}
+
 ssize_t __cobalt_sched_getconfig_np(int cpu, int policy,
 				    void __user *u_config,
 				    size_t len,
@@ -798,6 +833,16 @@ COBALT_SYSCALL(sched_getconfig_np, conforming,
 					   sched_fetch_config, sched_put_config);
 }
 
+COBALT_SYSCALL(sched_getconfig_np64, conforming,
+	       (int cpu, int policy,
+		union sched_config64 __user *u_config,
+		size_t len))
+{
+	return __cobalt_sched_getconfig_np(cpu, policy, u_config, len,
+					   sched_fetch_config64,
+					   sched_put_config64);
+}
+
 int __cobalt_sched_weightprio(int policy,
 			      const struct sched_param_ex64 *param_ex)
 {
@@ -886,6 +931,22 @@ COBALT_SYSCALL(sched_setscheduler_ex, conforming,
 					    u_winoff, u_promoted);
 }
 
+COBALT_SYSCALL(sched_setscheduler_ex64, conforming,
+	       (pid_t pid, int policy,
+		const struct sched_param_ex64 __user *u_param,
+		__u32 __user *u_winoff, int __user *u_promoted))
+{
+	struct sched_param_ex64 param_ex;
+	int ret;
+
+	ret = cobalt_copy_from_user(&param_ex, u_param, sizeof(param_ex));
+	if (ret)
+		return ret;
+
+	return cobalt_sched_setscheduler_ex(pid, policy, &param_ex, u_winoff,
+					    u_promoted);
+}
+
 int cobalt_sched_getscheduler_ex(pid_t pid,
 				 int *policy_r,
 				 struct sched_param_ex64 *param_ex)
@@ -930,6 +991,27 @@ COBALT_SYSCALL(sched_getscheduler_ex, current,
 	return 0;
 }
 
+COBALT_SYSCALL(sched_getscheduler_ex64, current,
+	       (pid_t pid, int __user *u_policy,
+		struct sched_param_ex64 __user *u_param))
+{
+	struct sched_param_ex64 param_ex;
+	int ret, policy;
+
+	ret = cobalt_sched_getscheduler_ex(pid, &policy, &param_ex);
+	if (ret)
+		return ret;
+
+	ret = cobalt_copy_to_user(u_param, &param_ex, sizeof(*u_param));
+	if (ret)
+		return ret;
+
+	if (cobalt_copy_to_user(u_policy, &policy, sizeof(policy)))
+		return -EFAULT;
+
+	return 0;
+}
+
 void cobalt_sched_reclaim(struct cobalt_process *process)
 {
 	struct cobalt_resources *p = &process->resources;
diff --git a/kernel/cobalt/posix/sched.h b/kernel/cobalt/posix/sched.h
index a226c39d3..34c14bd91 100644
--- a/kernel/cobalt/posix/sched.h
+++ b/kernel/cobalt/posix/sched.h
@@ -109,11 +109,19 @@ COBALT_SYSCALL_DECL(sched_setconfig_np,
 		     union sched_config __user *u_config,
 		     size_t len));
 
+COBALT_SYSCALL_DECL(sched_setconfig_np64,
+		    (int cpu, int policy, union sched_config64 __user *u_config,
+		     size_t len));
+
 COBALT_SYSCALL_DECL(sched_getconfig_np,
 		    (int cpu, int policy,
 		     union sched_config __user *u_config,
 		     size_t len));
 
+COBALT_SYSCALL_DECL(sched_getconfig_np64,
+		    (int cpu, int policy, union sched_config64 __user *u_config,
+		     size_t len));
+
 COBALT_SYSCALL_DECL(sched_setscheduler_ex,
 		    (pid_t pid,
 		     int policy,
@@ -121,11 +129,20 @@ COBALT_SYSCALL_DECL(sched_setscheduler_ex,
 		     __u32 __user *u_winoff,
 		     int __user *u_promoted));
 
+COBALT_SYSCALL_DECL(sched_setscheduler_ex64,
+		    (pid_t pid, int policy,
+		     const struct sched_param_ex64 __user *u_param,
+		     __u32 __user *u_winoff, int __user *u_promoted));
+
 COBALT_SYSCALL_DECL(sched_getscheduler_ex,
 		    (pid_t pid,
 		     int __user *u_policy,
 		     struct sched_param_ex __user *u_param));
 
+COBALT_SYSCALL_DECL(sched_getscheduler_ex64,
+		    (pid_t pid, int __user *u_policy,
+		     struct sched_param_ex64 __user *u_param));
+
 void cobalt_sched_reclaim(struct cobalt_process *process);
 
 #endif /* !_COBALT_POSIX_SCHED_H */
diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index 2fa8a9e6a..9853e6924 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/cred.h>
 #include <linux/jhash.h>
@@ -599,6 +600,22 @@ COBALT_SYSCALL(thread_setschedparam_ex, conforming,
 	return ret;
 }
 
+COBALT_SYSCALL(thread_setschedparam_ex64, conforming,
+	       (unsigned long pth, int policy,
+		const struct sched_param_ex64 __user *u_param,
+		__u32 __user *u_winoff, int __user *u_promoted))
+{
+	struct sched_param_ex64 param_ex;
+	int ret;
+
+	ret = cobalt_copy_from_user(&param_ex, u_param, sizeof(param_ex));
+	if (ret)
+		return ret;
+
+	return cobalt_thread_setschedparam_ex(pth, policy, &param_ex, u_winoff,
+					      u_promoted);
+}
+
 int cobalt_thread_getschedparam_ex(unsigned long pth,
 				   int *policy_r,
 				   struct sched_param_ex64 *param_ex)
@@ -641,6 +658,24 @@ COBALT_SYSCALL(thread_getschedparam_ex, current,
 	return cobalt_thread_put_schedparam_ex(u_param, &param_ex, policy);
 }
 
+COBALT_SYSCALL(thread_getschedparam_ex64, current,
+	       (unsigned long pth, int __user *u_policy,
+		struct sched_param_ex64 __user *u_param))
+{
+	struct sched_param_ex64 param_ex;
+	int ret, policy;
+
+	ret = cobalt_thread_getschedparam_ex(pth, &policy, &param_ex);
+	if (ret)
+		return ret;
+
+	ret = cobalt_copy_to_user(u_policy, &policy, sizeof(policy));
+	if (ret)
+		return ret;
+
+	return cobalt_copy_to_user(u_param, &param_ex, sizeof(param_ex));
+}
+
 int cobalt_thread_setschedprio(unsigned long pth,
 			       int prio,
 			       __u32 __user *u_winoff,
@@ -742,6 +777,21 @@ COBALT_SYSCALL(thread_create, init,
 	return __cobalt_thread_create(pth, policy, &param_ex, xid, u_winoff);
 }
 
+COBALT_SYSCALL(thread_create64, init,
+	       (unsigned long pth, int policy,
+		struct sched_param_ex64 __user *u_param, int xid,
+		__u32 __user *u_winoff))
+{
+	struct sched_param_ex64 param_ex;
+	int ret;
+
+	ret = cobalt_copy_from_user(&param_ex, u_param, sizeof(param_ex));
+	if (ret)
+		return ret;
+
+	return __cobalt_thread_create(pth, policy, &param_ex, xid, u_winoff);
+}
+
 struct cobalt_thread *
 cobalt_thread_shadow(struct cobalt_local_hkey *hkey,
 		     __u32 __user *u_winoff)
diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
index 8916d05b9..fb4306351 100644
--- a/kernel/cobalt/posix/thread.h
+++ b/kernel/cobalt/posix/thread.h
@@ -184,6 +184,10 @@ COBALT_SYSCALL_DECL(thread_create,
 		     struct sched_param_ex __user *u_param,
 		     int xid, __u32 __user *u_winoff));
 
+COBALT_SYSCALL_DECL(thread_create64, (unsigned long pth, int policy,
+				      struct sched_param_ex64 __user *u_param,
+				      int xid, __u32 __user *u_winoff));
+
 struct cobalt_thread *
 cobalt_thread_shadow(struct cobalt_local_hkey *lhkey,
 		     __u32 __user *u_winoff);
@@ -210,11 +214,20 @@ COBALT_SYSCALL_DECL(thread_setschedparam_ex,
 		     __u32 __user *u_winoff,
 		     int __user *u_promoted));
 
+COBALT_SYSCALL_DECL(thread_setschedparam_ex64,
+		    (unsigned long pth, int policy,
+		     const struct sched_param_ex64 __user *u_param,
+		     __u32 __user *u_winoff, int __user *u_promoted));
+
 COBALT_SYSCALL_DECL(thread_getschedparam_ex,
 		    (unsigned long pth,
 		     int __user *u_policy,
 		     struct sched_param_ex __user *u_param));
 
+COBALT_SYSCALL_DECL(thread_getschedparam_ex64,
+		    (unsigned long pth, int __user *u_policy,
+		     struct sched_param_ex64 __user *u_param));
+
 COBALT_SYSCALL_DECL(thread_setschedprio,
 		    (unsigned long pth,
 		     int prio,
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index c6c430cff..449bd1818 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -173,7 +173,14 @@
 		__cobalt_symbolic_syscall(timer_gettime64),		\
 		__cobalt_symbolic_syscall(timerfd_settime64),		\
 		__cobalt_symbolic_syscall(timerfd_gettime64),		\
-		__cobalt_symbolic_syscall(pselect64))
+		__cobalt_symbolic_syscall(pselect64),			\
+		__cobalt_symbolic_syscall(thread_create64),		\
+		__cobalt_symbolic_syscall(thread_setschedparam_ex64),	\
+		__cobalt_symbolic_syscall(thread_getschedparam_ex64),	\
+		__cobalt_symbolic_syscall(sched_setconfig_np64),	\
+		__cobalt_symbolic_syscall(sched_getconfig_np64),	\
+		__cobalt_symbolic_syscall(sched_setscheduler_ex64),	\
+		__cobalt_symbolic_syscall(sched_getscheduler_ex64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),

-- 
2.39.2

