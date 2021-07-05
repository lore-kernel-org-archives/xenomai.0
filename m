From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 9/9] cobalt/posix/io: Unify native and compat versions of
 select
Date: Mon,  5 Jul 2021 09:36:41 +0200
Message-Id: <c4c2fc21a32d6519c8adcea636248937f5dba23a.1625470600.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625470600.git.jan.kiszka@siemens.com>
References: <cover.1625470600.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Rather than duplicating lots of code for the sake of compat userspace
accesses, provide a common version that is given a flag to decide
whether to take the compat or regular code paths.

This also brings restart support to the compat selection version which
was forgotten by 36132cdb21cd.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/io.c        | 97 ++++++++++++++++++++++++---------
 kernel/cobalt/posix/io.h        |  3 +
 kernel/cobalt/posix/syscall32.c | 92 +------------------------------
 3 files changed, 76 insertions(+), 116 deletions(-)

diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 8a74074f3c..0c17f55bf3 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -19,6 +19,7 @@
  */
 #include <linux/err.h>
 #include <linux/fs.h>
+#include <cobalt/kernel/compat.h>
 #include <cobalt/kernel/ppd.h>
 #include <xenomai/rtdm/internal.h>
 #include "process.h"
@@ -210,15 +211,10 @@ int __cobalt_select_bind_all(struct xnselector *selector,
 	return 0;
 }
 
-/* int select(int, fd_set *, fd_set *, fd_set *, struct __kernel_old_timeval *) */
-COBALT_SYSCALL(select, primary,
-	       (int nfds,
-		fd_set __user *u_rfds,
-		fd_set __user *u_wfds,
-		fd_set __user *u_xfds,
-		struct __kernel_old_timeval __user *u_tv))
+int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
+		    void __user *u_xfds, void __user *u_tv, bool compat)
 {
-	fd_set __user *ufd_sets[XNSELECT_MAX_TYPES] = {
+	void __user *ufd_sets[XNSELECT_MAX_TYPES] = {
 		[XNSELECT_READ] = u_rfds,
 		[XNSELECT_WRITE] = u_wfds,
 		[XNSELECT_EXCEPT] = u_xfds
@@ -250,9 +246,18 @@ COBALT_SYSCALL(select, primary,
 				goto out;
 			}
 		} else {
-			if (!access_wok(u_tv, sizeof(tv))
-			    || cobalt_copy_from_user(&tv, u_tv, sizeof(tv)))
-				return -EFAULT;
+#ifdef CONFIG_XENO_ARCH_SYS3264
+			if (compat) {
+				if (sys32_get_timeval(&tv, u_tv))
+					return -EFAULT;
+			} else
+#endif
+			{
+				if (!access_wok(u_tv, sizeof(tv))
+				    || cobalt_copy_from_user(&tv, u_tv,
+							     sizeof(tv)))
+					return -EFAULT;
+			}
 
 			if (tv.tv_usec >= 1000000)
 				return -EINVAL;
@@ -268,13 +273,22 @@ COBALT_SYSCALL(select, primary,
 	for (i = 0; i < XNSELECT_MAX_TYPES; i++)
 		if (ufd_sets[i]) {
 			in_fds[i] = &in_fds_storage[i];
-			out_fds[i] = & out_fds_storage[i];
-			if (!access_wok((void __user *) ufd_sets[i],
-					sizeof(fd_set))
-			    || cobalt_copy_from_user(in_fds[i],
-						     (void __user *) ufd_sets[i],
-						     fds_size))
-				return -EFAULT;
+			out_fds[i] = &out_fds_storage[i];
+#ifdef CONFIG_XENO_ARCH_SYS3264
+			if (compat) {
+				if (sys32_get_fdset(in_fds[i], ufd_sets[i],
+						    fds_size))
+					return -EFAULT;
+			} else
+#endif
+			{
+				if (!access_wok((void __user *) ufd_sets[i],
+						sizeof(fd_set))
+				    || cobalt_copy_from_user(in_fds[i],
+							     (void __user *)ufd_sets[i],
+							     fds_size))
+					return -EFAULT;
+			}
 		}
 
 	selector = curr->selector;
@@ -294,7 +308,8 @@ COBALT_SYSCALL(select, primary,
 
 		/* Bind directly the file descriptors, we do not need to go
 		   through xnselect returning -ECHRNG */
-		if ((err = __cobalt_select_bind_all(selector, in_fds, nfds)))
+		err = __cobalt_select_bind_all(selector, in_fds, nfds);
+		if (err)
 			return err;
 	}
 
@@ -326,15 +341,45 @@ out:
 		else
 			tv.tv_sec = tv.tv_usec = 0;
 
-		if (cobalt_copy_to_user(u_tv, &tv, sizeof(tv)))
-			return -EFAULT;
+#ifdef CONFIG_XENO_ARCH_SYS3264
+		if (compat) {
+			if (sys32_put_timeval(u_tv, &tv))
+				return -EFAULT;
+		} else
+#endif
+		{
+			if (cobalt_copy_to_user(u_tv, &tv, sizeof(tv)))
+				return -EFAULT;
+		}
 	}
 
 	if (err >= 0)
-		for (i = 0; i < XNSELECT_MAX_TYPES; i++)
-			if (ufd_sets[i]
-			    && cobalt_copy_to_user((void __user *) ufd_sets[i],
-						   out_fds[i], sizeof(fd_set)))
-				return -EFAULT;
+		for (i = 0; i < XNSELECT_MAX_TYPES; i++) {
+			if (!ufd_sets[i])
+				continue;
+#ifdef CONFIG_XENO_ARCH_SYS3264
+			if (compat) {
+				if (sys32_put_fdset(ufd_sets[i], out_fds[i],
+						    sizeof(fd_set)))
+					return -EFAULT;
+			} else
+#endif
+			{
+				if (cobalt_copy_to_user((void __user *)ufd_sets[i],
+							out_fds[i], sizeof(fd_set)))
+					return -EFAULT;
+			}
+		}
 	return err;
 }
+
+/* int select(int, fd_set *, fd_set *, fd_set *, struct __kernel_old_timeval *) */
+COBALT_SYSCALL(select, primary,
+	       (int nfds,
+		fd_set __user *u_rfds,
+		fd_set __user *u_wfds,
+		fd_set __user *u_xfds,
+		struct __kernel_old_timeval __user *u_tv))
+{
+	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, false);
+}
diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
index e4f7d4d51f..d9f29fa595 100644
--- a/kernel/cobalt/posix/io.h
+++ b/kernel/cobalt/posix/io.h
@@ -28,6 +28,9 @@ int __cobalt_first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds);
 int __cobalt_select_bind_all(struct xnselector *selector,
 			     fd_set *fds[XNSELECT_MAX_TYPES], int nfds);
 
