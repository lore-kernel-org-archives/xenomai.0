From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 4/9] y2038: lib/cobalt/clock: dispatch clock_gettime
Date: Tue,  1 Jun 2021 11:43:29 +0200
Message-Id: <20210601094334.774394-5-florian.bezdeka@siemens.com>
In-Reply-To: <20210601094334.774394-1-florian.bezdeka@siemens.com>
References: <20210601094334.774394-1-florian.bezdeka@siemens.com>
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
Cc: jan.kiszka@siemens.com, chensong@tj.kylinos.cn, Florian Bezdeka <florian.bezdeka@siemens.com>

From: chensong <chensong@tj.kylinos.cn>

If sizeof time_t bigger than 4, which means glibc supports
64bit timespec, go to clock_gettime64.

otherwise, go to original clock_settime.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
[Florian: Rebased on top of next]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/clock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 3f87278ce..21a66ddcf 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -151,7 +151,11 @@ static int __do_clock_host_realtime(struct timespec *ts)
 
 static int __do_clock_gettime(clockid_t clock_id, struct timespec *tp)
 {
+#ifdef __USE_TIME_BITS64
+	return -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime64, clock_id, tp);
+#else
 	return -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
+#endif
 }
 
 static int gettime_via_tsc(clockid_t clock_id, struct timespec *tp)
-- 
2.31.1


