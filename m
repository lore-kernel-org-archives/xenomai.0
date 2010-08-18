Message-ID: <4C6BE610.7020507@domain.hid>
Date: Wed, 18 Aug 2010 15:54:24 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid>
	<4C6932E8.7050701@domain.hid>		<4C694AB3.8050407@domain.hid>
	<4C698E16.5050806@domain.hid>		<1282040830.1730.232.camel@domain.hid>		<4C6ACA50.3080108@domain.hid>	<1282120049.1730.304.camel@domain.hid>
	<4C6BCDE5.6050607@domain.hid>
In-Reply-To: <4C6BCDE5.6050607@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE17A7E88FF45609495129D9D"
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE17A7E88FF45609495129D9D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 18.08.2010 14:11, Stefan Kisdaroczi wrote:
> [...]
> hi philippe, hope this helps:
>
>
> (gdb) bt
> #0  doublefault_fn () at arch/x86/kernel/doublefault_32.c:47
> #1  0x00000000 in ?? ()
>
> I set two breakpoints:
> 1) do_test_wp_bit()
> 2) zap_low_mappings()
>
> The second breakpoint is never reached, the fault seems to happen in
> do_test_wp_bit().
> arch/x86/mm/init_32.c : mem_init() -> test_wp_bit() -> do_test_wp_bit()=

>  =20

If I got it right, do_test_wp_bit() should fault, and then
ipipe_handle_exception gets called.
At this point, ipipe_init_early() was called, but ipipe_init() not.
So, I currently guess the bug is somewhere in ipipe_handle_exception().

Looking at ipipe-2.6.git I see the following commits which could be relat=
ed:
x86: Fix root domain state restoring on exception return, 22.01.2010,
Jan, a2bc69bd3bd2e6a8f39d8407c647d7dfd2821bc0
x86/ipipe: Fix up regs unconditionally on exceptions, 12.04.2010, Jan,
ed2e37c05c897a46ea895a0dfbf08086057e2bcf

Stefan



--------------enigE17A7E88FF45609495129D9D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxr5hcACgkQIPTw9rIdn6qVdwCcCtsK6FHs945ulO3GK8brQt+9
l1sAn2fGdLVudnmL64KmztRhxCKa2wkH
=mukE
-----END PGP SIGNATURE-----

--------------enigE17A7E88FF45609495129D9D--

