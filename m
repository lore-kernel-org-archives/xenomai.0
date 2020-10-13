Subject: Re: [PATCH] cobalt/x86: raise escalate virq with irq_inject_pipeline
 instead of irq_post_oob
References: <20201013074559.4535-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <971364e6-4f57-6810-628e-fa09335eeaea@siemens.com>
Date: Tue, 13 Oct 2020 16:37:33 +0200
MIME-Version: 1.0
In-Reply-To: <20201013074559.4535-1-hongzhan.chen@intel.com>
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
To: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 13.10.20 09:45, hongzha1 wrote:
> Before calling irq_post_oob, interrupts must be hard disabled
> in the cpu. But irq_inject_pipeline would handle it internally.
> 
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
> 
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> index af3433e8e..46294036b 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
> @@ -23,6 +23,7 @@
>  #include <asm-generic/xenomai/thread.h>
>  #include <asm/xenomai/wrappers.h>
>  #include <asm/traps.h>
> +#include <linux/irq_pipeline.h>
>  
>  #ifndef IPIPE_X86_FPU_EAGER
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
> @@ -90,7 +91,7 @@ static inline int xnarch_escalate(void)
>  {
>  	if (running_inband()) {
>  		/* orginal xenomai domain equals oob stage */
> -		irq_post_oob(cobalt_pipeline.escalate_virq);
> +		irq_inject_pipeline(cobalt_pipeline.escalate_virq);
>  		return 1;
>  	}
>  /*	if (ipipe_root_p) {
> 

Thanks, both this and the enable_oob_stage applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

