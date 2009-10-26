Message-ID: <4AE55A4D.6010106@domain.hid>
Date: Mon, 26 Oct 2009 09:14:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20091024080304.22784.46688.stgit@domain.hid>
	<1256402324.2862.495.camel@domain.hid>
In-Reply-To: <1256402324.2862.495.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3464591323B45C2052A882AF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 0/2] fork-safe rt_print,
	rt_syslog extension
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Oliver Schlenker <oliver.schlenker@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3464591323B45C2052A882AF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2009-10-24 at 10:03 +0200, Jan Kiszka wrote:
>> Please pull Oliver's rt_print patches from
>>
>>     git://xenomai.org/xenomai-jki.git for-upstream
>>
>>
>> Oliver Schlenker (2):
>>       Fork-safe rt_print
>>       Syslog extension of rt_print
>>
>>  include/rtdk.h      |    2 +
>>  src/rtdk/rt_print.c |   72 ++++++++++++++++++++++++++++++++++++++++++=
++++-----
>>  2 files changed, 67 insertions(+), 7 deletions(-)
>>
>> PS: Trying to manage patches by hand is doomed to fail. I can only
>> recommend anyone investing the time to get familiar with basic git
>> commands. It quickly pays off, even for managing only private changes.=

>=20
> Please, make sure to provide a prefix in your short log; this makes
> sorting the short logs for changes by topic a bit easier. E.g.
>=20
> rtdk: fork-safe rt_print
> rtdk: syslog extension of rt_print
>=20

As you already merged it - too late to fix. Sorry, will try to avoid
forgetting this in the future.

Jan


--------------enig3464591323B45C2052A882AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrlWk0ACgkQitSsb3rl5xQr4ACgqyzdc5YWaMT4Qzmw+JvIYCHs
ZKIAoJrCHo8QJrEuinM+9lKE7WtTFJOV
=myhD
-----END PGP SIGNATURE-----

--------------enig3464591323B45C2052A882AF--

