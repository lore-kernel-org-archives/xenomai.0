Message-ID: <5130E0C7.80709@siemens.com>
Date: Fri, 01 Mar 2013 18:09:27 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <1362151982.5735.YahooMailNeo@web171205.mail.ir2.yahoo.com>
In-Reply-To: <1362151982.5735.YahooMailNeo@web171205.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kvm freeze with ipipe patch for kernel 3.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gabriele Moabiti <gabmoa@yahoo.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-03-01 16:33, Gabriele Moabiti wrote:
> 
> I'm using an XP guest with qemu+kvm (vmx) on linux host (kernel 3.2.21 + ipipe patch + xenomai version 2.6.2.1)
> and I'm experiencing many system freezes when the vm is active.
> I think then problem is in the 3.x (3.2,3.4,3.5) ipipe patch (ipipe-core-3.2.21-x86-5.patch):
> 
> :
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> 
> 
> ....
> 
> @@ -5749,13 +5795,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>       */
>      smp_mb();
> 
> -    local_irq_disable();
> -
>      if (vcpu->mode == EXITING_GUEST_MODE || vcpu->requests
>          || need_resched() || signal_pending(current)) {
>          vcpu->mode = OUTSIDE_GUEST_MODE;
>          smp_wmb();
> -        local_irq_enable();
> +        hard_cond_local_irq_enable();
>          preempt_enable();
>          kvm_x86_ops->cancel_injection(vcpu);
>          r = 1;
> 
> 
> ....
> 
> 
> 
> 
> local_irq_enable() should be enabled after hard_cond_local_irq_enable (as in the 2.6.38 patch), in this way:
> 
> 
> 
> ...
> -    local_irq_disable();
> -
>      if (vcpu->mode == EXITING_GUEST_MODE || vcpu->requests
>          || need_resched() || signal_pending(current)) {
>          vcpu->mode = OUTSIDE_GUEST_MODE;
>          smp_wmb();
> +        hard_cond_local_irq_enable();
>          local_irq_enable();
>          preempt_enable();
> ....
> 
> I've done some tests and now the system runs fine.

There is more broken, even in latest stable 3.5.7. See the patches at
[1] for a tested version. Unfortunately, I cannot update my tree for 3.8
ATM as git services seem to be down on xenomai.org.

Would be great if you could give it try and report remaining issues.

Jan

[1]
http://git.xenomai.org/?p=ipipe-jki.git;a=shortlog;h=refs/heads/for-upstream/3.5

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

