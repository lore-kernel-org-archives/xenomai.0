Message-ID: <47AB0152.20205@domain.hid>
Date: Thu, 07 Feb 2008 14:02:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040405000400000907090700"
Subject: [Adeos-main] [PATCH] Sort stack dumps on non-root faults
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

This is a multi-part message in MIME format.
--------------040405000400000907090700
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi Philippe,

while trying to understand Petr's problem (no clue yet), I came across
this: dump_stack was called unconditionally, ipipe_trace_panic_dump was
missing.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------040405000400000907090700
Content-Type: text/x-patch;
 name="sort-stack-dumping-on-nonroot-faults.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sort-stack-dumping-on-nonroot-faults.patch"

---
 arch/x86/kernel/ipipe.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Index: b/arch/x86/kernel/ipipe.c
===================================================================
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -770,19 +770,22 @@ int __ipipe_handle_exception(struct pt_r
 		ipipe_trace_panic_freeze();
 
 		/* Always warn about user land and unfixable faults. */
-		if ((error_code & 4) || !search_exception_tables(instruction_pointer(regs)))
+		if ((error_code & 4) || !search_exception_tables(instruction_pointer(regs))) {
 			printk(KERN_ERR "BUG: Unhandled exception over domain"
 			       " %s at 0x%lx - switching to ROOT\n",
 			       ipd->name, instruction_pointer(regs));
+			dump_stack();
+			ipipe_trace_panic_dump();
 #ifdef CONFIG_IPIPE_DEBUG
 		/* Also report fixable ones when debugging is enabled. */
-		else
+		} else {
 			printk(KERN_WARNING "WARNING: Fixable exception over "
 			       "domain %s at 0x%lx - switching to ROOT\n",
 			       ipd->name, instruction_pointer(regs));
+			dump_stack();
+			ipipe_trace_panic_dump();
 #endif /* CONFIG_IPIPE_DEBUG */
-
-		dump_stack();
+		}
 	}
 
 	__ipipe_std_extable[vector](regs, error_code);

--------------040405000400000907090700--

