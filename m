From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qan3SzVFZz"
Content-Transfer-Encoding: 7bit
Message-ID: <18350.7454.600401.472547@domain.hid>
Date: Sat, 9 Feb 2008 22:37:34 +0100
In-Reply-To: <18350.7135.108901.491437@domain.hid>
References: <18350.7135.108901.491437@domain.hid>
Subject: [Xenomai-core] [patch 4/4] posix skin user-space support for select.
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


--Qan3SzVFZz
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


stats:
 include/posix/sys/select.h     |   23 +++++++++++++++++++++++
 src/skins/posix/Makefile.am    |    1 +
 src/skins/posix/posix.wrappers |    1 +
 src/skins/posix/select.c       |   26 ++++++++++++++++++++++++++
 src/skins/posix/wrappers.c     |    9 +++++++++
 5 files changed, 60 insertions(+)

-- 


					    Gilles Chanteperdrix.

--Qan3SzVFZz
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-select-posix-user.diff"
Content-Transfer-Encoding: 7bit

--- include/posix/sys/select.h	(revision 0)
+++ include/posix/sys/select.h	(revision 0)
@@ -0,0 +1,23 @@
+#ifndef _XENO_POSIX_SELECT_H
+#define _XENO_POSIX_SELECT_H
+
+#if !(defined(__KERNEL__) || defined(__XENO_SIM__))
+
+#include_next <sys/select.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+extern int __real_select (int __nfds, fd_set *__restrict __readfds,
+			  fd_set *__restrict __writefds,
+			  fd_set *__restrict __exceptfds,
+			  struct timeval *__restrict __timeout);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* !(__KERNEL__ || __XENO_SIM__) */
+
+#endif /* _XENO_POSIX_SELECT_H */
--- src/skins/posix/wrappers.c	(revision 3460)
+++ src/skins/posix/wrappers.c	(working copy)
@@ -30,6 +30,7 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <sys/select.h>
 
 /* sched */
 int __real_pthread_setschedparam(pthread_t thread,
@@ -235,3 +236,11 @@ int __real_munmap(void *addr, size_t len
 {
 	return munmap(addr, len);
 }
+
+int __real_select (int __nfds, fd_set *__restrict __readfds,
+		   fd_set *__restrict __writefds,
+		   fd_set *__restrict __exceptfds,
+		   struct timeval *__restrict __timeout)
+{
+	return select(__nfds, __readfds, __writefds, __exceptfds, __timeout);
+}
--- src/skins/posix/select.c	(revision 0)
+++ src/skins/posix/select.c	(revision 0)
@@ -0,0 +1,26 @@
+#include <errno.h>
+#include <posix/syscall.h>
+#include <sys/select.h>
+
+extern int __pse51_muxid;
+
+int __wrap_select (int __nfds, fd_set *__restrict __readfds,
+		   fd_set *__restrict __writefds,
+		   fd_set *__restrict __exceptfds,
+		   struct timeval *__restrict __timeout)
+{
+	int err;
+
+	err = XENOMAI_SKINCALL5(__pse51_muxid, __pse51_select, __nfds,
+				__readfds, __writefds, __exceptfds, __timeout);
+
+	if (err == -EBADF || err == -EPERM || err == -ENOSYS)
+		return __real_select(__nfds, __readfds,
+				     __writefds, __exceptfds, __timeout);
+
+	if (err > 0)
+		return err;
+
+	errno = -err;
+	return -1;
+}
--- src/skins/posix/posix.wrappers	(revision 3460)
+++ src/skins/posix/posix.wrappers	(working copy)
@@ -87,3 +87,4 @@
 --wrap shm_unlink
 --wrap mmap
 --wrap munmap
+--wrap select
--- src/skins/posix/Makefile.am	(revision 3460)
+++ src/skins/posix/Makefile.am	(working copy)
@@ -15,6 +15,7 @@ libpthread_rt_la_SOURCES = \
 	mutex.c \
 	shm.c \
 	interrupt.c \
+	select.c \
 	rtdm.c \
 	wrappers.c
 

--Qan3SzVFZz--

