Message-ID: <4B2673F2.4010609@domain.hid>
Date: Mon, 14 Dec 2009 18:20:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [pull request] noarch: fix ftrace code patching
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

The following changes since commit 779cfc6a68bcc9c4acb1eec3922c25eb43b08a2f:
  Jan Kiszka (1):
        Set oops_in_progress on failing context check

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6 queues/2.6.31-noarch

Jan Kiszka (1):
      Disable both real and virtual interrupts during ftrace code changes

 kernel/trace/ftrace.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

------

Disable both real and virtual interrupts during ftrace code changes

This is required as the call stack contains some further local_irq_save/
restore which would otherwise reenable real interrupts spuriously.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 kernel/trace/ftrace.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5c007b6..9ca1e65 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2802,9 +2802,11 @@ static int ftrace_convert_nops(struct module *mod,
 	}
 
 	/* disable interrupts to prevent kstop machine */
-	local_irq_save_hw_notrace(flags);
+	local_irq_save(flags);
+	local_irq_disable_hw();
 	ftrace_update_code(mod);
-	local_irq_restore_hw_notrace(flags);
+	local_irq_enable_hw();
+	local_irq_restore(flags);
 	mutex_unlock(&ftrace_lock);
 
 	return 0;
@@ -2887,9 +2889,11 @@ void __init ftrace_init(void)
 	/* Keep the ftrace pointer to the stub */
 	addr = (unsigned long)ftrace_stub;
 
-	local_irq_save_hw_notrace(flags);
+	local_irq_save(flags);
+	local_irq_disable_hw();
 	ftrace_dyn_arch_init(&addr);
-	local_irq_restore_hw_notrace(flags);
+	local_irq_enable_hw();
+	local_irq_restore(flags);
 
 	/* ftrace_dyn_arch_init places the return code in addr */
 	if (addr)
-- 
1.6.0.2

