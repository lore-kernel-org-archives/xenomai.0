From: Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] testsuite/smokey: relax posix-clock time dependancy
Date: Fri,  9 Nov 2018 10:14:30 +0100
Message-Id: <20181109091430.24559-1-henning.schild@siemens.com>
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

The test often asserted. This patch gives the thread a priority,
introduces a 25us margin and prints the value in case we still fail.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 testsuite/smokey/posix-clock/posix-clock.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/posix-clock/posix-clock.c b/testsuite/smokey/posix-clock/posix-clock.c
index f672a9d52..36e0f5dea 100644
--- a/testsuite/smokey/posix-clock/posix-clock.c
+++ b/testsuite/smokey/posix-clock/posix-clock.c
@@ -417,8 +417,10 @@ static int clock_decrease_after_periodic_timer_first_tick(void)
 
 	diff = now.tv_sec * 1000000000ULL + now.tv_nsec -
 		(timer.it_value.tv_sec * 1000000000ULL + timer.it_value.tv_nsec);
-	if (!smokey_assert(diff < 1000000000))
+	if (!smokey_assert(diff < 1000000000ULL + 25000ULL)) {
+		fprintf(stderr, "diff = %llu\n", diff);
 		return -EINVAL;
+	}
 	
 	ret = smokey_check_errno(read(t, &ticks, sizeof(ticks)));
 	if (ret < 0)
@@ -430,10 +432,21 @@ static int clock_decrease_after_periodic_timer_first_tick(void)
 	return smokey_check_errno(close(t));
 }
 
+static int init_posix_clock(void)
+{
+	struct sched_param params = {.sched_priority = 1};
+
+	return pthread_setschedparam(pthread_self(), SCHED_FIFO, &params);
+}
+
 static int run_posix_clock(struct smokey_test *t, int argc, char *const argv[])
 {
 	int ret;
 
+	ret = init_posix_clock();
+	if (ret)
+		return ret;
+
 	ret = clock_increase_before_oneshot_timer_first_tick();
 	if (ret)
 		return ret;
-- 
2.19.1


