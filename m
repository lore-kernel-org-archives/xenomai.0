Message-ID: <2ff1a98a0710010729ybda8d61lf5f4baad2ea8b879@domain.hid>
Date: Mon, 1 Oct 2007 16:29:38 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710011343.l91DhGXs001995@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <2ff1a98a0710010610l7c32f6d8j5264ae8b133166e6@domain.hid>
	<200710011343.l91DhGXs001995@domain.hid>
Subject: Re: [Xenomai-core] ARM compiling error
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 10/1/07, Patrick <kpa_info@domain.hid> wrote:
> > -----Message d'origine-----
> > De: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> > Envoy=E9: lundi, 1. octobre 2007 15:11
> > =C0: Patrick
> > Cc: xenomai-core
> > Objet: Re: [Xenomai-core] ARM compiling error
> > > On 10/1/07, Patrick <kpa_info@domain.hid> wrote:
> > > > On 10/1/07, Patrick <kpa_info@domain.hid> wrote:
> > > > >
> > > > > I install Xenomai 2.3.4 for ARM on 2.6.20 kernel. The prepare-ker=
nel
> > > > > script
> > > > > work well.
> > > >
> > > > Which ARM machine ?
> > > > Which version of the ARM patch ?
> > > > From your compilation log, I would say that you are using an I-pipe
> > > > patch which is older than Xenomai v2.3.4, so the general advice is =
to
> > > > use the I-pipe patch which comes with the version of Xenomai you us=
e.
> > >
> > > I use an ARM PXA270 and adeos-ipipe-2.6.20-arm-1.7-05.
> > >
> > > I use the latest stable version of Xenomai (2.3.4) and the latest ver=
sion
> > of
> > > ipipe for ARM (1.7).
> >
> > The I-pipe patch which comes with Xenomai (2.3.4) is
> > adeos-ipipe-2.6.20-arm-1.7-06, you will find it in the
> > ksrc/arch/arm/patches subdirectory of Xenomai sources. If you call
> > prepare-kernel without any argument it will pick the right patch.
> >
> > Please do send your replies to the mailing list.
>
> I have already tried this (with arm-1.7-05 from adeos website and arm-1.7=
-06
> from xenomai/ksrc/arch/arm/patches) but the result is the same.

I have just tried to build Xenomai-2.3.4 for PXA 270 (LogicPD PXA270
Card Engine Development Platform), and it builds flawlessly. So, I
suggest you erase everything, and restart from clean sources, use
I-pipe for ARM version 1.7-06, and nothing else.

--=20
                                               Gilles Chanteperdrix

