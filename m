Message-ID: <4AAAAD28.8060107@domain.hid>
Date: Fri, 11 Sep 2009 22:03:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <9b3e2dc20909111201m1b553420k5436a2da179e3279@domain.hid>
In-Reply-To: <9b3e2dc20909111201m1b553420k5436a2da179e3279@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA034982675208DCB77FB042A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] CONFIG_NR_CPUS is too large
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Sinclair <radarsat1@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA034982675208DCB77FB042A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Stephen Sinclair wrote:
> Hello,
>=20
> I am trying to install Xenomai.  After patching the kernel (I have
> tried with 2.6.29.5 and 2.6.30.5), I get the following error message:
>=20
>=20
> $ make
> scripts/kconfig/conf -s arch/x86/Kconfig
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   SYMLINK include/asm -> include/asm-x86
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from include/linux/sched.h:62,
>                  from arch/x86/kernel/asm-offsets_64.c:8,
>                  from arch/x86/kernel/asm-offsets.c:4:
> include/linux/ipipe.h:76:2: error: #error "CONFIG_NR_CPUS is too
> large, please lower it."
> make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2
>=20
>=20
> The CONFIG_NR_CPUS config variable is set to the default 64, but I
> still get this error if I lower it to 4 or 2.  (This is a dual-core
> machine, AMD X2.)
>=20
> I tried commenting-out this error, just to see what would happen, but
> I get an oops on boot.  Setting the boot flag earlyprintk=3Dvga shows a=

> backtrace, and the crash happens immediately after
> __ipipe_enable_irqdesc, which is in ipipe_virtualize_irq.
>=20
> I don't know how to proceed from here, does anyone know why
> CONFIG_NR_CPUS is triggering this error?

Could you post the .config that fails to build?

Yeah, there is a limitation, normally 96 (IIRC). 2 or 4 CPUs is
definitely far below it.

Jan


--------------enigA034982675208DCB77FB042A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkqqrTUACgkQniDOoMHTA+kD1ACZAb3fOa5AXWM+H29VZY5oq4FB
RWMAnRs9z61wRL+Sn5dSTirhOuY/1V2k
=m1w1
-----END PGP SIGNATURE-----

--------------enigA034982675208DCB77FB042A--

