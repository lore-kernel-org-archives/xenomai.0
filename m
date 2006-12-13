Message-ID: <4580307C.3040401@domain.hid>
Date: Wed, 13 Dec 2006 17:55:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45802F00.1090008@domain.hid>
In-Reply-To: <45802F00.1090008@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF899F74983FA11857186AB3F"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] Re: [PATCH] 2.6.19: Fix irq_disable in early
	start_kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF899F74983FA11857186AB3F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi Philippe,
>=20
> this was a nice bug: After applying some totally unrelated cleanup patc=
h
> that removes a few useless EXPORT_SYMBOLS from ipipe, I got this during=

> boot:
>=20
> ...
> Xenomai: hal/x86 started.
> BUG: unable to handle kernel NULL pointer dereference at virtual addres=
s
> 000000f1
> ...
> EIP is at kref_get+0x9/0x43
> ...
> Call Trace:
>  [<c020e077>] kobject_get+0x12/0x17
>  [<c01c28ae>] sysfs_create_link+0xda/0x140
>  [<c02412bb>] class_device_add+0x217/0x3dc
>  [<c0241492>] class_device_register+0x12/0x15
>  [<c0241519>] class_device_create+0x84/0xa5
>  [<c022fe47>] misc_register+0x109/0x140
>  [<c0142748>] xnheap_mount+0x9a/0xa2
>  [<c03fad0c>] __xeno_sys_init+0xd9/0x15d
>  [<c01004d0>] init+0x127/0x2dc
>  [<c0103e97>] kernel_thread_helper+0x7/0x10
>=20
> The reason: xnheap_dev.dev=3D1!? But that field is located untouched in=
 a
> static structure, i.e. *must* be 0! Interrupting the kernel shortly
> after boot already returned it as 1. Finally, after breaking at the
> beginning of start_kernel, I got the expected 0 and then quickly found
> the messed-up piece of code a few lines below.
>=20
> Please apply attached patch, I suspect it is a typo (ipipe isn't
> initialised at this point to handle such requests, so the stall bit
> ended up in xnheap_dev for me - who knows what can happen on other
> setups...).
>=20
> Jan
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> ---
>  init/main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: linux-2.6.19/init/main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.19.orig/init/main.c
> +++ linux-2.6.19/init/main.c
> @@ -489,7 +489,7 @@ asmlinkage void __init start_kernel(void
>  	unwind_init();
>  	lockdep_init();
> =20
> -	local_irq_disable_head();
> +	local_irq_disable_hw();

Hmm, while hitting "Send" I wondered if lockdep may additionally want

+	trace_hardirqs_off();

to be happily initialised. Dunno yet, but it looks reasonable.

>  	early_boot_irqs_off();
>  	early_init_irq_lock_class();
> =20



--------------enigF899F74983FA11857186AB3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgDB8niDOoMHTA+kRAv0KAJ4pCeFV6SZA9T241CQQnRhf5Agt5wCfQYcd
jvNZjucYg4hHJ6NGZLAZVmk=
=3jZB
-----END PGP SIGNATURE-----

--------------enigF899F74983FA11857186AB3F--

