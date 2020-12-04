From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/2] lib: remove remaining likely/unlikely branch annotations
Date: Fri,  4 Dec 2020 12:43:34 +0100
Message-Id: <20201204114335.2513658-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

In user-space at least, we'd be better off trusting the CPU's branch
predictor, instead of relying on our limited perception when it comes
to determining the likeliness of a condition, or every compiler to do
the right thing with respect to efficient branching.

We only have a few unlikely predictions in-tree on straightforward
conditions, which we can remove safely:

- POSIX condvars wait/signal loops on x86, arm and arm64 showed no
  observable performance penalty.

- other callers from the thread cancellation path, or debug
  instrumentation are slow paths in essence anyway.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/boilerplate/debug.h | 4 ++--
 lib/cobalt/cond.c           | 4 ++--
 lib/cobalt/mutex.c          | 4 ++--
 lib/copperplate/threadobj.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/boilerplate/debug.h b/include/boilerplate/debug.h
index f3eb68749..d3ab0ef80 100644
--- a/include/boilerplate/debug.h
+++ b/include/boilerplate/debug.h
@@ -76,7 +76,7 @@ void debug_init(void);
 #define __bt(__exp)						\
 	({							\
 		typeof(__exp) __ret = (__exp);			\
-		if (unlikely(__ret < 0))			\
+		if (__ret < 0)					\
 			backtrace_log((int)__ret, __FUNCTION__,	\
 				      __FILE__, __LINE__);	\
 		__ret;						\
@@ -85,7 +85,7 @@ void debug_init(void);
 #define __bterrno(__exp)					\
 	({							\
 		typeof(__exp) __ret = (__exp);			\
-		if (unlikely(__ret < 0))			\
+		if (__ret < 0)					\
 			backtrace_log(-errno, __FUNCTION__,	\
 				      __FILE__, __LINE__);	\
 		__ret;						\
diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index e66b20922..1bf5c74b3 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -167,7 +167,7 @@ static int __attribute__((cold))
 
 static inline int cobalt_cond_autoinit(union cobalt_cond_union *ucond)
 {
-	if (unlikely(ucond->shadow_cond.magic != COBALT_COND_MAGIC))
+	if (ucond->shadow_cond.magic != COBALT_COND_MAGIC)
 		return cobalt_cond_doautoinit(ucond);
 	return 0;
 }
@@ -201,7 +201,7 @@ COBALT_IMPL(int, pthread_cond_destroy, (pthread_cond_t *cond))
 	struct cobalt_cond_shadow *_cond =
 		&((union cobalt_cond_union *)cond)->shadow_cond;
 
-	if (unlikely(_cond->magic != COBALT_COND_MAGIC))
+	if (_cond->magic != COBALT_COND_MAGIC)
 		return (cobalt_cond_autoinit_type(cond) < 0) ? EINVAL : 0;
 
 	return -XENOMAI_SYSCALL1( sc_cobalt_cond_destroy, _cond);
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index ad0ed1eba..29236c75a 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -240,7 +240,7 @@ static int __attribute__((cold))
 
 static inline int cobalt_mutex_autoinit(union cobalt_mutex_union *umutex)
 {
-	if (unlikely(umutex->shadow_mutex.magic != COBALT_MUTEX_MAGIC))
+	if (umutex->shadow_mutex.magic != COBALT_MUTEX_MAGIC)
 		return cobalt_mutex_doautoinit(umutex);
 	return 0;
 }
@@ -273,7 +273,7 @@ COBALT_IMPL(int, pthread_mutex_destroy, (pthread_mutex_t *mutex))
 		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
 	int err;
 
-	if (unlikely(_mutex->magic != COBALT_MUTEX_MAGIC))
+	if (_mutex->magic != COBALT_MUTEX_MAGIC)
 		return (cobalt_mutex_autoinit_type(mutex) < 0) ? EINVAL : 0;
 
 	err = XENOMAI_SYSCALL1(sc_cobalt_mutex_destroy, _mutex);
diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index 8e7c14a64..a3101baa1 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1022,7 +1022,7 @@ static int request_setschedparam(struct threadobj *thobj, int policy,
 #ifdef CONFIG_XENO_PSHARED
 	struct remote_request *rq;
 
-	if (unlikely(!threadobj_local_p(thobj))) {
+	if (!threadobj_local_p(thobj)) {
 		rq = xnmalloc(sizeof(*rq));
 		if (rq == NULL)
 			return -ENOMEM;
@@ -1065,7 +1065,7 @@ static int request_cancel(struct threadobj *thobj) /* thobj->lock held, dropped.
 	struct remote_request *rq;
 	int ret;
 
-	if (unlikely(!threadobj_local_p(thobj))) {
+	if (!threadobj_local_p(thobj)) {
 		threadobj_unlock(thobj);
 		rq = xnmalloc(sizeof(*rq));
 		if (rq == NULL)
-- 
2.26.2


