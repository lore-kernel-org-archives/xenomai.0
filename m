Message-ID: <4AF9571F.7090500@domain.hid>
Date: Tue, 10 Nov 2009 13:05:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AF87D53.9090102@domain.hid> <4AF947FA.4030908@domain.hid>
In-Reply-To: <4AF947FA.4030908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3C9CEF727C3D779C0CDFF59B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [pull request] heap reference and trivial build
 fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C9CEF727C3D779C0CDFF59B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> The following changes since commit 6d7d6bc436ef3d1fb51fa8de06d4ecf004e=
3b6a5:
>>   Gilles Chanteperdrix (1):
>>         nucleus: defer selector block deletion to an APC.
>>
>> are available in the git repository at:
>>
>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>
>> Jan Kiszka (2):
>>       nucleus: Track heap mapping on to mm-clone
>>       nucleus: Fix trivial build warning
>>
>>  ksrc/nucleus/heap.c   |   12 +++++++++++-
>>  ksrc/nucleus/module.c |    2 +-
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> Hi Jan,
>=20
> do you agree if I add the notification to the xenomai-git mailing list
> for your tree? It makes it possible to review your patches without any
> action on your side. Note that a recent modification to the notificatio=
n
> mechanism only shows the relevant patches.
>=20

No problem. Ah, the new filter looks nice!

And how would my new workflow look like? Just silently push into
'for-upstream'?

Jan


--------------enig3C9CEF727C3D779C0CDFF59B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr5VyUACgkQitSsb3rl5xSGvwCeI6p0GTrTb4Zbt5ndmNWuEFby
WCEAnA9w353LwYoUv0yJ0GPqxBAr4oy/
=5SVU
-----END PGP SIGNATURE-----

--------------enig3C9CEF727C3D779C0CDFF59B--

