Subject: Re: [Adeos-main] [PATCH] avoid suboptimal use of ipipe_lock_cpu
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45803F34.9000003@domain.hid>
References: <45803F34.9000003@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 21:47:22 +0100
Message-Id: <1166129243.23946.158.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Wed, 2006-12-13 at 18:58 +0100, Jan Kiszka wrote:
> Hi,
> 
> while disassembling that bug in start_kernel, I noticed that
> ipipe_lock_cpu(flags) is used in a suboptimal way in some
> ipipe_XXX_head() services, i.e. when the flags are actually of no
> interest. The compiler still generates the unneeded pushf/pop <reg>, and
> this in a hot-path.
> 
> Attached patch should perform better. Lightly tested, but QEMU SMP still
> works here.

Merged, thanks.

> 
> Jan
> plain text document attachment (avoid-ipipe_lock_cpu.patch)
> ---
>  include/linux/ipipe.h |    8 ++++----
>  kernel/ipipe/core.c   |    8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6.19/include/linux/ipipe.h
> ===================================================================
> --- linux-2.6.19.orig/include/linux/ipipe.h
> +++ linux-2.6.19/include/linux/ipipe.h
> @@ -471,18 +471,18 @@ static inline void ipipe_restore_pipelin
>  static inline void ipipe_stall_pipeline_head(void)
>  {
>  	ipipe_declare_cpuid;
> -	unsigned long flags;
>  
> -	ipipe_lock_cpu(flags);
> +	local_irq_disable_hw();
> +	ipipe_load_cpuid();
>  	__set_bit(IPIPE_STALL_FLAG, &__ipipe_pipeline_head()->cpudata[cpuid].status);
>  }
>  
>  static inline unsigned long ipipe_test_and_stall_pipeline_head(void)
>  {
> -	unsigned long flags;
>  	ipipe_declare_cpuid;
>  
> -	ipipe_lock_cpu(flags);
> +	local_irq_disable_hw();
> +	ipipe_load_cpuid();
>  	return __test_and_set_bit(IPIPE_STALL_FLAG, &__ipipe_pipeline_head()->cpudata[cpuid].status);
>  }
>  
> Index: linux-2.6.19/kernel/ipipe/core.c
> ===================================================================
> --- linux-2.6.19.orig/kernel/ipipe/core.c
> +++ linux-2.6.19/kernel/ipipe/core.c
> @@ -303,10 +303,10 @@ void fastcall ipipe_restore_pipeline_fro
>  void ipipe_unstall_pipeline_head(void)
>  {
>  	struct ipipe_domain *head;
> -	unsigned long flags;
>  	ipipe_declare_cpuid;
>  
> -	ipipe_lock_cpu(flags);
> +	local_irq_disable_hw();
> +	ipipe_load_cpuid();
>  	head = __ipipe_pipeline_head();
>  	__clear_bit(IPIPE_STALL_FLAG, &head->cpudata[cpuid].status);
>  
> @@ -323,9 +323,9 @@ void ipipe_unstall_pipeline_head(void)
>  void fastcall __ipipe_restore_pipeline_head(struct ipipe_domain *head, unsigned long x)
>  {
>  	ipipe_declare_cpuid;
> -	unsigned long flags;
>  
> -	ipipe_lock_cpu(flags);
> +	local_irq_disable_hw();
> +	ipipe_load_cpuid();
>  
>  	if (x) {
>  #ifdef CONFIG_DEBUG_KERNEL
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



