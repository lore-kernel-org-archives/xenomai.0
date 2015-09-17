From: Henning Schild <henning.schild@siemens.com>
Date: Thu, 17 Sep 2015 14:46:32 +0200
Message-Id: <1442493995-25337-1-git-send-email-henning.schild@siemens.com>
In-Reply-To: <20150917143955.01a71eb6@md1em3qc>
References: <20150917143955.01a71eb6@md1em3qc>
Subject: [Xenomai] [PATCH xenomai2 1/2] adopt to kernel change
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
 include/rtdm/rtdm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/rtdm/rtdm.h b/include/rtdm/rtdm.h
index d907f08..5da5687 100644
--- a/include/rtdm/rtdm.h
+++ b/include/rtdm/rtdm.h
@@ -49,6 +49,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/fs.h>
+#include <linux/uio.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/ioctl.h>
@@ -295,8 +297,12 @@ static inline ssize_t rt_dev_recvfrom(int fd, void *buf, size_t len, int flags,
 
 	msg.msg_name = from;
 	msg.msg_namelen = from ? *fromlen : 0;
+#ifdef __KERNEL__
+	iov_iter_init(&msg.msg_iter, READ, &iov, 1, len);
+#else
 	msg.msg_iov = &iov;
 	msg.msg_iovlen = 1;
+#endif
 	msg.msg_control = NULL;
 	msg.msg_controllen = 0;
 
@@ -351,8 +357,12 @@ static inline ssize_t rt_dev_sendto(int fd, const void *buf, size_t len,
 
 	msg.msg_name = (struct sockaddr *)to;
 	msg.msg_namelen = tolen;
+#ifdef __KERNEL__
+	iov_iter_init(&msg.msg_iter, WRITE, &iov, 1, len);
+#else
 	msg.msg_iov = &iov;
 	msg.msg_iovlen = 1;
+#endif
 	msg.msg_control = NULL;
 	msg.msg_controllen = 0;
 
-- 
2.4.6


