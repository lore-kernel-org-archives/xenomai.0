From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cb0+x/Vn1c8HrljXuWXC"
Date: Mon, 09 Oct 2006 10:52:34 +0200
Message-Id: <1160383954.5015.17.camel@domain.hid>
Mime-Version: 1.0
Subject: [Adeos-main] BUG: adeos-ipipe-2.6.15-arm-1.5-00.patch on 2.6.15.7
	-- syscalls
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


--=-cb0+x/Vn1c8HrljXuWXC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to get running Adeos/Xenomai on a Netsilicon 9360
(ARM926EJ-Sid(wb) rev 4 (v5l))-Board with linux-2.6.15.7 and found
following bug in ipipe.root (__ipipe_syscall_root)

In __ipipe_syscall_root the syscall-nr is checked by:

__ipipe_syscall_watched_p(current, scno)

((
#define __NR_SYSCALL_BASE      0x900000
#define __ARM_NR_BASE                      (__NR_SYSCALL_BASE+0x0f0000)
#define __ipipe_syscall_watched_p(p, sc)        \
        (((p)->flags & PF_EVNOTIFY) || (unsigned long)sc >=3D __ARM_NR_BASE=
 + 64)
))

but in entry-common.S this number is substracted by __NR_SYSCALL_BASE,
so the check (scno >=3D __ARM_NR_BASE + 64) can never succeed.

...

        ldr     ip, [tsk, #TI_FLAGS]            @ check for syscall tracing
        bic     scno, scno, #0xff000000         @ mask off SWI op-code
        eor     scno, scno, #__NR_SYSCALL_BASE  @ check OS number          =
     <---- substraction
#ifdef CONFIG_IPIPE
        stmfd   sp!, {r0-r3, ip}
        add     r1, sp, #S_OFF
        add     r1, r1, #20
        mov     r0, scno
        bl      __ipipe_syscall_root
        cmp     r0, #0
        ldmfd   sp!, {r0-r3, ip}
        blt     __ipipe_ret_fast_syscall
        bgt     __ipipe_fast_exit_syscall
#endif /* CONFIG_IPIPE */

...


My Patch:

--- ipipe-root.c.orig  2006-10-09 10:42:11.000000000 +0200
+++ ipipe-root.c  2006-10-09 10:42:26.000000000 +0200
@@ -339,7 +339,7 @@
=20
        /* We use r7 to pass the syscall number to the other domains */
        origr7 =3D regs->ARM_r7;
-       regs->ARM_r7 =3D __NR_SYSCALL_BASE + scno;
+       scno=3Dregs->ARM_r7 =3D __NR_SYSCALL_BASE + scno;
=20
        /*
         * This routine either returns:





Manfred

--=-cb0+x/Vn1c8HrljXuWXC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFKg3SbMvu5jIEpfsRAuzMAJ43WhMbaTT/cqpkhrdEiro4oGmtgQCfZaaD
MtxyjpyoMP2NduTmI+YnbOg=
=ydSG
-----END PGP SIGNATURE-----

--=-cb0+x/Vn1c8HrljXuWXC--


