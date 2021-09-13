Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v3 2/3] y2038: lib/cobalt/rtdm: dispatch recvmmg
Date: Mon, 13 Sep 2021 09:45:57 +0800
Message-Id: <1631497557-25064-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

If libc reports time64_t support, recvmmsg is dispatched to the
time64_t based syscall.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 lib/cobalt/rtdm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index f3fb5d4..8232310 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -272,7 +272,12 @@ COBALT_IMPL(int, recvmmsg, (int fd, struct mmsghdr *msgvec, unsigned int vlen,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg64, fd, msgvec,
+				vlen, flags, timeout);
+#else
 	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg, fd, msgvec, vlen, flags, timeout);
+#endif
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.7.4


