From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18448.10221.879356.57696@domain.hid>
Date: Thu, 24 Apr 2008 08:25:49 +0200
In-Reply-To: <18448.10157.853132.856441@domain.hid>
References: <18448.9649.956656.531081@domain.hid>
	<18448.9901.799115.445182@domain.hid>
	<18448.9967.355128.570111@domain.hid>
	<18448.10037.181558.14996@domain.hid>
	<18448.10157.853132.856441@domain.hid>
Subject: [Xenomai-core] [5/9] Define new syscalls for the posix skin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


This patch defines the new syscalls get_heap_addr (more on this syscall later),
and get_thread_cb. The get_thread_cb syscall is used in user-space to associate
the thread xnthread_t pointer with each user-space xenomai thread, using POSIX
TSD.

This is needed for the mutex implementation to allow setting the mutex owner.

However, two things: 
- I do not know if you should like that much passing kernel-space pointers to
  user-space;
- this is implemented as a posix skin service, but should probably be defined as
  a core syscall, and called in all skin implementations, so as to allow threads
  from other skins to user Xenomai posix skin services.

---
 include/posix/syscall.h  |    3 +++
 src/skins/posix/thread.c |   11 +++++++++++
 2 files changed, 14 insertions(+)

Index: include/posix/syscall.h
===================================================================
--- include/posix/syscall.h	(revision 3718)
+++ include/posix/syscall.h	(working copy)
@@ -46,6 +46,7 @@
 #define __pse51_mutex_lock            20
 #define __pse51_mutex_timedlock       21
 #define __pse51_mutex_trylock         22
+#define __pse51_check_init            __pse51_mutex_trylock
 #define __pse51_mutex_unlock          23
 #define __pse51_cond_init             24
 #define __pse51_cond_destroy          25
@@ -101,6 +102,8 @@
 #define __pse51_thread_getschedparam  75
 #define __pse51_thread_kill           76
 #define __pse51_select                77
+#define __pse51_get_heap_addr         78
+#define __pse51_get_thread_cb	      79
 
 #ifdef __KERNEL__
 
Index: src/skins/posix/thread.c
===================================================================
--- src/skins/posix/thread.c	(revision 3718)
+++ src/skins/posix/thread.c	(working copy)
@@ -26,6 +26,7 @@
 #include <posix/syscall.h>
 
 extern int __pse51_muxid;
+extern pthread_key_t pse51_cur_key;
 
 static pthread_attr_t default_attr;
 static int linuxthreads;
@@ -41,6 +42,13 @@ static void __pthread_sigharden_handler(
 	XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
 }
 
+static void set_kthread_cb(void)
+{
+	void *kthread_cb;
+	XENOMAI_SKINCALL1(__pse51_muxid, __pse51_get_thread_cb, &kthread_cb);
+	pthread_setspecific(pse51_cur_key, kthread_cb);
+}
+
 int __wrap_pthread_setschedparam(pthread_t thread,
 				 int policy, const struct sched_param *param)
 {
@@ -56,6 +64,7 @@ int __wrap_pthread_setschedparam(pthread
 
 	if (!err && promoted) {
 		old_sigharden_handler = signal(SIGHARDEN, &__pthread_sigharden_handler);
+		set_kthread_cb();
 		if (policy != SCHED_OTHER)
 			XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
 	}
@@ -132,6 +141,8 @@ static void *__pthread_trampoline(void *
 	start = iargs->start;
 	cookie = iargs->arg;
 
+	set_kthread_cb();
+
 	__real_sem_post(&iargs->sync);
 
 	if (!err) {


-- 


					    Gilles.

