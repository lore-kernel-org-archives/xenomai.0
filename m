Message-ID: <45D46704.9050109@domain.hid>
Date: Thu, 15 Feb 2007 14:58:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D45AEA.50404@domain.hid> <1171547803.24117.8.camel@domain.hid>
In-Reply-To: <1171547803.24117.8.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig968D631DEC7EF9673280B622"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
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
--------------enig968D631DEC7EF9673280B622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-02-15 at 14:06 +0100, Jan Kiszka wrote:
>> Hi all,
>>
>> I think I found another unwanted side-effect of the no-cow changes:
>>
>> With the I-pipe 1.7 patch series the test for missing mlockall no long=
er
>> works. I just - once again - wrote a test program that was lacking thi=
s
>> call, but only with I-pipe 1.6-06 (same Xenomai version: latest trunk)=
 I
>> get the usual error message on startup.
>>
>=20
> I can't reproduce this with 1.7-01 here. Which Xenomai codebase are you=

> currently using (trunk/, 2.3.x maintenance or stock 2.3)?

Specifically trunk, but the first observation was over 2.3.x
maintenance. The test code is using the posix skin.

Jan


--------------enig968D631DEC7EF9673280B622
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1GcEniDOoMHTA+kRAu0kAJ9ztfzt9ci09G6UBIL5pYaMIhzV/wCfaQdS
9j9AlRdqHc45HxkZBOhj/w4=
=gVZJ
-----END PGP SIGNATURE-----

--------------enig968D631DEC7EF9673280B622--

