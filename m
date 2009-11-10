Message-ID: <4AF8B50E.4010900@domain.hid>
Date: Tue, 10 Nov 2009 01:34:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AF8A72E.1060204@domain.hid>
In-Reply-To: <4AF8A72E.1060204@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] hal: Ensure atomicity
	of	rthal_local_irq_disabled
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> [Patch is now also available in 'for-upstream']
> 
> ipipe_test_pipeline_from is not atomic /wrt reading the current cpu
> number (or an offset for the per-cpu area) and actually reading the
> virtualized interrupt state. Work around this by disabling hard IRQs
> while accessing this service.
> 
> This fixes false-positives of RTDM driver debug checks.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
>  include/asm-generic/hal.h |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
> index 97c549e..3095b85 100644
> --- a/include/asm-generic/hal.h
> +++ b/include/asm-generic/hal.h
> @@ -117,7 +117,14 @@ typedef spinlock_t rthal_spinlock_t;
>  #endif /* !CONFIG_XENO_OPT_PIPELINE_HEAD */
>  #define rthal_local_irq_flags(x)	((x) = ipipe_test_pipeline_from(&rthal_domain) & 1)
>  #define rthal_local_irq_test()		ipipe_test_pipeline_from(&rthal_domain)
> -#define rthal_local_irq_disabled()	ipipe_test_pipeline_from(&rthal_domain)
> +#define rthal_local_irq_disabled()				\
> +({								\
> +	unsigned long __flags, __ret;				\
> +	local_irq_save_hw(__flags);				\
> +	__ret = ipipe_test_pipeline_from(&rthal_domain);	\
> +	local_irq_restore_hw(__flags);				\
> +	__ret;							\
> +})

Maybe we can avoid that on UP systems?

-- 
					    Gilles.

