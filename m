From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH v2 4/5] [y2038] lib: cobalt: clock: dispatch clock_gettime
Date: Fri, 12 Mar 2021 12:02:01 +0800
Message-Id: <1615521721-5945-1-git-send-email-chensong@tj.kylinos.cn>
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
64bit timespec, go to clock_gettime64.

otherwise, go to original clock_settime.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 lib/cobalt/clock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index edd640b..e861413 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -172,7 +172,11 @@ static int gettime_via_tsc(clockid_t clock_id, struct timespec *tp)
 		tp->tv_nsec = rem;
 		return 0;
 	default:
+#ifdef __USE_TIME_BITS64
+		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime64, clock_id, tp);
+#else
 		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
+#endif
 	}
 
 	if (ret) {
@@ -197,7 +201,11 @@ static int gettime_via_vdso(clockid_t clock_id, struct timespec *tp)
 		ret = __cobalt_vdso_gettime(clock_id, tp);
 		break;
 	default:
+#ifdef __USE_TIME_BITS64
+		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime64, clock_id, tp);
+#else
 		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
+#endif
 	}
 
 	if (ret) {
-- 
2.7.4




