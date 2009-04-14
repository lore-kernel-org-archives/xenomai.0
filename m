Message-ID: <49E4B5CC.1050902@domain.hid>
Date: Tue, 14 Apr 2009 18:11:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] posix: Avoid double declarations
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Please pull from git://git.xenomai.org/xenomai-jki.git for-upstream
and run bootstrap.

---------->

Recent glibc versions come with support for
pthread_mutexattr_get/setprotocol and pthread_condattr_get/setclock.
Make sure we don't declare those prototypes in Xenomai's pthread.h a
second time as this can cause g++ warnings and even errors.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 configure.in            |    4 ++--
 include/posix/pthread.h |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/configure.in b/configure.in
index b291ce4..6a8b821 100644
--- a/configure.in
+++ b/configure.in
@@ -750,8 +750,8 @@ if test x$CONFIG_XENO_POSIX_UITRON_MLOCKALL = xy; then
 fi
 
 save_LIBS="$LIBS"
-LIBS="$LIBS -lrt"
-AC_CHECK_FUNCS([shm_open shm_unlink mmap64 ftruncate64])
+LIBS="$LIBS -lrt -lpthread"
+AC_CHECK_FUNCS([shm_open shm_unlink mmap64 ftruncate64 pthread_mutexattr_setprotocol pthread_condattr_setclock])
 LIBS="$save_LIBS"
 
 AC_MSG_CHECKING(whether to enable dlopen support for skin libraries)
diff --git a/include/posix/pthread.h b/include/posix/pthread.h
index 2344158..98db325 100644
--- a/include/posix/pthread.h
+++ b/include/posix/pthread.h
@@ -418,17 +418,21 @@ int pthread_intr_control_np(pthread_intr_t intr,
 extern "C" {
 #endif
 
+#ifndef HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
 int pthread_mutexattr_getprotocol(const pthread_mutexattr_t *attr,
 				  int *proto);
 
 int pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr,
 				  int proto);
+#endif
 
+#ifndef HAVE_PTHREAD_CONDATTR_SETCLOCK
 int pthread_condattr_getclock(const pthread_condattr_t *attr,
 			      clockid_t *clk_id);
 
 int pthread_condattr_setclock(pthread_condattr_t *attr,
 			      clockid_t clk_id);
+#endif
 
 int pthread_make_periodic_np(pthread_t thread,
 			     struct timespec *starttp,

