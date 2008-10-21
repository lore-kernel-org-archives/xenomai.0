Message-ID: <48FD7741.9050600@domain.hid>
Date: Tue, 21 Oct 2008 08:31:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48FCDC52.1070507@domain.hid>
	<48FCE40C.1080100@domain.hid>	<48FCEB70.7030808@domain.hid>
	<48FCEC25.2040200@domain.hid>	<48FCED48.5050608@domain.hid>
	<48FCF14C.8050103@domain.hid> <48FCF2E2.8050809@domain.hid>
	<48FCF4FB.1040104@domain.hid> <48FCF74E.1090102@domain.hid>
	<48FCF86F.3030007@domain.hid> <48FCF8D4.6030507@domain.hid>
	<48FCF94C.3000206@domain.hid> <48FCF9B7.9000201@domain.hid>
	<48FD0913.6040100@domain.hid> <48FD11B4.30201@domain.hid>
In-Reply-To: <48FD11B4.30201@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA3879A0C675A0FABFA05B4D2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Warning when compiling trunk.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA3879A0C675A0FABFA05B4D2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Well I am busy with the ARM FCSE now. Do you want my test case ?
>>>> Yes, hoping that it triggers on x86 as well. And is toolchain indepe=
ndent.
>> It doesn't trigger. Can you reproduce on x86?
>=20
> Beware, I just noticed that I commited my fix. I thought I had commited=

> only files where I made changes for SIGWINCH, but it happens that I had=

> also made changes for SIGWINCH in src/skins/native/task.c

I ran my local version of yesterday afternoon, and I used UP - no
segfaults. This issue remains fishy. Even if there is a race, we need to
understand it first. And I'm still failing to see what races.

Jan


--------------enigA3879A0C675A0FABFA05B4D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj9d0kACgkQniDOoMHTA+n2bQCfTFc4g5wOvLsC7GMn55dwEfF5
KS0AoISjRrsffHbPQW4md2dNaOSPWGj5
=6W/5
-----END PGP SIGNATURE-----

--------------enigA3879A0C675A0FABFA05B4D2--

