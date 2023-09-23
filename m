Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE1DDAB
	for <xenomai@lists.linux.dev>; Sat, 23 Sep 2023 10:23:27 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 690CB40002;
	Sat, 23 Sep 2023 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1695464605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=krszoIXeYeIoX8QtlaU6844p6RLkKZ2NAtrUuLV7bn0=;
	b=B9o0z/aZHlswfpli4p6dB+xwCXFOK8zXltj/rI25zv0O7mgSBp9T5644hjgjUBqwEr+R5c
	eHJWN6j8/8DcyTsJuBBa1yO6Be7dCKLPWDEJPaBJ4Z4kWhsHxhuBlF2rIeakyFKm52/az1
	Yb6jODXj5T+jb7geC4hKL7LEO0jdPbcFwqsiCGTG/5nrgF5J/AfEW2d5pMyf8Zg5uqkSme
	xbBdrcNGuHB62ys34EHQtV1xphdU66Dd1SB/X+EWaW/XvJTIJMcygG1Hv8uolPu6+Rq580
	NR3V6PJQEAVFPf6g+D/aXBq91hhaIjsLo+yHIH3uTzB3sz0B011AopxGFttKPQ==
References: <20586e6d-090b-4cff-b616-e637f2e4d9d1@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [dovetail 6.6][PATCH] x86: dovetail: Fix Intel shadow stack
 support
