Message-ID: <482A831C.6000801@domain.hid>
Date: Wed, 14 May 2008 08:13:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid>	<A3B06EAFE0D9C14096681C935E0B300802110F22@domain.hid>
	<4829A948.6080806@domain.hid>
In-Reply-To: <4829A948.6080806@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD592717EDF4B4E6B94260002"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] gdb + multi-threaded application + Intel dual
 core	processor + Xenomai => frozen system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Kaeppeler, Oliver" <Oliver.Kaeppeler@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD592717EDF4B4E6B94260002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Kaeppeler, Oliver wrote:
>> Hello Jan,
>>
>> thanks for your answer. We had used Xenomai 2.4.3 in our tests. Now, I=
 also tried the daily snapshot version, but the problem remains.
>>
>> The problem should be reproducable by the sample program, we attached =
in our last message...
>=20
> OK, will give this a try later today.

Done, but so far without success, even with your .config. Are you sure
that you booted the right kernel after the update (and that the update
actually contained the fix)?

Jan


--------------enigD592717EDF4B4E6B94260002
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIKoMmniDOoMHTA+kRAv7gAJ0Y2Qv0Cqmz+eDEqYrK0PMONPMtAACfYr65
HgrCuJYNgVBkAfWeu0T4wqE=
=B949
-----END PGP SIGNATURE-----

--------------enigD592717EDF4B4E6B94260002--

