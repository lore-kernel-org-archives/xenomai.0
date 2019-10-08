From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] arm64/ipipe: Add support for userspace return notifier
Message-ID: <e8d943ee-1103-07ec-bede-c36b4a06c745@siemens.com>
Date: Tue, 8 Oct 2019 18:55:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This adds the arm64-specific bits to implement the userspace return
notifier.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/kernel/entry.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 805d89c0711d..8ebd72125afb 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -954,8 +954,23 @@ finish_ret_to_user:
 	enable_step_tsk x1, x2
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase
+#endif
+#ifdef CONFIG_IPIPE
+	ldr	x0, [tsk, #TSK_TI_IPIPE]
+	tst	x0, #_TIP_USERINTRET
+	b.ne	call_user_intret_notifier
+exit_head:
 #endif
 	kernel_exit 0
+#ifdef CONFIG_IPIPE
+call_user_intret_notifier:
+	enable_daif
+	bl     	__ipipe_notify_user_intreturn
+	disable_daif
+	cmp    	x0, #0
+	b.ne    exit_head
+	b	ret_to_user_noirq
+#endif
 ENDPROC(ret_to_user)
 
 /*
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

