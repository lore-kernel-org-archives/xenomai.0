Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 2/3] y2038: lib/cobalt/signal: dispatch sigtimedwait
Date: Fri,  9 Jul 2021 15:10:10 +0800
Message-Id: <1625814610-22665-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

If sizeof time_t bigger than 4, which means glibc supports
64bit timespec, go to sigtimedwait64.

otherwise, go to original sigtimedwait.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 lib/cobalt/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index 7e03301..40d315e 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -62,7 +62,11 @@ COBALT_IMPL(int, sigtimedwait, (const sigset_t *set, siginfo_t *si,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sigtimedwait64, set, si, timeout);
+#else
 	ret = XENOMAI_SYSCALL3(sc_cobalt_sigtimedwait, set, si, timeout);
+#endif
 	if (ret < 0) {
 		errno = -ret;
 		ret = -1;
-- 
2.7.4


