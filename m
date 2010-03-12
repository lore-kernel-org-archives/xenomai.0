Message-ID: <4B9A5CDA.7080704@domain.hid>
Date: Fri, 12 Mar 2010 16:25:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020602030205020902070105"
Subject: [Xenomai-core] [RFC] KVM over Xenomai and I-pipe
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------020602030205020902070105
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

this is still in the state "study", but it is working fairly nicely so far:

These two patches harden latest KVM for use over I-pipe kernels and make
Xenomai aware of the lazy host state restoring that KVM uses for
performance reasons. The latter basically means calling the sched-out
notifier that KVM registers with the kernel when switching from a Linux
task to some shadow. This is safe in all recent versions of KVM and
still gives nice KVM performance (that of KVM before 2.6.32) without
significant impact on the RT latency (Note: if you have an old VT-x CPU,
guest-issued wbinvd will ruin RT as it is not intercepted by the hardware!).

To test it, you need to apply the kernel patch on top of current kvm.git
master [1], obtain kvm-kmod.git [2], run configure on it (assuming your
host kernel is a Xenomai one, otherwise use --kerneldir) and then "make
sync-kmod LINUX=/path/to/kvm.git". After a final make && make install,
you will have recent kvm modules that are I-pipe aware. The Xenomai
patch simply appies to the 2.5 tree. This has been tested with
ipipe-2.6.32-x86-2.6-01 + [3] and Xenomai-2.5 git.

Feedback welcome, specifically if you think it's worth integrating both
patches into upstream. The kernel bits would make sense over some
2.6.33-x86, but additional work will be required to account for the
user-return notifiers introduced with that release (kvm-kmod currently
wraps them away for older kernels).

Jan

[1]git://git.kernel.org/pub/scm/virt/kvm/kvm.git
[2]git://git.kernel.org/pub/scm/virt/kvm/kvm-kmod.git
[3]http://git.kiszka.org/?p=ipipe-2.6.git;a=commitdiff;h=0bddff1716aba6dd5ca11627ee377a5a25fa3dae

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

--------------020602030205020902070105
Content-Type: text/x-patch;
 name="0001-Harden-KVM-for-use-over-I-pipe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Harden-KVM-for-use-over-I-pipe.patch"

>From 55480e98b8f35818a838bb2bd1f24764276a9b17 Mon Sep 17 00:00:00 2001
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Wed, 10 Mar 2010 08:32:02 +0100
Subject: [PATCH] Harden KVM for use over I-pipe

This allows to use KVM on I-pipe-enabled kernels. I-pipe domains that
preempt a VCPU task and let the preempting task return to user space
additionally have to fire the sched-out notifiers of VCPU task with IRQs
disable. Those will restore host states that are lazily switched for
performance reasons.

Tested with modfied Xenomai on Intel, should work with AMD hosts as
well.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kvm/svm.c |    4 ++--
 arch/x86/kvm/vmx.c |   10 ++++++----
 arch/x86/kvm/x86.c |   11 +++++++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index def4877..7e81639 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3025,7 +3025,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	clgi();
 
-	local_irq_enable();
+	local_irq_enable_hw();
 
 	asm volatile (
 		"push %%"R"bp; \n\t"
@@ -3110,7 +3110,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	reload_tss(vcpu);
 
-	local_irq_disable();
+	local_irq_disable_hw();
 
 	stgi();
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ae3217d..741e2a1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -736,12 +736,12 @@ static void __vmx_load_host_state(struct vcpu_vmx *vmx)
 		 * If we have to reload gs, we must take care to
 		 * preserve our gs base.
 		 */
-		local_irq_save(flags);
+		local_irq_save_hw(flags);
 		kvm_load_gs(vmx->host_state.gs_sel);
 #ifdef CONFIG_X86_64
 		wrmsrl(MSR_GS_BASE, vmcs_readl(HOST_GS_BASE));
 #endif
-		local_irq_restore(flags);
+		local_irq_restore_hw(flags);
 	}
 	reload_tss();
 #ifdef CONFIG_X86_64
@@ -754,9 +754,11 @@ static void __vmx_load_host_state(struct vcpu_vmx *vmx)
 
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 703f637..713a392 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1657,8 +1657,12 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	unsigned long flags;
+
+	local_irq_save_hw_cond(flags);
 	kvm_put_guest_fpu(vcpu);
 	kvm_x86_ops->vcpu_put(vcpu);
+	local_irq_restore_hw_cond(flags);
 }
 
 static int is_efer_nx(void)
@@ -4332,17 +4336,19 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	preempt_disable();
 
+	local_irq_disable();
+	local_irq_disable_hw();
+
 	kvm_x86_ops->prepare_guest_switch(vcpu);
 	if (vcpu->fpu_active)
 		kvm_load_guest_fpu(vcpu);
 
-	local_irq_disable();
-
 	clear_bit(KVM_REQ_KICK, &vcpu->requests);
 	smp_mb__after_clear_bit();
 
 	if (vcpu->requests || need_resched() || signal_pending(current)) {
 		set_bit(KVM_REQ_KICK, &vcpu->requests);
+		local_irq_enable_hw();
 		local_irq_enable();
 		preempt_enable();
 		r = 1;
@@ -4388,6 +4394,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		hw_breakpoint_restore();
 
 	set_bit(KVM_REQ_KICK, &vcpu->requests);
+	local_irq_enable_hw();
 	local_irq_enable();
 
 	++vcpu->stat.exits;
-- 
1.6.0.2


--------------020602030205020902070105
Content-Type: text/x-patch;
 name="0001-Enable-KVM-on-Xenomai-kernels.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Enable-KVM-on-Xenomai-kernels.patch"

>From 618e445548d38f712c4d5d108da627fd30207631 Mon Sep 17 00:00:00 2001
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Wed, 10 Mar 2010 10:35:36 +0100
Subject: [PATCH] Enable KVM on Xenomai kernels

Call the sched-out notifier (so far this can only be kvm_sched_out) when
switching Linux tasks. This restores the complete host state after a VM
exit and allows shadow threads to safely preempt VCPU threads.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-x86/bits/pod_64.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86/bits/pod_64.h b/include/asm-x86/bits/pod_64.h
index 88e049d..96793f7 100644
--- a/include/asm-x86/bits/pod_64.h
+++ b/include/asm-x86/bits/pod_64.h
@@ -68,6 +68,15 @@ static inline void xnarch_switch_to(xnarchtcb_t *out_tcb, xnarchtcb_t *in_tcb)
 	struct task_struct *next = in_tcb->user_task;
 
 	if (likely(next != NULL)) {
+#ifdef CONFIG_PREEMPT_NOTIFIERS
+		struct preempt_notifier *notifier;
+		struct hlist_node *node;
+
+		hlist_for_each_entry(notifier, node, &prev->preempt_notifiers,
+				     link)
+			notifier->ops->sched_out(notifier, next);
+#endif
+
 		if (task_thread_info(prev)->status & TS_USEDFPU)
 			/*
 			 * __switch_to will try and use __unlazy_fpu,
-- 
1.6.0.2


--------------020602030205020902070105--

