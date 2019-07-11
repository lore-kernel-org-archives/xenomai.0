From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 6/6] ipipe: Let ipipe_set_irq_affinity return an error
Date: Thu, 11 Jul 2019 21:56:17 +0200
Message-Id: <205e6005ddf4f345d76041ca5c8b061db46dda50.1562874977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
References: <cover.1562874977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
References: <cover.1562874977.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

x86 may generate one, so change the signature.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/ipipe.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index f7c07a207093..45e8c87bff93 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -433,12 +433,12 @@ void ipipe_prepare_panic(void);
 #ifndef ipipe_smp_p
 #define ipipe_smp_p (1)
 #endif
-void ipipe_set_irq_affinity(unsigned int irq, cpumask_t cpumask);
+int ipipe_set_irq_affinity(unsigned int irq, cpumask_t cpumask);
 void ipipe_send_ipi(unsigned int ipi, cpumask_t cpumask);
 #else  /* !CONFIG_SMP */
 #define ipipe_smp_p (0)
 static inline
-void ipipe_set_irq_affinity(unsigned int irq, cpumask_t cpumask) { }
+int ipipe_set_irq_affinity(unsigned int irq, cpumask_t cpumask) { return 0; }
 static inline void ipipe_send_ipi(unsigned int ipi, cpumask_t cpumask) { }
 static inline void ipipe_disable_smp(void) { }
 #endif	/* CONFIG_SMP */
-- 
2.16.4


