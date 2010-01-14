Message-ID: <4B4F55E5.1040902@domain.hid>
Date: Thu, 14 Jan 2010 18:35:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [pull request] Fix lockdep breakage under ipipe
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

The following changes since commit 5a171916b8d8009d8611b175236bb5287a0dc8e2:
  Philippe Gerum (1):
        Merge branch 'ipipe-2.6.32-noarch' into ipipe-2.6.32-x86

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6 queues/2.6.32-x86

Jan Kiszka (1):
      x86: Do not trace Linux IRQ state in save_args

 arch/x86/kernel/entry_64.S |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

---

x86: Do not trace Linux IRQ state in save_args

If save_args is used in I-pipe mode, we must not trace Linux IRQs here,
otherwise we virtually leak the mask and lockdep gets confused.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/entry_64.S |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 9985954..ce29b45 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -344,7 +344,10 @@ ENTRY(save_args)
 	/*
 	 * We entered an interrupt context - irqs are off:
 	 */
-2:	TRACE_IRQS_OFF
+2:
+#ifndef CONFIG_IPIPE
+	TRACE_IRQS_OFF
+#endif
 	ret
 	CFI_ENDPROC
 END(save_args)
-- 
1.6.0.2

