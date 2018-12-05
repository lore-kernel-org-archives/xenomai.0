From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] cobalt/posix: fcntl: turn the generic argument into a long
 value
Date: Wed,  5 Dec 2018 16:29:00 +0100
Message-Id: <20181205152900.28540-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

In order to prevent unexpected truncation of pointer args in userland
with the LP64 data model, libcobalt's fcntl() wrapper should accept a
long (3rd) argument.

Anticipate this change in the corresponding syscall implementation in
the Cobalt core.  The updated ABI remains backward-compatible for
current users.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/posix/io.c | 2 +-
 kernel/cobalt/posix/io.h | 2 +-
 kernel/cobalt/rtdm/fd.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index ef4a0fea2..f35aaf8cd 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -53,7 +53,7 @@ COBALT_SYSCALL(close, lostage, (int fd))
 	return rtdm_fd_close(fd, 0);
 }
 
-COBALT_SYSCALL(fcntl, current, (int fd, int cmd, int arg))
+COBALT_SYSCALL(fcntl, current, (int fd, int cmd, long arg))
 {
 	return rtdm_fd_fcntl(fd, cmd, arg);
 }
diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
index 647f7f3e9..6f20dbedd 100644
--- a/kernel/cobalt/posix/io.h
+++ b/kernel/cobalt/posix/io.h
@@ -37,7 +37,7 @@ COBALT_SYSCALL_DECL(socket,
 
 COBALT_SYSCALL_DECL(close, (int fd));
 
-COBALT_SYSCALL_DECL(fcntl, (int fd, int cmd, int arg));
+COBALT_SYSCALL_DECL(fcntl, (int fd, int cmd, long arg));
 
 COBALT_SYSCALL_DECL(ioctl,
 		    (int fd, unsigned int request, void __user *arg));
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 807a11eae..f3b6444c3 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -371,7 +371,7 @@ int rtdm_fd_fcntl(int ufd, int cmd, ...)
 {
 	struct rtdm_fd *fd;
 	va_list ap;
-	int arg;
+	long arg;
 	int ret;
 
 	fd = rtdm_fd_get(ufd, 0);
@@ -379,7 +379,7 @@ int rtdm_fd_fcntl(int ufd, int cmd, ...)
 		return PTR_ERR(fd);
 
 	va_start(ap, cmd);
-	arg = va_arg(ap, int);
+	arg = va_arg(ap, long);
 	va_end(ap);
 
 	switch (cmd) {
-- 
2.17.2


