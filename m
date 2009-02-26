Message-ID: <49A6A433.9040200@domain.hid>
Date: Thu, 26 Feb 2009 15:16:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 2/3] native: Avoid lazy non-TLS rt_task_self
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Unconditionally allocate a self task key in the non-TLS case so that we
do not trigger migration via malloc on first access.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 src/skins/native/task.c |   50 +++++++++++++++++++++++++----------------------
 1 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/src/skins/native/task.c b/src/skins/native/task.c
index b3ee9b2..24da8ef 100644
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -58,9 +58,16 @@ static void *rt_task_trampoline(void *cookie)
 	void (*entry) (void *cookie);
 	struct sched_param param;
 	struct rt_arg_bulk bulk;
-	RT_TASK *task;
+	RT_TASK *task, *self;
 	long err;
 
+#ifdef HAVE___THREAD
+	self = &__native_self;
+#else /* !HAVE___THREAD */
+	self = malloc(sizeof(*self));
+	pthread_setspecific(__native_tskey, self);
+#endif /* !HAVE___THREAD */
+
 	if (iargs->prio > 0) {
 		/*
 		 * Re-apply sched params here as some libpthread
@@ -95,11 +102,10 @@ static void *rt_task_trampoline(void *cookie)
 	if (err)
 		goto fail;
 
-	xeno_set_current();
+	if (self)
+		*self = *task;
 
-#ifdef HAVE___THREAD
-	__native_self = *task;
-#endif /* HAVE___THREAD */
+	xeno_set_current();
 
 	if (iargs->mode & T_WARNSW)
 		xeno_sigxcpu_no_mlock = 0;
@@ -185,8 +191,20 @@ int rt_task_shadow(RT_TASK *task, const char *name, int prio, int mode)
 	struct sched_param param;
 	struct rt_arg_bulk bulk;
 	RT_TASK task_desc;
+	RT_TASK *self;
 	int err;
 
+#ifdef HAVE___THREAD
+	self = &__native_self;
+#else /* !HAVE___THREAD */
+	self = pthread_getspecific(__native_tskey);
+
+	if (!self)
+		self = malloc(sizeof(*self));
+
+	pthread_setspecific(__native_tskey, self);
+#endif /* !HAVE___THREAD */
+
 	if (task == NULL)
 		task = &task_desc; /* Discarded. */
 
@@ -215,9 +233,9 @@ int rt_task_shadow(RT_TASK *task, const char *name, int prio, int mode)
 				NULL);
 
 	if (!err) {
-#ifdef HAVE___THREAD
-		__native_self = *task;
-#endif /* HAVE___THREAD */
+		if (self)
+			*self = *task;
+
 		xeno_set_current();
 
 		if (mode & T_WARNSW)
@@ -343,22 +361,8 @@ RT_TASK *rt_task_self(void)
 
 	if (self->opaque == XN_NO_HANDLE)
 		return NULL;
-
 #else /* !HAVE___THREAD */
-	self = (RT_TASK *)pthread_getspecific(__native_tskey);
-
-	if (self)
-		return self;
-
-	self = (RT_TASK *)malloc(sizeof(*self));
-
-	if (!self ||
-	    XENOMAI_SKINCALL1(__native_muxid, __native_task_self, self) != 0) {
-		free(self);
-		return NULL;
-	}
-
-	pthread_setspecific(__native_tskey, self);
+	self = pthread_getspecific(__native_tskey);
 #endif /* !HAVE___THREAD */
 
 	return self;

