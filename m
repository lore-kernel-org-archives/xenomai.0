Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FC4C7B
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:06 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230505072058a3bf83563c4ffe4ddf
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:20:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Fo9F24ra/qDZWNkIlXakBmXUi5d9Y+bA78GgoOygwIo=;
 b=oOZQjxgehXbiv57iGxGRgJLi7r0Q0kW3m7gjbtS2b8xEQvtvUmi5WXwZHNMzJx17h7Z171
 SbOWQPqTN+O7kKTqayzrDwpQfjQHE44PQbJELd+2thjjbkn462h5mUzhR0RJbwrjwNQkGnO4
 waqdrFE0FTYdfXKZQU2AjpF9bGa40=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:20:56 +0200
Subject: [PATCH 01/17] y2038: cobalt: posix/sem: Remove compat syscall for
 sem_timedwait64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-1-64a972ff2189@siemens.com>
References: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
In-Reply-To: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/sem.c       | 22 ++++++++--------------
 kernel/cobalt/posix/sem.h       |  3 ---
 kernel/cobalt/posix/syscall32.c |  7 -------
 kernel/cobalt/posix/syscall32.h |  4 ----
 4 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index 71b8c52f5..aca03a555 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -360,18 +360,6 @@ int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
 	return ret;
 }
 
-int __cobalt_sem_timedwait64(struct cobalt_sem_shadow __user *u_sem,
-			     const struct __kernel_timespec __user *u_ts)
-{
-	int ret = 1;
-	struct timespec64 ts64;
-
-	if (u_ts)
-		ret = cobalt_get_timespec64(&ts64, u_ts);
-
-	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
-}
-
 static int sem_post(xnhandle_t handle)
 {
 	struct cobalt_sem *sem;
@@ -472,8 +460,8 @@ COBALT_SYSCALL(sem_timedwait, primary,
 	       (struct cobalt_sem_shadow __user *u_sem,
 		const struct __user_old_timespec __user *u_ts))
 {
-	int ret = 1;
 	struct timespec64 ts64;
+	int ret = 1;
 
 	if (u_ts)
 		ret = cobalt_get_u_timespec(&ts64, u_ts);
@@ -485,7 +473,13 @@ COBALT_SYSCALL(sem_timedwait64, primary,
 	       (struct cobalt_sem_shadow __user *u_sem,
 		const struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_sem_timedwait64(u_sem, u_ts);
+	struct timespec64 ts64;
+	int ret = 1;
+
+	if (u_ts)
+		ret = cobalt_get_timespec64(&ts64, u_ts);
+
+	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
 
 COBALT_SYSCALL(sem_trywait, primary,
diff --git a/kernel/cobalt/posix/sem.h b/kernel/cobalt/posix/sem.h
index d7dbb9098..e1e4d68f0 100644
--- a/kernel/cobalt/posix/sem.h
+++ b/kernel/cobalt/posix/sem.h
@@ -66,9 +66,6 @@ __cobalt_sem_open(struct cobalt_sem_shadow __user *usm,
 int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
 			   const struct timespec64 *ts);
 
-int __cobalt_sem_timedwait64(struct cobalt_sem_shadow __user *u_sem,
-			     const struct __kernel_timespec __user *u_ts);
-
 int __cobalt_sem_destroy(xnhandle_t handle);
 
 void cobalt_nsem_reclaim(struct cobalt_process *process);
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index b65a0a760..2b4911c59 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -137,13 +137,6 @@ COBALT_SYSCALL32emu(sem_timedwait, primary,
 	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
 
-COBALT_SYSCALL32emu(sem_timedwait64, primary,
-		    (struct cobalt_sem_shadow __user *u_sem,
-		     const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_sem_timedwait64(u_sem, u_ts);
-}
-
 COBALT_SYSCALL32emu(clock_getres, current,
 		    (clockid_t clock_id,
 		     struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 55f08121c..f36fff272 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -293,8 +293,4 @@ COBALT_SYSCALL32emu_DECL(sem_timedwait,
 			 (struct cobalt_sem_shadow __user *u_sem,
 			  const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(sem_timedwait64,
-			 (struct cobalt_sem_shadow __user *u_sem,
-			  const struct __kernel_timespec __user *u_ts));
-
 #endif /* !_COBALT_POSIX_SYSCALL32_H */

-- 
2.39.2

