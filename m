From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 6/8] cobalt/thread: send backtracing request only when XNWARN
 is set
Date: Sat,  1 Jun 2019 17:15:00 +0200
Message-Id: <20190601151502.27216-7-rpm@xenomai.org>
In-Reply-To: <20190601151502.27216-1-rpm@xenomai.org>
References: <20190601151502.27216-1-rpm@xenomai.org>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

If the relaxing thread did not ask for being warned upon such event,
there is no point in asking for a backtrace.

See https://www.xenomai.org/pipermail/xenomai/2019-May/040925.html

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/thread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index fa7a65569..6caf9ef37 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2131,11 +2131,11 @@ void xnthread_relax(int notify, int reason)
 	 * information.
 	 */
 	xnthread_propagate_schedparam(thread);
-	
+
 	if (xnthread_test_state(thread, XNUSER) && notify) {
-		xndebug_notify_relax(thread, reason);
 		if (xnthread_test_state(thread, XNWARN)) {
 			/* Help debugging spurious relaxes. */
+			xndebug_notify_relax(thread, reason);
 			memset(&si, 0, sizeof(si));
 			si.si_signo = SIGDEBUG;
 			si.si_code = SI_QUEUE;
-- 
2.20.1


