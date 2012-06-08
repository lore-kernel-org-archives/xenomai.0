From: Chris Stone <chris.stone@optelian.com>
Date: Fri, 8 Jun 2012 15:18:35 +0000
Message-ID: <623784B6C75D274389918D358E89E8BB0B7FF2B2@OPTELIAN5.optelian.local>
References: <623784B6C75D274389918D358E89E8BB0B7FF136@OPTELIAN5.optelian.local>
	<4FD1A689.8050107@xenomai.org>
	<623784B6C75D274389918D358E89E8BB0B7FF282@OPTELIAN5.optelian.local>
	<4FD216BD.3080409@xenomai.org>
In-Reply-To: <4FD216BD.3080409@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] GPIO irq handler on powerpc.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am not using a 3.2.x kernel. It was not a vendor specific tree, but
a mainline 3.0.13 kernel.=20

Cheers,
    Chris.

> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Friday, June 08, 2012 11:14 AM
> To: Chris Stone
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] GPIO irq handler on powerpc.
>=20
> On 06/08/2012 04:50 PM, Chris Stone wrote:
>=20
> > There was a call to generic_handle_irq that should have been calling
> > ipipe_handle_chained_irq so I have a fix for the problem. Here is a
> > diff:
> >
> > diff -r 0f7a4ec77dc0 arch/powerpc/sysdev/mpc8xxx_gpio.c
> > --- a/arch/powerpc/sysdev/mpc8xxx_gpio.c        Mon Jun 04 11:04:14
> 2012 -0400
> > +++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c        Fri Jun 08 10:39:40
> 2012 -0400
> > @@ -151,7 +151,7 @@
> >
> >          mask =3D in_be32(mm->regs + GPIO_IER)&  in_be32(mm->regs +
> GPIO_IMR);
> >          if (mask)
> > -               generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq,
> > +
> > + ipipe_handle_chained_irq(irq_linear_revmap(mpc8xxx_gc->irq,
> >                                                       32 -
> ffs(mask)));
> >   }
> >
> > I did not see this in the core-3.2 branch of the ipipe git, so you
> may
> > need to merge this in. Let me know if I should be providing this fix
> in another form.
> >
>=20
> This won't apply to a mainline 3.2.x kernel. Are these bits part of a
> vendor-specific tree?
>=20
> --
> Philippe.

