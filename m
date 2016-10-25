References: <9eed427afba0029a91a7819dd38f7ba55d81ca0a.1477330570.git.henning.schild@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ad9f2539-4c73-aabf-74b7-09b0a18abc5e@xenomai.org>
Date: Tue, 25 Oct 2016 15:26:09 +0200
MIME-Version: 1.0
In-Reply-To: <9eed427afba0029a91a7819dd38f7ba55d81ca0a.1477330570.git.henning.schild@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 1/2] hal/x86: fix kernel-space FPU with 4.1
	kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 10/24/2016 07:39 PM, Henning Schild wrote:
> Starting at kernel 4.1 we have a per-cpu flag for kernel fpu and do not
> abuse the flag of current anymore. This patch is a minimal fix for
> something that is hard to get your head around, but xenomai 2.6 will not
> go beyond 4.1. So not effort to fix or document what is going on ...
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  include/asm-x86/bits/pod.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/asm-x86/bits/pod.h b/include/asm-x86/bits/pod.h
> index 678720a..8a16713 100644
> --- a/include/asm-x86/bits/pod.h
> +++ b/include/asm-x86/bits/pod.h
> @@ -58,6 +58,10 @@ static inline void xnarch_leave_root(xnarchtcb_t *rootcb)
>  	rootcb->spp = &current->thread.x86reg_sp;
>  	rootcb->ipp = &current->thread.rip;
>  #endif
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,0,0)
> +	if (kernel_fpu_disabled())
> +		wrap_clear_fpu_used(current);
> +#endif
>  	rootcb->ts_usedfpu = !!wrap_test_fpu_used(current);

Does this fix work with regular RAID/crypto/mmx drivers enabled and
active for instance?

I would rather invert that logic, i.e. if !kernel_fpu_disabled(), then
set_fpu_used(). Otherwise we might not notice when Xenomai preempts some
regular kernel code which hijacked the fpu from kernel space.

-- 
Philippe.

