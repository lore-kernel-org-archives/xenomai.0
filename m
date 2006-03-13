Message-ID: <4415B8C2.6000806@domain.hid>
Date: Mon, 13 Mar 2006 19:24:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>	<200603131154.13627.lbocseg@domain.hid>	<200603131415.49256.lbocseg@domain.hid>
	<200603131458.09074.lbocseg@domain.hid>
In-Reply-To: <200603131458.09074.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig48F4E7DD7E40761373DE6910"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig48F4E7DD7E40761373DE6910
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Sorry Jan, I was looking at a different documentation. Now I read the r=
ight=20
> one. It is good. But I didn't understand why didn't you keep the latter=
 note:=20
> "The nucleus timer has to be started to obtain valid results." I would =

> include it before the other note.
>=20

Well, it's no longer relevant for Xenomai: you can't load a driver
without the timer being started - loading xeno_rtdm will do this.

On the other hand, you are right when considering RTAI where you still
face this obstacle. I will re-introduce the note below, but the strategy
will remain that it's up to the user (application) to resolve this.

"The system timer has to be started to obtain valid results. If this
happens automatically or is controlled by the application depends on the
RTDM host environment, see related documentation of the real-time Linux
extension."

Jan


--------------enig48F4E7DD7E40761373DE6910
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFbjCniDOoMHTA+kRAnh9AJsG57kIHW41WOPSyMCPK/Bz1nMM3ACfdKzq
4Kx967aOfNR7knDo5/jBblE=
=Hd4K
-----END PGP SIGNATURE-----

--------------enig48F4E7DD7E40761373DE6910--

