Date: Sun, 11 Oct 2015 15:05:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151011130536.GA1765@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Issue with CONFIG_PREEMPT_VOLUNTARY
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

It seems commit fdb5d54d04b8c3b6b6a6ad7ac2b6248cf0b415e0 in the
I-pipe kernels cause a warning when CONFIG_PREEMPT_VOLUNTARY and
CONFIG_IPIPE_DEBUG_INTERNAL are enabled. The culprit is the call to
__ipipe_root_p.

The following patch avoids this warning:

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 0320453..a5e440d 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1730,17 +1730,19 @@ int notrace __ipipe_check_percpu_access(void)
 	if (raw_irqs_disabled_flags(flags))
 		goto out;
 
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		goto out;
+
 	/*
 	 * Last chance: hw interrupts were enabled on entry while
 	 * running over the root domain, but the root stage might be
 	 * currently stalled, in which case preemption would be
 	 * disabled, and no migration could occur.
 	 */
-	if (this_domain == ipipe_root_domain) {
-		p = raw_cpu_ptr(&ipipe_percpu.root);
-		if (test_bit(IPIPE_STALL_FLAG, &p->status) || preempt_count())
+
+	p = raw_cpu_ptr(&ipipe_percpu.root);
+	if (test_bit(IPIPE_STALL_FLAG, &p->status) || preempt_count())
 			goto out;
-	}
 	/*
 	 * Our caller may end up accessing the wrong per-cpu variable
 	 * instance due to CPU migration; tell it to complain about


-- 
					    Gilles.
https://click-hack.org

