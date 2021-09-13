From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/posix/io: Privatize some select helpers
Message-ID: <4f606a3b-4127-53a6-a561-d3b79d660e40@siemens.com>
Date: Mon, 13 Sep 2021 22:11:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This was missed in c4c2fc21a32d.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/io.c | 6 +++---
 kernel/cobalt/posix/io.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 0c17f55bf3..be8a2d3f0f 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -167,7 +167,7 @@ COBALT_SYSCALL(mmap, lostage,
 	return cobalt_copy_to_user(u_addrp, &u_addr, sizeof(u_addr));
 }
 
-int __cobalt_first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
+static int __cobalt_first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 {
 	int i, fd;
 
@@ -181,8 +181,8 @@ int __cobalt_first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 	return 1;
 }
 
-int __cobalt_select_bind_all(struct xnselector *selector,
-			     fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
+static int __cobalt_select_bind_all(struct xnselector *selector,
+				    fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 {
 	bool first_fd = true;
 	unsigned fd, type;
diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
index d9f29fa595..c02595b4f3 100644
--- a/kernel/cobalt/posix/io.h
+++ b/kernel/cobalt/posix/io.h
@@ -23,11 +23,6 @@
 #include <xenomai/posix/syscall.h>
 #include <cobalt/kernel/select.h>
 
-int __cobalt_first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds);
-
-int __cobalt_select_bind_all(struct xnselector *selector,
-			     fd_set *fds[XNSELECT_MAX_TYPES], int nfds);
-
 int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 		    void __user *u_xfds, void __user *u_tv, bool compat);
 
-- 
2.31.1

