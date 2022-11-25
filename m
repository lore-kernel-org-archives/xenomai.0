Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E32CA4
	for <xenomai@lists.linux.dev>; Fri, 25 Nov 2022 11:11:18 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2022112511111025392784608cae283c
        for <xenomai@lists.linux.dev>;
        Fri, 25 Nov 2022 12:11:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Q8/U4viouZi+m1S32XNo81wDOEyN7awH3ZfUltqoTWo=;
 b=KcHbs5QA38qBV8Kmmrc/GZ1R+wTsEdnD6hf14oLFIFqAZbBMx+OHbFwDR3bcDQFgQe+hMQ
 K4NoEezrK8AQC4tWpENAZkHaGc8+Bt/6ERov9sj5qHql4sd3WR0UP5CU39yr6+S9qdbSlNpw
 rnoMJyfHy8h13UJ7IroV15I+AcZRc=;
Message-ID: <294c591ac3625f88218e09da23a9fd144440afb3.camel@siemens.com>
Subject: Re: [ipipe 4.19][RFC PATCH] ipipe: Do not report spurious
 interrupts by using printk
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 25 Nov 2022 12:11:08 +0100
In-Reply-To: <8e95dbd6-b120-11a0-8c30-ce4f29b1ec84@siemens.com>
References: <20221125090834.617271-1-florian.bezdeka@siemens.com>
	 <8e95dbd6-b120-11a0-8c30-ce4f29b1ec84@siemens.com>
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

On Fri, 2022-11-25 at 11:53 +0100, Jan Kiszka wrote:
> On 25.11.22 10:08, Florian Bezdeka wrote:
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >=20
> > Hi all,
> >=20
> > I need this patch to get the Hikey board (part of the Xenomai CI lab) u=
p
> > and running. The problem appeared when updating the test images from
> > Debian 11 to Debian 12 and with that from gcc 10 to gcc 12.
> >=20
> > My understanding is:
> >  - During boot a UART hangup occurs, so we release the IRQ
> >  - While that happens there is still on IRQ in flight on a different CP=
U
> >  - The in-flight IRQ is detected as spurious interrupt
> >  - We try to report that using printk()
> >=20
> > printk() internally calls ipipe_unstall_root() - by using one of the=
=20
> > _irqrestore() macros/functions - which unconditionally calls=20
> > hard_local_irq_enable() so HW IRQs are enabled now.
> >=20
> > I end up in an IRQ stack overflow.
> >=20
> > I assume this happens because the UART IRQ is a level-triggered IRQ. So
> > it simply fires again.
> >=20
> > Does that make sense?
> >=20
> > How to fix that properly? Ideas welcome...
> >=20
> > The problem can be reproduced on the hikey board quite well. Nearly
> > every boot ends up in the IRQ stack overflow.
> >=20
> > Best regards,
> > Florian
> > =20
> >=20
> >  kernel/ipipe/core.c | 2 +-
> >  kernel/irq/handle.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
> > index d12e71103424..17ad6f2841f9 100644
> > --- a/kernel/ipipe/core.c
> > +++ b/kernel/ipipe/core.c
> > @@ -1491,7 +1491,7 @@ void __ipipe_dispatch_irq(unsigned int irq, int f=
lags) /* hw interrupts off */
> > =20
> >  #ifdef CONFIG_IPIPE_DEBUG
> >  	if (irq >=3D IPIPE_NR_IRQS) {
> > -		pr_err("I-pipe: spurious interrupt %u\n", irq);
> > +		//pr_err("I-pipe: spurious interrupt %u\n", irq);
> >  		return;
> >  	}
> >  #endif
> > diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> > index e2f7afcb1ae6..1c3221c72977 100644
> > --- a/kernel/irq/handle.c
> > +++ b/kernel/irq/handle.c
> > @@ -32,7 +32,7 @@ void handle_bad_irq(struct irq_desc *desc)
> >  {
> >  	unsigned int irq =3D irq_desc_get_irq(desc);
> > =20
> > -	print_irq_desc(irq, desc);
> > +	//print_irq_desc(irq, desc);
> >  	kstat_incr_irqs_this_cpu(desc);
> >  	ack_bad_irq(irq);
> >  }
>=20
> Is this issue 4.19-specific, resolved in 5.4? Or in dovetail?

The affected code looks the same in 4.19 and 5.4 but it never triggered
on 5.4 (AFAICT).=C2=A0

I compared the UART drivers between this versions and there was one
noticeable difference. A patch will follow as this difference
fixed/introduced a bug (UART hang), but it has no effect on this one
(irq stack overflow).=20

>=20
> Jan
>=20

