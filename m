From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 4/4] [y2038] lib: cobalt: clock: dispatch clock_settime
Date: Thu, 11 Mar 2021 10:47:07 +0800
Message-Id: <1615430827-23866-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

If sizeof time_t bigger than 4, which means glibc supports
64bit timespec, and __xn_feat_time64 is available in kernel,
go to clock_settime64.

otherwise, go to original clock_settime.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 lib/cobalt/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 8f06320..843ecd4 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -276,7 +276,13 @@ COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct timespec *tp))
 	if (clock_id == CLOCK_REALTIME && !cobalt_use_legacy_tsc())
 		return __STD(clock_settime(CLOCK_REALTIME, tp));
 
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL2((cobalt_features_available(__xn_feat_time64)) ?
+			 sc_cobalt_clock_settime64 : sc_cobalt_clock_settime,
+			 clock_id, tp);
+#else
 	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
+#endif
 	if (ret) {
 		errno = ret;
 		return -1;
-- 
2.7.4




