From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH v3 3/5] libcobalt: improve condvar autoinit support
Date: Wed, 10 Apr 2019 13:14:06 +0200
Message-Id: <20190410111408.18824-4-norbert.lange@andritz.com>
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

contrary to some comments, condvars are automatically
initialised on signal/wait.
Correct the destroy method to not report an
error on such condvars.

Check whether the condition variable has the
static initializer is now more strict.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 lib/cobalt/cond.c | 86 +++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index 00a201855..9553824c2 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -142,6 +142,32 @@ COBALT_IMPL(int, pthread_cond_init, (pthread_cond_t *cond,
 	return 0;
 }
 
+static int __attribute__((cold))
+	cobalt_cond_autoinit_type(const pthread_cond_t *cond)
+{
+	static const pthread_cond_t cond_initializer =
+		PTHREAD_COND_INITIALIZER;
+
+	return memcmp(cond, &cond_initializer, sizeof(cond_initializer)) == 0 ?
+		0 : -1;
+}
+
+static int __attribute__((cold))
+	cobalt_cond_doautoinit(union cobalt_cond_union *ucond)
+{
+	if (cobalt_cond_autoinit_type(&ucond->native_cond) < 0)
+		return EINVAL;
+
+	return __COBALT(pthread_cond_init(&ucond->native_cond, NULL));
+}
+
+static inline int cobalt_cond_autoinit(union cobalt_cond_union *ucond)
+{
+	if (unlikely(ucond->shadow_cond.magic != COBALT_COND_MAGIC))
+		return cobalt_cond_doautoinit(ucond);
+	return 0;
+}
+
 /**
  * @fn int pthread_cond_destroy(pthread_cond_t *cond)
  * @brief Destroy a condition variable
@@ -168,7 +194,11 @@ COBALT_IMPL(int, pthread_cond_init, (pthread_cond_t *cond,
  */
 COBALT_IMPL(int, pthread_cond_destroy, (pthread_cond_t *cond))
 {
-	struct cobalt_cond_shadow *_cond = &((union cobalt_cond_union *)cond)->shadow_cond;
+	struct cobalt_cond_shadow *_cond =
+		&((union cobalt_cond_union *)cond)->shadow_cond;
+
+	if (unlikely(_cond->magic != COBALT_COND_MAGIC))
+		return (cobalt_cond_autoinit_type(cond) < 0) ? EINVAL : 0;
 
 	return -XENOMAI_SYSCALL1( sc_cobalt_cond_destroy, _cond);
 }
@@ -193,12 +223,6 @@ static void __pthread_cond_cleanup(void *data)
 	c->mutex->lockcnt = c->count;
 }
 
-static int __attribute__((cold)) cobalt_cond_autoinit(pthread_cond_t *cond)
-{
-	return __COBALT(pthread_cond_init(cond, NULL));
-}
-
-
 /**
  * Wait on a condition variable.
  *
@@ -262,10 +286,10 @@ COBALT_IMPL(int, pthread_cond_wait, (pthread_cond_t *cond, pthread_mutex_t *mute
 	if (_mx->magic != COBALT_MUTEX_MAGIC)
 		return EINVAL;
 
-	if (_cnd->magic != COBALT_COND_MAGIC)
-		goto autoinit;
+	err = cobalt_cond_autoinit((union cobalt_cond_union *)cond);
+	if (err)
+		return err;
 
-  cont:
 	if (_mx->attr.type == PTHREAD_MUTEX_ERRORCHECK) {
 		xnhandle_t cur = cobalt_get_current();
 
@@ -297,12 +321,6 @@ COBALT_IMPL(int, pthread_cond_wait, (pthread_cond_t *cond, pthread_mutex_t *mute
 	pthread_testcancel();
 
 	return -err ?: -c.err;
-
-  autoinit:
-	err = cobalt_cond_autoinit(cond);
-	if (err)
-		return err;
-	goto cont;
 }
 
 /**
@@ -357,10 +375,10 @@ COBALT_IMPL(int, pthread_cond_timedwait, (pthread_cond_t *cond,
 	if (_mx->magic != COBALT_MUTEX_MAGIC)
 		return EINVAL;
 
-	if (_cnd->magic != COBALT_COND_MAGIC)
-		goto autoinit;
+	err = cobalt_cond_autoinit((union cobalt_cond_union *)cond);
+	if (err)
+		return err;
 
-  cont:
 	if (_mx->attr.type == PTHREAD_MUTEX_ERRORCHECK) {
 		xnhandle_t cur = cobalt_get_current();
 
@@ -391,12 +409,6 @@ COBALT_IMPL(int, pthread_cond_timedwait, (pthread_cond_t *cond,
 	pthread_testcancel();
 
 	return -err ?: -c.err;
-
-  autoinit:
-	err = cobalt_cond_autoinit(cond);
-	if (err)
-		return err;
-	goto cont;
 }
 
 /**
@@ -431,10 +443,10 @@ COBALT_IMPL(int, pthread_cond_signal, (pthread_cond_t *cond))
 	__u32 flags;
 	int err;
 
-	if (_cnd->magic != COBALT_COND_MAGIC)
-		goto autoinit;
+	err = cobalt_cond_autoinit((union cobalt_cond_union *)cond);
+	if (err)
+		return err;
 
-  cont:
 	mutex_state = get_mutex_state(_cnd);
 	if (mutex_state == NULL)
 		return 0;	/* Fast path, no waiter. */
@@ -455,12 +467,6 @@ COBALT_IMPL(int, pthread_cond_signal, (pthread_cond_t *cond))
 		cond_state->pending_signals = pending_signals + 1;
 
 	return 0;
-
-  autoinit:
-	err = cobalt_cond_autoinit(cond);
-	if (err)
-		return err;
-	goto cont;
 }
 
 /**
@@ -491,10 +497,10 @@ COBALT_IMPL(int, pthread_cond_broadcast, (pthread_cond_t *cond))
 	__u32 flags;
 	int err;
 
-	if (_cnd->magic != COBALT_COND_MAGIC)
-		goto autoinit;
+	err = cobalt_cond_autoinit((union cobalt_cond_union *)cond);
+	if (err)
+		return err;
 
-  cont:
 	mutex_state = get_mutex_state(_cnd);
 	if (mutex_state == NULL)
 		return 0;
@@ -513,12 +519,6 @@ COBALT_IMPL(int, pthread_cond_broadcast, (pthread_cond_t *cond))
 	cond_state->pending_signals = ~0U;
 
 	return 0;
-
-  autoinit:
-	err = cobalt_cond_autoinit(cond);
-	if (err)
-		return err;
-	goto cont;
 }
 
 /**
-- 
2.20.1


