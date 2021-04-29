Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 2/3] y2038: lib/cobalt/clock: dispatch clock_adjtime
Date: Thu, 29 Apr 2021 15:45:05 +0800
Message-Id: <1619682305-16110-1-git-send-email-chensong_2000@189.cn>
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
64bit timespec, go to clock_adjtime64.

otherwise, go to original clock_adjtime.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 lib/cobalt/clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 3045563..41751a8 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -313,7 +313,12 @@ COBALT_IMPL(int, clock_adjtime, (clockid_t clock_id, struct timex *tx))
 {
 	int ret;
 
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_adjtime64, clock_id, tx);
+#else
 	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_adjtime, clock_id, tx);
+#endif
+
 	if (ret < 0) {
 		errno = ret;
 		return -1;
-- 
2.7.4


