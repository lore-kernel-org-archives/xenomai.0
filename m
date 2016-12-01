From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c8c57cac-bec8-069d-5522-a4895f9183fe@siemens.com>
Date: Thu, 1 Dec 2016 17:15:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] x86/ipipe: Skip lockdep check for vector_lock
	under I-pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The lock becomes an __ipipe_spinlock_t in that case, and that's out of
scope for lockdep.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/kernel/apic/vector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 17a4a98..244801f 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -485,7 +485,9 @@ void setup_vector_irq(int cpu)
 {
 	int irq;
 
+#ifndef CONFIG_IPIPE
 	lockdep_assert_held(&vector_lock);
+#endif
 	/*
 	 * On most of the platforms, legacy PIC delivers the interrupts on the
 	 * boot cpu. But there are certain platforms where PIC interrupts are
-- 
2.1.4

