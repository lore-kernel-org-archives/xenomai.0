From: Jan Kiszka <jan.kiszka@web.de>
Subject: [v5.13.y-dovetail][PATCH 1/2] irq_pipeline: Clean up stage_info field
 and users
Message-ID: <cea5bae9-bd20-91f3-838f-4fd5e4065f1e@web.de>
Date: Thu, 3 Jun 2021 11:50:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This field represents mutually exclusive states, namely

- IRQENTRY_INBAND_UNSTALLED
- IRQENTRY_INBAND_STALLED
- IRQENTRY_OOB

Encodes them as enum and test against them, rather than against state
bits that suggest they could be combined.

Also flip the inverted naming of INBAND_STALLED vs. INBAND_UNSTALLED:
Only when we entered under INBAND_UNSTALLED, certain actions need to be
taken on exit.

Finally, document the stage_info field of irqentry_state.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--

Note: Tested only as backport to 5.10-x86 so far.

 arch/x86/kernel/irq_pipeline.c |  2 +-
 arch/x86/mm/fault.c            |  2 +-
 include/linux/entry-common.h   | 11 ++++++++---
 kernel/entry/common.c          | 12 ++++++------
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline=
.c
index 7ff5c03386e8..6944f9e4f852 100644
=2D-- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -64,7 +64,7 @@ static irqentry_state_t pipeline_enter_rcu(void)
 {
 	irqentry_state_t state =3D {
 		.exit_rcu =3D false,
-		.stage_info =3D 0,
+		.stage_info =3D IRQENTRY_INBAND_UNSTALLED,
 	};

 	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index dcc3e77fed2b..a242ac40a71d 100644
=2D-- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -813,7 +813,7 @@ static inline void cond_reenable_irqs_kernel(irqentry_=
state_t state,
 					struct pt_regs *regs)
 {
 	if (regs->flags & X86_EFLAGS_IF) {
-		if (state.stage_info & IRQENTRY_INBAND_STALLED)
+		if (state.stage_info =3D=3D IRQENTRY_INBAND_UNSTALLED)
 			unstall_inband_nocheck();
 		hard_local_irq_enable();
 	}
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 0b6639ff313f..2a08b00632b9 100644
=2D-- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -399,6 +399,12 @@ void irqentry_enter_from_user_mode(struct pt_regs *re=
gs);
  */
 void irqentry_exit_to_user_mode(struct pt_regs *regs);

+enum irqentry_info {
+	IRQENTRY_INBAND_UNSTALLED =3D 0,
+	IRQENTRY_INBAND_STALLED,
+	IRQENTRY_OOB,
+};
+
 #ifndef irqentry_state
 /**
  * struct irqentry_state - Opaque object for exception state storage
@@ -406,6 +412,7 @@ void irqentry_exit_to_user_mode(struct pt_regs *regs);
  *            exit path has to invoke rcu_irq_exit().
  * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
  *           lockdep state is restored correctly on exit from nmi.
+ * @stage_info: Information about pipeline state and current stage on IRQ=
 entry.
  *
  * This opaque object is filled in by the irqentry_*_enter() functions an=
d
  * must be passed back into the corresponding irqentry_*_exit() functions
@@ -421,9 +428,7 @@ typedef struct irqentry_state {
 		bool	lockdep;
 	};
 #ifdef CONFIG_IRQ_PIPELINE
-#define IRQENTRY_INBAND_STALLED	BIT(0)
-#define IRQENTRY_OOB_ENTRY	BIT(1)
-	int	stage_info;
+	enum irqentry_info stage_info;
 #endif
 } irqentry_state_t;
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e8f274523217..5a669f87ec3f 100644
=2D-- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -404,13 +404,13 @@ noinstr irqentry_state_t irqentry_enter(struct pt_re=
gs *regs)
 	irqentry_state_t ret =3D {
 		.exit_rcu =3D false,
 #ifdef CONFIG_IRQ_PIPELINE
-		.stage_info =3D 0,
+		.stage_info =3D IRQENTRY_INBAND_STALLED,
 #endif
 	};

 #ifdef CONFIG_IRQ_PIPELINE
 	if (running_oob()) {
-		ret.stage_info =3D IRQENTRY_OOB_ENTRY;
+		ret.stage_info =3D IRQENTRY_OOB;
 		return ret;
 	}
 #endif
@@ -419,7 +419,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs=
 *regs)
 #ifdef CONFIG_IRQ_PIPELINE
 		WARN_ON_ONCE(irq_pipeline_debug() && irqs_disabled());
 		stall_inband_nocheck();
-		ret.stage_info =3D IRQENTRY_INBAND_STALLED;
+		ret.stage_info =3D IRQENTRY_INBAND_UNSTALLED;
 #endif
 		irqentry_enter_from_user_mode(regs);
 		return ret;
@@ -432,7 +432,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs=
 *regs)
 	 * irqs are off on entry, we have to stall the in-band stage.
 	 */
 	if (!test_and_stall_inband_nocheck())
-		ret.stage_info =3D IRQENTRY_INBAND_STALLED;
+		ret.stage_info =3D IRQENTRY_INBAND_UNSTALLED;
 #endif

 	/*
@@ -510,7 +510,7 @@ static inline
 bool irqexit_may_preempt_schedule(irqentry_state_t state,
 				struct pt_regs *regs)
 {
-	return !!(state.stage_info & IRQENTRY_INBAND_STALLED);
+	return state.stage_info =3D=3D IRQENTRY_INBAND_UNSTALLED;
 }

 #else
@@ -579,7 +579,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqen=
try_state_t state)
 	 * irqentry_enter() raised it in order to mirror the hardware
 	 * state.
 	 */
-	if (state.stage_info & IRQENTRY_INBAND_STALLED)
+	if (state.stage_info =3D=3D IRQENTRY_INBAND_UNSTALLED)
 		unstall_inband();
 #endif
 	return;
=2D-
2.26.2


