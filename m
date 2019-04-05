Subject: Re: kvm fpu warning on 4.14.89
References: <d53140e58f60459694e2e66a94d0a518@systemceramics.com>
 <CAPR3TAhurhcwOGe9wfnOTUd=VBRvXuMLxZtNZ-3+QNyd=TOJnA@mail.gmail.com>
 <ebec2dcf-9549-fed2-6a48-299597bc7079@siemens.com>
 <CAPR3TAjFNV-0LgZ=+ydtseAQw-jdmYRHO4FQwybTjAHwDV59Xg@mail.gmail.com>
 <CAPR3TAhP1VwSE5OjKiznfuzsRXyigeN+ohQP1jQE-roLDMh5LA@mail.gmail.com>
 <32be3d2e-020f-468c-2940-26a09e96daeb@siemens.com>
 <CAPR3TAitTeY0rNVZ6v0moFzh0d_hA6zyS-R3fm+DK+HX4yj3PQ@mail.gmail.com>
 <04ffd701-4df7-5a2b-8000-cf5bec9d06d7@siemens.com>
 <CAPR3TAg=5on1=gJHSChHHwAb3AafZNx3jizMerdZvYKnN5YObA@mail.gmail.com>
 <9d5a6b6e-d7ba-00cd-3851-b26961ebbee7@siemens.com>
 <a7f863b1-9389-4a04-152d-8bc1ec0d723c@siemens.com>
 <CAPR3TAitwUBW8AzOX6cWyBgnp+bKhiNHWE3PBfs-OdAcQSCANw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <48849a99-34f6-a84f-22cc-664028431ae7@siemens.com>
Date: Fri, 5 Apr 2019 10:14:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAPR3TAitwUBW8AzOX6cWyBgnp+bKhiNHWE3PBfs-OdAcQSCANw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: cagnulein <cagnulein@gmail.com>
Cc: xenomai@xenomai.org

On 05.04.19 08:20, cagnulein wrote:
> Hi Jan, thanks for your patch.
> I've just tried but I have the same issue: I start a kvm guest (windows 10 iot 
> 2019) and it works, but when I start a latency test the whole system hangs 
> completely.
> 
> Could i give you more info in some way?

OK... First question: Are you sure the patch was applied to the kernel
you tested? Just to double-check a common mistake.

Then, there are no debug messages on the uart at all when the system
locks up? What is your kernel config?

Next, please try with ipipe-4.4.y and this change:

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 2d480a64e172..0a1929dca183 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8453,6 +8453,10 @@ static void vmx_handle_external_intr(struct kvm_vcpu *vcpu)
 		unsigned long tmp;
 #endif
 
+#ifdef CONFIG_IPIPE
+		__clear_bit(IPIPE_STALL_FLAG,
+			    &ipipe_this_cpu_root_context()->status);
+#endif
 		vector =  exit_intr_info & INTR_INFO_VECTOR_MASK;
 		desc = (gate_desc *)vmx->host_idt_base + vector;
 		entry = gate_offset(*desc);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f895d4e0eb3e..e6863bd226e6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6639,6 +6639,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	    || need_resched() || signal_pending(current)) {
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		smp_wmb();
+		__ipipe_exit_vm();
 		hard_cond_local_irq_enable();
 		local_irq_enable();
 		preempt_enable();

Just make sure to have CONFIG_DEBUG_STACKOVERFLOW disabled (I just
discovered a compilation issue on that kernel version).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

