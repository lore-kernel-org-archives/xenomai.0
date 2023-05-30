Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD019924
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 18:57:14 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202305301857051e3a51e6203b0604c1
        for <xenomai@lists.linux.dev>;
        Tue, 30 May 2023 20:57:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DIr1HJgTYBM+1/uaeuO5nv/TXIomo3aq1DKAcCjXpkk=;
 b=Ca0ockm+P9qfbKXns/0NvX6dKB+bakqs1jSXrKF0fzH7ZDMlYjFFv0xR0xOyaoXl7dRi7c
 7wX1g/5dn/7Z4IYoNaip6seZLGhySNuF/rgRnDMHgawHfYBGgi7GGFwYspNC8ygTlQ7/OAUR
 ZgjJ/VceArKHOZsA6MS4IbFHT8MhU=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 30 May 2023 20:57:05 +0200
Subject: [PATCH v3 2/4] y2038: cobalt/posix/select: Adding pselect64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230516-florian-y2038-part-three-v3-2-ecb4d58538d7@siemens.com>
References: <20230516-florian-y2038-part-three-v3-0-ecb4d58538d7@siemens.com>
In-Reply-To: <20230516-florian-y2038-part-three-v3-0-ecb4d58538d7@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This is not a full implementation of pselect() as we do not support
waiting for signals yet. The xnsynch infrastructure is not prepared
for that.

We will not wrap pselect() in userspace. We will only use the new
syscall for providing y2038 safety for select().

Another reason against a full pselec64 implementation is the fact that
the XENOMAI_SYSCALLx() infrastructure ends at XENOMAI_SYSCALL5(),
a real pselect64() implementation would require XENOMAI_SYSCALL6().

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/io.c           | 32 ++++++++++++++++++++++++++++++++
 kernel/cobalt/posix/io.h           |  8 +++++++-
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 2dca90071..3e65efaab 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -140,6 +140,7 @@
 #define sc_cobalt_timer_gettime64		117
 #define sc_cobalt_timerfd_settime64		118
 #define sc_cobalt_timerfd_gettime64		119
+#define sc_cobalt_pselect64			120
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 786cb8ea9..f8e1b91c3 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -393,3 +393,35 @@ COBALT_SYSCALL(select, primary,
 
 	return ret;
 }
+
+COBALT_SYSCALL(pselect64, primary,
+	       (int nfds,
+		fd_set __user *u_rfds,
+		fd_set __user *u_wfds,
+		fd_set __user *u_xfds,
+		struct __kernel_timespec __user *u_ts))
+{
+	struct timespec64 ts64, *to = NULL;
+	int ret = 0;
+
+	if (u_ts) {
+		ret = cobalt_get_timespec64(&ts64, u_ts);
+		to = &ts64;
+	}
+
+	if (ret)
+		return ret;
+
+	ret = __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, to, false);
+
+	/*
+	 * Normally pselect() would not write back the modified timeout. As we
+	 * only use it for keeping select() y2038 safe we do it here as well.
+	 *
+	 * See CoBaLt_select() for some notes about error handling.
+	 */
+	if (u_ts)
+		cobalt_put_timespec64(&ts64, u_ts);
+
+	return ret;
+}
diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
index 1d9ee0918..ca46aa309 100644
--- a/kernel/cobalt/posix/io.h
+++ b/kernel/cobalt/posix/io.h
@@ -24,7 +24,7 @@
 #include <cobalt/kernel/select.h>
 
 int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
-		    void __user *u_xfds, void __user *u_tv, bool compat);
+		    void __user *u_xfds, struct timespec64 *to, bool compat);
 
 COBALT_SYSCALL_DECL(open,
 		    (const char __user *u_path, int oflag));
@@ -76,4 +76,10 @@ COBALT_SYSCALL_DECL(select,
 		     fd_set __user *u_xfds,
 		     struct __kernel_old_timeval __user *u_tv));
 
+COBALT_SYSCALL_DECL(pselect64, (int nfds,
+				fd_set __user *u_rfds,
+				fd_set __user *u_wfds,
+				fd_set __user *u_xfds,
+				struct __kernel_timespec __user *u_tv));
+
 #endif /* !_COBALT_POSIX_IO_H */
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index f2ffdb3a2..47dc77e1c 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -172,7 +172,8 @@
 		__cobalt_symbolic_syscall(timer_settime64),		\
 		__cobalt_symbolic_syscall(timer_gettime64),		\
 		__cobalt_symbolic_syscall(timerfd_settime64),		\
-		__cobalt_symbolic_syscall(timerfd_gettime64))
+		__cobalt_symbolic_syscall(timerfd_gettime64),		\
+		__cobalt_symbolic_syscall(pselect64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),

-- 
2.39.2

