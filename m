Message-ID: <4C6BF202.4@domain.hid>
Date: Wed, 18 Aug 2010 16:45:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [RFC][PATCH] x86: Work around deadlock between
 ipipe_critical_enter and rwlocks
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

When preempting the read side of a Linux rwlock with a critical IPI
while the write side was already spinning and Linux is the top-most
domain, ipipe_critical_enter will trigger a deadlock.

Work around this issue by detecting long stalls while waiting for all
CPUs, terminate the request in this case, and restart it. In that case
we have to make sure that a potential sync function is not executed
multiple time, so we have to synchronize the restart on all CPUs passing
through the IPI handler, though now in arbitrary order.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

This patch is still under test, and as it usually took at least several
hundred reboot cycles to trigger the issue, this test may take some more
days. Still I would like to collect first feedback on the proposal. I'm
not fully happy with having to define an arbitrary loop count as restart
condition. Let's hope this behaves properly when the number of CPU
increases.

I haven't checked all other arches, but at least powerpc requires a
similar fix - maybe by pushing the generic bits into generic ipipe code.

 arch/x86/kernel/ipipe.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 76283c3..cc2ca03 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -55,10 +55,14 @@ DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
 
 #ifdef CONFIG_SMP
 
+#define IPIPE_CRITICAL_TIMEOUT	1000000
+
 static cpumask_t __ipipe_cpu_sync_map;
 
 static cpumask_t __ipipe_cpu_lock_map;
 
+static cpumask_t __ipipe_cpu_pass_map;
+
 static unsigned long __ipipe_critical_lock;
 
 static IPIPE_DEFINE_SPINLOCK(__ipipe_cpu_barrier);
@@ -406,6 +410,8 @@ void __ipipe_do_critical_sync(unsigned irq, void *cookie)
 		/* Call the sync routine if any. */
 		__ipipe_cpu_sync();
 
+	cpu_set(cpu, __ipipe_cpu_pass_map);
+
 	spin_unlock(&__ipipe_cpu_barrier);
 
 	cpu_clear(cpu, __ipipe_cpu_sync_map);
@@ -441,6 +447,7 @@ unsigned long ipipe_critical_enter(void (*syncfn) (void))
 
 	{
 		int cpu = ipipe_processor_id();
+		unsigned long loops;
 		cpumask_t lock_map;
 
 		if (!cpu_test_and_set(cpu, __ipipe_cpu_lock_map)) {
@@ -451,17 +458,46 @@ unsigned long ipipe_critical_enter(void (*syncfn) (void))
 				} while (++n < cpu);
 			}
 
+restart:
 			spin_lock(&__ipipe_cpu_barrier);
 
 			__ipipe_cpu_sync = syncfn;
 
+			cpus_clear(__ipipe_cpu_pass_map);
+			cpu_set(cpu, __ipipe_cpu_pass_map);
+
 			/* Send the sync IPI to all processors but the current one. */
 			apic->send_IPI_allbutself(IPIPE_CRITICAL_VECTOR);
 
 			cpus_andnot(lock_map, cpu_online_map, __ipipe_cpu_lock_map);
 
-			while (!cpus_equal(__ipipe_cpu_sync_map, lock_map))
+			loops = IPIPE_CRITICAL_TIMEOUT;
+
+			while (!cpus_equal(__ipipe_cpu_sync_map, lock_map)) {
 				cpu_relax();
+
+				if (--loops == 0) {
+					/*
+					 * We ran into a deadlock due to a
+					 * contended rwlock. Cancel this round
+					 * and retry after some cycles.
+					 */
+					__ipipe_cpu_sync = NULL;
+
+					spin_unlock(&__ipipe_cpu_barrier);
+
+					/*
+					 * Ensure all CPUs consumed the IPI to
+					 * avoid running __ipipe_cpu_sync
+					 * prematurely.
+					 */
+					while (!cpus_equal(cpu_online_map,
+							   __ipipe_cpu_pass_map))
+						cpu_relax();
+
+					goto restart;
+				}
+			}
 		}
 
 		atomic_inc(&__ipipe_critical_count);
-- 
1.7.1

