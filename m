From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/4] lib/alchemy/testsuite: Extend pipe-1 test by timeout
 checks
Date: Tue, 12 Oct 2021 20:19:19 +0200
Message-Id: <52170d1e399f7e7d002d3b1c52b142d041423fd9.1634062760.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634062760.git.jan.kiszka@siemens.com>
References: <cover.1634062760.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Validates all three rt_pipe_read functions /wrt non-blocking read as
well as timeouts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/alchemy/testsuite/pipe-1.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/lib/alchemy/testsuite/pipe-1.c b/lib/alchemy/testsuite/pipe-1.c
index 3f821efe41..4202be2bac 100644
--- a/lib/alchemy/testsuite/pipe-1.c
+++ b/lib/alchemy/testsuite/pipe-1.c
@@ -73,7 +73,10 @@ static void *regular_thread(void *arg)
 
 int main(int argc, char *const argv[])
 {
+	struct timespec ts_start, ts_end, ts_timeout, ts_delta;
 	struct pipe_message m;
+	RTIME start, end;
+	SRTIME timeout;
 	int ret;
 
 	traceobj_init(&trobj, argv[0], 0);
@@ -97,6 +100,36 @@ int main(int argc, char *const argv[])
 	ret = rt_pipe_read(&mpipe, &m, sizeof(m), TM_NONBLOCK);
 	traceobj_check(&trobj, ret, -EWOULDBLOCK);
 
+	ret = rt_pipe_read_until(&mpipe, &m, sizeof(m), TM_NONBLOCK);
+	traceobj_check(&trobj, ret, -EWOULDBLOCK);
+
+	ts_timeout.tv_sec = 0;
+	ts_timeout.tv_nsec = 0;
+	ret = rt_pipe_read_timed(&mpipe, &m, sizeof(m), &ts_timeout);
+	traceobj_check(&trobj, ret, -EWOULDBLOCK);
+
+	start = rt_timer_read();
+	timeout = rt_timer_ns2ticks(100000000);
+	ret = rt_pipe_read(&mpipe, &m, sizeof(m), timeout);
+	end = rt_timer_read();
+	traceobj_assert(&trobj, end - start >= timeout);
+	traceobj_assert(&trobj, end - start < timeout + rt_timer_ns2ticks(5000000));
+
+	start = rt_timer_read();
+	timeout = start + rt_timer_ns2ticks(100000000);
+	ret = rt_pipe_read_until(&mpipe, &m, sizeof(m), timeout);
+	end = rt_timer_read();
+	traceobj_assert(&trobj, end >= timeout);
+	traceobj_assert(&trobj, end < timeout + rt_timer_ns2ticks(5000000));
+
+	clock_gettime(CLOCK_COPPERPLATE, &ts_start);
+	timespec_adds(&ts_timeout, &ts_start, 100000000);
+	ret = rt_pipe_read_timed(&mpipe, &m, sizeof(m), &ts_timeout);
+	clock_gettime(CLOCK_COPPERPLATE, &ts_end);
+	timespec_sub(&ts_delta, &ts_end, &ts_timeout);
+	traceobj_assert(&trobj, ts_delta.tv_sec >= 0);
+	traceobj_assert(&trobj, ts_delta.tv_nsec < 5000000);
+
 	ret = pthread_create(&t_reg, NULL, regular_thread, NULL);
 	traceobj_check(&trobj, ret, 0);
 
-- 
2.31.1


