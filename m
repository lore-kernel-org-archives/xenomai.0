Message-ID: <44E2C547.30601@domain.hid>
Date: Wed, 16 Aug 2006 09:12:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44DA896F.9060102@domain.hid> <44DB1865.90004@domain.hid>
	<44DB9958.10109@domain.hid> <44DCAF88.2060801@domain.hid>
	<44DD08A0.5000603@domain.hid>
In-Reply-To: <44DD08A0.5000603@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC446F6AE9072A48F02924DB1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Test, benchmark, demo frameworks
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
--------------enigC446F6AE9072A48F02924DB1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
> Jan Kiszka wrote:
>> ...
>> So, how to proceed?
>>  =20
> <aside> wiki++ </>
>=20
> 1 file at a time - I suppose..
>=20
> I'll start by poaching Hannes' Makefile, bundling it into an examples/
> dir with
> my 3-way version of his timer programs.  Id like see the target files
> appear as 0 len files,
> ( presuming this necessary for svn diff to see code I drop in )
>=20
> Then we can discuss the more nuanced improvements /* adding tutorial,
> guidance */
>=20
> After that, its just step and repeat, tossing crap along the way.
>=20

Ok, to ease pushing things into folders, I would suggest creating this
structure in the root dir of trunk:

examples/native/...
examples/native/kernel/...
examples/posix/...
examples/...
examples/drivers/can/...
examples/drivers/serial/...

All stuff self-contained, i.e. one should simply cd to the folder type
make, maybe additionally providing some information on the xenomai
installation dir / kernel source path, and some binary pops up, ready to
run or insmod.

I would furthermore suggest to have some kind of hello-xenomai.c in
every skin example folder that is intended as the beginners tutorial,
providing an elementary framework to start hacking.


Reorganising the testsuites is another topic. I currently have no idea
how to sort things. We have some stuff under sim/skins/*/testsuite that
only builds for the simulator, there is src/testsuite, intended to be
distributed and installed on the target, and we may want to have a
larger testsuite that can be downloaded separately (my concern is also
about driver tests here). Anyone any ideas/comments on this?

Jan


--------------enigC446F6AE9072A48F02924DB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE4sVIniDOoMHTA+kRAn+eAJ9oV8UBrCYaEyofGAF5hAXJa//RlQCgg7FG
QBFpSlYRZjwu+O7jrxsDK/k=
=EqM4
-----END PGP SIGNATURE-----

--------------enigC446F6AE9072A48F02924DB1--

