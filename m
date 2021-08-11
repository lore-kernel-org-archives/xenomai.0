From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 2/3] y2038: lib/cobalt/internal: dispatch monitor_wait
Date: Wed, 11 Aug 2021 15:36:49 +0200
Message-Id: <20210811133651.42582-5-florian.bezdeka@siemens.com>
In-Reply-To: <20210811133651.42582-1-florian.bezdeka@siemens.com>
References: <20210811133651.42582-1-florian.bezdeka@siemens.com>
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

If sizeof time_t bigger than 4, which means glibc supports
64bit timespec, go to monitor_wait64.

otherwise, go to original monitor_wait.

Signed-off-by: Song Chen <chensong_2000@189.cn>
[Florian: Fix warnings reported by checkpatch.pl, coding style]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/internal.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index 42b60c35b..75933a830 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -258,8 +258,12 @@ int cobalt_monitor_wait(cobalt_monitor_t *mon, int event,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	ret = XENOMAI_SYSCALL4(sc_cobalt_monitor_wait,
-			       mon, event, ts, &opret);
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL4(sc_cobalt_monitor_wait64, mon, event, ts,
+			       &opret);
+#else
+	ret = XENOMAI_SYSCALL4(sc_cobalt_monitor_wait, mon, event, ts, &opret);
+#endif
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.30.2


