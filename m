From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] cobalt: Fix resource leak of cobalt_monitor
Date: Mon, 17 Jan 2022 17:53:41 +0100
Message-Id: <20220117165341.387782-1-florian.bezdeka@siemens.com>
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

We have a test within the smokey testsuite which actually does
something like

   cobalt_monitor_init()
   cobalt_monitor_wait()
       cobalt_monitor_enter()
         -> timeout
       cobalt_monitor_exit()
   cobalt_monitor_destroy()

If the posix_mutex tests were run right after this scenario the mutex
tests failed. The wrong mutex state was caused by the monitor in the
previous test not being cleaned up properly.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

I'm not 100% sure about this fix. Maybe we should move it into
cobalt_monitor_reclaim, maybe I'm using the monitor in a wrong way
inside the y2038 tests. Everything is possible...

@Philippe: It would be very nice if you could have a look as well.
Thanks!

I triggered a CI run on all of our supported platforms. Looks good so far and
the testsuite does no longer fail in the compat case as well. The compat tests
were manually run. 64 bit kernel but 32 bit userland.


 kernel/cobalt/posix/monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/posix/monitor.c b/kernel/cobalt/posix/monitor.c
index 91396955c..c266b8b3b 100644
--- a/kernel/cobalt/posix/monitor.c
+++ b/kernel/cobalt/posix/monitor.c
@@ -425,6 +425,7 @@ COBALT_SYSCALL(monitor_destroy, primary,
 		goto fail;
 	}
 
+	xnsynch_release(&mon->gate, curr);
 	cobalt_monitor_reclaim(&mon->resnode, s); /* drops lock */
 
 	xnsched_run();
-- 
2.30.2


