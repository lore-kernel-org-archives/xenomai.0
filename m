From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 2/5] y2038: lib/cobalt/mqueue: dispatch mq_timedsend
Date: Tue, 10 Aug 2021 12:24:48 +0200
Message-Id: <20210810102451.49642-3-florian.bezdeka@siemens.com>
In-Reply-To: <20210810102451.49642-1-florian.bezdeka@siemens.com>
References: <20210810102451.49642-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Song Chen <chensong_2000@189.cn>

Dispatch mq_timesend to the 64bit aware syscall if libc reports
time64_t support.

Signed-off-by: Song Chen <chensong_2000@189.cn>
[Florian: Rephrase commit message]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/mq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index 471d9b39e..59e46f2e2 100644
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
2.30.2


