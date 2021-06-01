From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 5/6] y2038: lib/cobalt/clock: dispatch clock_adjtime
Date: Tue,  1 Jun 2021 15:31:23 +0200
Message-Id: <20210601133124.1466307-6-florian.bezdeka@siemens.com>
In-Reply-To: <20210601133124.1466307-1-florian.bezdeka@siemens.com>
References: <20210601133124.1466307-1-florian.bezdeka@siemens.com>
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

From: Song Chen <chensong_2000@189.cn>

If sizeof time_t bigger than 4, which means glibc supports
64bit timespec, go to clock_adjtime64.

otherwise, go to original clock_adjtime.

Signed-off-by: Song Chen <chensong_2000@189.cn>
Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 37e01c130..cacc19186 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -309,7 +309,12 @@ COBALT_IMPL(int, clock_adjtime, (clockid_t clock_id, struct timex *tx))
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
2.31.1


