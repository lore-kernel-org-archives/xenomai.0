Subject: Re: [PATCH 1/4] cobalt/x86: adapt fpu code with Linux kernel upstream
References: <20200918062935.8410-1-fino.meng@linux.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f768e3fb-b9d1-8229-a8d8-767186d8f493@siemens.com>
Date: Fri, 18 Sep 2020 15:04:06 +0200
MIME-Version: 1.0
In-Reply-To: <20200918062935.8410-1-fino.meng@linux.intel.com>
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
To: Fino Meng <fino.meng@linux.intel.com>, xenomai@xenomai.org

<no commit message>

When I'm asking questions on the code, there was a need for a commit 
message.

On 18.09.20 08:29, Fino Meng wrote:
> Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
> Signed-off-by: Mingliang Hu <mingliang.hu@intel.com>
> ---
>   kernel/cobalt/arch/x86/thread.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/thread.c
> index ba807ac1e..c33ad832f 100644
> --- a/kernel/cobalt/arch/x86/thread.c
> +++ b/kernel/cobalt/arch/x86/thread.c
> @@ -26,6 +26,10 @@
>   #include <asm/mmu_context.h>
>   #include <asm/processor.h>
>   
> +#ifdef IPIPE_X86_FPU_EAGER
> +extern void fpu__initialize(struct fpu *fpu);

This will go along with ipipe for 5.4 patching that function to be 
non-static again, right?

> +#endif
> +
>   static struct kmem_cache *xstate_cache;
>   
>   #ifdef IPIPE_X86_FPU_EAGER
> @@ -472,7 +476,7 @@ void xnarch_leave_root(struct xnthread *root)
>   #if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
>   	/* restore current's fpregs */
>   	__cpu_invalidate_fpregs_state();
> -	switch_fpu_finish(&current->thread.fpu, smp_processor_id());
> +	switch_fpu_finish(&current->thread.fpu);

That is not correct for < 5.2 (5f409e20b794).

>   #else
>   	/* mark current thread as not owning the FPU anymore */
>   	if (fpregs_active())
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

