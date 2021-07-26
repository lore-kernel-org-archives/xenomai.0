Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 2/3] y2038: lib/cobalt/internal: dispatch monitor_wait
Date: Mon, 26 Jul 2021 15:16:35 +0800
Message-Id: <1627283795-4128-1-git-send-email-chensong_2000@189.cn>
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
64bit timespec, go to monitor_wait64.

otherwise, go to original monitor_wait.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 lib/cobalt/internal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index bc3287b..ef3f163 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -256,8 +256,13 @@ int cobalt_monitor_wait(cobalt_monitor_t *mon, int event,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL4(sc_cobalt_monitor_wait64,
+			       mon, event, ts, &opret);
+#else
 	ret = XENOMAI_SYSCALL4(sc_cobalt_monitor_wait,
 			       mon, event, ts, &opret);
+#endif
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.7.4


