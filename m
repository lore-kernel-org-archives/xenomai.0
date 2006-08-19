Message-ID: <44E6BF53.4000809@domain.hid>
Date: Sat, 19 Aug 2006 09:35:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44DA896F.9060102@domain.hid> <44DB1865.90004@domain.hid>
	<44DB9958.10109@domain.hid> <44DCAF88.2060801@domain.hid>
	<44E5F0B4.8070405@domain.hid> <44E6009E.7020304@domain.hid>
	<44E606B9.6050406@domain.hid>
In-Reply-To: <44E606B9.6050406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5B70E5CD0D2B8A6EFE6CCD65"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Test, benchmark
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5B70E5CD0D2B8A6EFE6CCD65
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
> Jan Kiszka wrote:
>> Jim Cromie wrote:
>> =20
>>> ...
>>> just responding to small part now..
>>>
>>> this patch adds switchtest, switchbench (and drops switch) and irqben=
ch.
>>>
>>> each test-prog has a corresponding $XENOT_<progname>
>>> with which you can inject new test arguments individually.
>>> Most of these can be undef'd, except for XENOT_IRQBENCH,
>>> which needs to be set in order for test to run (since the test requir=
es
>>> additional resources, as you noted above)
>>>    =20
>>
>> I doesn't necessarily require additional parameters (default is the
>> first serial port on PCs).
>>
>> Why not adding a switch to xeno_test instead? Something like "-a
>> <additional-tests>" (e.g. "-a irqbench,whateverbench"). However, pleas=
e
>> don't forget to document this extension (man page?).
>>
>> Jan
>>
>>  =20
> several reasons for my preference:
>=20
> - xeno-test is already cluttered with options, many of which propagate
> down to tests
> - as more tests are added, more option-clashing is inevitable.
>    this makes pass-downs more complicated.
> - prog-specific options isolate us from option clashes / churn
> - assuming -a <prog>,
>    need to handle multiples on line (I havent done that with shell geto=
pts)
>    I have to wonder if all shells have uniform getopt behavior -
>       we want to work on bash, sh, ash, dash ...

Maybe there are even simpler solutions, but this one seems to be
busybox-safe (sed must be on):

list=3D"a,b,c,d"
for option in `echo $list|sed -e's/,/\n/g'`; do
	case $option in
	a)
		do_this
		;;
	b)
		do_that
		;;
	...
	esac
done

But that's just a suggestion. Your approach is simpler and, given good
documentation, is ok as well.

> - I get to duck the manpage update ;-)


--------------enig5B70E5CD0D2B8A6EFE6CCD65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE5r9TniDOoMHTA+kRAq2qAJ4zncpkgNujJsBTcacHKaiwM2E2cgCdFhqu
ksQwBd2i9xcWl3TfAt4eG+8=
=7VWD
-----END PGP SIGNATURE-----

--------------enig5B70E5CD0D2B8A6EFE6CCD65--

