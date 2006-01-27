Message-ID: <43DA0C2C.5040208@domain.hid>
Date: Fri, 27 Jan 2006 13:03:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Fix to RTDM open problems
References: <43D9F603.8000505@domain.hid>
In-Reply-To: <43D9F603.8000505@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7A09E666903E1F6E9DECD939"
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7A09E666903E1F6E9DECD939
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> When RTDM is exposed to code like this:
>=20
>   device1 =3D rt_dev_open("some_device", O_RDWR);
>   device2 =3D rt_dev_open("some_device", O_RDWR);
>=20
> I get a SEGFAULT, which I attribute to a missing assignment to
> context_ptr in the case when the device is already busy, the lack of
> this assignment leads to a segfault in cleanup_instance.
>=20
>=20
> --- xenomai-2.1-rc2/ksrc/skins/rtdm/core.c~     2006-01-07
> 18:08:34.000000000 +0100
> +++ xenomai-2.1-rc2/ksrc/skins/rtdm/core.c      2006-01-27
> 11:14:43.000000000 +0100
> @@ -136,6 +136,8 @@
>=20
>          if (context->device) {
>              xnlock_put_irqrestore(&rt_dev_lock, s);
> +
> +            *context_ptr =3D NULL;
>              return -EBUSY;
>          }
>          context->device =3D device;
>=20

Yep, correct. Don't know, I must have smoked something while trying to
fix this bug some weeks ago. Thanks for reporting and also providing a
patch.

I just gave it another try, also re-organising the involved function
create_instance() slightly. Please checkout latest SVN or try the
following patch and let me know if this works now, really.

Thanks again,
Jan


Index: core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- core.c      (revision 475)
+++ core.c      (working copy)
@@ -116,13 +116,13 @@
     spl_t                   s;


+    *context_ptr =3D NULL;
+
     xnlock_get_irqsave(&rt_fildes_lock, s);

     *fildes_ptr =3D fildes =3D free_fildes;
-    if (!fildes) {
+    if (unlikely(!fildes)) {
         xnlock_put_irqrestore(&rt_fildes_lock, s);
-
-        *context_ptr =3D NULL;
         return -ENFILE;
     }
     free_fildes =3D fildes->next;
@@ -134,15 +134,13 @@
     if (context) {
         xnlock_get_irqsave(&rt_dev_lock, s);

-        if (context->device) {
+        if (unlikely(context->device)) {
             xnlock_put_irqrestore(&rt_dev_lock, s);
             return -EBUSY;
         }
         context->device =3D device;

         xnlock_put_irqrestore(&rt_dev_lock, s);
-
-        *context_ptr =3D context;
     } else {
         if (nrt_mem)
             context =3D kmalloc(sizeof(struct rtdm_dev_context) +
@@ -150,13 +148,14 @@
         else
             context =3D xnmalloc(sizeof(struct rtdm_dev_context) +
                                device->context_size);
-        *context_ptr =3D context;
-        if (!context)
+        if (unlikely(!context))
             return -ENOMEM;

         context->device =3D device;
     }

+    *context_ptr =3D context;
+
     context->fd  =3D get_fd(fildes);
     context->ops =3D &device->ops;
     atomic_set(&context->close_lock_count, 0);



--------------enig7A09E666903E1F6E9DECD939
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD2gwtniDOoMHTA+kRAhT5AJ49/62Y71PeYpdnnRXQOEZs8+qajACdHKsR
2Vm6CqXaY+KFZNUFNk7X2Z8=
=sSxf
-----END PGP SIGNATURE-----

--------------enig7A09E666903E1F6E9DECD939--

