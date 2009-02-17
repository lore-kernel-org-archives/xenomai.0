Message-ID: <499AC7E5.2070900@domain.hid>
Date: Tue, 17 Feb 2009 15:21:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] ipipe-x86-2.6.27: Fix __ipipe_move_root_irq
	build
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

irq_to_desc is 2.6.28+ stuff.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

Index: linux-2.6.27-xeno_64/include/asm-x86/ipipe.h
===================================================================
--- linux-2.6.27-xeno_64.orig/include/asm-x86/ipipe.h
+++ linux-2.6.27-xeno_64/include/asm-x86/ipipe.h
@@ -122,7 +122,7 @@ int __ipipe_check_tickdev(const char *de
 #define __ipipe_move_root_irq(irq)					\
 	do {								\
 		if (irq < NR_IRQS) {					\
-			struct irq_chip *chip = irq_to_desc(irq)->chip;	\
+			struct irq_chip *chip = irq_desc[irq].chip;	\
 			if (chip->move)					\
 				chip->move(irq);			\
 		}							\

