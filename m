Message-ID: <4B223227.4020208@domain.hid>
Date: Fri, 11 Dec 2009 12:51:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [pull request] Avoid double bug reports
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

The following changes since commit 88fd7426f3565647b4f5ef93d8e612e059dae873:
  Philippe Gerum (1):
        Make generic atomic ops Adeos-aware

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6.git queues/2.6.31-noarch

Jan Kiszka (2):
      noarch: Don't check for internal errors during oops
      noarch: Set oops_in_progress on failing context check

 kernel/ipipe/core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

-------

noarch: Don't check for internal errors during oops

We are busted already, verifying the context here only generates
confusing output or causes even more corruptions.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 kernel/ipipe/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index ffaceaa..c9bc5b4 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -312,7 +312,7 @@ void __ipipe_unstall_root(void)
 
 #ifdef CONFIG_IPIPE_DEBUG_INTERNAL
 	/* This helps catching bad usage from assembly call sites. */
-	BUG_ON(!__ipipe_root_domain_p);
+	BUG_ON(!__ipipe_root_domain_p && !oops_in_progress);
 #endif
 
 	p = ipipe_root_cpudom_ptr();
@@ -328,7 +328,7 @@ void __ipipe_unstall_root(void)
 void __ipipe_restore_root(unsigned long x)
 {
 #ifdef CONFIG_IPIPE_DEBUG_INTERNAL
-	BUG_ON(!ipipe_root_domain_p);
+	BUG_ON(!ipipe_root_domain_p && !oops_in_progress);
 #endif
 
 	if (x)
-- 
1.6.0.2

------

noarch: Set oops_in_progress on failing context check

This helps to avoid raising multiple bugs that may even precede the
actually issue in the output.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 kernel/ipipe/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index c9bc5b4..aa2e5a0 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1676,7 +1676,7 @@ void ipipe_check_context(struct ipipe_domain *border_domain)
 
 	ipipe_context_check_off();
 	ipipe_trace_panic_freeze();
-	ipipe_set_printk_sync(__ipipe_current_domain);
+	oops_in_progress = 1;
 
 	if (this_domain->priority > border_domain->priority)
 		printk(KERN_ERR "I-pipe: Detected illicit call from domain "
-- 
1.6.0.2

