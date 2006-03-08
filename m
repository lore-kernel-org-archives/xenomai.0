Message-ID: <440F2973.6000408@domain.hid>
Date: Wed, 08 Mar 2006 19:58:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Error on rtdm skin with --enable-dox-doc
References: <200603081421.10284.lbocseg@domain.hid>	<440F15C9.1020509@domain.hid>
	<17423.8047.793660.826276@domain.hid>
In-Reply-To: <17423.8047.793660.826276@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig59C17C259144B37CCD074382"
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
--------------enig59C17C259144B37CCD074382
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Rodrigo Rosenfeld Rosas wrote:
>  > > Hi Jan,
>  > >=20
>  > > When compiling svn xenomai I noticed the following error with --en=
able-dox-doc=20
>  > > switch:
>  > >=20
>  > > CC [M]  kernel/xenomai/skins/rtdm/drvlib.o
>  > > kernel/xenomai/skins/rtdm/drvlib.c:1513:1: error: unterminated #if=
def
>  > >=20
>  >=20
>  > I just passed this stage with trunk revision 671 without problems
>  > (doxygen 1.4.4). Moreover, there is no #ifdef or related preprocesso=
r
>  > stuff in the latest drvlib.c at line 1513.
>=20
> I have a few warnings with doxygen 1.4.2:
>=20
> ksrc/skins/rtdm/drvlib.c:151: Warning: Member rtdm_task_destroy found i=
n multiple @defgroup groups! The member will be put in group rtdmtask, an=
d not in group rtdmtask

That's totally weird: "You are in rtdmtask, and not in rtdmtask!?" Even
more confusing, there is only a single "@defgroup rtdmtask" in the code.

I think I said this before: doxygen's error reporting sucks! I'm not
excluding that something is broken here, but I don't know where to look.
Could anyone of you try some older revisions of drvlib.c and
rtdm.h/rtdm_driver.h to check where the regression(?) may come from?

Jan


--------------enig59C17C259144B37CCD074382
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEDylzniDOoMHTA+kRArhNAJ4ivX7JwRPAXZGQF6LNyGhWu8I0pACfSUvF
F99jSNixE89qncOB6tQ+2FI=
=gi81
-----END PGP SIGNATURE-----

--------------enig59C17C259144B37CCD074382--

