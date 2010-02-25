Message-ID: <4B870134.2040802@domain.hid>
Date: Fri, 26 Feb 2010 00:01:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>
	<4B86FCBB.10203@domain.hid> <4B86FFA0.3000403@domain.hid>
In-Reply-To: <4B86FFA0.3000403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC2590698227BED3EC50479F4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2590698227BED3EC50479F4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Charlton, John wrote:
>>>> I have a xenomai application that runs without problems with xenomai=
-2.4.6.1/linux-2.6.27.7. When run under xenomai-2.5.1/linux-2.6.32.7 it f=
ails with the warning: Xenomai: process memory not locked (missing mlocka=
ll?).  I verified that mlockall() is being called before any xenomai call=
s are made as follows with out error:
>>>>
>>> I'm afraid that warning is misleading.
>> And this should fix the error reporting (without any signal handler
>> installed, your application will still terminate, though):
>=20
> Arg, it will conflict with the libxenomai thing. I am punished for not
> having pushed my work earlier.
>=20
> Did you test it? Or should I wait for John to test it before merging it=
?
>=20

Of course it's untested. :)

Yes, I forgot to state explicitly that it would be nice of John to check
this with his application.

I've no problem rebasing this later on over your work, the changes are
trivial enough.

Jan


--------------enigC2590698227BED3EC50479F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuHATgACgkQitSsb3rl5xRcLwCgqr1ClCJRCqakuqZiyQq4ew8o
ET4AoK0d+ePo4KG7JpcGQwvYS53hjlr+
=1FgT
-----END PGP SIGNATURE-----

--------------enigC2590698227BED3EC50479F4--

