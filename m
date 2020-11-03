From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 5/5] lib/cobalt/clock.c:dispatch clock_settime
Date: Tue,  3 Nov 2020 11:05:43 +0800
Message-Id: <1604372743-2986-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com, henning.schild@siemens.com

Regarding sizeof time_t, dispatch 32bit timespec to clock_settime
and 64bit timespec to clock_settime64.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 lib/cobalt/clock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 11fd1aa..44b2f3f 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -237,7 +237,11 @@ COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct timespec *tp))
 {
 	int ret;
 
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
+	if (sizeof(time_t) > 4)
+		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime64,
+					clock_id, tp);
+	else
+		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
 	if (ret) {
 		errno = ret;
 		return -1;
-- 
2.7.4




