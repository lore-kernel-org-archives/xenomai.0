From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH] rtdm/testing: latmus: clean up patch
Date: Tue, 25 May 2021 02:12:13 -0400
Message-Id: <20210525061213.24193-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org, xenomai@xenomai.org

1. remove unnecessary include file
2. remove wrapper for rtdm_timer_init_on_cpu and directly call it

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/kernel/drivers/testing/latmus.c b/kernel/drivers/testing/latmus.c
index bef662260..36f829c0d 100644
--- a/kernel/drivers/testing/latmus.c
+++ b/kernel/drivers/testing/latmus.c
@@ -15,7 +15,6 @@
 #include <linux/fs.h>
 #include <linux/fcntl.h>
 #include <cobalt/kernel/pipe.h>
-#include <cobalt/kernel/sched.h>
 #include <rtdm/ipc.h>
 #include <rtdm/testing.h>
 #include <rtdm/driver.h>
@@ -33,10 +32,6 @@
 			       (__runner)->name, ##__args);		\
 	} while (0)
 
-#define cobalt_init_xntimer_on_cpu(__timer, __cpu, __handler)		\
-		rtdm_timer_init_on_cpu(__timer, __handler,		\
-			#__handler, __cpu)
-
 struct latmus_message {
 	struct xnpipe_mh mh;
 	char data[];
@@ -342,7 +337,8 @@ static struct latmus_runner *create_irq_runner(int cpu)
 	};
 
 	init_runner_base(&irq_runner->runner);
-	cobalt_init_xntimer_on_cpu(&irq_runner->timer, cpu, latmus_irq_handler);
+	rtdm_timer_init_on_cpu(&irq_runner->timer, latmus_irq_handler,
+			"latmus_irq_handler", cpu);
 
 	return &irq_runner->runner;
 }
@@ -440,8 +436,8 @@ static struct latmus_runner *create_sirq_runner(int cpu)
 	sirq_runner->sirq = sirq;
 	sirq_runner->sirq_percpu = sirq_percpu;
 	init_runner_base(&sirq_runner->runner);
-	cobalt_init_xntimer_on_cpu(&sirq_runner->timer, cpu,
-			latmus_sirq_timer_handler);
+	rtdm_timer_init_on_cpu(&sirq_runner->timer, latmus_sirq_timer_handler,
+			"latmus_sirq_timer_handler", cpu);
 
 	for_each_possible_cpu(_cpu)
 		*per_cpu_ptr(sirq_percpu, _cpu) = sirq_runner;
@@ -676,7 +672,8 @@ static struct latmus_runner *create_uthread_runner(int cpu)
 	};
 
 	init_runner_base(&u_runner->runner);
-	cobalt_init_xntimer_on_cpu(&u_runner->timer, cpu, latmus_pulse_handler);
+	rtdm_timer_init_on_cpu(&u_runner->timer, latmus_pulse_handler,
+			"latmus_pulse_handler", cpu);
 	xntimer_set_gravity(&u_runner->timer, XNTIMER_UGRAVITY);
 	rtdm_event_init(&u_runner->pulse, 0);
 
-- 
2.17.1


