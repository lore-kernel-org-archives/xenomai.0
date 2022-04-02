References: <20220402030919.5104-1-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [linux-dovetail PATCH 1/2] x86: fix duplication definication
 issue in making allyesconfig
Date: Sat, 02 Apr 2022 11:45:37 +0200
In-reply-to: <20220402030919.5104-1-hongzhan.chen@intel.com>
Message-ID: <874k3bpzqm.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>
Cc: xenomai@xenomai.org


Hongzhan Chen via Xenomai <xenomai@xenomai.org> writes:

> When making allyesconfig, there is duplication definication issue.
> To fix it, make them exclusive each other.
>
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  arch/x86/kernel/irq_pipeline.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
> index 8daac9f78ebe..624fad67fe56 100644
> --- a/arch/x86/kernel/irq_pipeline.c
> +++ b/arch/x86/kernel/irq_pipeline.c
> @@ -138,13 +138,11 @@ static void do_sysvec_inband(struct irq_desc *desc)
>  	case HYPERV_STIMER0_VECTOR:
>  		__sysvec_hyperv_stimer0(regs);
>  		break;
> -#endif
> -#ifdef CONFIG_ACRN_GUEST
> +#elif defined CONFIG_ACRN_GUEST
>  	case HYPERVISOR_CALLBACK_VECTOR:
>  		__sysvec_acrn_hv_callback(regs);
>  		break;
> -#endif
> -#ifdef CONFIG_XEN_PVHVM
> +#elif defined CONFIG_XEN_PVHVM
>  	case HYPERVISOR_CALLBACK_VECTOR:
>  		__sysvec_xen_hvm_callback(regs);
>  		break;

There may be a broader issue in the original implementation which this
patch only papers over.

In theory, building a kernel image one could run on multiple flavors of
HV should be possible - there seems to be no mutal exclusion in the
Kconfig specs between XEN, ACRN and HYPERV client support - which this
change would disable by always preferring HYPERV over ACRN when it comes
to pipelining interrupts.

However, Dovetail does not cope well with paravirtualization ATM anyway,
which is why XEN depends on !IRQ_PIPELINE. As a result, there is no
point in keeping the case for XEN_PVHVM around. We should have the same
constraint on CONFIG_HYPERV, therefore the other conflicting case should
go away, leaving ACRN_GUEST as the sole user of
HYPERVISOR_CALLBACK_VECTOR, with no conflict anymore.

-- 
Philippe.

