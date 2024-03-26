Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3880C0F
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448992; cv=none; b=ILZVamiytJEa0iY8gh9ti3lvtcgsNAM1BTxdUvwJVRtrrS4DWLSZRidZIHM2NqwYVY1tQUIaxmTioqiyclUi0t7ka2gEU3dERUT8x5KerWW1tejjWEzDyqemLVFow/0pzmcB5r5MS923yJ1FDbTvcu6tPaGs/G8ufhhLaIZxTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448992; c=relaxed/simple;
	bh=J+k44u0ovKziPPGQGBsxOGLNiEe/MUnJ5tBKd1nv0S8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C70Y//FMTmPdOq3PEl3xrveFu77BCcpLJvLZMtavl8e59lLzAflp4ma7nAX423Q1ics6RnnBsVSxSEaw4Ygu3PDwUWT8SDpd4iz9RLGovMHKvfuqmTN7YZfAH8DoiXR4ZCkbZiiuanb5H4yu0ZxdqQiOH76Fv7u1lBmpLcDozEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5A3AE6450960
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 11:29:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zSKFhHNPbRvJ; Tue, 26 Mar 2024 11:29:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D75986450973;
	Tue, 26 Mar 2024 11:29:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CKVS9A7GwjQb; Tue, 26 Mar 2024 11:29:45 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id AA6E86343B21;
	Tue, 26 Mar 2024 11:29:45 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] Alchemy: Fix rt_task_unblock() for RT_MUTEX
Date: Tue, 26 Mar 2024 11:29:33 +0100
Message-Id: <20240326102934.15109-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Starting with Xenomai 3, RT_MUTEX is based on libcobalt's pthread mutex
implementation.
POSIX requires that pthread_mutex_lock() and pthread_mutex_timedlocks sha=
ll
not return EINTR, this requirement breaks rt_task_unblock() if a RT_TASK
blocks on a RT_MUTEX.

To restore the functionality provide a new flag to __pthread_mutex_lock()
and __pthread_mutex_timedlock()
It can get interrupted and will return EINTR to the caller.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/cobalt/pthread.h |  5 +++++
 lib/alchemy/mutex.c      |  8 ++++++++
 lib/cobalt/mutex.c       | 31 ++++++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
index 1a8991f5c..4c0680053 100644
--- a/include/cobalt/pthread.h
+++ b/include/cobalt/pthread.h
@@ -170,6 +170,11 @@ int pthread_attr_getpersonality_ex(const pthread_att=
r_ex_t *attr_ex,
=20
 int pthread_attr_setpersonality_ex(pthread_attr_ex_t *attr_ex,
 				   int personality);
+
+int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex);
+
+int pthread_mutex_timedlock_eintr_np(pthread_mutex_t *mutex, const struc=
t timespec *to);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 9681e124e..27b936ac5 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -327,7 +327,11 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
=20
 	/* Slow path. */
 	if (abs_timeout =3D=3D NULL) {
+#ifdef CONFIG_XENO_MERCURY
 		ret =3D -__RT(pthread_mutex_lock(&mcb->lock));
+#else
+		ret =3D -pthread_mutex_lock_eintr_np(&mcb->lock);
+#endif
 		goto done;
 	}
=20
@@ -338,7 +342,11 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
 	 * the user timeout into something POSIX understands.
 	 */
 	clockobj_convert_clocks(&alchemy_clock, abs_timeout, CLOCK_REALTIME, &t=
s);
+#ifdef CONFIG_XENO_MERCURY
 	ret =3D -__RT(pthread_mutex_timedlock(&mcb->lock, &ts));
+#else
+	ret =3D -pthread_mutex_timedlock_eintr_np(&mcb->lock, &ts);
+#endif
 done:
 	switch (ret) {
 	case -ENOTRECOVERABLE:
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index c77d10684..3cd975a3f 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -314,7 +314,7 @@ COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mute=
x_t *mutex))
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
+static int __pthread_mutex_lock(pthread_mutex_t *mutex, bool want_eintr)
 {
 	struct cobalt_mutex_shadow *_mutex =3D
 		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
@@ -373,7 +373,7 @@ slow_path:
=20
 	do
 		ret =3D XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
-	while (ret =3D=3D -EINTR);
+	while (ret =3D=3D -EINTR && !want_eintr);
=20
 	if (ret =3D=3D 0)
 		_mutex->lockcnt =3D 1;
@@ -392,6 +392,16 @@ protect:
 	goto fast_path;
 }
=20
+COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
+{
+	return __pthread_mutex_lock(mutex, false);
+}
+
+int pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex)
+{
+	return __pthread_mutex_lock(mutex, true);
+}
+
 /**
  * Attempt, during a bounded time, to lock a mutex.
  *
@@ -423,8 +433,8 @@ protect:
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlo=
ck64,
-		   (pthread_mutex_t *mutex, const struct timespec *to))
+static int __pthread_mutex_timedlock(pthread_mutex_t *mutex, const struc=
t timespec *to,
+				     bool want_eintr)
 {
 	struct cobalt_mutex_shadow *_mutex =3D
 		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
@@ -484,7 +494,7 @@ slow_path:
 #else
 		ret =3D XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock, _mutex, to);
 #endif
-	} while (ret =3D=3D -EINTR);
+	} while (ret =3D=3D -EINTR && !want_eintr);
=20
 	if (ret =3D=3D 0)
 		_mutex->lockcnt =3D 1;
@@ -502,6 +512,17 @@ protect:
 	goto fast_path;
 }
=20
+COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlo=
ck64,
+		   (pthread_mutex_t *mutex, const struct timespec *to))
+{
+	return __pthread_mutex_timedlock(mutex, to, false);
+}
+
+int pthread_mutex_timedlock_eintr_np(pthread_mutex_t *mutex, const struc=
t timespec *to)
+{
+	return __pthread_mutex_timedlock(mutex, to, true);
+}
+
 /**
  * Attempt to lock a mutex.
  *
--=20
2.34.1

