From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/4] cobalt/clock: drop xnclock_get_host_time()
Date: Sat,  5 Dec 2020 13:00:14 +0100
Message-Id: <20201205120014.2754097-5-rpm@xenomai.org>
In-Reply-To: <20201205120014.2754097-1-rpm@xenomai.org>
References: <20201205120014.2754097-1-rpm@xenomai.org>
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

No point in abstracting xnclock_get_host_time() and actually
counter-intuitive since it refers to the host-managed wallclock time,
not to any Xenomai-controlled clock device. Fix the single in-tree
user and drop this call.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/clock.h | 2 --
 kernel/cobalt/clock.c         | 6 ------
 kernel/cobalt/timer.c         | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
index c26776a0b..94dfd2f99 100644
--- a/include/cobalt/kernel/clock.h
+++ b/include/cobalt/kernel/clock.h
@@ -330,8 +330,6 @@ static inline xnticks_t xnclock_read_realtime(struct xnclock *clock)
 unsigned long long xnclock_divrem_billion(unsigned long long value,
 					  unsigned long *rem);
 
-xnticks_t xnclock_get_host_time(void);
-
 #ifdef CONFIG_XENO_OPT_VFILE
 
 void xnclock_init_proc(void);
diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index f8291b006..2a5b61760 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -348,12 +348,6 @@ void xnclock_adjust(struct xnclock *clock, xnsticks_t delta)
 }
 EXPORT_SYMBOL_GPL(xnclock_adjust);
 
-xnticks_t xnclock_get_host_time(void)
-{
-	return ktime_to_ns(ktime_get_real());
-}
-EXPORT_SYMBOL_GPL(xnclock_get_host_time);
-
 xnticks_t xnclock_core_read_monotonic(void)
 {
 	return xnclock_core_ticks_to_ns(xnclock_core_read_raw());
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index b8b60c4e5..ccd3c3b70 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -853,7 +853,7 @@ int xntimer_grab_hardware(void)
 #endif /* CONFIG_XENO_OPT_STATS_IRQS */
 
 	nkclock.wallclock_offset =
-		xnclock_get_host_time() - xnclock_read_monotonic(&nkclock);
+		ktime_to_ns(ktime_get_real()) - xnclock_read_monotonic(&nkclock);
 
 	ret = xntimer_setup_ipi();
 	if (ret)
-- 
2.26.2


