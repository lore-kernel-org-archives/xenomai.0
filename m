Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED8A492
	for <xenomai@lists.linux.dev>; Fri, 18 Nov 2022 21:22:57 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20221118154222e77a560769df3f3c6a
        for <xenomai@lists.linux.dev>;
        Fri, 18 Nov 2022 16:42:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=dPLarflOcmCMwAG+9hZNE6FORtyMusdEkHEaQyTyUiA=;
 b=MzkPNuPGqfyCnSB5erRBztpojqd5o2PXAHYPy4TFGAQrZxYEkBY6MTUIzQeifR8vrr/EUz
 /v2iyzDS8gWQX3DRsJoMMf+BVxIPB+t7w1bVfSdYZQOG8e0sl7bMWBD98pDfnFQAcHmC/vYh
 7dZhz0Q89JycsXnminIU0gcK+jd0o=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC][stable 3.0.x] lib: Switch to pthread_mutexattr_setrobust
Date: Fri, 18 Nov 2022 16:42:20 +0100
Message-Id: <20221118154220.869584-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

With recent glibc (at least 2.34), autoconf fails to detect
pthread_mutexattr_setrobust_np. But that is long deprecated anyway. So
switch to pthread_mutexattr_setrobust and only fall back to _np when
needed.

This is a backport of the following commits from stable 3.2:

746cbeb6ccc0 ("lib: Switch to pthread_mutexattr_setrobust")
3f85c174e297 ("lib: Fix fallback signature of pthread_mutexattr_setrobust")
2d947e6fe3f8 ("lib: Re-add "static" to pthread_mutexattr_setrobust fallback stub")

Backporting allows the stable 3.0 branch to be build with the latest
Debian toolchain, so we don't need a special CI setup for the 3.0
branch.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Hi all,

would it be acceptable to apply this patch to the 3.0.x stable branch? 
It would allow us to build this branch with the same infrastructure once 
we like to update to the next Debian version (12).

Especially the y2038 tests require a recent glibc version the next 
Debian stable release (bookworm, Debian 12) will ship such a version.

One alternative would be to use different build environments for
different Xenomai stable branches. I fear that's hard to maintain -
especially the CI configuration will likely explode.

WDYT?

This patch has been tested with both build environments, so Debian 11
(as is now) and the upcoming Debian 12.

Best regards,
Florian

 configure.ac               |  1 +
 include/boilerplate/libc.h | 14 +++++++++++---
 lib/alchemy/mutex.c        |  4 ++--
 lib/vxworks/semLib.c       |  4 ++--
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index f31365c7a..0ad866ddd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -489,6 +489,7 @@ save_LIBS="$LIBS"
 LIBS="$LIBS -lrt -lpthread"
 AC_CHECK_FUNCS([pthread_mutexattr_setprotocol	\
 		pthread_mutexattr_getprotocol	\
+		pthread_mutexattr_setrobust	\
 		pthread_mutexattr_setrobust_np	\
 		pthread_condattr_getclock	\
 		pthread_condattr_setclock	\
diff --git a/include/boilerplate/libc.h b/include/boilerplate/libc.h
index 134176e54..e7d33101f 100644
--- a/include/boilerplate/libc.h
+++ b/include/boilerplate/libc.h
@@ -186,10 +186,18 @@ __weak int shm_unlink(const char *name)
 }
 #endif	/* !HAVE_SHM_UNLINK */
 
-#ifndef HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP
-#define pthread_mutexattr_setrobust_np(__attr, __robust)	\
-	({ ENOSYS; })
+#ifndef HAVE_PTHREAD_MUTEXATTR_SETROBUST
+#ifdef HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP
+#define pthread_mutexattr_setrobust	pthread_mutexattr_setrobust_np
+#else
+static inline
+int pthread_mutexattr_setrobust(pthread_mutexattr_t *attr,
+				int *robustness)
+{
+	return ENOSYS;
+}
 #endif /* !HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP */
+#endif /* !HAVE_PTHREAD_MUTEXATTR_SETROBUST */
 
 #if !defined(HAVE_PTHREAD_SETNAME_NP) && defined(CONFIG_XENO_MERCURY)
 static inline
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 09eb1364e..f89338586 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -131,8 +131,8 @@ int rt_mutex_create(RT_MUTEX *mutex, const char *name)
 	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
 	pthread_mutexattr_setpshared(&mattr, mutex_scope_attribute);
 	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE);
-	/* pthread_mutexattr_setrobust_np() might not be implemented. */
-	pthread_mutexattr_setrobust_np(&mattr, PTHREAD_MUTEX_ROBUST_NP);
+	/* pthread_mutexattr_setrobust() might not be implemented. */
+	pthread_mutexattr_setrobust(&mattr, PTHREAD_MUTEX_ROBUST_NP);
 	ret = __RT(pthread_mutex_init(&mcb->lock, &mattr));
 	if (ret) {
 		xnfree(mcb);
diff --git a/lib/vxworks/semLib.c b/lib/vxworks/semLib.c
index acce160ee..180ed2000 100644
--- a/lib/vxworks/semLib.c
+++ b/lib/vxworks/semLib.c
@@ -411,8 +411,8 @@ SEM_ID semMCreate(int options)
 	 */
 	pthread_mutexattr_init(&mattr);
 	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE);
-	/* pthread_mutexattr_setrobust_np() might not be implemented. */
-	pthread_mutexattr_setrobust_np(&mattr, PTHREAD_MUTEX_ROBUST_NP);
+	/* pthread_mutexattr_setrobust() might not be implemented. */
+	pthread_mutexattr_setrobust(&mattr, PTHREAD_MUTEX_ROBUST_NP);
 	if (options & SEM_INVERSION_SAFE)
 		pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
 	pthread_mutexattr_setpshared(&mattr, mutex_scope_attribute);
-- 
2.35.1

