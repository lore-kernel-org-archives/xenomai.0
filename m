Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECFF79F4
	for <xenomai@lists.linux.dev>; Wed, 21 Aug 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252720; cv=none; b=fPzWxDxYMre5tuada0bxDq4dwG9LaXRE3YIx1Fh3hrxX9sKwOT3tH3GuYPiy1dmCUwLd+2DLNYcxAG2dC5RIXhvYdPluxPPqe6w4iH26HGhTucaBy2VHy2ANc31RvZMMRR83qpHyAeb7JdfRGqEskuGns6rKr6f9urEMljV/Rck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252720; c=relaxed/simple;
	bh=AVHq1z1SyjSIloChNYyjwrOY2ahHPbhq3PH5yPkekZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UGFoVo4X11Xv7ejZCInamduPrSZZo7rYDkrkuiTVzo2cq8yddCcUaPwbJBgEfOs6Mumm+bNV2Tbzx5+s5xjIbvrZTdys6h5rBSMGGcJ/IW2nRzEGatga0XrlyQzvQXvN3V3LacCHBl0I27ZfR6lktamzs172SXXdVkzeVqtWekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ceZZgnEq; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ceZZgnEq"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202408211505035abc3af2f217287c34
        for <xenomai@lists.linux.dev>;
        Wed, 21 Aug 2024 17:05:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qGFVCHjOLKyvVNGtxTZuYwPSQpQrWzTrAYPJ6ESFt5E=;
 b=ceZZgnEq1VnQEVflppDwp0W/0YSORSh7/M2anX8L5+PnMYJE3KyH7Mk6ievkVSavDTOpvQ
 x9DX6fc5eAmd4AoLf9EVG3bWYXVhJrcTtR4ksFovstM0utqdPll9tWIqieCCuFTyWneAUS4z
 iM3rcNl1S2zpt3w1V34yIYo3SRtDzT8UY7uZ0QDqdtR5zwAXR97yfmwWJkyIRZV6X4WhO1O+
 kslw3gz/TTX21SQPGU7qoWEx1Wn8DEzCdwVlTT576AT7X1dsPC9qsNIAKIQd+zWkGsjvK/xQ
 tJrciAxYOaExBT6qfJ3fXFQmTIJd8MMKltonz3mGrwBj1JjBdN6UBH/A==;
Message-ID: <294f5d0740a0cd729ed855f46588c17a31b5e025.camel@siemens.com>
Subject: Re: [PATCH RFC dovetail 6.11,6.10] x86: dovetail: Allow
 CONFIG_ACRN_GUEST and CONFIG_KVM_GUEST at the same time
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Ionut Nechita <ionut.nechita@intel.com>
Date: Wed, 21 Aug 2024 17:05:02 +0200
In-Reply-To: <87y14qgc8n.fsf@xenomai.org>
References: 
	<20240821-flo-6-10-fix-kvm-acrn-both-active-v1-1-7473ea13b638@siemens.com>
	 <87y14qgc8n.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2024-08-21 at 16:51 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > do_sysvec_inband() assumed that only one of CONFIG_ACRN_GUEST and
> > CONFIG_KVM_GUEST is active at the same time. If both were enabled we
> > run into a compile issue:
> >=20
> > arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
> > arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
> >    160 |         case HYPERVISOR_CALLBACK_VECTOR:
> >        |         ^~~~
> > arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
> >    154 |         case HYPERVISOR_CALLBACK_VECTOR:
> >        |         ^~~~
> >=20
> > As only one hypervisor (HV) can be active at the same time, but support
> > for more than one can be compiled in, we have to migrate from a build
> > time decision to a runtime based one.
> >=20
> > We hook into the sysvec_install() macro and call a dovetail specific
> > pipelined_sysvec_install(). This way we get informed about the init
> > phase of HV guest code and handle all hypervisors the same way.
> >=20
> > The trampoline function (pipeline_hv_callback()) is needed to statisfy
> > type checks done by run_sysvec_on_irqstack_cond().
> >=20
> > Link: https://lore.kernel.org/xenomai/PH0PR11MB59498BE915597AEF0B5BBB30=
F4B42@PH0PR11MB5949.namprd11.prod.outlook.com/
> > Reported-by: Ionut Nechita <ionut.nechita@intel.com>
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> > Hi all,
> >=20
> > this is my first try to fix the build error shown in patch 1 that
> > appears when both CONFIG_ACRN_GUEST and CONFIG_KVM_GUEST are active.
> >=20
> > This patch (series) applies to recent dovetail versions only. I tested =
6.11,
> > 6.10 and 6.9. LTS versions (like 6.6, 6.1 and below) would require a
> > backport. The FRED support added in recent version makes a difference
> > here.
>=20
> Dovetail does not support the FRED extension (ATM at least).

