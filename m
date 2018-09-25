From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:47 +0200
Message-Id: <20180925103809.4932-11-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 10/32] x86/mtrr: ipipe: protect against preemption
 from head stage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We don't want the co-kernel to get in the way while we are busy
updating the MTRRs. Hard disable preemption around the critical
sections.
---
 arch/x86/kernel/cpu/mtrr/cyrix.c   | 12 ++++++++++--
 arch/x86/kernel/cpu/mtrr/generic.c | 12 +++++++-----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
index 4296c702a3f7..209169840922 100644
--- a/arch/x86/kernel/cpu/mtrr/cyrix.c
+++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
@@ -19,7 +19,7 @@ cyrix_get_arr(unsigned int reg, unsigned long *base,
 
 	arr = CX86_ARR_BASE + (reg << 1) + reg;	/* avoid multiplication by 3 */
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* enable MAPEN */
@@ -29,7 +29,7 @@ cyrix_get_arr(unsigned int reg, unsigned long *base,
 	rcr = getCx86(CX86_RCR_BASE + reg);
 	setCx86(CX86_CCR3, ccr3);			/* disable MAPEN */
 
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 
 	shift = ((unsigned char *) base)[1] & 0x0f;
 	*base >>= PAGE_SHIFT;
@@ -179,6 +179,7 @@ static void cyrix_set_arr(unsigned int reg, unsigned long base,
 			  unsigned long size, mtrr_type type)
 {
 	unsigned char arr, arr_type, arr_size;
+	unsigned long flags;
 
 	arr = CX86_ARR_BASE + (reg << 1) + reg;	/* avoid multiplication by 3 */
 
@@ -222,6 +223,8 @@ static void cyrix_set_arr(unsigned int reg, unsigned long base,
 		}
 	}
 
+	flags = hard_local_irq_save();
+
 	prepare_set();
 
 	base <<= PAGE_SHIFT;
@@ -231,6 +234,8 @@ static void cyrix_set_arr(unsigned int reg, unsigned long base,
 	setCx86(CX86_RCR_BASE + reg, arr_type);
 
 	post_set();
+
+	hard_local_irq_restore(flags);
 }
 
 typedef struct {
@@ -248,8 +253,10 @@ static unsigned char ccr_state[7] = { 0, 0, 0, 0, 0, 0, 0 };
 
 static void cyrix_set_all(void)
 {
+	unsigned long flags;
 	int i;
 
+	flags = hard_local_irq_save();
 	prepare_set();
 
 	/* the CCRs are not contiguous */
@@ -264,6 +271,7 @@ static void cyrix_set_all(void)
 	}
 
 	post_set();
+	hard_local_irq_restore(flags);
 }
 
 static const struct mtrr_ops cyrix_mtrr_ops = {
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e12ee86906c6..eb2a56615ad2 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -785,7 +785,7 @@ static void generic_set_all(void)
 	unsigned long mask, count;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	prepare_set();
 
 	/* Actually set the state */
@@ -795,7 +795,7 @@ static void generic_set_all(void)
 	pat_init();
 
 	post_set();
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 
 	/* Use the atomic bitops to update the global mask */
 	for (count = 0; count < sizeof mask * 8; ++count) {
@@ -819,12 +819,13 @@ static void generic_set_all(void)
 static void generic_set_mtrr(unsigned int reg, unsigned long base,
 			     unsigned long size, mtrr_type type)
 {
-	unsigned long flags;
+	unsigned long rflags, vflags;
 	struct mtrr_var_range *vr;
 
 	vr = &mtrr_state.var_ranges[reg];
 
-	local_irq_save(flags);
+	local_irq_save(vflags);
+	rflags = hard_local_irq_save();
 	prepare_set();
 
 	if (size == 0) {
@@ -845,7 +846,8 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 	}
 
 	post_set();
-	local_irq_restore(flags);
+	hard_local_irq_restore(rflags);
+	local_irq_restore(vflags);
 }
 
 int generic_validate_add_page(unsigned long base, unsigned long size,
-- 
2.14.4


