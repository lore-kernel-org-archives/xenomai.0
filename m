MIME-Version: 1.0
From: Josh Bowman <jbowman@facts-inc.com>
Date: Sat, 1 Apr 2017 02:25:09 -0400
Message-ID: <CAGTNcBtzrhyCvWycQGo+G_gyDjK17jWCGudszBNgF1Uv=9pmcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] latency.c: fix occasional SIGSEGV at shutdown when mode
	is USER_TASK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

Under Mercury, I've been seeing occasionally a "Segmentation fault" message
when I hit ctrl-c to stop the latency test program. I caught a core dump,
and the stack trace leads back to the sem_wait() call in the display task.

I think this is caused by the cleanup() routine destroying the semaphore
before it calls join on the display task. This patch seems to fix the issue.

-Josh

diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index e800361..5304342 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -492,6 +492,8 @@ static void cleanup(void)
     if (test_mode == USER_TASK) {
         pthread_cancel(latency_task);
         pthread_join(latency_task, NULL);
+        pthread_join(display_task, NULL);
+
         sem_close(display_sem);
         sem_unlink(sem_name);
         gavgjitter /= (test_loops > 1 ? test_loops : 2) - 1;
@@ -504,10 +506,9 @@ static void cleanup(void)
         gmaxjitter = overall.result.max;
         gavgjitter = overall.result.avg;
         goverrun = overall.result.overruns;
+        pthread_join(display_task, NULL);
     }

-    pthread_join(display_task, NULL);
-
     if (benchdev >= 0)
         close(benchdev);
