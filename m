From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6/9] cobalt/select: Add proper handling of EADV
Date: Mon,  5 Jul 2021 09:36:38 +0200
Message-Id: <ef3dd5c07befc1051ddce5c802edc3b070a50568.1625470600.git.jan.kiszka@siemens.com>
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

Since rtdm_fd_select started to return EADV for unknown fds
(2db562ad62ec), we were returning that code to applications in case a
selector had been allocated for the caller already. That was because
libcobalt lacked handling of this error.

This fixes it and also establish proper signaling of EBADF in case the
is a real error related to an RTDM fd. For that purpose, detect if
__cobalt_select_bind_all got EADV for the first fd or for a succeeding
one, i.e. on an unsupported mixed fd set.

Also return EADV if the early __cobalt_first_fd_valid_p test fails. That
ensures that we only retry with the regular Linux call when it makes
sense.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/io.c        | 13 +++++++++++--
 kernel/cobalt/posix/syscall32.c |  2 +-
 lib/cobalt/select.c             |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 70dd3c9c55..8a74074f3c 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -183,6 +183,7 @@ int __cobalt_first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 int __cobalt_select_bind_all(struct xnselector *selector,
 			     fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 {
+	bool first_fd = true;
 	unsigned fd, type;
 	int err;
 
@@ -193,8 +194,16 @@ int __cobalt_select_bind_all(struct xnselector *selector,
 			     fd < nfds;
 			     fd = find_next_bit(set->fds_bits, nfds, fd + 1)) {
 				err = rtdm_fd_select(fd, selector, type);
-				if (err)
+				if (err) {
+					/*
+					 * Do not needlessly signal "retry
+					 * under Linux" for mixed fd sets.
+					 */
+					if (err == -EADV && !first_fd)
+						return -EBADF;
 					return err;
+				}
+				first_fd = false;
 			}
 	}
 
@@ -275,7 +284,7 @@ COBALT_SYSCALL(select, primary,
 		   simple test: test if the first file descriptor we find in the
 		   fd_set is an RTDM descriptor or a message queue descriptor. */
 		if (!__cobalt_first_fd_valid_p(in_fds, nfds))
-			return -EBADF;
+			return -EADV;
 
 		selector = xnmalloc(sizeof(*curr->selector));
 		if (selector == NULL)
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 98b9218a81..5a6de285f9 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -796,7 +796,7 @@ COBALT_SYSCALL32emu(select, nonrestartable,
 	if (selector == NULL) {
 		/* Bail out if non-RTDM fildes is found. */
 		if (!__cobalt_first_fd_valid_p(in_fds, nfds))
-			return -EBADF;
+			return -EADV;
 
 		selector = xnmalloc(sizeof(*curr->selector));
 		if (selector == NULL)
diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
index 362a182389..7727012c7a 100644
--- a/lib/cobalt/select.c
+++ b/lib/cobalt/select.c
@@ -36,7 +36,7 @@ COBALT_IMPL(int, select, (int __nfds, fd_set *__restrict __readfds,
 
 	pthread_setcanceltype(oldtype, NULL);
 
-	if (err == -EBADF || err == -EPERM || err == -ENOSYS)
+	if (err == -EADV || err == -EPERM || err == -ENOSYS)
 		return __STD(select(__nfds, __readfds,
 				    __writefds, __exceptfds, __timeout));
 
-- 
2.26.2


