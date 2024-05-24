Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E376E128829
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539850; cv=none; b=bgWhqJVNI+J02pMo93hBAuBUT5q0hcHOUvzpPkr3ii1ML/lislxx7WzfH6e5+G9FBYOovXcmTdVMGR8YvnF7hlXXplgaz+ediJFtHEp56VyJvTPiQJsEphY5UKOlGjXFxdh36KYFdQ4eX9tp0tJuLj2Jnv1ytNbmEcJniyLvADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539850; c=relaxed/simple;
	bh=1D0k5ln6xqSpN/Maf952ZZ5jLsQPEIcyvHsks3S/pNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPEzQvrZyoj7gVMEcYzgH3P8ex8JbibduLNAD60+5I8RlAKgvPHsc46cJpxYSJJy2tjj6gi2Emd4Qr2koFsKUp/rGYPtmTT+qO+32enHlzIlXk4XPrDbfTCHe30K1cToCaOEUPSOaqlxy1q9s6rQnmt10vy4RZgoHwEfPXgvXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0D6A86195FCF;
	Fri, 24 May 2024 10:37:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Y6uvwMbqhxcW; Fri, 24 May 2024 10:37:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 83948626FAF9;
	Fri, 24 May 2024 10:37:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2gLGNmL_YkhB; Fri, 24 May 2024 10:37:18 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 501BB61B8F3E;
	Fri, 24 May 2024 10:37:18 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: lorenz@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v2 1/2] Alchemy: Fix rt_task_unblock() for RT_MUTEX
Date: Fri, 24 May 2024 10:36:41 +0200
Message-Id: <20240524083642.19434-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240524083642.19434-1-richard@nod.at>
References: <20240524083642.19434-1-richard@nod.at>
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

Co-developed-by: Lorenz Kofler <lorenz@sigma-star.at>
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/cobalt/pthread.h |  5 +++++
 lib/alchemy/mutex.c      |  8 ++++++++
 lib/cobalt/mutex.c       | 44 +++++++++++++++++++++++++++++++---------
 3 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
index 1a8991f5c..fed7dd2d8 100644
--- a/include/cobalt/pthread.h
+++ b/include/cobalt/pthread.h
@@ -170,6 +170,11 @@ int pthread_attr_getpersonality_ex(const pthread_att=
r_ex_t *attr_ex,
=20
 int pthread_attr_setpersonality_ex(pthread_attr_ex_t *attr_ex,
 				   int personality);
+
+int pthread_mutex_lock_interruptible_np(pthread_mutex_t *mutex);
+
+int pthread_timedmutex_lock_interruptible_np(pthread_mutex_t *mutex, con=
st struct timespec *to);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 9681e124e..6bec2d9bb 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -327,7 +327,11 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
=20
 	/* Slow path. */
 	if (abs_timeout =3D=3D NULL) {
+#ifdef CONFIG_XENO_MERCURY
 		ret =3D -__RT(pthread_mutex_lock(&mcb->lock));
+#else
+		ret =3D -pthread_mutex_lock_interruptible_np(&mcb->lock);
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
+	ret =3D -pthread_timedmutex_lock_interruptible_np(&mcb->lock, &ts);
+#endif
 done:
 	switch (ret) {
 	case -ENOTRECOVERABLE:
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index c77d10684..3583f34b7 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -314,7 +314,7 @@ COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mute=
x_t *mutex))
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
+static int __pthread_mutex_lock(pthread_mutex_t *mutex)
 {
 	struct cobalt_mutex_shadow *_mutex =3D
 		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
@@ -371,9 +371,7 @@ slow_path:
 		}
 	}
=20
-	do
-		ret =3D XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
-	while (ret =3D=3D -EINTR);
+	ret =3D XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
=20
 	if (ret =3D=3D 0)
 		_mutex->lockcnt =3D 1;
@@ -392,6 +390,20 @@ protect:
 	goto fast_path;
 }
=20
+COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
+{
+	int ret;
+	do
+		ret =3D __pthread_mutex_lock(mutex);
+	while (ret =3D=3D -EINTR);
+	return ret;
+}
+
+int pthread_mutex_lock_interruptible_np(pthread_mutex_t *mutex)
+{
+	return __pthread_mutex_lock(mutex);
+}
+
 /**
  * Attempt, during a bounded time, to lock a mutex.
  *
@@ -423,8 +435,7 @@ protect:
  *
  * @apitags{xthread-only, switch-primary}
  */
-COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlo=
ck64,
-		   (pthread_mutex_t *mutex, const struct timespec *to))
+static int __pthread_mutex_timedlock(pthread_mutex_t *mutex, const struc=
t timespec *to)
 {
 	struct cobalt_mutex_shadow *_mutex =3D
 		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
@@ -478,13 +489,11 @@ slow_path:
 		}
 	}
=20
-	do {
 #ifdef __USE_TIME_BITS64
-		ret =3D XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock64, _mutex, to);
+	ret =3D XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock64, _mutex, to);
 #else
-		ret =3D XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock, _mutex, to);
+	ret =3D XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock, _mutex, to);
 #endif
-	} while (ret =3D=3D -EINTR);
=20
 	if (ret =3D=3D 0)
 		_mutex->lockcnt =3D 1;
@@ -502,6 +511,21 @@ protect:
 	goto fast_path;
 }
=20
+COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlo=
ck64,
+		   (pthread_mutex_t *mutex, const struct timespec *to))
+{
+	int ret;
+	do
+		ret =3D __pthread_mutex_timedlock(mutex, to);
+	while (ret =3D=3D -EINTR);
+	return ret;
+}
+
+int pthread_timedmutex_lock_interruptible_np(pthread_mutex_t *mutex, con=
st struct timespec *to)
+{
+	return __pthread_mutex_timedlock(mutex, to);
+}
+
 /**
  * Attempt to lock a mutex.
  *
--=20
2.35.3

