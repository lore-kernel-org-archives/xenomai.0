From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH v3 1/5] libcobalt: improve mutex autoinit support
Date: Wed, 10 Apr 2019 13:14:04 +0200
Message-Id: <20190410111408.18824-2-norbert.lange@andritz.com>
In-Reply-To: <20190410111408.18824-1-norbert.lange@andritz.com>
References: <20190410111408.18824-1-norbert.lange@andritz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

contrary to some comments, mutexes are automatically
initialised on lock/unlock.
Correct the destroy method to not report an
error on such mutexes.

{get,set}prioceiling requires mutexes that were explicitly
initialised, so no change needed there

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 lib/cobalt/mutex.c | 180 +++++++++++++++++++++++----------------------
 1 file changed, 94 insertions(+), 86 deletions(-)

diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index ed32bba32..2748850e2 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -164,70 +164,52 @@ COBALT_IMPL(int, pthread_mutex_init, (pthread_mutex_t *mutex,
 }
 
 /**
- * Destroy a mutex.
- *
- * This service destroys the mutex @a mx, if it is unlocked and not referenced
- * by any condition variable. The mutex becomes invalid for all mutex services
- * (they all return the EINVAL error) except pthread_mutex_init().
- *
- * @param mutex the mutex to be destroyed.
- *
- * @return 0 on success,
- * @return an error number if:
- * - EINVAL, the mutex @a mx is invalid;
- * - EPERM, the mutex is not process-shared and does not belong to the current
- *   process;
- * - EBUSY, the mutex is locked, or used by a condition variable.
+ * Test if a mutex structure contains a valid autoinitializer.
  *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_destroy.html">
- * Specification.</a>
- *
- * @apitags{thread-unrestricted}
+ * @return the mutex type on success,
+ * @return -1 if not in supported autoinitializer state
  */
-COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
-{
-	struct cobalt_mutex_shadow *_mutex =
-		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
-	int err;
-
-	if (_mutex->magic != COBALT_MUTEX_MAGIC)
-		return EINVAL;
-
-	err = XENOMAI_SYSCALL1(sc_cobalt_mutex_destroy, _mutex);
-
-	return -err;
-}
-
-static int __attribute__((cold)) cobalt_mutex_autoinit(pthread_mutex_t *mutex)
+static int __attribute__((cold))
+	cobalt_mutex_autoinit_type(const pthread_mutex_t *mutex)
 {
-	static pthread_mutex_t uninit_normal_mutex =
-		PTHREAD_MUTEX_INITIALIZER;
+	static const pthread_mutex_t mutex_initializers[] = {
+#if HAVE_DECL_PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
+		PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,
+#endif
 #if HAVE_DECL_PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
-	static pthread_mutex_t uninit_recursive_mutex =
-		PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
+		PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP,
 #endif
+		PTHREAD_MUTEX_INITIALIZER
+	};
+	static const int mutex_types[] = {
 #if HAVE_DECL_PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
-	static pthread_mutex_t uninit_errorcheck_mutex =
-		PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP;
+		PTHREAD_MUTEX_ERRORCHECK_NP,
 #endif
-	struct cobalt_mutex_shadow *_mutex =
-		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
+#if HAVE_DECL_PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
+		PTHREAD_MUTEX_RECURSIVE_NP,
+#endif
+		PTHREAD_MUTEX_DEFAULT
+	};
+	int i;
+
+	for (i = sizeof(mutex_types) / sizeof(mutex_types[0]); i > 0; --i) {
+		if (memcmp(mutex, &mutex_initializers[i - 1],
+				sizeof(mutex_initializers[0])) == 0)
+			return mutex_types[i - 1];
+	}
+	return -1;
+}
+
+static int __attribute__((cold))
+	cobalt_mutex_doautoinit(union cobalt_mutex_union *umutex)
+{
+	struct cobalt_mutex_shadow *_mutex = &umutex->shadow_mutex;
 	int err __attribute__((unused));
 	pthread_mutexattr_t mattr;
 	int ret = 0, type;
 
-	if (memcmp(mutex, &uninit_normal_mutex, sizeof(*mutex)) == 0)
-		type = PTHREAD_MUTEX_DEFAULT;
-#if HAVE_DECL_PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
-	else if (memcmp(mutex, &uninit_recursive_mutex, sizeof(*mutex)) == 0)
-		type = PTHREAD_MUTEX_RECURSIVE_NP;
-#endif
-#if HAVE_DECL_PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
-	else if (memcmp(mutex, &uninit_errorcheck_mutex, sizeof(*mutex)) == 0)
-		type = PTHREAD_MUTEX_ERRORCHECK_NP;
-#endif
-	else
+	type = cobalt_mutex_autoinit_type(&umutex->native_mutex);
+	if (type < 0)
 		return EINVAL;
 
 	pthread_mutexattr_init(&mattr);
@@ -238,7 +220,8 @@ static int __attribute__((cold)) cobalt_mutex_autoinit(pthread_mutex_t *mutex)
 		goto out;
 	}
 	if (_mutex->magic != COBALT_MUTEX_MAGIC)
-		ret = __COBALT(pthread_mutex_init(mutex, &mattr));
+		ret = __COBALT(pthread_mutex_init(&umutex->native_mutex,
+			&mattr));
 	err = __COBALT(pthread_mutex_unlock(cobalt_autoinit_mutex));
 	if (err) {
 		if (ret == 0)
@@ -251,6 +234,49 @@ static int __attribute__((cold)) cobalt_mutex_autoinit(pthread_mutex_t *mutex)
 	return ret;
 }
 
+static inline int cobalt_mutex_autoinit(union cobalt_mutex_union *umutex)
+{
+	if (unlikely(umutex->shadow_mutex.magic != COBALT_MUTEX_MAGIC))
+		return cobalt_mutex_doautoinit(umutex);
+	return 0;
+}
+
+/**
+ * Destroy a mutex.
+ *
+ * This service destroys the mutex @a mx, if it is unlocked and not referenced
+ * by any condition variable. The mutex becomes invalid for all mutex services
+ * (they all return the EINVAL error) except pthread_mutex_init().
+ *
+ * @param mutex the mutex to be destroyed.
+ *
+ * @return 0 on success,
+ * @return an error number if:
+ * - EINVAL, the mutex @a mx is invalid;
+ * - EPERM, the mutex is not process-shared and does not belong to the current
+ *   process;
+ * - EBUSY, the mutex is locked, or used by a condition variable.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_destroy.html">
+ * Specification.</a>
+ *
+ * @apitags{thread-unrestricted}
+ */
+COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
+{
+	struct cobalt_mutex_shadow *_mutex =
+		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
+	int err;
+
+	if (unlikely(_mutex->magic != COBALT_MUTEX_MAGIC))
+		return (cobalt_mutex_autoinit_type(mutex) < 0) ? EINVAL : 0;
+
+	err = XENOMAI_SYSCALL1(sc_cobalt_mutex_destroy, _mutex);
+
+	return -err;
+}
+
 /**
  * Lock a mutex.
  *
@@ -296,15 +322,15 @@ COBALT_IMPL(int, pthread_mutex_lock, (pthread_mutex_t *mutex))
 	if (cur == XN_NO_HANDLE)
 		return EPERM;
 
-	if (_mutex->magic != COBALT_MUTEX_MAGIC)
-		goto autoinit;
+	ret = cobalt_mutex_autoinit((union cobalt_mutex_union *)mutex);
+	if (ret)
+		return ret;
 
 	/*
 	 * We track resource ownership for auto-relax of non real-time
 	 * shadows and some debug features, so we must always obtain
 	 * them via a syscall.
 	 */
-start:
 	status = cobalt_get_current_mode();
 	if ((status & (XNRELAX|XNWEAK|XNDEBUG)) == 0) {
 		if (_mutex->attr.protocol == PTHREAD_PRIO_PROTECT)
@@ -360,11 +386,6 @@ protect:
 	u_window->pp_pending = _mutex->handle;
 	lazy_protect = 1;
 	goto fast_path;
-autoinit:
-	ret = cobalt_mutex_autoinit(mutex);
-	if (ret)
-		return ret;
-	goto start;
 }
 
 /**
@@ -411,11 +432,11 @@ COBALT_IMPL(int, pthread_mutex_timedlock, (pthread_mutex_t *mutex,
 	if (cur == XN_NO_HANDLE)
 		return EPERM;
 
-	if (_mutex->magic != COBALT_MUTEX_MAGIC)
-		goto autoinit;
+	ret = cobalt_mutex_autoinit((union cobalt_mutex_union *)mutex);
+	if (ret)
+		return ret;
 
 	/* See __cobalt_pthread_mutex_lock() */
-start:
 	status = cobalt_get_current_mode();
 	if ((status & (XNRELAX|XNWEAK|XNDEBUG)) == 0) {
 		if (_mutex->attr.protocol == PTHREAD_PRIO_PROTECT)
@@ -471,11 +492,6 @@ protect:
 	u_window->pp_pending = _mutex->handle;
 	lazy_protect = 1;
 	goto fast_path;
-autoinit:
-	ret = cobalt_mutex_autoinit(mutex);
-	if (ret)
-		return ret;
-	goto start;
 }
 
 /**
@@ -515,9 +531,10 @@ COBALT_IMPL(int, pthread_mutex_trylock, (pthread_mutex_t *mutex))
 	if (cur == XN_NO_HANDLE)
 		return EPERM;
 
-	if (_mutex->magic != COBALT_MUTEX_MAGIC)
-		goto autoinit;
-start:
+	ret = cobalt_mutex_autoinit((union cobalt_mutex_union *)mutex);
+	if (ret)
+		return ret;
+
 	status = cobalt_get_current_mode();
 	if ((status & (XNRELAX|XNWEAK|XNDEBUG)) == 0) {
 		if (_mutex->attr.protocol == PTHREAD_PRIO_PROTECT)
@@ -558,11 +575,6 @@ slow_path:
 		_mutex->lockcnt = 1;
 
 	return -ret;
-autoinit:
-	ret = cobalt_mutex_autoinit(mutex);
-	if (ret)
-		return ret;
-	goto start;
 protect:
 	u_window = cobalt_get_current_window();
 	/*
@@ -611,9 +623,10 @@ COBALT_IMPL(int, pthread_mutex_unlock, (pthread_mutex_t *mutex))
 	xnhandle_t cur;
 	int err;
 
-	if (_mutex->magic != COBALT_MUTEX_MAGIC)
-		goto autoinit;
-start:
+	err = cobalt_mutex_autoinit((union cobalt_mutex_union *)mutex);
+	if (err)
+		return err;
+
 	cur = cobalt_get_current();
 	if (cur == XN_NO_HANDLE)
 		return EPERM;
@@ -645,11 +658,6 @@ do_syscall:
 
 	return -err;
 
-autoinit:
-	err = cobalt_mutex_autoinit(mutex);
-	if (err)
-		return err;
-	goto start;
 unprotect:
 	u_window = cobalt_get_current_window();
 	u_window->pp_pending = XN_NO_HANDLE;
-- 
2.20.1


