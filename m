Message-ID: <4E981957.5060501@domain.hid>
Date: Fri, 14 Oct 2011 13:13:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PULL] 2.6.38-x86: Make KVM I-pipe-aware
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

The following changes since commit 0bfe9ae6181af28018a9052d332057aa1aaf1b4f:

  ipipe-2.6.38.8-x86-2.10-01 (2011-07-21 09:52:35 +0200)

are available in the git repository at:
  git://git.kiszka.org/ipipe queues/2.6.38-x86

Jan Kiszka (3):
      ipipe: Re-add root preemption notifier
      Merge branch 'queues/2.6.38-noarch' into HEAD
      ipipe: x86: Make KVM I-pipe-aware

 arch/x86/kvm/svm.c         |    4 +-
 arch/x86/kvm/vmx.c         |   10 ++++++-
 arch/x86/kvm/x86.c         |   61 ++++++++++++++++++++++++++++++++++++--------
 include/linux/ipipe.h      |   35 +++++++++++++++++++++++++
 include/linux/ipipe_base.h |    2 +-
 kernel/ipipe/core.c        |    6 ++++
 6 files changed, 102 insertions(+), 16 deletions(-)

This is finally the stabilized version of [1], additionally rebased
over 2.6.38.

The original patch was missing some more synchronization around shared
MSR writeback when we preempt a KVM host thread (see patch below). Now
that this is fixed, even a non-Linux guest (here: Win7) runs fine on a
host CPU that is executing a Xenomai task as well. On the Xenomai side,
there is just a tiny additional patch require that I'll post separately.

Note that there are still quite a few open issues when it comes to
assigning PCI devices to a guest on an I-pipe host. But if your setup
does not depend on that feature, KVM is now usable together with
I-pipe/Xenomai (tested on Intel only, but AMD is much simpler, so I'm
optimistic :) ).

Jan

[1] http://thread.gmane.org/gmane.linux.kernel.adeos.general/1571

---

ipipe: x86: Make KVM I-pipe-aware

In order to use KVM on an I-pipe kernel, we need to harden some code
paths to truly disable interrupts and we have to install a root
preemption notifier once the guest CPU state is loaded. That notifier
will be called by a higher domain once it is about to switch in one of
its own tasks.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kvm/svm.c |    4 +-
 arch/x86/kvm/vmx.c |   10 ++++++-
 arch/x86/kvm/x86.c |   61 ++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index d8a15a1..15482e6 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3572,7 +3572,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	clgi();
 
