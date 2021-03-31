From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 2/3] y2038: lib/cobalt/clock: dispatch clock_nanosleep
Date: Wed, 31 Mar 2021 11:26:14 +0800
Message-Id: <1617161174-27187-1-git-send-email-chensong@tj.kylinos.cn>
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
64bit timespec, go to clock_nanosleep64.

otherwise, go to original clock_nanosleep.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 lib/cobalt/clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index e861413..b799e27 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -360,8 +360,13 @@ COBALT_IMPL(int, clock_nanosleep, (clockid_t clock_id,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep64,
+				clock_id, flags, rqtp, rmtp);
+#else
 	ret = -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep,
 				clock_id, flags, rqtp, rmtp);
+#endif
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.7.4




