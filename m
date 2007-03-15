From: Stelian Pop <stelian@domain.hid>
Content-Type: text/plain
Date: Thu, 15 Mar 2007 14:45:54 +0100
Message-Id: <1173966354.16299.41.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH - ARM] Fix tracer induced compile error for
	ARMv6 processors
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

Since the addition of the tracer, the following modification is required
to build Adeos on ARMv6 processors:

diff --git a/include/asm-arm/irqflags.h b/include/asm-arm/irqflags.h
index a433866..77700a1 100644
--- a/include/asm-arm/irqflags.h
+++ b/include/asm-arm/irqflags.h
@@ -18,10 +18,10 @@
 	: "=r" (x) : : "memory", "cc");				\
 	})
 
-#define local_irq_enable_hw()  __asm__("cpsie i	@ __sti" : : : "memory", "cc")
-#define local_irq_disable_hw() __asm__("cpsid i	@ __cli" : : : "memory", "cc")
-#define local_fiq_enable_hw()  __asm__("cpsie f	@ __stf" : : : "memory", "cc")
-#define local_fiq_disable_hw() __asm__("cpsid f	@ __clf" : : : "memory", "cc")
+#define local_irq_enable_hw_notrace()  __asm__("cpsie i	@ __sti" : : : "memory", "cc")
+#define local_irq_disable_hw_notrace() __asm__("cpsid i	@ __cli" : : : "memory", "cc")
+#define local_fiq_enable_hw_notrace()  __asm__("cpsie f	@ __stf" : : : "memory", "cc")
+#define local_fiq_disable_hw_notrace() __asm__("cpsid f	@ __clf" : : : "memory", "cc")
 
 #else
 

Thanks.

Stelian.
-- 
Stelian Pop <stelian@domain.hid>


