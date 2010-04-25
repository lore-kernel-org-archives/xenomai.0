Message-ID: <4BD45D70.5020301@domain.hid>
Date: Sun, 25 Apr 2010 17:19:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BD45469.5040006@domain.hid>
	<1272207860.28983.120.camel@domain.hid>
In-Reply-To: <1272207860.28983.120.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig05C7A70AA0656F547F2B23F5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [git pull] Fix bogus lock stealing case
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05C7A70AA0656F547F2B23F5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2010-04-25 at 16:40 +0200, Jan Kiszka wrote:
>> The following changes since commit fbc3b858ee728c1a6b03996e3285198caa7=
053c6:
>>   Gilles Chanteperdrix (1):
>>         debug: fix CONFIG_XENO_OPT_DEBUG_* issues
>>
>> are available in the git repository at:
>>
>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>
>> I'm starting to believe that once our customer stops reporting weird
>> Xenomai behavior, we have reached the ultimate level of zero bugs. For=

>> now this is just another "bugs--".
>=20
> Are you feeling better now?

Yeah. :) (Specifically as reproducing it was not that simple even after
I was sure to have found it in the code.)

>=20
>> Jan Kiszka (2):
>>       mutex-torture: Add test for disallowed lock stealing
>>       nucleus: Fix bogus lock stealing case
>>
>>  ksrc/nucleus/synch.c               |    6 ++--
>>  src/testsuite/unit/mutex-torture.c |   62 +++++++++++++++++++++++++++=
+++++++++
>>  2 files changed, 65 insertions(+), 3 deletions(-)
>>
>=20
>=20

Jan


--------------enig05C7A70AA0656F547F2B23F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvUXXUACgkQitSsb3rl5xSCIwCg4BCAeWjEXB/Vsi8o3bz55yp7
zdgAoMdUDWfaV8zntt1+Ebo9DrCxxLEz
=KyYm
-----END PGP SIGNATURE-----

--------------enig05C7A70AA0656F547F2B23F5--

