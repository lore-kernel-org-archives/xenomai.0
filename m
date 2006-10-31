Message-ID: <45477DB2.8090304@domain.hid>
Date: Tue, 31 Oct 2006 17:45:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] More woes with linux 2.6.18 and xenomai 2.2.3
	or 2.2.4 - irq_desc structure changed
References: <1F695B041C4BC345AFB7BD5D647B85000119975A@mail.senetas.com>
	<1162282862.4996.18.camel@domain.hid>
In-Reply-To: <1162282862.4996.18.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1BBC159CC48324D7F0AF1460"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1BBC159CC48324D7F0AF1460
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2006-10-31 at 10:18 +1100, John Weston wrote:
>> Continuing from my previous email regarding xenomai 2.2.4 and linux
>> 2.6.18 for ppc (8260), I have also noticed that the underlying
>> irq_desc structure has changed (in include/linux/irq.h), which in turn=

>> breaks hal.c.
>>
>> Are there any more recents patches available to fix this? Thanks in
>> advance
>=20
> The upcoming 2.3-rc1 fixes the issues raised by upgrading to 2.6.18 and=

> beyond (includes mutex and irq_desc conflicts). You can get this code
> from the SVN trunk/, until -rc1 is rolled out (soon).

Shouldn't the 2.6.18-ppc patch be removed from the 2.2.x series then?
Just to avoid further frustrations. User who know for what setups it
works (I guess switching off the native skin will work around this
conflict) could still cherry pick from new versions.

Jan


--------------enig1BBC159CC48324D7F0AF1460
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFR321niDOoMHTA+kRAviKAJ9C2UyHjWC6IX5f/TvBbHbV24e8MQCfRhYG
OPy1UJf6Py+sftPblF1UZNI=
=dZCq
-----END PGP SIGNATURE-----

--------------enig1BBC159CC48324D7F0AF1460--

