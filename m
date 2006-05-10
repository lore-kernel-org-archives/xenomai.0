Message-ID: <4461FED6.9010603@domain.hid>
Date: Wed, 10 May 2006 16:55:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] lock-up by failing rt_task_spawn/create
References: <4460FC50.6030904@domain.hid>	<17504.65186.650064.785243@domain.hid>	<44610180.30206@domain.hid>
	<17505.60475.312706.601248@domain.hid>
In-Reply-To: <17505.60475.312706.601248@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1438724309FB862D13BED9A5"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1438724309FB862D13BED9A5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > BTW, this reminds me the ask for a merging plan of the kgdb sup=
port for
>  > >  > ipipe - this bug was tracked down via kgdb...
>  > >=20
>  > > There are some issues with the kgdb patch:
>  > > - it does not work if the nucleus is compiled as a module, because=
 it
>  > >   uses xnpod_current_thread()
>  >=20
>  > I know, but I do not have a clean solution for this yet. A workaroun=
d
>  > would be to force the nucleus into the kernel via kconfig if the kgd=
b is
>  > enabled. Any other ideas how to detect kernel-only threads (i.e. inv=
alid
>  > "current")?
>=20
> If we suppose that the kgdb patch is made adeos aware, could we ask a
> domain-specific callback to be called when not running the root domain =
?
> This callback would be set by Xenomai in an #ifdef CONFIG_KGDB section.=


Sounds good, will try this.

>=20
>  >=20
>  > > - it does not work on SMP because the kgdb patch uses
>  > >   smp_processor_id(), which does not work on SMP over Xenomai doma=
in.
>  > >=20
>  >=20
>  > Ok, but probably fixable. If simple search&replace in the kgdb patch=
 is
>  > not enough, a similar workaround could be applied for now: disallow =
kgdb
>  > usage over SMP.
>=20
> Since we are going to have this problem over and over again for each
> patch that we want to adapt to xenomai (ltt comes to my mind), maybe we=

> could make smp_processor_id() in adeos patch safe to be called over non=

> root domain by using ipipe_processor_id() when called over non-root
> domains.
>=20
> I think there is currently no code that take advantage of the fact that=

> the fast smp_processor_id() may safely be called over shadow threads, s=
o
> the performance penalty of using ipipe_processor_id() will be minimal.
>=20

What about the potential penalty for normal Linux callers of
smp_processor_id()? Would this degrade the overall performance
noticeably even if there is now kgdb or ltt? Or should we make this
"ipipe-safe" smp_processor_id() optional for such users?

Jan


--------------enig1438724309FB862D13BED9A5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEYf7WniDOoMHTA+kRApF6AJ9yJ4R7KKbfyu+BLAxlvNPWd/Re9wCfW7xH
jiJGyBMDk06c8Wh66VCJwis=
=iHdX
-----END PGP SIGNATURE-----

--------------enig1438724309FB862D13BED9A5--

