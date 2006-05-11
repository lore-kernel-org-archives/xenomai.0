Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] Xenomai on Freescale i.MX21 (ARM926J)
Date: Thu, 11 May 2006 17:10:14 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E04A43A5@domain.hid>
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

> -----Message d'origine-----
> De=A0: Philippe Gerum [mailto:rpm@xenomai.org]
> Envoy=E9=A0: jeudi, 11. mai 2006 15:50
> =C0=A0: ROSSIER Daniel
> Cc=A0: xenomai@xenomai.org
> Objet=A0: Re: [Xenomai-core] Xenomai on Freescale i.MX21 (ARM926J)
>=20
>=20
> Hi,
>=20
> I recently worked on the integration of the i.MX21 support into the
> Adeos codebase. The basic idea is to reduce the amount of
> platform-specific code in your original patch, so that changes =
happening
> in the generic Adeos core will be immediately available to the =
Freescale
> platform too. Since the core i.MX21 support is not mainline yet =
AFAICS,
> we will have to deal with three patches instead of one, all to be
> applied against 2.6.14 vanilla, in this order:
>=20
> - The patch called patch-linux-2.6.14.imx21_1.0.0 you posted to this
> list, providing the i.MX21 core bits for the Linux kernel.
> - the vanilla Adeos patch for 2.6.14 over ARM [1]
> - the attached patch completing the i.MX21 support for Adeos.

Great. I guess it's the best way to do before Microcross publishes =
everything in the main line.

>=20
> What remains:
> - the "idle=3Dpoll" bootparam, for using a busy loop in the idle task,
> instead of the default idle method.
> - some cleanups in a few areas of the 3rd patch, which still emits
> various warnings (gcc 3.4.1). Some of them may not be that innocuous, =
so
> they deserves to be fixed, I think.

Ok. We will work on these two points and provide you with a new patch.

>=20
> When time allows, I'd like you try rebuilding a complete kernel using
> the patch list above, and let me know if your i.MX21 board still runs
> with it. From that point, we should be able to refine the Adeos =
support
> for this platform, enough to bundle it with Xeno.
>=20
> [1]
> =
http://download.gna.org/adeos/patches/v2.6/arm/adeos-ipipe-2.6.14-arm-1.3=
-
> 02.patch
>=20
>=20
> --
>=20
> Philippe.

