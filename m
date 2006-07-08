Message-ID: <44B02B69.9050903@domain.hid>
Date: Sun, 09 Jul 2006 00:02:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai beginner problem.
References: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>	<44AEC245.7090702@domain.hid>	<e325d110607080632u5d80322bte8d32d8e4828030e@domain.hid>	<17583.47182.991802.118974@domain.hid>	<e325d110607080808w7778fb6ayf1f033b79be7c92b@domain.hid>	<1152371904.5004.2.camel@domain.hid>	<e325d110607081156n42b7d8f1m892949b16dc2e9f@domain.hid>
	<17584.4915.679135.575538@domain.hid>
In-Reply-To: <17584.4915.679135.575538@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB53E1CE8DDF89A0C1F7E0640"
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
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB53E1CE8DDF89A0C1F7E0640
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Kim Chuan Lim wrote:
>  > Hi Philippe,
>  >=20
>  > Thanks, it works again. ^ ^
>  >=20
>  > I manage to run few testsuit program but two of them(switchbench and=

>  > cyclic) are crashing my xenomai machine.
>  >=20
>  > May i know what is the reason?
>=20
> The reason is unknown so far, such crashes are abnormal. What kind of
> crash is it ? Also, if not running in text mode, could you run the test=
s
> in text mode, in order to be able to send us the kernel oops text or
> stack trace, if any.
>=20

Further things that may help to track this down:

o Was your kernel build and installation really consistent after the
  last modifications, did you re-run both module_install _and_ install?

o Which tests succeeded? Maybe the effect is limited to one skin (for
  what reason ever).

o Please do not forget to attach your .config (preferably compressed).
  You were using latest SVN trunk of Xenomai?

o If you face a total hang up of your box, try to redirect the kernel
  messages to a serial console and capture the result via a null-modem
  link to a second station. See linux/Documentation/serial-console.txt
  for a howto.

Thanks in advance,
Jan


--------------enigB53E1CE8DDF89A0C1F7E0640
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEsCt1niDOoMHTA+kRAvRsAJwK1ekSFPW1l3/UOCpfE6iZ0VHnNwCfWyiM
mhQDLY7235D3Ybkv+1vpRW4=
=6rZW
-----END PGP SIGNATURE-----

--------------enigB53E1CE8DDF89A0C1F7E0640--

