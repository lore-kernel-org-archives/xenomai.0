Message-ID: <447F3ABE.9000708@domain.hid>
Date: Thu, 01 Jun 2006 21:06:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xnpod help
References: <39142.155.98.4.39.1149186052.squirrel@domain.hid>
In-Reply-To: <39142.155.98.4.39.1149186052.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD6B11C14F1BB2F90A471DA5E"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6B11C14F1BB2F90A471DA5E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Brandt Erickson wrote:
> Hey,
> I'm trying to write a simple looping module to test out xenomai nucleus=

> usage.  The problem is, when I insert the module (code attached), only =
the
> printks from the initialization function ever get displayed and none fr=
om
> the indefinite loop.  All the pod startup functions return success, so =
is
> the thread working and just not successfully sending the messages out o=
r
> is the thread not starting up at all?  Could someone tell me if I'm usi=
ng
> the xenomai nucleus correctly?  Thanks.

Have a look at other skins and their prologue/epilogue. RTDM is a fairly
simple skin e.g.

This is lacking in your case for init and may explain your problems
(unless some skin is already attached - but it's still required for
consistency):

#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
    /* The RTDM skin is stacked over the Xenomai pod. */
    err =3D xncore_attach();
#else /* !(__KERNEL__ && CONFIG_XENO_OPT_PERVASIVE) */
    /* The RTDM skin is standalone. */
    err =3D xnpod_init(&__rtdm_pod, XNCORE_LOW_PRIO, XNCORE_HIGH_PRIO,
XNREUSE);
#endif /* __KERNEL__ && CONFIG_XENO_OPT_PERVASIVE */

Jan


--------------enigD6B11C14F1BB2F90A471DA5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEfzq+niDOoMHTA+kRApWQAJ4hnQMtyRhida0Rg7mi+/fd5PWpJgCfXnX/
6fLVC8K3Wo89W8+cWPOvcpI=
=RgU0
-----END PGP SIGNATURE-----

--------------enigD6B11C14F1BB2F90A471DA5E--

