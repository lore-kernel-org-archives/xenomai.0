Message-ID: <460394A8.5010501@domain.hid>
Date: Fri, 23 Mar 2007 09:49:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [RT_PIPE] - User space read() not waking up
References: <20070322215707.232970@domain.hid>
	<b647ffbd0703230142n46a215ddv5ab0e2c984d0d93c@domain.hid>
In-Reply-To: <b647ffbd0703230142n46a215ddv5ab0e2c984d0d93c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C23CF54D510570EF60B9315"
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C23CF54D510570EF60B9315
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> [...]
>> So basically, my question is:
>> If I have rt_pipe_write() writing to a pipe from a kernel module with =
a
>> 200 us period and I have a read() in a tight loop reading from that sa=
me
>> pipe is user space, what could be the origin of the fact that
>> sometimes my
>> read() doesn't get woken up?
>=20
>=20
> Xenomai does provide a Linux system with hard real-time support but it
> doesn't make the Linux kernel itself hard real-time, nor user-space
> applications which relies merely on the standard kernel services.

Good that you read the mail more thoroughly than I did... :-/

Yes, that's obviously an application design issue.

Jan


--------------enig7C23CF54D510570EF60B9315
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGA5SoniDOoMHTA+kRAkykAJ9jvCH4xW/OBmXQKVL3AuMH/my4NACfbyFN
Zb/SfoTLqn4dNDq+M8kji6k=
=em2u
-----END PGP SIGNATURE-----

--------------enig7C23CF54D510570EF60B9315--