-	local_irq_enable();
+	local_irq_enable_hw();
 
 	asm volatile (
 		"push %%"R"bp; \n\t"
@@ -3653,7 +3653,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	reload_tss(vcpu);
 
-	local_irq_disable();
+	local_irq_disable_hw();
 
 	stgi();
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index bf89ec2..5ef8af9 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -883,9 +883,11 @@ static void __vmx_load_host_state(struct vcpu_vmx *vmx)
 
 static void vmx_load_host_state(struct vcpu_vmx *vmx)
 {
-	preempt_disable();
+	unsigned long flags;
+
+	ipipe_preempt_disable(flags);
 	__vmx_load_host_state(vmx);
-	preempt_enable();
+	ipipe_preempt_enable(flags);
 }
 
 /*
@@ -1097,6 +1099,7 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 	unsigned long *msr_bitmap;
 
 	vmx_load_host_state(vmx);
+	local_irq_disable_hw_cond();
 	save_nmsrs = 0;
 #ifdef CONFIG_X86_64
 	if (is_long_mode(&vmx->vcpu)) {
@@ -1126,6 +1129,7 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 		move_msr_up(vmx, index, save_nmsrs++);
 
 	vmx->save_nmsrs = save_nmsrs;
+	local_irq_enable_hw_cond();
 
 	if (cpu_has_vmx_msr_bitmap()) {
 		if (is_long_mode(&vmx->vcpu))
@@ -4171,7 +4175,9 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx_vcpu_load(&vmx->vcpu, cpu);
 	vmx->vcpu.cpu = cpu;
 	err = vmx_vcpu_setup(vmx);
+	local_irq_disable_hw_cond();
 	vmx_vcpu_put(&vmx->vcpu);
+	local_irq_enable_hw_cond();
 	put_cpu();
 	if (err)
 		goto free_vmcs;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bcc0efc..edb12fe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -38,6 +38,7 @@
 #include <linux/iommu.h>
 #include <linux/intel-iommu.h>
 #include <linux/cpufreq.h>
+#include <linux/ipipe.h>
 #include <linux/user-return-notifier.h>
 #include <linux/srcu.h>
 #include <linux/slab.h>
@@ -109,6 +110,7 @@ struct kvm_shared_msrs_global {
 struct kvm_shared_msrs {
 	struct user_return_notifier urn;
 	bool registered;
+	bool dirty;
 	struct kvm_shared_msr_values {
 		u64 host;
 		u64 curr;
@@ -163,22 +165,36 @@ static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
 		vcpu->arch.apf.gfns[i] = ~0;
 }
 
+static void kvm_restore_shared_msrs(struct kvm_shared_msrs *locals)
+{
+	struct kvm_shared_msr_values *values;
+	unsigned long flags;
+	unsigned int slot;
+
+	local_irq_save_hw_cond(flags);
+	if (locals->dirty) {
+		for (slot = 0; slot < shared_msrs_global.nr; ++slot) {
+			values = &locals->values[slot];
+			if (values->host != values->curr) {
+				wrmsrl(shared_msrs_global.msrs[slot],
+				       values->host);
+				values->curr = values->host;
+			}
+		}
+		locals->dirty = false;
+	}
+	local_irq_restore_hw_cond(flags);
+}
+
 static void kvm_on_user_return(struct user_return_notifier *urn)
 {
-	unsigned slot;
 	struct kvm_shared_msrs *locals
 		= container_of(urn, struct kvm_shared_msrs, urn);
-	struct kvm_shared_msr_values *values;
 
-	for (slot = 0; slot < shared_msrs_global.nr; ++slot) {
-		values = &locals->values[slot];
-		if (values->host != values->curr) {
-			wrmsrl(shared_msrs_global.msrs[slot], values->host);
-			values->curr = values->host;
-		}
-	}
+	kvm_restore_shared_msrs(locals);
 	locals->registered = false;
 	user_return_notifier_unregister(urn);
+	ipipe_unregister_root_preempt_handler();
 }
 
 static void shared_msr_update(unsigned slot, u32 msr)
@@ -224,6 +240,7 @@ void kvm_set_shared_msr(unsigned slot, u64 value, u64 mask)
 		return;
 	smsr->values[slot].curr = value;
 	wrmsrl(shared_msrs_global.msrs[slot], value);
+	smsr->dirty = true;
 	if (!smsr->registered) {
 		smsr->urn.on_user_return = kvm_on_user_return;
 		user_return_notifier_register(&smsr->urn);
@@ -2110,9 +2127,27 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	struct kvm_shared_msrs *smsr = &__get_cpu_var(shared_msrs);
+	unsigned long flags;
+
+	local_irq_save_hw_cond(flags);
+
 	kvm_x86_ops->vcpu_put(vcpu);
 	kvm_put_guest_fpu(vcpu);
 	vcpu->arch.last_host_tsc = native_read_tsc();
+
+	if (!smsr->dirty)
+		ipipe_unregister_root_preempt_handler();
+	local_irq_restore_hw_cond(flags);
+}
+
+static void kvm_ipipe_root_preempt(void *cookie)
+{
+	struct kvm_vcpu *vcpu = cookie;
+
+	kvm_arch_vcpu_put(vcpu);
+	kvm_restore_shared_msrs(&__get_cpu_var(shared_msrs));
+	ipipe_unregister_root_preempt_handler();
 }
 
 static int is_efer_nx(void)
@@ -5207,6 +5242,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	}
 
 	preempt_disable();
+	local_irq_disable();
+	local_irq_disable_hw_cond();
+
+	ipipe_register_root_preempt_handler(kvm_ipipe_root_preempt, vcpu);
 
 	kvm_x86_ops->prepare_guest_switch(vcpu);
 	if (vcpu->fpu_active)
@@ -5216,12 +5255,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	atomic_set(&vcpu->guest_mode, 1);
 	smp_wmb();
 
-	local_irq_disable();
-
 	if (!atomic_read(&vcpu->guest_mode) || vcpu->requests
 	    || need_resched() || signal_pending(current)) {
 		atomic_set(&vcpu->guest_mode, 0);
 		smp_wmb();
+		local_irq_enable_hw_cond();
 		local_irq_enable();
 		preempt_enable();
 		kvm_x86_ops->cancel_injection(vcpu);
@@ -5258,6 +5296,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	atomic_set(&vcpu->guest_mode, 0);
 	smp_wmb();
+	local_irq_enable_hw_cond();
 	local_irq_enable();
 
 	++vcpu->stat.exits;
-- 
1.7.3.4

