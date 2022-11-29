Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1269290B
	for <xenomai@lists.linux.dev>; Tue, 29 Nov 2022 12:48:35 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20221129124827bfea071c2d425e2db0
        for <xenomai@lists.linux.dev>;
        Tue, 29 Nov 2022 13:48:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+vCmKsiyW1z7THgmAUBK/2DyEl6umhROfH4+/tlYhKs=;
 b=ez4b03YbIHxZ5Ono2locgaW9ax/6+uuObqN+nVC0hs0zbX9Qla7UKA5YgULNA3TqPDvm8D
 oqnzIoY3dqMLnmaIrJLHdNdYZnm9aRSrUqFZ1BuBAXSmoOjGfhD1SFRMM8wjGmeHgZi7V14b
 7anx/lsdnfl5YPoDlzzEpDMKKO2SU=;
Message-ID: <ea06df62c8c5458ddce909a10d94492a4e1072e0.camel@siemens.com>
Subject: Re: [ipipe 4.19 5.4][PATCH] ipipe: Fix handling of level triggered
 IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Greg Gallagher <greg@embeddedgreg.com>, Gunter Grau
	 <gunter.grau@philips.com>
Date: Tue, 29 Nov 2022 13:48:26 +0100
In-Reply-To: <94eafc79-3141-1a6c-330f-c7662013ca3f@siemens.com>
References: <20221128120908.1136136-1-florian.bezdeka@siemens.com>
	 <99782966-4c04-7b60-1b29-0986af501f92@siemens.com>
	 <94eafc79-3141-1a6c-330f-c7662013ca3f@siemens.com>
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

On Tue, 2022-11-29 at 07:33 +0100, Jan Kiszka wrote:
> On 29.11.22 07:29, Jan Kiszka wrote:
> > On 28.11.22 13:09, Florian Bezdeka wrote:
> > > Hardware IRQs are enabled here! It might happen that right after
> > > enabling the IRQ at hardware level the IRQ comes in again, even befor=
e
> > > we could fix the software IRQ state flag.
> > >=20
> > > The result was a IRQ storm and system freeze because the same IRQ was
> > > not properly masked at hw level during next IRQ arrival. The software
> > > IRQ flag is checked before going down to the HW level.
> > >=20
> > > Switching to unmask_irq() has two effects:
> > >   - We do not have to care about the software IRQ state flag anymore
> > >   - IRQ state is updated in a hwirq off section together with the hw
> > >     state, so the software state flag and hw state should no longer
> > >     diverge.
> > >=20
> > > Link: https://lore.kernel.org/xenomai/20220210153313.2229625-1-gunter=
.grau@philips.com/
> > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > ---
> > >  kernel/irq/chip.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > > index 41415a5ef7d0..6b34403858aa 100644
> > > --- a/kernel/irq/chip.c
> > > +++ b/kernel/irq/chip.c
> > > @@ -990,8 +990,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
> > > =20
> > >  void __ipipe_end_level_irq(struct irq_desc *desc)
> > >  {
> > > -	desc->irq_data.chip->irq_unmask(&desc->irq_data);
> > > -	irq_state_clr_masked(desc);
> > > +	unmask_irq(desc);
> > >  }
> > > =20
> > >  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
> >=20
> > Ok, this is part of the answer to my other question.
> >=20
> > Can you also document a code path that enters __ipipe_end_level_irq wit=
h
> > hard-irqs on?
> >=20
>=20
> To answer myself: E.g. Linux IRQ handling uses ipipe_end callbacks like
> this, and then obviously without hard IRQs off. I'll augment the patch
> explanation.

Exactly. Who is responsible for applying the patch to all the different
arch trees that we have? If you need a v2 to make the process easier,
just post your adjustments. I will happily take them and send v2.

Florian

>=20
> Jan
>=20