Yep, but Linux got support for it, so the code path for recent kernels
is a bit different and this patch does no longer apply. That was what I
tried to express.

>=20
> >=20
> > Feedback welcome...
>=20
> The logic looks fine to me, some nitpicking below:

Thanks for the input!

>=20
> > ---
> >  arch/x86/include/asm/idtentry.h |  9 +++++++++
> >  arch/x86/kernel/irq_pipeline.c  | 19 +++++++++----------
> >  2 files changed, 18 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idt=
entry.h
> > index 524cb93afc34..3107f2cbf7f8 100644
> > --- a/arch/x86/include/asm/idtentry.h
> > +++ b/arch/x86/include/asm/idtentry.h
> > @@ -235,6 +235,12 @@ __visible __noreturn void __##func(struct pt_regs =
*regs)
> >  #define DEFINE_IDTENTRY_SYSVEC_SIMPLE_PIPELINED(vector, func)		\
> >  	DEFINE_IDTENTRY_SYSVEC_PIPELINED(vector, func)
> > =20
> > +extern void (*pipelined_hv_callback_fn)(struct pt_regs *regs);
> > +static inline void pipelined_sysvec_install(int vector, const void
> > *function)
>=20
> s/pipelined_sysvec_install/pipelined_install_sysvec/
>=20
> to align with what seems to be the common naming (e.g. fred_install_sysve=
c).
>=20

Will do in v2. We hook into sysvec_install() so I took that pattern,
but I agree with your suggestion.

> > +{
> > +	if (vector =3D=3D HYPERVISOR_CALLBACK_VECTOR)
> > +		pipelined_hv_callback_fn =3D function;
> > +}
> >  #else  /* !CONFIG_IRQ_PIPELINE */
> > =20
> >  #define DECLARE_IDTENTRY_SYSVEC_PIPELINED(vector, func)		DECLARE_IDTEN=
TRY_SYSVEC(vector, func)
> > @@ -274,6 +280,8 @@ __visible noinstr void func(struct pt_regs *regs,		=
	\
> >  									\
> >  static noinline void __##func(struct pt_regs *regs, u32 vector)
> > =20
> > +#define pipelined_sysvec_install(vector, function)
> > +
> >  #endif	/* !CONFIG_IRQ_PIPELINE */
> > =20
> >  /**
> > @@ -523,6 +531,7 @@ static inline void fred_install_sysvec(unsigned int=
 vector, const idtentry_t fun
> >  #endif
> > =20
> >  #define sysvec_install(vector, function) {				\
> > +        pipelined_sysvec_install(vector, __##function);			\
> >  	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
> >  		fred_install_sysvec(vector, function);			\
> >  	else								\
> > diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipel=
ine.c
> > index 73e97fba55e7..21e40eafd9d5 100644
> > --- a/arch/x86/kernel/irq_pipeline.c
> > +++ b/arch/x86/kernel/irq_pipeline.c
> > @@ -14,6 +14,8 @@
> >  #include <asm/mshyperv.h>
> >  #include <asm/idtentry.h>
> > =20
> > +void (*pipelined_hv_callback_fn)(struct pt_regs *regs) =3D NULL;
> > +
> >  static struct irq_domain *sipic_domain;
> > =20
> >  static void sipic_irq_noop(struct irq_data *data) { }
> > @@ -76,6 +78,12 @@ static void pipeline_exit_rcu(irqentry_state_t state=
)
> >  		ct_irq_exit();
> >  }
> > =20
> > +static void pipeline_hv_callback(struct pt_regs *regs)
> > +{
> > +	if (pipelined_hv_callback_fn)
>=20
> Is there any way we could have no callback set there? We are interposing
> at the earliest possible code spot already, i.e. where vectors are
> installed. So either we do have a vector set when receiving
> HYPERVISOR_CALLBACK_VECTOR, or the arch code did not install any handler
> for that vector in the first place, and we should never receive such
> trap. At any rate, ignoring the event looks wrong.

I was not sure about spurious interrupts. To my understanding they
would reach this point as well. To catch that I just made sure that at
least one HV guest code registered the vector, otherwise we would crash
with a NULL pointer reference.

Do you still want me to remove the check?

But yeah, beside that it's "impossible" that we receive this vector
without a registration.

Florian

>=20
> > +		pipelined_hv_callback_fn(regs);
> > +}
> > +
>=20
> --=20
> Philippe.

