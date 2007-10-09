Message-ID: <470BB2DE.7030800@domain.hid>
Date: Tue, 09 Oct 2007 18:57:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030500070908070001040105"
Subject: [Adeos-main] [RFC][PATCH] i386: report unhandled non-root faults
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>

This is a multi-part message in MIME format.
--------------030500070908070001040105
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This patch was part of my endeavour to understand the vmalloc-pinning
issue. It catches the theoretically impossible case that there is a bug
inside the I-pipe core. That bug may cause a fault over a non-root
domain AND that domain may not show any interest in the fault. Linux is
called then, and things fall apart.

As the patch adds code to the fault handler's hot-patch, I decided to
make the check depend on CONFIG_IPIPE_DEBUG. It's i386 only, but porting
it to other archs should be straightforward.

My feeling is that this safety belt can be useful again for bugs we will
surely invent in the future. :)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------030500070908070001040105
Content-Type: text/x-patch;
 name="catch-non-root-faults.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="catch-non-root-faults.patch"

---
 arch/i386/kernel/ipipe.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

Index: linux-2.6.22.9/arch/i386/kernel/ipipe.c
===================================================================
--- linux-2.6.22.9.orig/arch/i386/kernel/ipipe.c
+++ linux-2.6.22.9/arch/i386/kernel/ipipe.c
@@ -642,8 +642,17 @@ fastcall int __ipipe_handle_exception(st
 #endif /* CONFIG_KGDB */
 
 	if (!ipipe_trap_notify(vector, regs)) {
-		__ipipe_exptr handler = __ipipe_std_extable[vector];
-		handler(regs,error_code);
+#ifdef CONFIG_IPIPE_DEBUG
+		if (!ipipe_root_domain_p) {
+			/* Fix up domain so that Linux can handle this. */
+			ipipe_current_domain = ipipe_root_domain;
+			ipipe_trace_panic_freeze();
+			printk(KERN_ERR "BUG: Unhandled exception over domain"
+					" %s - switching to ROOT\n",
+					ipipe_current_domain->name);
+		}
+#endif /* CONFIG_IPIPE_DEBUG */
+		__ipipe_std_extable[vector](regs, error_code);
 		local_irq_restore(flags);
 		__fixup_if(regs);
 		return 0;


--------------030500070908070001040105--

