Message-ID: <50F6FCDB.1020109@siemens.com>
Date: Wed, 16 Jan 2013 20:17:47 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] ipipe: Re-fix migration helper for legacy users
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

In the legacy use case, __ipipe_switch_tail will be invoked over the
non-root domain after hardening. So clearing of TASK_HARDENING must not
be restricted to root.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

For the case my analysis was right. With this, Xenomai 2.6 works again
here.

 kernel/ipipe/core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 6929156..4695ba8 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1124,7 +1124,9 @@ int __ipipe_switch_tail(void)
 	hard_local_irq_disable();
 #endif
 	x = __ipipe_root_p;
+#ifndef CONFIG_IPIPE_LEGACY
 	if (x)
+#endif
 		complete_domain_migration();
 
 #ifndef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
-- 
1.7.3.4

