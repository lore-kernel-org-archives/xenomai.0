Message-ID: <4D89A286.5060707@domain.hid>
Date: Wed, 23 Mar 2011 08:34:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=LM5LNr1mT-f3xY-w-ATzRNPZX3hPVsFpG=TnC@mail.gmail.com>
In-Reply-To: <AANLkTi=LM5LNr1mT-f3xY-w-ATzRNPZX3hPVsFpG=TnC@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB288AFC25D44F54AEECE2977"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] CLOCK_REALTIME synchronized to NTP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB288AFC25D44F54AEECE2977
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-03-23 01:59, Jeff Weber wrote:
> I need to timetag events from a realtime context with a NPT-synchronize=
d
> system clock.  This topic comes up periodically on the mailing list.  L=
ast I
> recall, there was talk of adding the capability via an alternate
> (non-CLOCK_REALTIME) clock_id. What is the status of this topic?
>=20

The special POSIX clock CLOCK_HOST_REALTIME is part of xenomai head (2.6
development tree), ipipe back-end support is available for x86 so far.
That clock allows to read the Linux CLOCK_REALTIME without leaving the
RT context.

Jan


--------------enigB288AFC25D44F54AEECE2977
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk2JooYACgkQitSsb3rl5xQeVACguP/1RaqMHjoTukmb/wxAUj6b
HPkAoLFLXaQvbyGvyd6YV60iZTv2YMvG
=cn9e
-----END PGP SIGNATURE-----

--------------enigB288AFC25D44F54AEECE2977--

