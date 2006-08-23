Message-ID: <44ECB7EF.7050300@domain.hid>
Date: Wed, 23 Aug 2006 22:17:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Problems building RTnet
References: <200608232058.36523.niklaus.giger@domain.hid>
	<44ECB384.8080000@domain.hid>
In-Reply-To: <44ECB384.8080000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig244DE84842F23BC3B143A89B"
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig244DE84842F23BC3B143A89B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Niklaus Giger wrote:
>> Hi=20
>>
>> Since a few hours RTnet cannot even be configured, as the Xenomai vers=
ion got
>> bumped to 2.3-devel. See
>> http://ngiger.dyndns.org/buildbot/tqm860/builds/8/step-cfg_RTnet/0
>> Where it says:
>>
>> checking for Xenomai version... configure: error: *** Unsupported Xeno=
mai=20
>> version 2.3-devel in /var/buildbot/slave/tqm860/linux
>=20
> Fixed (for the next versions now as well...).
>=20
>> This morning the buildbot complained like the following:
>> powerpc-860-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I../../../config   =
-g -I. -I/usr/xenomai/include -g -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -W=
all -pipe -I../../../stack/include -I../../../stack/include -g -MT=20
>> rtnet_ifs.o -MD -MP -MF ".deps/rtnet_ifs.Tpo" -c -o rtnet_ifs.o rtnet_=
ifs.c;=20
>> \
>>         then mv -f ".deps/rtnet_ifs.Tpo" ".deps/rtnet_ifs.Po"; else=20
>> rm -f ".deps/rtnet_ifs.Tpo"; exit 1; fi
>> In file included from rtnet_ifs.c:31:
>> ../../../stack/include/rtnet.h:29:23: rtdm/rtdm.h: No such file or dir=
ectory
>=20
> There must be still something wrong with the xenomai user-space
> installation. Check if the xeno-config handed to RTnet returns
> reasonable paths and if those paths contain the files we need here.
>=20

Looks like a DESTDIR-or-not-DESTDIR question in the include (and lib?)
paths xeno-config returns. Do we need two runs for the Xenomai lib
installation, one for the target and one for the build host? Or is RTnet
supposed to add DESTDIR to all paths returned by xeno-config? Tricky,
too tricky for tonight.

Jan


--------------enig244DE84842F23BC3B143A89B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFE7LfvniDOoMHTA+kRAqBYAJ9Y1DCYpBQ1oX630YvAjhIR+csD8ACXY0CC
vmvptdb7LgO1ePJtzbSdVQ==
=Jc4j
-----END PGP SIGNATURE-----

--------------enig244DE84842F23BC3B143A89B--

