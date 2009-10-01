Message-ID: <4AC45669.4080808@domain.hid>
Date: Thu, 01 Oct 2009 09:12:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <021401ca40ef$f0503470$d0f09d50$@biz>
In-Reply-To: <021401ca40ef$f0503470$d0f09d50$@biz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B81F62D855120B01C01AAB0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Kernel panic on reboot (Xenomai 2.4.9.1,
 kernel 2.6.31, x86 SMP)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Stocks <rjs@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B81F62D855120B01C01AAB0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rob Stocks wrote:
> We have a problem with Xenomai v2.4.9.1, kernel 2.6.31, x86 SMP in that=
 we
> get a kernel panic on reboot:
>=20
> 	swapper[0]: segfault at 15aba ip 0000e6ba sp 00000189 error 4
> 	no vm86_info: BAD
> 	Kernel panic - not syncing: Attempted to kill the idle task!
> 	Pis: 0, comm.: swapper Not tainted 2.6.31-CROCUS #1
> 	Call Trace:
> 	 [<810280cb>] panic+0x49/0xed
> 	 [<8102a6f6>] do_exit+0x55/0xdc4
> 	 [<81028fec>] ? printk+0x9f/0x104
> 	 [<810031ec>] ? reboot_interrupt+0x0/0x38
> 	 [<81014af7>] save_v86_state+0xa6/0x168
> 	 [<810031ec>] ? reboot_interrupt+0x0/0x38
> 	 [<81002ac6>] work_notifysig_v86+0x06/0x18
> 	 [<810031ec>] ? reboot_interrupt+0x0/0x38
> 	reboot[1781]: segfault at 15aba ip 0000e6ba sp 00000189 error 4
> 	no vm86_info: BAD
>=20
> Other than this, it seems to work fine.
>=20
> We had previously been using v2.4.7, kernel 2.6.28.7 which does not hav=
e
> this issue but for development, we would like to use X and we find that=
 some
> X applications (e.g. Netbeans & eclipse) hang the system (with no indic=
ation
> of cause i.e. no console messages & nothing in the logs - the system ju=
st
> stops). However, when we use v2.4.9.1 with kernel 2.6.31, we can use X =
apps
> perfectly but we can't reboot!
>=20
> Anyone have any ideas/suggestions?

Please provide your .config, I'll try to have a look.

Jan


--------------enig0B81F62D855120B01C01AAB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrEVmoACgkQitSsb3rl5xTc6gCfZyvpOIzwzuSFaQaLA9duM8/K
OCsAn3DsdOK7Z5K/DXQwh4Cwke+aIg/A
=4jVe
-----END PGP SIGNATURE-----

--------------enig0B81F62D855120B01C01AAB0--

