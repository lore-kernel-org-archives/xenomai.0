From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AF943BD.3020808@domain.hid>
References: <4AF8A72E.1060204@domain.hid>  <4AF8B50E.4010900@domain.hid>
	<1257848915.2210.487.camel@domain.hid>
	<4AF943BD.3020808@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Nov 2009 11:55:43 +0100
Message-ID: <1257850543.2210.494.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] hal: Ensure atomicity of
 rthal_local_irq_disabled
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

On Tue, 2009-11-10 at 11:43 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2009-11-10 at 01:34 +0100, Gilles Chanteperdrix wrote:
> >> Jan Kiszka wrote:
> >>> [Patch is now also available in 'for-upstream']
> >>>
> >>> ipipe_test_pipeline_from is not atomic /wrt reading the current cpu
> >>> number (or an offset for the per-cpu area) and actually reading the
> >>> virtualized interrupt state. Work around this by disabling hard IRQs
> >>> while accessing this service.
> >>>
> >>> This fixes false-positives of RTDM driver debug checks.
> >>>
> >>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> >>> ---
> >>>  include/asm-generic/hal.h |    9 ++++++++-
> >>>  1 files changed, 8 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
> >>> index 97c549e..3095b85 100644
> >>> --- a/include/asm-generic/hal.h
> >>> +++ b/include/asm-generic/hal.h
> >>> @@ -117,7 +117,14 @@ typedef spinlock_t rthal_spinlock_t;
> >>>  #endif /* !CONFIG_XENO_OPT_PIPELINE_HEAD */
> >>>  #define rthal_local_irq_flags(x)	((x) = ipipe_test_pipeline_from(&rthal_domain) & 1)
> >>>  #define rthal_local_irq_test()		ipipe_test_pipeline_from(&rthal_domain)
> >>> -#define rthal_local_irq_disabled()	ipipe_test_pipeline_from(&rthal_domain)
> >>> +#define rthal_local_irq_disabled()				\
> >>> +({								\
> >>> +	unsigned long __flags, __ret;				\
> >>> +	local_irq_save_hw(__flags);				\
> >>> +	__ret = ipipe_test_pipeline_from(&rthal_domain);	\
> >>> +	local_irq_restore_hw(__flags);				\
> >>> +	__ret;							\
> >>> +})
> >> Maybe we can avoid that on UP systems?
> >>
> > 
> > Yes, we should rather use local_irq_save/restore_hw_smp().
> > 
> 
> Oh, *_hw_smp is new, isn't it? Do we need to wrap it for older I-pipes?

Yes, it was introduced to solve the SMP migration issue actually, so we
need a wrapper. The advantage of having that wrapper instead of going
for inlined #ifdef CONFIG_SMP is that I could simply get rid of that
wrapper in 3.x, since all legacy pipeline patches would be deprecated
there anyway.

> 
> Jan


-- 
Philippe.



