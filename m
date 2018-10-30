From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH 1/3] lib/cobalt: Do not call glibc's {recv|send}mmsg if it is
 too old
Date: Tue, 30 Oct 2018 11:29:12 +0100
Message-Id: <1540895354-16866-2-git-send-email-sebastian.smolorz@gmx.de>
In-Reply-To: <1540895354-16866-1-git-send-email-sebastian.smolorz@gmx.de>
References: <1540895354-16866-1-git-send-email-sebastian.smolorz@gmx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Fix linking error when using glibc versions which do not provide
recvmmsg or sendmmsg.

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 lib/cobalt/wrappers.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 20ad63a..951cd15 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -260,7 +260,11 @@ __weak
 int __real_recvmmsg(int fd, struct mmsghdr *msgvec, unsigned int vlen,
 		    unsigned int flags, struct timespec *timeout)
 {
+#if (__GLIBC__ == 2) && (__GLIBC_MINOR__ < 12)
+	return -ENOSYS;
+#else
 	return recvmmsg(fd, msgvec, vlen, flags, timeout);
+#endif
 }
 
 __weak
@@ -273,7 +277,11 @@ __weak
 int __real_sendmmsg(int fd, struct mmsghdr *msgvec, unsigned int vlen,
 		    unsigned int flags)
 {
+#if (__GLIBC__ == 2) && (__GLIBC_MINOR__ < 14)
+	return -ENOSYS;
+#else
 	return sendmmsg(fd, msgvec, vlen, flags);
+#endif
 }
 
 __weak
-- 
2.7.4