Date: Sat, 23 Sep 2023 12:23:16 +0200
In-reply-to: <20586e6d-090b-4cff-b616-e637f2e4d9d1@siemens.com>
Message-ID: <87lecxxk6b.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Let fpregs_lock_and_load return the saved flags of fpregs_lock and make
> sure that the shadow stack callers use that properly.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/include/asm/fpu/api.h |  2 +-
>  arch/x86/kernel/fpu/core.c     |  8 ++++++--
>  arch/x86/kernel/shstk.c        | 31 +++++++++++++++++++------------
>  3 files changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index 84ce78d643792..0cd5f7642326f 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -98,7 +98,7 @@ static inline void fpregs_unlock(unsigned long flags)
>   * being automatically saved/restored. Then FPU state can be modified safely in the
>   * registers, before unlocking with fpregs_unlock().
>   */
> -void fpregs_lock_and_load(void);
> +unsigned long fpregs_lock_and_load(void);
>  
>  #ifdef CONFIG_X86_DEBUG_FPU
>  extern void fpregs_assert_state_consistent(void);
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 0d86706b962a4..85925b10ee045 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -817,8 +817,10 @@ void switch_fpu_return(void)
>  }
>  EXPORT_SYMBOL_GPL(switch_fpu_return);
>  
> -void fpregs_lock_and_load(void)
> +unsigned long fpregs_lock_and_load(void)
>  {
> +	unsigned long flags;
> +
>  	/*
>  	 * fpregs_lock() only disables preemption (mostly). So modifying state
>  	 * in an interrupt could screw up some in progress fpregs operation.
> @@ -827,12 +829,14 @@ void fpregs_lock_and_load(void)
>  	WARN_ON_ONCE(!irq_fpu_usable());
>  	WARN_ON_ONCE(current->flags & PF_KTHREAD);
>  
> -	fpregs_lock();
> +	flags = fpregs_lock();
>  
>  	fpregs_assert_state_consistent();
>  
>  	if (test_thread_flag(TIF_NEED_FPU_LOAD))
>  		fpregs_restore_userregs();
> +
> +	return flags;
>  }
>  
>  #ifdef CONFIG_X86_DEBUG_FPU
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index fd689921a1dba..fbaeb08bdc8d0 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -158,6 +158,7 @@ static int shstk_setup(void)
>  {
>  	struct thread_shstk *shstk = &current->thread.shstk;
>  	unsigned long addr, size;
> +	unsigned long flags;
>  
>  	/* Already enabled */
>  	if (features_enabled(ARCH_SHSTK_SHSTK))
> @@ -172,10 +173,10 @@ static int shstk_setup(void)
>  	if (IS_ERR_VALUE(addr))
>  		return PTR_ERR((void *)addr);
>  
> -	fpregs_lock_and_load();
> +	flags = fpregs_lock_and_load();
>  	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
>  	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
> -	fpregs_unlock();
> +	fpregs_unlock(flags);
>  
>  	shstk->base = addr;
>  	shstk->size = size;
> @@ -225,12 +226,13 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
>  static unsigned long get_user_shstk_addr(void)
>  {
>  	unsigned long long ssp;
> +	unsigned long flags;
>  
> -	fpregs_lock_and_load();
> +	flags = fpregs_lock_and_load();
>  
>  	rdmsrl(MSR_IA32_PL3_SSP, ssp);
>  
> -	fpregs_unlock();
> +	fpregs_unlock(flags);
>  
>  	return ssp;
>  }
> @@ -336,6 +338,7 @@ static int shstk_pop_sigframe(unsigned long *ssp)
>  int setup_signal_shadow_stack(struct ksignal *ksig)
>  {
>  	void __user *restorer = ksig->ka.sa.sa_restorer;
> +	unsigned long flags;
>  	unsigned long ssp;
>  	int err;
>  
> @@ -360,15 +363,16 @@ int setup_signal_shadow_stack(struct ksignal *ksig)
>  	if (unlikely(err))
>  		return -EFAULT;
>  
> -	fpregs_lock_and_load();
> +	flags = fpregs_lock_and_load();
>  	wrmsrl(MSR_IA32_PL3_SSP, ssp);
> -	fpregs_unlock();
> +	fpregs_unlock(flags);
>  
>  	return 0;
>  }
>  
>  int restore_signal_shadow_stack(void)
>  {
> +	unsigned long flags;
>  	unsigned long ssp;
>  	int err;
>  
> @@ -384,9 +388,9 @@ int restore_signal_shadow_stack(void)
>  	if (unlikely(err))
>  		return err;
>  
> -	fpregs_lock_and_load();
> +	flags = fpregs_lock_and_load();
>  	wrmsrl(MSR_IA32_PL3_SSP, ssp);
> -	fpregs_unlock();
> +	fpregs_unlock(flags);
>  
>  	return 0;
>  }
> @@ -413,6 +417,7 @@ void shstk_free(struct task_struct *tsk)
>  
>  static int wrss_control(bool enable)
>  {
> +	unsigned long flags;
>  	u64 msrval;
>  
>  	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> @@ -430,7 +435,7 @@ static int wrss_control(bool enable)
>  	if (features_enabled(ARCH_SHSTK_WRSS) == enable)
>  		return 0;
>  
> -	fpregs_lock_and_load();
> +	flags = fpregs_lock_and_load();
>  	rdmsrl(MSR_IA32_U_CET, msrval);
>  
>  	if (enable) {
> @@ -447,13 +452,15 @@ static int wrss_control(bool enable)
>  	wrmsrl(MSR_IA32_U_CET, msrval);
>  
>  unlock:
> -	fpregs_unlock();
> +	fpregs_unlock(flags);
>  
>  	return 0;
>  }
>  
>  static int shstk_disable(void)
>  {
> +	unsigned long flags;
> +
>  	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
>  		return -EOPNOTSUPP;
>  
> @@ -461,11 +468,11 @@ static int shstk_disable(void)
>  	if (!features_enabled(ARCH_SHSTK_SHSTK))
>  		return 0;
>  
> -	fpregs_lock_and_load();
> +	flags = fpregs_lock_and_load();
>  	/* Disable WRSS too when disabling shadow stack */
>  	wrmsrl(MSR_IA32_U_CET, 0);
>  	wrmsrl(MSR_IA32_PL3_SSP, 0);
> -	fpregs_unlock();
> +	fpregs_unlock(flags);
>  
>  	shstk_free(current);
>  	features_clr(ARCH_SHSTK_SHSTK | ARCH_SHSTK_WRSS);

Merged, thanks.

-- 
Philippe.
