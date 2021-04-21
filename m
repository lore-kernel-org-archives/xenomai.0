Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v5 3/5] y2038: lib/cobalt/clock: dispatch clock_settime
Date: Wed, 21 Apr 2021 16:33:35 +0800
Message-Id: <1618994015-21169-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, florian.bezdeka@siemens.com
Cc: chensong <chensong@tj.kylinos.cn>

From: chensong <chensong@tj.kylinos.cn>

If sizeof time_t bigger than 4, which means glibc supports
64bit timespec, go to clock_settime64.

otherwise, go to original clock_settime.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 lib/cobalt/clock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 8f06320..edd640b 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -276,7 +276,11 @@ COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct timespec *tp))
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
2.7.4


