Message-ID: <44E5B93F.40603@domain.hid>
Date: Fri, 18 Aug 2006 14:57:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] speed up building of posix apps
References: <44E5ACFA.50905@domain.hid> <1155904681.4326.67.camel@domain.hid>
In-Reply-To: <1155904681.4326.67.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF8E4ECDD9E8E50C7DF0B5969"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF8E4ECDD9E8E50C7DF0B5969
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2006-08-18 at 14:05 +0200, Jan Kiszka wrote:
>=20
>> PS: What about the silence-libtool patch? I've heard neither ack nor
>> nack so far.
>=20
> Still pondering the libtool --module issue.
>=20

Try a grep -r shouldnotlink `find /usr/lib/ -name "*.la"` to get an
impression what kind of libraries were linked with --module and what
most likely not. I cannot imagine they all do such "patching" like we. :)=


Jan


--------------enigF8E4ECDD9E8E50C7DF0B5969
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE5bk/niDOoMHTA+kRAuMaAJ96YCT0xSqIlbLQxM1lfKkyerRCFACdF1wa
GkfAw8+ovoDrkOg8AZ1aHd0=
=sR5C
-----END PGP SIGNATURE-----

--------------enigF8E4ECDD9E8E50C7DF0B5969--

