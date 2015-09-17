From: Henning Schild <henning.schild@siemens.com>
Date: Thu, 17 Sep 2015 14:46:34 +0200
Message-Id: <1442493995-25337-3-git-send-email-henning.schild@siemens.com>
In-Reply-To: <1442493995-25337-1-git-send-email-henning.schild@siemens.com>
References: <20150917143955.01a71eb6@md1em3qc>
 <1442493995-25337-1-git-send-email-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH xenomai3 1/2] adopt to kernel change
	c0371da6047abd261bc483c744dbc7d81a116172
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 include/cobalt/kernel/compat.h    |  3 ++-
 include/cobalt/kernel/rtdm/rtdm.h |  8 ++++----
 kernel/cobalt/posix/compat.c      | 14 ++++++++------
 kernel/cobalt/posix/syscall32.c   |  5 +++--
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
index b0ef81e..c21ee31 100644
--- a/include/cobalt/kernel/compat.h
+++ b/include/cobalt/kernel/compat.h
@@ -136,7 +136,8 @@ int sys32_put_siginfo(void __user *u_si, const struct siginfo *si,
 		      int overrun);
 
 int sys32_get_msghdr(struct msghdr *msg,
-		     const struct compat_msghdr __user *u_cmsg);
+		     const struct compat_msghdr __user *u_cmsg,
+		     int direction);
 
 int sys32_put_msghdr(struct compat_msghdr __user *u_cmsg,
 		     const struct msghdr *msg);
diff --git a/include/cobalt/kernel/rtdm/rtdm.h b/include/cobalt/kernel/rtdm/rtdm.h
index 7b1b33a..e269231 100644
--- a/include/cobalt/kernel/rtdm/rtdm.h
+++ b/include/cobalt/kernel/rtdm/rtdm.h
@@ -19,6 +19,8 @@
 #ifndef _COBALT_RTDM_RTDM_H
 #define _COBALT_RTDM_RTDM_H
 
+#include <linux/fs.h>
+#include <linux/uio.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/ioctl.h>
@@ -91,8 +93,7 @@ ssize_t rtdm_recvfrom(int s, void *buf, size_t len, int flags,
 	iov.iov_len = len;
 	msg.msg_name = from;
 	msg.msg_namelen = from ? *fromlen : 0;
-	msg.msg_iov = &iov;
-	msg.msg_iovlen = 1;
+	iov_iter_init(&msg.msg_iter, READ, &iov, 1, len);
 	msg.msg_control = NULL;
 	msg.msg_controllen = 0;
 
@@ -122,8 +123,7 @@ static inline ssize_t rtdm_sendto(int s, const void *buf, size_t len,
 	iov.iov_len = len;
 	msg.msg_name = (struct sockaddr *)to;
 	msg.msg_namelen = tolen;
-	msg.msg_iov = &iov;
-	msg.msg_iovlen = 1;
+	iov_iter_init(&msg.msg_iter, WRITE, &iov, 1, len);
 	msg.msg_control = NULL;
 	msg.msg_controllen = 0;
 
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index 6118f8a..1aaa374 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -15,6 +15,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+#include <linux/uio.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <cobalt/kernel/compat.h>
@@ -338,17 +339,19 @@ int sys32_put_siginfo(void __user *u_si, const struct siginfo *si,
 EXPORT_SYMBOL_GPL(sys32_put_siginfo);
 
 int sys32_get_msghdr(struct msghdr *msg,
-		     const struct compat_msghdr __user *u_cmsg)
+		     const struct compat_msghdr __user *u_cmsg,
+		     int direction)
 {
 	compat_uptr_t tmp1, tmp2, tmp3;
+	compat_size_t tmp4;
 
 	if (u_cmsg == NULL ||
 	    !access_rok(u_cmsg, sizeof(*u_cmsg)) ||
 	    __xn_get_user(tmp1, &u_cmsg->msg_name) ||
 	    __xn_get_user(msg->msg_namelen, &u_cmsg->msg_namelen) ||
 	    __xn_get_user(tmp2, &u_cmsg->msg_iov) ||
-	    __xn_get_user(msg->msg_iovlen, &u_cmsg->msg_iovlen) ||
 	    __xn_get_user(tmp3, &u_cmsg->msg_control) ||
+	    __xn_get_user(tmp4, &u_cmsg->msg_iovlen) ||
 	    __xn_get_user(msg->msg_controllen, &u_cmsg->msg_controllen) ||
 	    __xn_get_user(msg->msg_flags, &u_cmsg->msg_flags))
 		return -EFAULT;
@@ -357,9 +360,8 @@ int sys32_get_msghdr(struct msghdr *msg,
 		msg->msg_namelen = sizeof(struct sockaddr_storage);
 
 	msg->msg_name = compat_ptr(tmp1);
-	msg->msg_iov = compat_ptr(tmp2);
 	msg->msg_control = compat_ptr(tmp3);
-
+	iov_iter_init(&msg->msg_iter, direction, compat_ptr(tmp2), 1, tmp4);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sys32_get_msghdr);
@@ -371,8 +373,8 @@ int sys32_put_msghdr(struct compat_msghdr __user *u_cmsg,
 	    !access_wok(u_cmsg, sizeof(*u_cmsg)) ||
 	    __xn_put_user(ptr_to_compat(msg->msg_name), &u_cmsg->msg_name) ||
 	    __xn_put_user(msg->msg_namelen, &u_cmsg->msg_namelen) ||
-	    __xn_put_user(ptr_to_compat(msg->msg_iov), &u_cmsg->msg_iov) ||
-	    __xn_put_user(msg->msg_iovlen, &u_cmsg->msg_iovlen) ||
+	    __xn_put_user(ptr_to_compat(msg->msg_iter.iov), &u_cmsg->msg_iov) ||
+	    __xn_put_user(msg->msg_iter.nr_segs, &u_cmsg->msg_iovlen) ||
 	    __xn_put_user(ptr_to_compat(msg->msg_control), &u_cmsg->msg_control) ||
 	    __xn_put_user(msg->msg_controllen, &u_cmsg->msg_controllen) ||
 	    __xn_put_user(msg->msg_flags, &u_cmsg->msg_flags))
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index b3ce8a7..7cfe3bb 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -15,6 +15,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+#include <linux/fs.h>
 #include <linux/types.h>
 #include <linux/err.h>
 #include <cobalt/uapi/syscall.h>
@@ -736,7 +737,7 @@ COBALT_SYSCALL32emu(recvmsg, probing,
 	struct msghdr m;
 	ssize_t ret;
 
-	ret = sys32_get_msghdr(&m, umsg);
+	ret = sys32_get_msghdr(&m, umsg, READ);
 	if (ret)
 		return ret;
 
@@ -753,7 +754,7 @@ COBALT_SYSCALL32emu(sendmsg, probing,
 	struct msghdr m;
 	int ret;
 
-	ret = sys32_get_msghdr(&m, umsg);
+	ret = sys32_get_msghdr(&m, umsg, WRITE);
 
 	return ret ?: rtdm_fd_sendmsg(fd, &m, flags);
 }
-- 
2.4.6


