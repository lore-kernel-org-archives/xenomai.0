Message-ID: <44100E57.6010506@domain.hid>
Date: Thu, 09 Mar 2006 12:15:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Error on rtdm skin with --enable-dox-doc
References: <200603081421.10284.lbocseg@domain.hid>	<440F15C9.1020509@domain.hid>	<17423.8047.793660.826276@domain.hid>	<440F2973.6000408@domain.hid>
	<17423.19362.464622.738321@domain.hid>
In-Reply-To: <17423.19362.464622.738321@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0E654E77404777CA1A83ACAE"
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
--------------enig0E654E77404777CA1A83ACAE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > Rodrigo Rosenfeld Rosas wrote:
>  > >  > > Hi Jan,
>  > >  > >=20
>  > >  > > When compiling svn xenomai I noticed the following error with=
 --enable-dox-doc=20
>  > >  > > switch:
>  > >  > >=20
>  > >  > > CC [M]  kernel/xenomai/skins/rtdm/drvlib.o
>  > >  > > kernel/xenomai/skins/rtdm/drvlib.c:1513:1: error: unterminate=
d #ifdef
>  > >  > >=20
>  > >  >=20
>  > >  > I just passed this stage with trunk revision 671 without proble=
ms
>  > >  > (doxygen 1.4.4). Moreover, there is no #ifdef or related prepro=
cessor
>  > >  > stuff in the latest drvlib.c at line 1513.
>  > >=20
>  > > I have a few warnings with doxygen 1.4.2:
>  > >=20
>  > > ksrc/skins/rtdm/drvlib.c:151: Warning: Member rtdm_task_destroy fo=
und in multiple @defgroup groups! The member will be put in group rtdmtas=
k, and not in group rtdmtask
>  >=20
>  > That's totally weird: "You are in rtdmtask, and not in rtdmtask!?" E=
ven
>  > more confusing, there is only a single "@defgroup rtdmtask" in the c=
ode.
>  >=20
>  > I think I said this before: doxygen's error reporting sucks! I'm not=

>  > excluding that something is broken here, but I don't know where to l=
ook.
>  > Could anyone of you try some older revisions of drvlib.c and
>  > rtdm.h/rtdm_driver.h to check where the regression(?) may come from?=

>=20
> I have just checked, the error appears with revision 121, an old
> one. EXPORT_SYMBOL may be the culprit, again...
>=20

It seems so. Doxygen 1.4.6, e.g., is messing up the RTDM groups.

I just played with a few workarounds, this one here seems to have the
effect we need:

PREDEFINED             =3D DOXYGEN_CPP \
        "EXPORT_SYMBOL(symbol)=3Dstruct {}"

Alternatively, I could move EXPORT_SYMBOL in drvlib.c out of all doxygen
groups, giving up the locality of function definition and symbol export
again. :(

Jan


--------------enig0E654E77404777CA1A83ACAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEEA5XniDOoMHTA+kRAlI1AJ9WG5FuXI6gxI2jPGDu4en372zPsQCfQOT7
IZrnEMWUJ1e+XOgoP8qpfO0=
=Stqv
-----END PGP SIGNATURE-----

--------------enig0E654E77404777CA1A83ACAE--

