Message-ID: <49D481EF.1010908@domain.hid>
Date: Thu, 02 Apr 2009 11:14:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Fix rt_task_shadow error path without __thread.
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


Hi,

it seems that rt_task_shadow currently leaves the self tsd assigned (and
uninitialized) in case of error. So, here is an attempt to fix this
situation:

Index: src/skins/native/task.c
===================================================================
--- src/skins/native/task.c     (revision 4727)
+++ src/skins/native/task.c     (working copy)
@@ -187,15 +187,8 @@

 #ifdef HAVE___THREAD
        self = &__native_self;
-#else /* !HAVE___THREAD */
-       self = pthread_getspecific(__native_tskey);
+#endif /* HAVE___THREAD */

-       if (!self)
-               self = malloc(sizeof(*self));
-
-       pthread_setspecific(__native_tskey, self);
-#endif /* !HAVE___THREAD */
-
        if (task == NULL)
                task = &task_desc; /* Discarded. */

@@ -217,9 +210,13 @@
                                NULL);

        if (!err) {
-               if (self)
-                       *self = *task;
+#ifndef HAVE___THREAD
+               self = malloc(sizeof(*self));

+               pthread_setspecific(__native_tskey, self);
+#endif /* !HAVE___THREAD */
+               *self = *task;
+
                xeno_set_current();

                if (mode & T_WARNSW)


-- 
                                                 Gilles.

