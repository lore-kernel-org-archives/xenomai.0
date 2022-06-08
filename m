Message-ID: <a7e38d23-ceb4-f81d-62c2-a39265aa770d@siemens.com>
Date: Wed, 8 Jun 2022 16:48:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] switchtest: Cleanup FPU tests after ipipe -> dovetail
 transition
Content-Language: en-US
References: <20220525074718.25647-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220525074718.25647-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 25.05.22 09:47, Florian Bezdeka wrote:
> FPU usage in kernel space was allowed / enabled with ipipe, but is no
> longer available for dovetail based kernels. That allows us to clean
> up the FPU related tests of the switchtest utility.
> 
> fp_kernel_supported() can be removed as all supported architectures
> returned 0 already. That allows us to remove the FPU feature test flag
> RTTST_SWTEST_USE_FPU as well.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/rtdm/uapi/testing.h                   |  1 -
>  .../arch/arm/include/asm/xenomai/fptest.h     |  5 ----
>  .../arch/arm64/include/asm/xenomai/fptest.h   |  5 ----
>  .../arch/x86/include/asm/xenomai/fptest.h     | 11 ---------
>  kernel/drivers/testing/switchtest.c           | 23 -------------------
>  testsuite/switchtest/switchtest.c             |  1 -
>  6 files changed, 46 deletions(-)
> 
> diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
> index f8207b8c7..49f0b7f25 100644
> --- a/include/rtdm/uapi/testing.h
> +++ b/include/rtdm/uapi/testing.h
> @@ -68,7 +68,6 @@ struct rttst_swtest_task {
>  
>  /* Possible values for struct rttst_swtest_task::flags. */
>  #define RTTST_SWTEST_FPU		0x1
> -#define RTTST_SWTEST_USE_FPU		0x2 /* Only for kernel-space tasks. */
>  #define RTTST_SWTEST_FREEZE		0x4 /* Only for kernel-space tasks. */
>  
>  struct rttst_swtest_dir {
> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
> index ca1752206..fc177fcb5 100644
> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
> @@ -30,11 +30,6 @@
>  
>  #include <asm/xenomai/uapi/fptest.h>
>  
> -static inline int fp_kernel_supported(void)
> -{
> -	return 0;
> -}
> -
>  static inline int fp_linux_begin(void)
>  {
>  	return -ENOSYS;
> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> index bc9dc342e..0958d5e2a 100644
> --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
> @@ -13,11 +13,6 @@
>  
>  #define have_fp (ELF_HWCAP & HWCAP_FP)
>  
> -static inline int fp_kernel_supported(void)
> -{
> -	return 0;
> -}
> -
>  static inline int fp_linux_begin(void)
>  {
>  	return -ENOSYS;
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
> index 83a6413d5..55818f853 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
> @@ -24,17 +24,6 @@
>  #include <asm/xenomai/wrappers.h>
>  #include <asm/xenomai/uapi/fptest.h>
>  
> -/*
> - * We do NOT support out-of-band FPU operations in kernel space for a
> - * reason: this is a mess. Out-of-band FPU is just fine and makes a
> - * lot of sense for many real-time applications, but you have to do
> - * that from userland.
> - */
> -static inline int fp_kernel_supported(void)
> -{
> -	return 0;
> -}
> -
>  static inline int fp_linux_begin(void)
>  {
>  	kernel_fpu_begin();
> diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
> index b5bc256df..9072717d5 100644
> --- a/kernel/drivers/testing/switchtest.c
> +++ b/kernel/drivers/testing/switchtest.c
> @@ -416,9 +416,6 @@ static void rtswitch_ktask(void *cookie)
>  	rtswitch_pend_rt(ctx, task->base.index);
>  
>  	while (!rtdm_task_should_stop()) {
> -		if (task->base.flags & RTTST_SWTEST_USE_FPU)
> -			fp_regs_set(fp_features, task->base.index + i * 1000);
> -
>  		switch(i % 3) {
>  		case 0:
>  			/* to == from means "return to last task" */
> @@ -437,17 +434,6 @@ static void rtswitch_ktask(void *cookie)
>  			rtswitch_to_rt(ctx, task->base.index, to);
>  		}
>  
> -		if (task->base.flags & RTTST_SWTEST_USE_FPU) {
> -			expected = task->base.index + i * 1000;
> -			fp_val = fp_regs_check(fp_features, expected, report);
> -
> -			if (fp_val != expected) {
> -				if (task->base.flags & RTTST_SWTEST_FREEZE)
> -					xntrace_user_freeze(0, 0);
> -				handle_ktask_error(ctx, fp_val);
> -			}
> -		}
> -
>  		if (++i == 4000000)
>  			i = 0;
>  	}
> @@ -465,15 +451,6 @@ static int rtswitch_create_ktask(struct rtswitch_context *ctx,
>  	char name[30];
>  	int err;
>  
> -	/*
> -	 * Silently disable FP tests in kernel if FPU is not supported
> -	 * there. Typical case is math emulation support: we can use
> -	 * it from userland as a synthetic FPU, but there is no sane
> -	 * way to use it from kernel-based threads (Xenomai or Linux).
> -	 */
> -	if (!fp_kernel_supported())
> -		ptask->flags &= ~RTTST_SWTEST_USE_FPU;
> -
>  	ptask->flags |= RTSWITCH_KERNEL;
>  	err = rtswitch_register_task(ctx, ptask);
>  
> diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
> index f2a5c1601..752671e39 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -832,7 +832,6 @@ static int task_create(struct cpu_tasks *cpu,
>  	switch(param->type) {
>  	case RTK:
>  		param->swt.flags = (param->fp & AFP ? RTTST_SWTEST_FPU : 0)
> -			| (param->fp & UFPP ? RTTST_SWTEST_USE_FPU : 0)
>  			| (freeze_on_error ? RTTST_SWTEST_FREEZE : 0);
>  
>  		err=ioctl(cpu->fd,RTTST_RTIOC_SWTEST_CREATE_KTASK,&param->swt);

Thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

