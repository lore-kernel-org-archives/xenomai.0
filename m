Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 2/3] y2038: lib/cobalt/clock: dispatch clock_getres
Date: Tue, 27 Apr 2021 15:27:11 +0800
Message-Id: <1619508431-16944-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org
Cc: chensong <chensong@tj.kylinos.cn>

From: chensong <chensong@tj.kylinos.cn>

If sizeof time_t bigger than 4, which means glibc supports
64bit timespec, go to clock_getres64.

otherwise, go to original clock_getres.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 lib/cobalt/clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 45593ed..3045563 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -101,7 +101,12 @@ COBALT_IMPL(int, clock_getres, (clockid_t clock_id, struct timespec *tp))
 {
 	int ret;
 
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_getres64, clock_id, tp);
+#else
 	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_getres, clock_id, tp);
+#endif
+
 	if (ret) {
 		errno = ret;
 		return -1;
-- 
2.7.4