+int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
+		    void __user *u_xfds, void __user *u_tv, bool compat);
+
 COBALT_SYSCALL_DECL(open,
 		    (const char __user *u_path, int oflag));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index c298f38f5a..a37478f3f9 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -743,102 +743,14 @@ COBALT_SYSCALL32emu(event_wait, primary,
 	return __cobalt_event_wait(u_event, bits, u_bits_r, mode, tsp);
 }
 
-COBALT_SYSCALL32emu(select, nonrestartable,
+COBALT_SYSCALL32emu(select, primary,
 		    (int nfds,
 		     compat_fd_set __user *u_rfds,
 		     compat_fd_set __user *u_wfds,
 		     compat_fd_set __user *u_xfds,
 		     struct old_timeval32 __user *u_tv))
 {
-	compat_fd_set __user *ufd_sets[XNSELECT_MAX_TYPES] = {
-		[XNSELECT_READ] = u_rfds,
-		[XNSELECT_WRITE] = u_wfds,
-		[XNSELECT_EXCEPT] = u_xfds
-	};
-	fd_set *in_fds[XNSELECT_MAX_TYPES] = {NULL, NULL, NULL};
-	fd_set *out_fds[XNSELECT_MAX_TYPES] = {NULL, NULL, NULL};
-	fd_set in_fds_storage[XNSELECT_MAX_TYPES],
-		out_fds_storage[XNSELECT_MAX_TYPES];
-	xnticks_t timeout = XN_INFINITE;
-	xntmode_t mode = XN_RELATIVE;
-	struct xnselector *selector;
-	struct xnthread *curr;
-	struct __kernel_old_timeval tv;
-	xnsticks_t diff;
-	size_t fds_size;
-	int i, err;
-
-	curr = xnthread_current();
-
-	if (u_tv) {
-		err = sys32_get_timeval(&tv, u_tv);
-		if (err)
-			return err;
-
-		if (tv.tv_usec >= 1000000)
-			return -EINVAL;
-
-		timeout = clock_get_ticks(CLOCK_MONOTONIC) + tv2ns(&tv);
-		mode = XN_ABSOLUTE;
-	}
-
-	fds_size = __FDELT__(nfds + __NFDBITS__ - 1) * sizeof(compat_ulong_t);
-
-	for (i = 0; i < XNSELECT_MAX_TYPES; i++)
-		if (ufd_sets[i]) {
-			in_fds[i] = &in_fds_storage[i];
-			out_fds[i] = & out_fds_storage[i];
-			if (sys32_get_fdset(in_fds[i], ufd_sets[i], fds_size) < 0)
-				return -EFAULT;
-		}
-
-	selector = curr->selector;
-	if (selector == NULL) {
-		/* Bail out if non-RTDM fildes is found. */
-		if (!__cobalt_first_fd_valid_p(in_fds, nfds))
-			return -EADV;
-
-		selector = xnmalloc(sizeof(*curr->selector));
-		if (selector == NULL)
-			return -ENOMEM;
-		xnselector_init(selector);
-		curr->selector = selector;
-
-		/* Bind directly the file descriptors, we do not need to go
-		   through xnselect returning -ECHRNG */
-		err = __cobalt_select_bind_all(selector, in_fds, nfds);
-		if (err)
-			return err;
-	}
-
-	do {
-		err = xnselect(selector, out_fds, in_fds, nfds, timeout, mode);
-		if (err == -ECHRNG) {
-			int bind_err = __cobalt_select_bind_all(selector,
-								out_fds, nfds);
-			if (bind_err)
-				return bind_err;
-		}
-	} while (err == -ECHRNG);
-
-	if (u_tv && (err > 0 || err == -EINTR)) {
-		diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
-		if (diff > 0)
-			ticks2tv(&tv, diff);
-		else
-			tv.tv_sec = tv.tv_usec = 0;
-
-		if (sys32_put_timeval(u_tv, &tv))
-			return -EFAULT;
-	}
-
-	if (err >= 0)
-		for (i = 0; i < XNSELECT_MAX_TYPES; i++)
-			if (ufd_sets[i] &&
-			    sys32_put_fdset(ufd_sets[i], out_fds[i],
-					    sizeof(fd_set)) < 0)
-				return -EFAULT;
-	return err;
+	return __cobalt_select(nfds, u_rfds, u_wfds, u_xfds, u_tv, true);
 }
 
 COBALT_SYSCALL32emu(recvmsg, handover,
-- 
2.26.2


