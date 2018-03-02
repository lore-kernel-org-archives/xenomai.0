From: Henning Schild <henning.schild@siemens.com>
Date: Fri,  2 Mar 2018 14:22:05 +0100
Message-Id: <20180302132205.28807-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [PATCH] cobalt/kernel: fix clock_adjtime() compile error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai @ xenomai . org" <xenomai@xenomai.org>

Moving the definition out of the ifdef solves the following error:

include/xenomai/cobalt/kernel/clock.h:260:16: error:
 ‘struct <anonymous>’ has no member named ‘adjust_time’
include/xenomai/cobalt/kernel/clock.h:263:19: error:
 ‘struct <anonymous>’ has no member named ‘adjust_time’

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 include/cobalt/kernel/clock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
index bf03c5921..bbdec9357 100644
--- a/include/cobalt/kernel/clock.h
+++ b/include/cobalt/kernel/clock.h
@@ -53,8 +53,6 @@ struct xnclock {
 		xnticks_t (*read_monotonic)(struct xnclock *clock);
 		int (*set_time)(struct xnclock *clock,
 				const struct timespec *ts);
-		int (*adjust_time)(struct xnclock *clock,
-				   struct timex *tx);
 		xnsticks_t (*ns_to_ticks)(struct xnclock *clock,
 					  xnsticks_t ns);
 		xnsticks_t (*ticks_to_ns)(struct xnclock *clock,
@@ -66,6 +64,8 @@ struct xnclock {
 		void (*program_remote_shot)(struct xnclock *clock,
 					    struct xnsched *sched);
 #endif
+		int (*adjust_time)(struct xnclock *clock,
+				   struct timex *tx);
 		int (*set_gravity)(struct xnclock *clock,
 				   const struct xnclock_gravity *p);
 		void (*reset_gravity)(struct xnclock *clock);
-- 
2.16.1


