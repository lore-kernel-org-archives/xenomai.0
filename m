Message-ID: <45420A72.8000700@domain.hid>
Date: Fri, 27 Oct 2006 15:32:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] enable/disable all interrupts from user space
References: <200610261639.36013.jweber@domain.hid>
In-Reply-To: <200610261639.36013.jweber@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD367A4712F77445B4EBFBB4B"
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD367A4712F77445B4EBFBB4B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Weber wrote:
> How do I enable/disable all interrupts (Linux and Xenomai) from user sp=
ace? =20
> (native skin preferred)

For x86:

iopl(3);
__asm__ __volatile__("cli/sti");

Ugly hack, typical a sign that something should be moved somewhere
else... (there are a few exceptions, though)

We once had some discussion if we shouldn't export domain stalling
features to user-space in order to support things like X-servers that
currently come with such code, toasting any RT kernel. May come one day,
but this will be primarily for legacy non-RT code.

Jan


--------------enigD367A4712F77445B4EBFBB4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFQgpyniDOoMHTA+kRAh+fAJ9EIH4iQdgSMeHS9pjpbM1vKlHrSQCffo4L
TVQHUVXvwrTl5tlcbe/8neE=
=2xUg
-----END PGP SIGNATURE-----

--------------enigD367A4712F77445B4EBFBB4B--

