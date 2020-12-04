From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH] copperplate/timerobj: fix start/start, start/stop races
Date: Fri,  4 Dec 2020 16:31:04 +0100
Message-Id: <20201204153104.2522806-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

Concurrent timer start vs start, or start vs stop operations may end
up confusing the logic, like:

- a periodic timer being reinserted into the dispatch queue while
  disabled.

- dirty reads of inconsistent ( date, interval, handler ) triplets by
  the dispatch loop, as the timer properties are being updated
  concurrently.

Fix this by moving all updates to the timer properties under the
protection of the dispatch lock (svlock), likewise for loads.

Issue reported by Ronny Meeus, with a preliminary fix:
https://xenomai.org/pipermail/xenomai/2020-December/043907.html

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 lib/copperplate/timerobj.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/lib/copperplate/timerobj.c b/lib/copperplate/timerobj.c
index cbfcda566..08cc0d3b9 100644
--- a/lib/copperplate/timerobj.c
+++ b/lib/copperplate/timerobj.c
@@ -98,6 +98,7 @@ static int server_prologue(void *arg)
 
 static void *timerobj_server(void *arg)
 {
+	void (*handler)(struct timerobj *tmobj);
 	struct timespec now, value, interval;
 	struct timerobj *tmobj, *tmp;
 	sigset_t set;
@@ -120,17 +121,18 @@ static void *timerobj_server(void *arg)
 
 		pvlist_for_each_entry_safe(tmobj, tmp, &svtimers, next) {
 			value = tmobj->itspec.it_value;
+			interval = tmobj->itspec.it_interval;
+			handler = tmobj->handler;
 			if (timespec_after(&value, &now))
 				break;
 			pvlist_remove_init(&tmobj->next);
-			interval = tmobj->itspec.it_interval;
 			if (interval.tv_sec > 0 || interval.tv_nsec > 0) {
 				timespec_add(&tmobj->itspec.it_value,
 					     &value, &interval);
 				timerobj_enqueue(tmobj);
 			}
 			write_unlock(&svlock);
-			tmobj->handler(tmobj);
+			handler(tmobj);
 			write_lock_nocancel(&svlock);
 		}
 
@@ -218,8 +220,7 @@ int timerobj_start(struct timerobj *tmobj,
 		   void (*handler)(struct timerobj *tmobj),
 		   struct itimerspec *it) /* lock held, dropped */
 {
-	tmobj->handler = handler;
-	tmobj->itspec = *it;
+	int ret = 0;
 
 	/*
 	 * We hold the queue lock long enough to prevent the timer
@@ -232,14 +233,23 @@ int timerobj_start(struct timerobj *tmobj,
 	 */
 	write_lock_nocancel(&svlock);
 
-	if (__RT(timer_settime(tmobj->timer, TIMER_ABSTIME, it, NULL)))
-		return __bt(-errno);
+       if (pvholder_linked(&tmobj->next))
+               pvlist_remove_init(&tmobj->next);
+
+	tmobj->handler = handler;
+	tmobj->itspec = *it;
+
+	if (__RT(timer_settime(tmobj->timer, TIMER_ABSTIME, it, NULL))) {
+		ret = __bt(-errno);
+		goto fail;
+	}
 
 	timerobj_enqueue(tmobj);
+fail:
 	write_unlock(&svlock);
 	timerobj_unlock(tmobj);
 
-	return 0;
+	return ret;
 }
 
 int timerobj_stop(struct timerobj *tmobj) /* lock held, dropped */
@@ -251,10 +261,9 @@ int timerobj_stop(struct timerobj *tmobj) /* lock held, dropped */
 	if (pvholder_linked(&tmobj->next))
 		pvlist_remove_init(&tmobj->next);
 
-	write_unlock(&svlock);
-
 	__RT(timer_settime(tmobj->timer, 0, &itimer_stop, NULL));
 	tmobj->handler = NULL;
+	write_unlock(&svlock);
 	timerobj_unlock(tmobj);
 
 	return 0;
-- 
2.26.2


