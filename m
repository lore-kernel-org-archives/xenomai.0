Message-ID: <47AF057A.3070305@domain.hid>
Date: Sun, 10 Feb 2008 15:08:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18350.7135.108901.491437@domain.hid>
	<18350.7315.555644.171720@domain.hid>
In-Reply-To: <18350.7315.555644.171720@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig78E518D49DE772B62D64C95B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [patch 2/4] RTDM support for select-like service.
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig78E518D49DE772B62D64C95B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> stats:
>  include/rtdm/rtdm.h        |    4 ++
>  include/rtdm/rtdm_driver.h |   30 +++++++++++++++-
>  ksrc/skins/rtdm/core.c     |   84 +++++++++++++++++++++++++++++++-----=
---------
>  ksrc/skins/rtdm/device.c   |   10 +++++
>  ksrc/skins/rtdm/drvlib.c   |   76 ++++++++++++++++++++++++++++++++++++=
----
>  5 files changed, 170 insertions(+), 34 deletions(-)
>=20

/me thinks that going for inline patches on this list is overdue...

> @@ -1148,8 +1208,8 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem,=20
> =20
>  	if (testbits(sem->synch_base.status, RTDM_SYNCH_DELETED))
>  		err =3D -EIDRM;
> -	else if (sem->value > 0)
> -		sem->value--;
> +	else if (sem->value > 0 && !--sem->value)
> +			xnselect_signal(&sem->select_block, 0);
>  	else if (timeout < 0) /* non-blocking mode */
>  		err =3D -EWOULDBLOCK;
>  	else {

Uuuh, this doesn't look equivalent (for --sem->value < 0).

Otherwise it's OK with me.

Jan


--------------enig78E518D49DE772B62D64C95B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD4DBQFHrwWEniDOoMHTA+kRAkmEAJ9xxONVcP1RN+bJYvw6aw9AZt2hmACXVoWN
rklxBeLxg7kn0zGbEeikvg==
=A5gz
-----END PGP SIGNATURE-----

--------------enig78E518D49DE772B62D64C95B--

