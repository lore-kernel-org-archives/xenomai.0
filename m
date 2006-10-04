Message-ID: <4523BD6F.2050708@domain.hid>
Date: Wed, 04 Oct 2006 15:55:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] root_thread_exit in pSOS skin
References: <e3291e320610030716i59d9bf11q286b2d142b79ef8d@domain.hid>
In-Reply-To: <e3291e320610030716i59d9bf11q286b2d142b79ef8d@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE9E1164E8FC527233B7A156A"
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
To: d p <dogpointer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE9E1164E8FC527233B7A156A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

d p wrote:
> I'm trying to use Xenomai over a Linux machine, in particular I'm tryin=
g to
> emulate a pSOS system by using the demo satch (executable satch_uvm). I=
 see
> that root_thread_exit is never called.
>=20
> How I have to do to get root_thread_exit called? I'd like to use this
> function to remove a pipe created in root_thread_init.

root_thread_exit maps to __xeno_user_exit [1], and that should get
called by the UVM main function [2].

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/nucleus/type=
s.h#L129
[2]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/asm-uvm/syst=
em.h#L406


--------------enigE9E1164E8FC527233B7A156A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFI71vniDOoMHTA+kRAtygAJ9yoFKik3kf8/acDtK4V0/LtIj1+QCffp9C
byyKT0+ywpLzK7Z59c4LQRI=
=vrRM
-----END PGP SIGNATURE-----

--------------enigE9E1164E8FC527233B7A156A--

