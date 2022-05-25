From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 1/2] x86: ipipe: Fix testing issue due to uninitialized FPU
Date: Wed, 25 May 2022 11:56:26 +0200
Message-Id: <20220525095627.40521-2-florian.bezdeka@siemens.com>
In-Reply-To: <20220525095627.40521-1-florian.bezdeka@siemens.com>
References: <20220525095627.40521-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
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
calling the fninit instruction. When running the tests in kernel space
in task context there is no guarantee that the FPU was initialized so
under heavy load / scheduling the test might fail and report a FPU
register corruption.

The new introduced fp_init() takes care of the FPU initialization. We
call it before fp_regs_set() in task context and re-use it for the kernel
context as well.

As the affected fptest.h exists for every ipipe/dovetail architecture
combination we have to touch all of those.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h  | 4 ++++
 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h  | 4 ++++
 .../arch/arm64/dovetail/include/asm/xenomai/fptest.h       | 4 ++++
 .../cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h   | 4 ++++
 .../cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h | 4 ++++
 .../cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h  | 4 ++++
 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h  | 7 ++++++-
 kernel/drivers/testing/switchtest.c                        | 4 +++-
 8 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h
index ad7814cce..4cc075223 100644
--- a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h
@@ -35,6 +35,10 @@ static inline int fp_kernel_supported(void)
 	return 0;
 }
 
+static inline void fp_init(void)
+{
+}
+
 static inline int fp_linux_begin(void)
 {
 	return -ENOSYS;
diff --git a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h
index b8c627bed..d3f335f86 100644
--- a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h
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
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h
index 5f3630dda..8c4228d40 100644
--- a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h
@@ -18,6 +18,10 @@ static inline int fp_kernel_supported(void)
 	return 0;
 }
 
+static inline void fp_init(void)
+{
+}
+
 static inline int fp_linux_begin(void)
 {
 	return -ENOSYS;
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h
index 291c9e5f0..39903a047 100644
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h
@@ -30,6 +30,10 @@ static inline int fp_kernel_supported(void)
 	return 0;
 }
 
+static inline void fp_init(void)
+{
+}
+
 static inline int fp_linux_begin(void)
 {
 	return -ENOSYS;
diff --git a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h
index e09ca2c3b..a9d93fe87 100644
--- a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h
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
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h
index 83a6413d5..463d9d370 100644
--- a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h
@@ -35,6 +35,10 @@ static inline int fp_kernel_supported(void)
 	return 0;
 }
 
+static inline void fp_init(void)
+{
+}
+
 static inline int fp_linux_begin(void)
 {
 	kernel_fpu_begin();
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
index f0ecd00e9..ccf7afa11 100644
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
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
index b5bc256df..312b4d870 100644
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
2.35.3


