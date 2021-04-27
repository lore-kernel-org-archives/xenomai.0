Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH v3 2/3] y2038: lib/cobalt/clock: dispatch clock_nanosleep
Date: Tue, 27 Apr 2021 14:41:17 +0800
Message-Id: <1619505677-14077-1-git-send-email-chensong_2000@189.cn>
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
64bit timespec, go to clock_nanosleep64.

otherwise, go to original clock_nanosleep.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 lib/cobalt/clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index e33c2da..45593ed 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -365,8 +365,13 @@ COBALT_IMPL(int, clock_nanosleep, (clockid_t clock_id,
 
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


