From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 5/9] y2038: lib/cobalt/clock: dispatch clock_settime
Date: Tue,  1 Jun 2021 11:43:30 +0200
Message-Id: <20210601094334.774394-6-florian.bezdeka@siemens.com>
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
64bit timespec, go to clock_settime64.

otherwise, go to original clock_settime.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/clock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 21a66ddcf..16081c86e 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -285,7 +285,11 @@ COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct timespec *tp))
 	if (clock_id == CLOCK_REALTIME && !cobalt_use_legacy_tsc())
 		return __STD(clock_settime(CLOCK_REALTIME, tp));
 
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime64, clock_id, tp);
+#else
 	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
+#endif
 	if (ret) {
 		errno = ret;
 		return -1;
-- 
2.31.1


