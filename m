Message-ID: <49477854.3030302@domain.hid>
Date: Tue, 16 Dec 2008 10:43:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] x86-2.6.27: Cleanup redundant mtrr hunk
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

Likely a merge artifact: IRQs are already reenabled a few lines above
this hunk.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

---
 arch/x86/kernel/cpu/mtrr/generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/arch/x86/kernel/cpu/mtrr/generic.c
===================================================================
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -575,7 +575,7 @@ static void generic_set_all(void)
 			set_bit(count, &smp_changes_mask);
 		mask >>= 1;
 	}
-	local_irq_restore_hw(flags);
+	
 }
 
 static void generic_set_mtrr(unsigned int reg, unsigned long base,

