Message-ID: <4C0AB7BA.7000100@domain.hid>
Date: Sat, 05 Jun 2010 22:46:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1OKZdD-0003ml-45@domain.hid> <4C095876.3060605@domain.hid>
	<4C099329.6000303@domain.hid> <4C0A49C4.8000509@domain.hid>
	<4C0A9AB9.7030602@domain.hid> <4C0A9C2A.1030002@domain.hid>
	<4C0AA224.6060409@domain.hid> <4C0AA2F0.6050201@domain.hid>
	<4C0AA3EC.7040106@domain.hid> <4C0AA548.6070409@domain.hid>
In-Reply-To: <4C0AA548.6070409@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4BBBA04CE1B9575B6C61DDC2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Rework
 handling of pthread carrier thread
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
--------------enig4BBBA04CE1B9575B6C61DDC2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Not being able to join a deleted task undermines seriously the utilit=
y
>>> of rt_task_join... What is it useful for, then?
>> See the doc: You join or delete, but not both.
>=20
> Looks to me like a workaround: you are not able to handle properly the
> life-cycle of an RT_TASK, so you changed the rules... is there really n=
o
> other way?

First of all, it turns a SEGV into a proper error code. Moreover,
rt_task_join now officially finalizes the object for native (it always
did technically!), as does pthread_join for POSIX. No rule changed, just
rule documentation and violation detection added. One may argue about
join after delete, but for what use case such a change of rt_task_delete
semantic?

Jan


--------------enig4BBBA04CE1B9575B6C61DDC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwKt70ACgkQitSsb3rl5xQB3ACgn/ZdBwtYdW6uVqa1AMWCmEfy
NREAoOVX2ary7ZZrQcXtIj9/fOMzss/Z
=mlWR
-----END PGP SIGNATURE-----

--------------enig4BBBA04CE1B9575B6C61DDC2--

