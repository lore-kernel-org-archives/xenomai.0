Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] Xenomai on Freescale i.MX21 (ARM926J)
Date: Tue, 9 May 2006 16:46:33 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0210DF1@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


Hi Philippe,

Any chance to see our work integrated within an official distribution?

Are you still reviewing the code?

Thanks for your feedback

Daniel

> -----Message d'origine-----
> De=A0: xenomai-core-bounces@domain.hid =
[mailto:xenomai-core-bounces@domain.hid] De
> la part de ROSSIER Daniel
> Envoy=E9=A0: mardi, 25. avril 2006 15:17
> =C0=A0: Philippe Gerum
> Cc=A0: xenomai@xenomai.org
> Objet=A0: RE: [Xenomai-core] Xenomai on Freescale i.MX21 (ARM926J)
>=20
>=20
>=20
> > -----Message d'origine-----
> > De=A0: Philippe Gerum [mailto:rpm@xenomai.org]
> > Envoy=E9=A0: jeudi, 20. avril 2006 15:43
> > =C0=A0: ROSSIER Daniel
> > Cc=A0: xenomai@xenomai.org
> > Objet=A0: Re: [Xenomai-core] Xenomai on Freescale i.MX21 (ARM926J)
> >
> > ROSSIER Daniel wrote:
> > >
> > > Dear all,
> > >
> > > We finally succeeded in the port of Xenomai on our Freescale =
i.MX21
> > board (ARM-926J);
> > > (The board used is the CSB535FS issued from Cogent with the BSP =
from
> > Microcross)
> > >
> > > To have further technical references, please see there:
> >
> =
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3Di.MX_LIT=
EKI
> > T&parentCode=3Di.MX21&nodeId=3D0162468rH31143ZrDR
> > >
> > > So, you will find two patches: the first one (patch-linux-
> > 2.6.14.imx21_1.0.0) is used to patch the Linux 2.6.14 for supporting =
the
> > board. Then, the second one =
(adeos-ipipe-2.6.14-arm-imx21-0.1.00.patch)
> > can be used against the imx21-enabled kernel for Xenomai, simply =
using
> the
> > prepare-kernel.sh script. The patch was originally inspired from the
> > Integrator/ARM11 patch; thanks to its author :-)
> > >
> > > We will publish soon some results regarding the different =
latencies,
> but
> > so far we measured about 2us between the IRQ and the timer =
reprogramming
> > (at the ipipe level). The problem now is the jitter which is pretty
> high:
> > about 1-2us, with some occasional peaks up to 5us.
> > > Having quite a few experience with this kind of board, we don't =
know
> if
> > it comes from the code itself, or purely from the hardware. Any
> > idea/suggestions would be welcome. For periodic tasks around 20us,
> > everything works perfecly.
> > >
> >
> > Those results are pretty impressive actually. Assuming that you =
compare
> > those figures with those obtained from traditional standalone RTOS =
e.g.
> > VxWorks on the same board, the critical difference with Xenomai is =
that
> > Linux is competing for the hw resources, and for instance, happily
> > trashes the cache under Xenomai's feet when scheduling its own tasks
> > during Xeno's idle time. Additionally, Adeos adds a small overhead =
due
> > to the interrupt virtualization, in exchange of real-time =
predictability
> > for their delivery. Therefore, in this respect, 5 us does not look =
that
> > bad already.
> >
> > Are 20 us a measure of the worst-case interrupt latency (i.e. =
running
> > latency -t2), or scheduling latency in user-space (i.e. running =
latency
> > -t0)?
> >
>=20
> No, I think we can go lower; the measure we actually got between the =
IRQ
> and the timer reprogramming is about 2 us with some jitters up to 5 =
us; we
> could
> normally guarantee not to exceed 5 us between the IRQ and timer
> reprogramming. Now, considering the ISR itself, we could get some time
> under 10us provided that the ISR remains short.
>=20
> So far, we measured the reaction time with the oscillo; we are now =
about
> to check the latencies with the latency utility from Xenomai.
>=20
> > > I don't know to what extent this (1 or 2) patch(es) can be =
integrated
> in
> > the official distribution;
> > but of course we are willing to make any adaptations to fulfill the
> > requirements for that.
> >
> > For the technical part, I guess that anyone interested in the ARM
> > support for Adeos/Xenomai will review this code; I'll be one of =
these
> > people, for sure. The usefulness of such contribution looks obvious =
to
> me.
> >
> > For the non-technical part, a pre-requisite for adding code to the =
Adeos
> > or Xenomai codebases is to properly identify it as coming from a
> > legitimate source, so if you, as a submitter, can confirm that you =
may
> > freely contribute it on behalf of the HEIG-VD (I guess?) or =
yourself,
> > that's fine with us. Btw, at first glance, I did not find any =
additional
> > GPL copyrights coming with your changes in the patches, it would be
> > better to have them, so that we always know who contributed to what, =
as
> > much as possible.
>=20
> Yes, it's ok. HEIG-VD is the University of Applied Sciences of Western
> Switzerland in Yverdon (http://www.heig-vd.ch) and I'm working at
> the REDS Institute (http://reds.eivd.ch, unfortunately in French only =
at
> the moment). We are granted to publish our work, at least
> all part which are not directly bound to some industrial projects (I'm
> trying to keep the stuff as open and public as possible ;-).
>=20
> >
> > >
> > > It's a first step; I hope it will help some other ARM9 developers =
and
> > look forward to reading some feedbacks.
> > >
> > > I profit to thank a lot the Xenomai team (Philippe, Jan, Gilles =
and
> the
> > others) for their excellent work and support).
> > >
> >
> > Xenomai exists because people participate in the Sisyphean task of
> > making it better, like you just did. In other words, welcome to the
> > band. Let's roll the rock.
> >
>=20
> Cool.
>=20
> > > Kind regards
> > >
> > > Daniel
> > >
> > >
> > >
> > > =
----------------------------------------------------------------------
> --
> > >
> > > _______________________________________________
> > > Xenomai-core mailing list
> > > Xenomai-core@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-core
> >
> >
> > --
> >
> > Philippe.
>=20
> Daniel
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

