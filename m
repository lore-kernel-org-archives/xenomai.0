Message-ID: <4B607553.7010706@domain.hid>
Date: Wed, 27 Jan 2010 18:18:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] x86: Update FIRST_SYSTEM_VECTOR
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

Adjust FIRST_SYSTEM_VECTOR so that it includes all the recently invented
system vectors.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

If someone has a good idea how to let this hunk explode in the future
after the list was once again extended, I'm all ears.

 arch/x86/include/asm/irq_vectors.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index f983bc6..6178f92 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -103,8 +103,6 @@
 #define NUM_INVALIDATE_TLB_VECTORS	   8
 #endif
 
-#define FIRST_SYSTEM_VECTOR		0xef
-
 /*
  * Local APIC timer IRQ vector is on a different priority level,
  * to work around the 'lost local interrupt if more than 2 IRQ
@@ -129,6 +127,9 @@
  */
 #define MCE_SELF_VECTOR			0xeb
 
+/* I-pipe: Lowest number of vectors above */
+#define FIRST_SYSTEM_VECTOR		0xea
+
 /*
  * First APIC vector available to drivers: (vectors 0x30-0xee) we
  * start at 0x31(0x41) to spread out vectors evenly between priority
-- 
1.6.0.2

