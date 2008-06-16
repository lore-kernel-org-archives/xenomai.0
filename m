Message-ID: <485695AE.7030509@domain.hid>
Date: Mon, 16 Jun 2008 18:32:46 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48568E78.5000606@domain.hid>
In-Reply-To: <48568E78.5000606@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] latency fix for 2.6.25?
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Pierangelo Masarati <masarati@domain.hid>
Cc: adeos-main@gna.org

Pierangelo Masarati wrote:
> Dear ADEOS users,
> 
> 2.6.25 seems to show abnormal latencies on hardware that showed good
> performances up to 2.6.24.  We think we traced down the issue to x86's
> process_xx.c, which disappeared after regressing default_idle() to
> 2.6.24.  The related changes are described in the attached patch.
> 

This patch would badly break the runqueue statistics, and likely the Linux
scheduler tick engine too.

Actually, the hunk in default_idle() seems useless, since co-kernel activity
should be accounted as Linux idle time anyway. Does this patch also fixes
the issue you tracked down?

diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 8d71912..d97c8c2 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -111,7 +111,7 @@ void default_idle(void)
 		 */
 		smp_mb();

-		local_irq_disable_hw();
+		local_irq_disable();
 		if (!need_resched()) {
 			ktime_t t0, t1;
 			u64 t0n, t1n;
@@ -123,9 +123,8 @@ void default_idle(void)
 			t1 = ktime_get();
 			t1n = ktime_to_ns(t1);
 			sched_clock_idle_wakeup_event(t1n - t0n);
-			local_irq_enable(); /* This will force enable_hw as well. */
-		} else
-			local_irq_enable_hw();
+		}
+		local_irq_enable();
 		current_thread_info()->status |= TS_POLLING;
 	} else {
 		/* loop is done by the caller */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index fa242a4..a3b2fa7 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -107,7 +107,7 @@ void default_idle(void)
 	 * test NEED_RESCHED:
 	 */
 	smp_mb();
-	local_irq_disable_hw();
+	local_irq_disable();
 	if (!need_resched()) {
 		ktime_t t0, t1;
 		u64 t0n, t1n;
@@ -119,9 +119,8 @@ void default_idle(void)
 		t1 = ktime_get();
 		t1n = ktime_to_ns(t1);
 		sched_clock_idle_wakeup_event(t1n - t0n);
-		local_irq_enable(); /* This will force enable_hw as well. */
-	} else
-		local_irq_enable_hw();
+	}
+	local_irq_enable();
 	current_thread_info()->status |= TS_POLLING;
 }

-- 
Philippe.


