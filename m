Message-ID: <47AF077A.9070602@domain.hid>
Date: Sun, 10 Feb 2008 15:17:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18350.7135.108901.491437@domain.hid>
In-Reply-To: <18350.7135.108901.491437@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCF4FAE78B8D01BC5AADF637B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [patch 0/4] Support for select-like services.
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
--------------enigCF4FAE78B8D01BC5AADF637B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> here comes a third edition of the patchset adding support for select.=20
>=20
> The core support now depends on a CONFIG_XENO_OPT_SELECT option, wherea=
s the
> posix support depends on a CONFIG_XENO_OPT_POSIX_SELECT option.
>=20
> The support for using rtdm_event_t and rtdm_sem_t objects is now built-=
in to
> these objects without creating new objects types (only if
> CONFIG_XENO_OPT_SELECT is enabled).
>=20
> The rtdm_context_get modification, allowing to check that the caller of=
 a service
> belongs to the same process as the file descriptor it uses, is now made=
 in
> __rtdm_context_get while rtdm_context_get passes a NULL first argument =
to this
> new service.
>=20
> When implementing these modifications, a few questions arise:
> - RTDM support currently depends on the CONFIG_XENO_OPT_SELECT option, =
should we
> add an RTDM specific option ?

IIRC, the policy is so far that the skin selects the nucleus features it
wants/needs, so we may better add the visible switch to RTDM as well.

> - in order to avoid numerous #ifdefs, and especially in drivers code, t=
he new
> callback added to device operations for binding RTDM file descriptors t=
o
> selector blocks is always there even if CONFIG_XENO_OPT_SELECT is disab=
led. Is
> it the right thing to do ?

That's ok, otherwise ifdef'ery would crawl into the drivers as well.
Given the conversion you posted for RTnet, we don't add noticeable bloat
this way.

Jan


--------------enigCF4FAE78B8D01BC5AADF637B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHrwd6niDOoMHTA+kRAucDAJ9z7HvVeVtx4yxhTakGtJj5bSdEzACdGclh
eYYKzxthUtn4VQWD6WqpYzo=
=bsTC
-----END PGP SIGNATURE-----

--------------enigCF4FAE78B8D01BC5AADF637B--

