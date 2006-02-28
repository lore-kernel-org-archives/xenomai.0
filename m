Message-ID: <4404B22D.5000906@domain.hid>
Date: Tue, 28 Feb 2006 21:27:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 16550 compile err: =?ISO-8859-15?Q?=3FRTDM=5F?=
	=?ISO-8859-15?Q?IRQ=5FENABLE=3F_undeclared_=28first_use_in_thi?=
	=?ISO-8859-15?Q?s_function=29?=
References: <4404AE22.3050600@domain.hid>
In-Reply-To: <4404AE22.3050600@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2AB96DA275AB900616F927BC"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2AB96DA275AB900616F927BC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
>  LD      drivers/xenomai/16550A/built-in.o
>  CC [M]  drivers/xenomai/16550A/16550A.o
> /mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121/drivers/xeno=
mai/16550A/16550A.c:
> In function ?rt_16550_interrupt?:
> /mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121/drivers/xeno=
mai/16550A/16550A.c:269:
> error: ?RTDM_IRQ_ENABLE? undeclared (first use in this function)
> /mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121/drivers/xeno=
mai/16550A/16550A.c:269:
> error: (Each undeclared identifier is reported only once
> /mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121/drivers/xeno=
mai/16550A/16550A.c:269:
> error: for each function it appears in.)
> make[4]: *** [drivers/xenomai/16550A/16550A.o] Error 1
> make[3]: *** [drivers/xenomai/16550A] Error 2
> make[2]: *** [drivers/xenomai] Error 2
> make[1]: *** [drivers] Error 2
> make: *** [_all] Error 2
>=20
>=20
> I de-configured 16550, it built fine, so I suspect some recent change
> missed this item.
>=20
> that said, I havent tried _NOENABLE, since im guessing blind.
>=20

Yeah, I'm on it. Here is half of the patch I'm currently preparing:

--- ../ksrc/drivers/16550A/16550A.c     (Revision 624)
+++ ../ksrc/drivers/16550A/16550A.c     (Arbeitskopie)
@@ -238,7 +238,7 @@
     int                     rbytes =3D 0;
     int                     events =3D 0;
     int                     modem;
-    int                     ret =3D RTDM_IRQ_PROPAGATE;
+    int                     ret =3D RTDM_IRQ_NONE;


     ctx =3D rtdm_irq_get_arg(irq_context, struct rt_16550_context);
@@ -266,7 +266,7 @@
                 events |=3D RTSER_EVENT_MODEMLO;
         }

-        ret =3D RTDM_IRQ_ENABLE | RTDM_IRQ_HANDLED;
+        ret =3D RTDM_IRQ_HANDLED;
     }

     if (ctx->in_nwait > 0) {


Jan



--------------enig2AB96DA275AB900616F927BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBLItniDOoMHTA+kRAj51AJ95xDkUuc0+fP8d07SISydp9jkmZgCfZ5vD
590wRUbM0Y22mzGv0pfjr1M=
=Heuj
-----END PGP SIGNATURE-----

--------------enig2AB96DA275AB900616F927BC--

