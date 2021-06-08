Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 2/5] y2038: lib/cobalt/mqueue: dispatch mq_timedsend
Date: Tue,  8 Jun 2021 10:11:49 +0800
Message-Id: <1623118309-7163-1-git-send-email-chensong_2000@189.cn>
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
64bit timespec, go to mq_timedsend64.

otherwise, go to original mq_timedsend.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 lib/cobalt/mq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index 471d9b3..59e46f2 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -332,8 +332,13 @@ COBALT_IMPL(int, mq_send, (mqd_t q, const char *buffer, size_t len, unsigned pri
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedsend64,
+			       q, buffer, len, prio, NULL);
+#else
 	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedsend,
 			       q, buffer, len, prio, NULL);
+#endif
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.7.4


