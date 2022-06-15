From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH stable/3.0.x 1/2] x86: cobalt/switchtest: Fix testing issue
 due to uninitialized FPU
Date: Wed, 15 Jun 2022 11:57:17 +0200
Message-Id: <20220615095718.2445543-2-florian.bezdeka@siemens.com>
In-Reply-To: <20220615095718.2445543-1-florian.bezdeka@siemens.com>
References: <20220615095718.2445543-1-florian.bezdeka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On x86 fp_regs_set() expects that the FPU state was initialized by
calling the fninit instruction. When running in kernel space in task
context there is no guarantee that the FPU was initialized. Under
heavy load / scheduling the test might fail and report a FPU
register corruption.

The new introduced fp_init() takes care of the FPU initialization. We
call it before fp_regs_set() in task context and re-use it for the kernel
context as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h      | 4 ++++
 kernel/cobalt/arch/blackfin/include/asm/xenomai/fptest.h | 4 ++++
 kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h  | 4 ++++
 kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h      | 7 ++++++-
 kernel/drivers/testing/switchtest.c                      | 4 +++-
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
index a76f1e6bb..d100baad4 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
@@ -35,6 +35,10 @@ static inline int fp_kernel_supported(void)
 	return 1;
 }
 
+static inline void fp_init(void)
+{
+}
+
 static inline int fp_linux_begin(void)
 {
 	return -ENOSYS;
diff --git a/kernel/cobalt/arch/blackfin/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/blackfin/include/asm/xenomai/fptest.h
index 904ce83fb..ffa057a81 100644
--- a/kernel/cobalt/arch/blackfin/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/blackfin/include/asm/xenomai/fptest.h
@@ -27,6 +27,10 @@ static inline int fp_kernel_supported(void)
 	return 0;
 }
 
+static inline void fp_init(void)
+{
+}
+
 static inline int fp_linux_begin(void)
 {
 	return -ENOSYS;
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h
index e09ca2c3b..a9d93fe87 100644
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/powerpc/include/asm/xenomai/fptest.h
@@ -41,6 +41,10 @@ static inline int fp_kernel_supported(void)
 #endif	/* !CONFIG_PPC_FPU */
 }
 
+static inline void fp_init(void)
+{
+}
+
 static inline int fp_linux_begin(void)
 {
 	return -ENOSYS;
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
index f0ecd00e9..ccf7afa11 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
@@ -29,6 +29,11 @@ static inline int fp_kernel_supported(void)
 	return 1;
 }
 
+static inline void fp_init(void)
+{
+	__asm__ __volatile__("fninit");
+}
+
 static inline int fp_linux_begin(void)
 {
 #if defined(CONFIG_X86_USE_3DNOW) \
@@ -48,7 +53,7 @@ static inline int fp_linux_begin(void)
 	/* kernel_fpu_begin() does no re-initialize the fpu context, but
 	   fp_regs_set() implicitely expects an initialized fpu context, so
 	   initialize it here. */
-	__asm__ __volatile__("fninit");
+	fp_init();
 	return 0;
 }
 
diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index 08b64820a..84eb586c7 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -416,8 +416,10 @@ static void rtswitch_ktask(void *cookie)
 	rtswitch_pend_rt(ctx, task->base.index);
 
 	while (!rtdm_task_should_stop()) {
-		if (task->base.flags & RTTST_SWTEST_USE_FPU)
+		if (task->base.flags & RTTST_SWTEST_USE_FPU) {
+			fp_init();
 			fp_regs_set(fp_features, task->base.index + i * 1000);
+		}
 
 		switch(i % 3) {
 		case 0:
-- 
2.30.2


