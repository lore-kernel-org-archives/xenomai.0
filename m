Message-ID: <4BC790B0.7090604@domain.hid>
Date: Fri, 16 Apr 2010 00:18:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <t2w95dbcd241004151500ne05d5991q4a8f6463f2b37ba1@domain.hid>
In-Reply-To: <t2w95dbcd241004151500ne05d5991q4a8f6463f2b37ba1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD7DDC0119CB868DA244533CF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [Vortx86DX] What's wrong with kernels upper than
 2.6.30.10 ?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles DOFFE <g.doffe@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD7DDC0119CB868DA244533CF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles DOFFE wrote:
> Hello,
>=20
> I try to install a real-time Linux kernel on a Roboard based on a Vorte=
x86DX
> (a x486 with TSC).
>=20
> All works fine with :
> Linux Kernel 2.6.30.10
> Xenomai 2.5.1
> Adeos patch adeos-ipipe-2.6.30.8-x86-2.4-09.patch
>=20
> But, for all kernels upper or equal to 2.6.31, I always get a double fa=
ult
> when testing WP bit. I have this double fault just after that :
>=20
> *Checking if this processor honours the WP bit even in supervisor mode.=
=2E.*
>=20
> I traced with some simple printk that the problem occurs in this functi=
on,
> at the end or after the call of fix_to_virt  :
>=20
> *static noinline int do_test_wp_bit(void)
> {
>         char tmp_reg;
>         int flag;
>=20
>         __asm__ __volatile__(
>                 "       movb %0, %1     \n"
>                 "1:     movb %1, %0     \n"
>                 "       xorl %2, %2     \n"
>                 "2:                     \n"
>                 _ASM_EXTABLE(1b,2b)
>                 :"=3Dm" (*(char *)fix_to_virt(FIX_WP_TEST)),
>                  "=3Dq" (tmp_reg),
>                  "=3Dr" (flag)
>                 :"2" (1)
>                 :"memory");
>=20
>         return flag;
> }*
>=20
> I'm (quasi) sure that the problem is not that function, due to it works=
 when
> the kernel is not patched.
> But where should I search ?
>=20
> Can you give me some indications ?

Does applying this patch [1] happen to change the picture?

If not, please provide your .config.

Jan

[1] http://thread.gmane.org/gmane.linux.kernel.adeos.general/1570


--------------enigD7DDC0119CB868DA244533CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvHkLUACgkQitSsb3rl5xQkrwCgkCDn0NhYI89BpI+64qkn16Wl
n3QAn1Nl0CjAj3kSIk2k+A4U/YRZ4/wv
=XKXB
-----END PGP SIGNATURE-----

--------------enigD7DDC0119CB868DA244533CF--

