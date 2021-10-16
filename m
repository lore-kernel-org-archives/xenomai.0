From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 3/3] lib: Switch to pthread_mutexattr_setrobust
Date: Sat, 16 Oct 2021 20:31:25 +0200
Message-Id: <746cbeb6ccc038cf3545bf68503651ef8397fca8.1634409085.git.jan.kiszka@web.de>
In-Reply-To: <cover.1634409085.git.jan.kiszka@web.de>
References: <cover.1634409085.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

With recent glibc (at least 2.34), autoconf fails to detect
pthread_mutexattr_setrobust_np. But that is long deprecated anyway. So
switch to pthread_mutexattr_setrobust and only fall back to _np when
needed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 configure.ac               |  1 +
 include/boilerplate/libc.h | 10 +++++++---
 lib/alchemy/mutex.c        |  4 ++--
 lib/vxworks/semLib.c       |  4 ++--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 480a94768d..d39443a35e 100644
=2D-- a/configure.ac
+++ b/configure.ac
@@ -542,6 +542,7 @@ AC_CHECK_FUNCS([pthread_mutexattr_setprotocol	\
 		pthread_mutexattr_getprotocol	\
 		pthread_mutexattr_getprioceiling \
 		pthread_mutexattr_setprioceiling \
+		pthread_mutexattr_setrobust	\
 		pthread_mutexattr_setrobust_np	\
 		pthread_mutex_getprioceiling	\
 		pthread_mutex_setprioceiling	\
diff --git a/include/boilerplate/libc.h b/include/boilerplate/libc.h
index 41b2eb91bb..797e377a2e 100644
=2D-- a/include/boilerplate/libc.h
+++ b/include/boilerplate/libc.h
@@ -243,14 +243,18 @@ __weak int shm_unlink(const char *name)
 }
 #endif	/* !HAVE_SHM_UNLINK */

-#ifndef HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP
+#ifndef HAVE_PTHREAD_MUTEXATTR_SETROBUST
+#ifdef HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP
+#define pthread_mutexattr_setrobust	pthread_mutexattr_setrobust_np
+#else
 static inline
-int pthread_mutexattr_setrobust_np(const pthread_mutexattr_t *attr,
-				   int *robustness)
+int pthread_mutexattr_setrobust(const pthread_mutexattr_t *attr,
+				int *robustness)
 {
 	return ENOSYS;
 }
 #endif /* !HAVE_PTHREAD_MUTEXATTR_SETROBUST_NP */
+#endif /* !HAVE_PTHREAD_MUTEXATTR_SETROBUST */

 #if !defined(HAVE_PTHREAD_SETNAME_NP) && defined(CONFIG_XENO_MERCURY)
 static inline
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 09eb1364ef..f893385864 100644
=2D-- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -131,8 +131,8 @@ int rt_mutex_create(RT_MUTEX *mutex, const char *name)
 	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
 	pthread_mutexattr_setpshared(&mattr, mutex_scope_attribute);
 	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE);
-	/* pthread_mutexattr_setrobust_np() might not be implemented. */
-	pthread_mutexattr_setrobust_np(&mattr, PTHREAD_MUTEX_ROBUST_NP);
+	/* pthread_mutexattr_setrobust() might not be implemented. */
+	pthread_mutexattr_setrobust(&mattr, PTHREAD_MUTEX_ROBUST_NP);
 	ret =3D __RT(pthread_mutex_init(&mcb->lock, &mattr));
 	if (ret) {
 		xnfree(mcb);
diff --git a/lib/vxworks/semLib.c b/lib/vxworks/semLib.c
index acce160ee1..180ed20005 100644
=2D-- a/lib/vxworks/semLib.c
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
=2D-
2.31.1


