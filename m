Message-ID: <4684BEA9.1050705@domain.hid>
Date: Fri, 29 Jun 2007 10:11:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB14C@rennsmail04.eu.thmulti.com>
	<4680DA9B.5020501@domain.hid> <46838C9C.7030303@domain.hid>
	<4684BD02.1070002@domain.hid>
In-Reply-To: <4684BD02.1070002@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig831F307E8357270108E17782"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Group-based RT caps
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig831F307E8357270108E17782
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Johan Borkhuis wrote:
> Jan Kiszka wrote:
>> I couldn't resist, the approach looked too simple and appealing:
>> http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/rt-caps-group.p=
atch
>>
>>
>> Actually, it's even more advanced than realtime-lsm in so far as it al=
so
>> checks for secondary group membership. You can use the nucleus module
>> parameter "xenomai_gid" to control the Xenomai group, also during
>> runtime using /sys.
>>
>> Works nicely for me. I'm able to run testsuite programs under my user
>> account that now additionally belongs to the "xenomai" group. :)
>>
>> Jan
>>  =20
>=20
> I used the patch (and reversed my modification of MLOCK_LIMIT) and this=

> works OK now, on a plain 2.3.1 version. Thanks!

Nice to hear.

>=20
> One thing I would like to see is to have the xenomai_gid parameter as a=

> kernel config parameter, next to the module parameter. The default can
> be -1, but I would like to have my configured xenomai-group as the
> default value, so I don't have to pass an extra parameter or modify
> /sys/module/xeno_nucleus/parameters/xenomai_gid.

Build the nucleus into the kernel, and you'll have it (with kernel 2.6
at least): "xeno_nucleus.xenomai_gid=3D<some-gid>"

Jan


--------------enig831F307E8357270108E17782
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFGhL6uniDOoMHTA+kRAj3LAJiJg+EUkOHr4hLk2SNE+w6YF2XgAJ4gmzX5
HiIz1mXDE+2I7xbLCFURlw==
=r97K
-----END PGP SIGNATURE-----

--------------enig831F307E8357270108E17782--

