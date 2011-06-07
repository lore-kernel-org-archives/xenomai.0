From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue,  7 Jun 2011 16:17:53 +0200
Message-Id: <cc58f0f43a3e9c99f551bcf718a93426ec8f1db7.1307456218.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
Subject: [Adeos-main] [PATCH 3/5] ipipe: x86: Fix flags corruption in
	arch_mangle_irq_bits on 64-bit systems
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Due to unwanted sign extension, we set all high bits in the mangled
flags on x86-64. Harmless on current CPUs, but that may change one day.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/include/asm/irqflags.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 6e316c0..fe9c928 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -143,7 +143,7 @@ static inline void halt(void)
 /* Merge virtual+real interrupt mask bits into a single word. */
 static inline unsigned long arch_mangle_irq_bits(int virt, unsigned long real)
 {
-	return (real & ~(1L << 31)) | ((virt != 0) << 31);
+	return (real & ~(1L << 31)) | ((unsigned long)(virt != 0) << 31);
 }
 
 /* Converse operation of arch_mangle_irq_bits() */
-- 
1.7.1


