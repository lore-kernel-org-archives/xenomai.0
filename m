Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A261C4A13
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323449; cv=none; b=MZY3H82IY+w14HOaMZ7ESMSssnPhY0tX9wS5MdzMTCFZsEcMyIy0qt8BkGA66QPXX+Ib3aKEtvN7h48IpAFvmccKRbd1ik/FPrhvMGM9olPqJS2cBx1iJysvbHYWLR9IVFw+YNKy56mzOG47WV9p6ofVNnw4vXfI62i2Ult17d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323449; c=relaxed/simple;
	bh=6STxoQTgt1/9CcrWY0USe67WQmys11xnqh7Fud5cK1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a2rh5T7xZh1+nCBkUz6J6hqlB3gfvBxDj2gv9SOVkfqNjdjhb4CUIwwubBWLeaxuJ5BU/xP3UPIfBu6cP+eOv86iKx5YwsKnrKS3IJGPb51OD8u+6J9wkOh9anuc2GorNTK8oMBRwD14blanDR+5yDUOPhviqNQecktVkp9kVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=r2yYumrG; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="r2yYumrG"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202509080923562a782a0d3400020733
        for <xenomai@lists.linux.dev>;
        Mon, 08 Sep 2025 11:23:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=d+M0ZwREp9yqoRz4DC2LzcGC6dJ2X2ikuJbgpIOQdDk=;
 b=r2yYumrGSTrrEp2Wi6RaW9HdxO/ie/ymxZFypGL2ZGdadJ5mMLQf90C4rFiog/OAPbiBOy
 KnuocK3OYo/yw7X5//FeKcv3jZ1UxKq7rcRCAU6MaNybQUXMN+7ASPiu5Fyva4o/s2dkJokj
 VJx8mxj3nsrnNQ/7PomCr5hHHFAHUTGGA62n0RdaxBKCPWySej2Lz4liccTr9+SAPZVsPJ1g
 SoP/P++LWeu/2kt2ZqKqiIrcjipGfMJdb2fDXmCVH6Wo6XaUINBIBzscjgzEFlTLR5jSlksz
 XaxhobE/Hkh/5R6j3ztVKPG5WrFfv5eh0i1aQE3/Y6R/JZ8+Ew4GHFMA==;
Message-ID: <312c039a18f033ee21137ec9af77b7d5a07ddf6a.camel@siemens.com>
Subject: Re: [PATCH Dovetail v2] irq_pipeline: Fix system freeze triggered
 by periodic edge type IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 08 Sep 2025 11:23:56 +0200
In-Reply-To: <18e3f6b4f6f10574fafa5530be7bbeb1347fcfa1.camel@siemens.com>
References: 
	<20250820-wip-flo-fix-edge-irq-handling-v2-1-1a958d17eace@siemens.com>
		 <87ikhwk7y8.fsf@xenomai.org>
	 <18e3f6b4f6f10574fafa5530be7bbeb1347fcfa1.camel@siemens.com>
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

On Fri, 2025-09-05 at 23:54 +0200, Florian Bezdeka wrote:
> On Fri, 2025-09-05 at 21:36 +0200, Philippe Gerum wrote:
> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> >=20
> > > When IRQ pipelining is enabled, it could happen that handle_edge_irq(=
)
> > > is interrupted while syncing the IRQ log - for the very same IRQ.
> > >=20
> > > The pipeline entry code will set the IRQS_PENDING flag and bail out
> > > forcing the sync code (lower part in handle_edge_irq()) to loop to
> > > infinity as the (periodic) IRQ might fire again after calling
> > > unmask_irq() and reaching the hard IRQ enablement in handle_irq_event=
().
> > >=20
> > > There is a "race window" involved. To trigger looping to infinity the
> > > IRQ(s) must arrive while processing the IRQ log for the same IRQ in
> > > handle_irq_event().
> > >=20
> >=20
> > [snip]
> >=20
> > >  kernel/irq/chip.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > > index 8a0831193d74..0fa3dce5b9fd 100644
> > > --- a/kernel/irq/chip.c
> > > +++ b/kernel/irq/chip.c
> > > @@ -669,6 +669,8 @@ static bool irq_can_handle_pm(struct irq_desc *de=
sc)
> > >  		WARN_ON_ONCE(irq_pipeline_debug() && !in_pipeline());
> > >  		if (irqd_is_wakeup_armed(&desc->irq_data))
> > >  			return true;
> > > +		if (irqd_irq_inprogress(&desc->irq_data))
> > > +			return true;
> > >  	} else if (irq_pm_check_wakeup(desc))
> > >  		return false;
> > > =20
> > >=20
> > > ---
> > > base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
> > > change-id: 20250820-wip-flo-fix-edge-irq-handling-16e48193aeac
> > >=20
> >=20
> > Good catch, this bug was obviously no fun to track down.
> >=20
> > The change above raises an issue though: what guarantees us that no har=
d
> > interrupt context for a given IRQ can run on multiple CPUs in parallel,
> > since the interrupt is not going to be masked anymore? The logic above
> > works if all occurrences hit the same CPU because the pipeline
> > introduces the needed serialization by design via the log, but if an
> > interrupt distributor decides to spray multiple occurrences of that
> > interrupt on multiple CPUs, we could be toast.
>=20
> I thought about that as well, but as far as I understood the code at
> least x86 and arm64 enforce a single CPU inside the effective affinity
> mask. So for those archs we would be fine - as long as no IRQ migration
> is in flight. Still unsure about others archs...
>=20
> The live lock situation during IRQ migration can happen on Linux as
> well. There is a fix in flight [1] that will handle that for Linux >=3D
> 6.17.=20
>=20
> Ideas welcome.
>=20
> [1] https://github.com/torvalds/linux/commit/8d39d6ec4db5da98999930922275=
84a97c203fd3

I'm currently testing the following, which is heavily enspired by the
upstream Fix for the IRQ migration issue:

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 45d0ab985068..acb6a580cc7f 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -638,6 +638,27 @@ static inline bool should_feed_pipeline(struct irq_des=
c *desc,
        }
 }
=20
+static bool irq_active_on_this_cpu(struct irq_desc *desc)
+{
+       struct irq_data *data =3D &desc->irq_data;
+       const struct cpumask *aff;
+
+       /* Check if active on any CPU */
+       if (!irqd_irq_inprogress(data))
+               return false;
+
+       /* The below works only for single target interrupts */
+       if (!IS_ENABLED(CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK) ||
+           !irqd_is_single_target(data) || desc->handle_irq !=3D handle_ed=
ge_irq)
+               return false;
+
+       aff =3D irq_data_get_effective_affinity_mask(data);
+       if (cpumask_first(aff) !=3D smp_processor_id())
+               return false;
+
+       return true;
+}
+
 static bool irq_can_handle_pm(struct irq_desc *desc)
 {
        unsigned int mask =3D IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
@@ -668,6 +689,8 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
                WARN_ON_ONCE(irq_pipeline_debug() && !in_pipeline());
                if (irqd_is_wakeup_armed(&desc->irq_data))
                        return true;
+               if (irq_active_on_this_cpu(desc))
+                       return true;

