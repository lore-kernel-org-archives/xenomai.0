From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 8/9] y2038: lib/cobalt/clock: dispatch clock_nanosleep
Date: Tue,  1 Jun 2021 11:43:33 +0200
Message-Id: <20210601094334.774394-9-florian.bezdeka@siemens.com>
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
64bit timespec, go to clock_nanosleep64.

otherwise, go to original clock_nanosleep.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 16081c86e..edecb40a0 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -361,8 +361,13 @@ COBALT_IMPL(int, clock_nanosleep, (clockid_t clock_id,
 
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
2.31.1


