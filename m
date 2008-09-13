Message-ID: <48CB648F.2090509@domain.hid>
Date: Sat, 13 Sep 2008 08:58:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CAACEF.3010902@domain.hid>
	<219129.74725.qm@domain.hid>
In-Reply-To: <219129.74725.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAB170FFBF10426DE922EFC2B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] compile error xenomai 2.4.5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: george_pitich@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB170FFBF10426DE922EFC2B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[ Don't start new topics by replying to unrelated ones! ]

George Pitich wrote:
> Tried to compile linux 2.6.26.5 kernel with xenomai 2.4.5 (also ran ./c=
onfigure --disable-x86-tsc --enable-x86-sep)
>=20
> ./prepare-kernel.sh  --arch=3Di386 --adeos=3D/usr/src/xenomai-2.4.5/ksr=
c/arch/x86/patches/adeos-ipipe-2.6.26-x86-2.0-09.patch --linux=3D/usr/src=
/linux-2.6.26.5
>=20
> make gave the error:
>=20
> arch/x86/xenomai/hal_32.c: In function =E2rthal_latency_above_max=E2:
> arch/x86/xenomai/hal_32.c:139: error: implicit declaration of function =
=E2die_nmi=E2
> make[1]: *** [arch/x86/xenomai/hal_32.o] Error 1
> make: *** [arch/x86/xenomai] Error 2

That's an issue of the 2.6.26 ipipe patch. Philippe, you dropped the
nmi_32.h hunk:

diff --git a/include/asm-x86/nmi_32.h b/include/asm-x86/nmi_32.h
index 70a958a..da25e1c 100644
--- a/include/asm-x86/nmi_32.h
+++ b/include/asm-x86/nmi_32.h
@@ -29,7 +29,8 @@ extern void setup_apic_nmi_watchdog (void *);
 extern void stop_apic_nmi_watchdog (void *);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
+extern int (*nmi_watchdog_tick)(struct pt_regs * regs, unsigned reason);=

+extern void die_nmi(struct pt_regs *, const char *msg);

 extern atomic_t nmi_active;
 extern unsigned int nmi_watchdog;

Should be merged into the unified nmi.h now.

George, in the meantime you can simply disable NMI watchdog support in
Xenomai, and then the build should succeed again.

Jan


--------------enigAB170FFBF10426DE922EFC2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjLZJAACgkQniDOoMHTA+nWIQCfWIGCVRcxcI0MlPxNExp4ukG3
jPwAmwcFV3V3Ycy6QOTaYpy48whdc4pl
=eAo5
-----END PGP SIGNATURE-----

--------------enigAB170FFBF10426DE922EFC2B--

