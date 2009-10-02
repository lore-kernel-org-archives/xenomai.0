Message-ID: <4AC62804.7090903@domain.hid>
Date: Fri, 02 Oct 2009 18:19:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AC61F57.2010404@domain.hid>
In-Reply-To: <4AC61F57.2010404@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig85732CD259AB04FAE0A05456"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTDM fd support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85732CD259AB04FAE0A05456
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi Jan,
>=20
> from discussions on the mailing list, it seems that we are going to nee=
d
> that unified file descriptors thing. However, since everybody wants
> 2.5.0 to be released ASAP, we should try to think about any changes for=

> this support which would break the ABI, do them now, and keep the rest
> for later.
>=20
> One such problem is the translation which currently exists between rtdm=

> file descriptors and descriptors passed to the posix skin, by adding
> 1024 - 128. So, I propose to fix this issue.
>=20
> The idea Philippe had, and which I tend to agree to, was, in case of
> open/socket/accept, to open("/dev/null"), and use an association table
> somewhere to associate with the kernel-space descriptor number. Since
> we are at it, this association table could in fact be the file
> descriptor table, which we would put in the core skin ppd. The actual
> data structure should be sparse, a linked list does not scale, so,
> probably a hash would do. (I could also propose a solution based on avl=

> trees, but their implementation is not nearly as simple).
>=20
> Additionnally, this would allow our open/socket to conform to posix
> which states that open should return the lowest free file descriptor.
>=20
> Should I propose a patch in that direction? Do you see any other
> possible cause of ABI breakage when we migrate to an unified file
> descriptors structure?

Right now this sounds like a plan - but I don't feel 100% comfortable to
predict that we will get along with it. Converting some skin-specific
service to a generic one involves quite a lot of refactoring. It is not
really unlikely that we define some ABI now that will later turn out to
be insufficient for what we want to achieve.

The only way around this is to implement at least a prototype. That
takes some time. And until this isn't done, we cannot release 2.5. Or we
have to set this limitation in stone and live with it until 3.x does it
correctly.

Jan


--------------enig85732CD259AB04FAE0A05456
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrGKAgACgkQitSsb3rl5xQSzQCff0O65lV8Ca1Ln+9ZvcKbAz7w
H0MAnRuL8Wq95dl1wahInOV5QmY5PuoT
=vvTs
-----END PGP SIGNATURE-----

--------------enig85732CD259AB04FAE0A05456--

