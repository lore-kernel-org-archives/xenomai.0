Message-ID: <44047A74.9040106@domain.hid>
Date: Tue, 28 Feb 2006 17:29:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Page faults
References: <fd6a47a90602280622o4cfb2b79g@domain.hid>	
	<440466C6.9050706@domain.hid>
	<fd6a47a90602280729xb39e0f4l@domain.hid>
In-Reply-To: <fd6a47a90602280729xb39e0f4l@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig003425989AF7638524A3BD9B"
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig003425989AF7638524A3BD9B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
>> Maybe not all of your user memory is cleanly locked and got swapped ou=
t
>> (swapping activated?). If you don't see kernel oopses and your program=
s
>> don't receive segfaults, these faults are references to swapped out or=

>> not yet mapped in pages. BTW, what does the kernel console tell you?
>=20
>=20
> I have a mlockall(MCL_CURRENT | MCL_FUTURE) in my main() (non-RT) task
> alright. Do I need to repeat that for the real-time tasks as well ?

You should not have to. I observed some cases where malloc'ed memory was
not immediately available, and you had to touch it first. I guess this
depends on how glibc requests the memory. So, if unsure, do an memset on
freshly allocated memory.

>=20
> I'm quite certain that my kernel is configured for swapping. I did not =
see
> any harm in it, as a mlockall() was given. Should I try turning it off =
(if
> so, where) ?

Swapping does not do any harm, correct. I just wanted to check what may
trigger the problem.

>=20
> I do not see 'oopses' and the dmesg log is clean, apart from one
> incidental spurious IRQ7 interrupt. Is 'dmesg' what you mean by 'kernel=

> console' ?
>=20

Ah, I oversaw some dependency. Try to enable CONFIG_XENO_OPT_DEBUG. Then
the nucleus should spit out which task is being relaxed due to faults:

"Switching XYZ to secondary mode after exception #? from user-space at
0x??? (pid ?)"

Jan



--------------enig003425989AF7638524A3BD9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBHp0niDOoMHTA+kRAlijAJ0ckNN8rCWA416ukc42Z2+c41iV0QCfTLzn
qh9B78ameDJIE1DCLVH4oac=
=GDbJ
-----END PGP SIGNATURE-----

--------------enig003425989AF7638524A3BD9B--

