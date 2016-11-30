Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <8612d9e224a0f91950a3.1480491048@devws148.be.alcatel-lucent.com>
Date: Wed, 30 Nov 2016 08:30:48 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH] copperplate/mercury: introduce weak function to
 get OS max thread priority
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This patch introduces a weak function in the mercury copperplate code
that allows to put an upper limit on the priority used by the created thread
objects.

Before this patch the complete OS scheduler's FIFO range was used and it was
not possible to restrict it. Restricting it can be useful in case other
activities (typically platform related things) need to get a higher priority
than the application threads.

The example below shows what needs to be implemented in the application to
restrict the range.

#include <copperplate/threadobj.h>
int threadobj_sched_get_priority_max()
{
    return 92;
}

NOTE: if the value returned by the function is not in the range supported by
the OS, the OS value will be used anyhow.

diff --git a/include/copperplate/threadobj.h b/include/copperplate/threadobj.h
--- a/include/copperplate/threadobj.h
+++ b/include/copperplate/threadobj.h
@@ -136,6 +136,8 @@ void threadobj_save_timeout(struct threa
 		corespec->timeout = *timeout;
 }
 
+int threadobj_sched_get_priority_max(void);
+
 #endif /* CONFIG_XENO_MERCURY */
 
 /*
diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -539,9 +539,16 @@ static void nop_sighandler(int sig)
 	/* nop */
 }
 
+__weak int threadobj_sched_get_priority_max(void)
+{
+	return sched_get_priority_max(SCHED_FIFO);
+}
+
 static inline void pkg_init_corespec(void)
 {
 	struct sigaction sa;
+	int max_prio;
+	int max_sched_prio;
 
 	/*
 	 * We don't have builtin scheduler-lock feature over Mercury,
@@ -555,7 +562,10 @@ static inline void pkg_init_corespec(voi
 	 * holding the scheduler lock, unless the latter has to block
 	 * for some reason, defeating the purpose of such lock anyway.
 	 */
-	threadobj_irq_prio = sched_get_priority_max(SCHED_FIFO);
+	max_prio = threadobj_sched_get_priority_max();
+	max_sched_prio = sched_get_priority_max(SCHED_FIFO);
+
+	threadobj_irq_prio = ((max_prio > max_sched_prio)? max_sched_prio:max_prio);
 	threadobj_lock_prio = threadobj_irq_prio - 1;
 	threadobj_high_prio = threadobj_irq_prio - 2;
 	threadobj_agent_prio = threadobj_high_prio;

