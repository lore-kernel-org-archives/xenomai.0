Message-ID: <49F6AAAE.9090200@domain.hid>
Date: Tue, 28 Apr 2009 09:05:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49F65852.6090401@domain.hid> <49F69377.7090005@domain.hid>
In-Reply-To: <49F69377.7090005@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6532C9E697D7F656E219B2F4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Does not exist "xnpod_start_timer" on Xenomai
	2.4.7 ???
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "Kim, Hee-young" <plugdboy@domain.hid>
Cc: xenomai@xenomai.org, rtfirewire-devel@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6532C9E697D7F656E219B2F4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Kim, Hee-young wrote:
>> Hi,
>>
>> I'm trying to patch "rt-firewire 0.1" for lastest xenomai patched
>> kernel. I fixed some functions to altered one. But, xnpod_start_timer(=
),
>> xnpod_stop_timer() and relates do not exist in pod.c.
>> and try to find same function name in Xenomai but there are no exists.=

>> Where can I find these functions? or How to solve it?
>=20
> The replacement is xnpod_enable_timesource, but you should not need to
> call it explicitely, especially not in a driver. So, you should rather
> remove these calls.
>=20
> BTW, any plan to publish the modified code ?
>=20

In any case, always use latest SVN as basis (it doesn't include that
service anymore, BTW) and put the rtfirewire mailing list on CC.

Jan


--------------enig6532C9E697D7F656E219B2F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkn2qq4ACgkQniDOoMHTA+npbwCcDZWB27/JD/+lHb4Xn/opw6ZY
0AkAn0LtYpTaOeykOQUcG/c4L4HkRiIQ
=FIsm
-----END PGP SIGNATURE-----

--------------enig6532C9E697D7F656E219B2F4--

