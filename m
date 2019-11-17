From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/3] testsuite/mq-2: clarify test implementation
Date: Sun, 17 Nov 2019 12:40:59 +0100
Message-Id: <20191117114100.3473-2-rpm@xenomai.org>
In-Reply-To: <20191117114100.3473-1-rpm@xenomai.org>
References: <20191117114100.3473-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 lib/alchemy/testsuite/mq-2.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/lib/alchemy/testsuite/mq-2.c b/lib/alchemy/testsuite/mq-2.c
index 3a631e4d7..9fea471b7 100644
--- a/lib/alchemy/testsuite/mq-2.c
+++ b/lib/alchemy/testsuite/mq-2.c
@@ -8,11 +8,11 @@ static struct traceobj trobj;
 
 static int tseq[] = {
 	3, 4, 5, 6,
-	1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2,
+	1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2,
 	7,
 };
 
-#define NMESSAGES ((sizeof(messages) / sizeof(messages[0])) - 1)
+#define NMESSAGES (sizeof(messages) / sizeof(messages[0]))
 
 static int messages[] = {
 	0xfafafafa,
@@ -25,7 +25,6 @@ static int messages[] = {
 	0x78787878,
 	0xdededede,
 	0xbcbcbcbc,
-	0x0
 };
 
 RT_QUEUE q;
@@ -41,9 +40,9 @@ static void peer_task(void *arg)
 		traceobj_mark(&trobj, 1);
 		ret = rt_queue_read(&q, &msg, sizeof(msg), TM_NONBLOCK);
 		traceobj_assert(&trobj, ret == sizeof(msg));
-		traceobj_assert(&trobj, msg == messages[NMESSAGES - n]);
+		traceobj_assert(&trobj, msg == messages[NMESSAGES - n - 1]);
 		traceobj_mark(&trobj, 2);
-	} while (n++ < NMESSAGES);
+	} while (n++ < NMESSAGES - 1);
 
 	traceobj_exit(&trobj);
 }
@@ -56,7 +55,7 @@ static void main_task(void *arg)
 
 	traceobj_enter(&trobj);
 
-	ret = rt_queue_create(&q, "QUEUE", sizeof(messages), NMESSAGES, Q_PRIO);
+	ret = rt_queue_create(&q, "QUEUE", sizeof(messages), NMESSAGES - 1, Q_PRIO);
 	traceobj_check(&trobj, ret, 0);
 
 	traceobj_mark(&trobj, 3);
@@ -72,11 +71,11 @@ static void main_task(void *arg)
 	traceobj_mark(&trobj, 5);
 
 	n = 0;
-	do
-		ret = rt_queue_write(&q, &messages[n], sizeof(int), Q_URGENT);
-	while (n++ < NMESSAGES && ret >= 0);
+	do {
+		ret = rt_queue_write(&q, &messages[n], sizeof(int), Q_URGENT); /* LIFO */
+	} while (++n < NMESSAGES && ret >= 0);
 
-	traceobj_assert(&trobj, ret == -ENOMEM && n == NMESSAGES + 1);
+	traceobj_assert(&trobj, ret == -ENOMEM && n == NMESSAGES);
 
 	traceobj_mark(&trobj, 6);
 
-- 
2.21.0


