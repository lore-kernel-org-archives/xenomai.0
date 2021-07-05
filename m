From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 8/9] cobalt/posix/compat: Privatize sys32_get/put_fdset
Date: Mon,  5 Jul 2021 09:36:40 +0200
Message-Id: <28f7f7e92f8098e01d9030fe29f5aa0535bcefb2.1625470600.git.jan.kiszka@siemens.com>
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

There is no use for this outside of the core that implements select. So
stop exporting these helpers. As there are no users outside, simplify
their return value on success to 0 because their callers do not care
about more.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/compat.h |  8 ++++----
 kernel/cobalt/posix/compat.c   | 14 ++++++--------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
index 6da7bafaf8..275735df59 100644
--- a/include/cobalt/kernel/compat.h
+++ b/include/cobalt/kernel/compat.h
@@ -110,11 +110,11 @@ int sys32_get_timex(struct __kernel_timex *tx,
 int sys32_put_timex(struct old_timex32 __user *ctx,
 		    const struct __kernel_timex *tx);
 
-ssize_t sys32_get_fdset(fd_set *fds, const compat_fd_set __user *cfds,
-			size_t cfdsize);
+int sys32_get_fdset(fd_set *fds, const compat_fd_set __user *cfds,
+		    size_t cfdsize);
 
-ssize_t sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
-			size_t fdsize);
+int sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
+		    size_t fdsize);
 
 int sys32_get_param_ex(int policy,
 		       struct sched_param_ex *p,
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index dbc9a9cf02..029fe2582a 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -176,8 +176,8 @@ int sys32_put_timex(struct old_timex32 __user *ctx,
 }
 EXPORT_SYMBOL_GPL(sys32_put_timex);
 
-ssize_t sys32_get_fdset(fd_set *fds, const compat_fd_set __user *cfds,
-			size_t cfdsize)
+int sys32_get_fdset(fd_set *fds, const compat_fd_set __user *cfds,
+		    size_t cfdsize)
 {
 	int rdpos, wrpos, rdlim = cfdsize / sizeof(compat_ulong_t);
 
@@ -188,12 +188,11 @@ ssize_t sys32_get_fdset(fd_set *fds, const compat_fd_set __user *cfds,
 		if (__xn_get_user(fds->fds_bits[wrpos], cfds->fds_bits + rdpos))
 			return -EFAULT;
 
-	return (ssize_t)rdlim * sizeof(long);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(sys32_get_fdset);
 
-ssize_t sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
-			size_t fdsize)
+int sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
+		    size_t fdsize)
 {
 	int rdpos, wrpos, wrlim = fdsize / sizeof(long);
 
@@ -204,9 +203,8 @@ ssize_t sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
 		if (__xn_put_user(fds->fds_bits[rdpos], cfds->fds_bits + wrpos))
 			return -EFAULT;
 
-	return (ssize_t)wrlim * sizeof(compat_ulong_t);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(sys32_put_fdset);
 
 int sys32_get_param_ex(int policy,
 		       struct sched_param_ex *p,
-- 
2.26.2


