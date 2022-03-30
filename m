From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] Alchemy: Fix rt_task_unblock() for RT_MUTEX
Date: Wed, 30 Mar 2022 22:16:14 +0200
Message-Id: <20220330201614.31083-1-richard@nod.at>
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
Cc: Richard Weinberger <richard@nod.at>

Starting with Xenomai 3, RT_MUTEX is based on libcobalt's pthread mutex
implementation.
POSIX requires that pthread_mutex_lock() shall not return EINTR,
this requirement breaks rt_task_unblock() if a RT_TASK blocks on
a RT_MUTEX.

To restore the functionality provide a new function, pthread_mutex_lock_e=
intr_np().
It can get interrupted and will return EINTR to the caller.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/cobalt/pthread.h |  2 ++
 lib/alchemy/mutex.c      |  2 +-
 lib/cobalt/mutex.c       | 14 ++++++++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
index 3e9bd47053bc..2994c2467219 100644
--- a/include/cobalt/pthread.h
+++ b/include/cobalt/pthread.h
@@ -62,6 +62,8 @@ COBALT_DECL(int, pthread_mutex_destroy(pthread_mutex_t =
*mutex));
=20
 COBALT_DECL(int, pthread_mutex_lock(pthread_mutex_t *mutex));
=20
+COBALT_DECL(int, pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex));
+
 COBALT_DECL(int, pthread_mutex_timedlock(pthread_mutex_t *mutex,
 					 const struct timespec *to));
=20
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index f8933858647a..bb97395142aa 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -327,7 +327,7 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
=20
 	/* Slow path. */
 	if (abs_timeout =3D=3D NULL) {
-		ret =3D -__RT(pthread_mutex_lock(&mcb->lock));
+		ret =3D -__RT(pthread_mutex_lock_eintr_np(&mcb->lock));
 		goto done;
 	}
=20
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index 73e45a1c4396..2ef02a175c13 100644
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
+COBALT_IMPL(int, pthread_mutex_lock_eintr_np, (pthread_mutex_t *mutex))
+{
+	return __pthread_mutex_lock(mutex, true);
+}
+
 /**
  * Attempt, during a bounded time, to lock a mutex.
  *
--=20
2.26.2


