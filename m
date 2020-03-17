Subject: Re: [RFC][PATCH 4.19] x86/ipipe: Protect TLB flushing against context
 switch by head domain
References: <266b8c4f-ffec-d04e-ab83-9ae4cbf3486f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3fbc1399-3dc5-71dc-fb73-a1fedd0e8259@siemens.com>
Date: Tue, 17 Mar 2020 18:06:48 +0100
MIME-Version: 1.0
In-Reply-To: <266b8c4f-ffec-d04e-ab83-9ae4cbf3486f@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 12.03.20 14:48, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> A Xenomai application is very rarely triggering
> 
> WARNING: CPU: 0 PID: 1997 at arch/x86/mm/tlb.c:560 [...]
> (local_tlb_gen > mm_tlb_gen)
> 
> This could be triggered by loaded_mm and loaded_mm_asid becoming out of
> sync when flush_tlb_func_common is interrupted by the head domain to
> switch a real-time task right between the retrieval of both values, or
> maybe even after that but before writing mm_tlb_gen back to
> cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen.
> 
> Avoid that case by making the retrieval atomic while keeping the TLB
> flush interruptible. Now, there could still be interrupt during the
> flush. To avoid writing back to the wrong context, we first atomically
> check after the flush if nothing changed and only write if that is the
> case. That may mean another TLB flush is triggered needlessly, but
> that's rare and acceptable.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Due to the rare nature of this issue, we are not yet confident to have
> truly fixed it this way.

The positive effect of the patch has been confirmed by now (with a high 
confidence). Merging it therefore.

Jan

> 
> Philippe, I'm seeing some similar attempt in dovetail but it appears to
> me it's missing some cases. Too bad that development was forking here
> and information isn't flowing smoothly yet.
> 
>   arch/x86/mm/tlb.c | 33 +++++++++++++++++++++++++--------
>   1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 1fcf20673982..9fbf0a5f710e 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -518,17 +518,27 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
>   	 * - f->new_tlb_gen: the generation that the requester of the flush
>   	 *                   wants us to catch up to.
>   	 */
> -	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
> -	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> -	u64 mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
> -	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
> +	struct mm_struct *loaded_mm;
> +	u32 loaded_mm_asid;
> +	u64 mm_tlb_gen;
> +	u64 local_tlb_gen;
>   	unsigned long flags;
>   
>   	/* This code cannot presently handle being reentered. */
>   	VM_WARN_ON(!irqs_disabled());
>   
> -	if (unlikely(loaded_mm == &init_mm))
> +	flags = hard_cond_local_irq_save();
> +
> +	loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
> +	loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> +	mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
> +	loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> +	local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
> +
> +	if (unlikely(loaded_mm == &init_mm)) {
> +		hard_cond_local_irq_restore(flags);
>   		return;
> +	}
>   
>   	VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
>   		   loaded_mm->context.ctx_id);
> @@ -540,13 +550,13 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
>   		 * garbage into our TLB.  Since switching to init_mm is barely
>   		 * slower than a minimal flush, just switch to init_mm.
>   		 */
> -		flags = hard_cond_local_irq_save();
>   		switch_mm_irqs_off(NULL, &init_mm, NULL);
>   		hard_cond_local_irq_restore(flags);
>   		return;
>   	}
>   
>   	if (unlikely(local_tlb_gen == mm_tlb_gen)) {
> +		hard_cond_local_irq_restore(flags);
>   		/*
>   		 * There's nothing to do: we're already up to date.  This can
>   		 * happen if two concurrent flushes happen -- the first flush to
> @@ -560,6 +570,8 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
>   	WARN_ON_ONCE(local_tlb_gen > mm_tlb_gen);
>   	WARN_ON_ONCE(f->new_tlb_gen > mm_tlb_gen);
>   
> +	hard_cond_local_irq_restore(flags);
> +
>   	/*
>   	 * If we get to this point, we know that our TLB is out of date.
>   	 * This does not strictly imply that we need to flush (it's
> @@ -620,8 +632,13 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
>   		trace_tlb_flush(reason, TLB_FLUSH_ALL);
>   	}
>   
> -	/* Both paths above update our state to mm_tlb_gen. */
> -	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
> +	flags = hard_cond_local_irq_save();
> +	if (loaded_mm == this_cpu_read(cpu_tlbstate.loaded_mm) &&
> +	    loaded_mm_asid == this_cpu_read(cpu_tlbstate.loaded_mm_asid)) {
> +		/* Both paths above update our state to mm_tlb_gen. */
> +		this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
> +	}
> +	hard_cond_local_irq_restore(flags);
>   }
>   
>   static void flush_tlb_func_local(void *info, enum tlb_flush_reason reason)
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

