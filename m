Message-ID: <4E359412.4090309@domain.hid>
Date: Sun, 31 Jul 2011 19:42:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QnZD3-00080U-DV@xenomai.org> <4E358F10.7070203@domain.hid>
In-Reply-To: <4E358F10.7070203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0973A09EA31C5F5673A58A64"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : rt_print: Provide
	rt_puts
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0973A09EA31C5F5673A58A64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-31 19:21, Gilles Chanteperdrix wrote:
> On 07/31/2011 06:49 PM, GIT version control wrote:
>> +int rt_puts(const char *s)
>> +{
>> +	return print_to_buffer(stdout, 0, RT_PRINT_MODE_PUTS, s, NULL);
>> +}
>=20
> gcc for ARM chokes here: it says that NULL can not be converted to a
> va_list, however I try it.

Hmm. Does this work?

diff --git a/src/skins/common/rt_print.c b/src/skins/common/rt_print.c
index 186de48..52538d8 100644
--- a/src/skins/common/rt_print.c
+++ b/src/skins/common/rt_print.c
@@ -243,7 +243,9 @@ int rt_printf(const char *format, ...)

 int rt_puts(const char *s)
 {
-	return print_to_buffer(stdout, 0, RT_PRINT_MODE_PUTS, s, NULL);
+	va_list dummy;
+
+	return print_to_buffer(stdout, 0, RT_PRINT_MODE_PUTS, s, dummy);
 }

 void rt_syslog(int priority, const char *format, ...)


Not really beautiful as well, I know.

Jan


--------------enig0973A09EA31C5F5673A58A64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk41lBoACgkQitSsb3rl5xSBrgCfafS7gtQQJnM2LR/vyyuYTdIr
DOIAoO18DH1lgfA8AF4J4fabFqNYra6Z
=9UHx
-----END PGP SIGNATURE-----

--------------enig0973A09EA31C5F5673A58A64--

