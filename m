Message-ID: <4A1A9F29.8050806@domain.hid>
Date: Mon, 25 May 2009 15:37:45 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <200905251736.07951.shashank.bhatia@domain.hid>
In-Reply-To: <200905251736.07951.shashank.bhatia@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF99E3396F95526BBD625C5F0"
Subject: Re: [Xenomai-help] Interrupt service routine problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Shashank Bhatia <shashank.bhatia@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF99E3396F95526BBD625C5F0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

the rt_intr_* functions are disabled by default in the kernel configurati=
on [1].

You can enable them here:
Real-time subsystem -> Interfaces -> Native API -> Interrupts

For device drivers its suggested that you use the RTDM skin and not the
rt_intr_* calls from the native API.

kisda

[1] https://mail.gna.org/public/xenomai-help/2006-07/msg00197.html


Shashank Bhatia schrieb:
> Dear All,
>=20
> I was trying to make a simple kernel module, and was unable to insert i=
t into=20
> the kernel space. The code and Error messages are provided hereunder:
>=20
>=20
> Code:
> #include <native/task.h>
> #include <native/timer.h>
> #include <native/intr.h>
>=20
> #define STACK_SIZE         0=20
>=20
> RT_INTR isrDesc;
>=20
>=20
> int isrKbdHandler(struct xnintr* _idesc) {
>=20
>=20
>   printk("module: catch a key\n");
>=20
>   return RT_INTR_PROPAGATE;=20
>=20
> }
>=20
>=20
>=20
> int init_module (void) {
>=20
>   printk("module: Init\n");
>   rt_intr_create(&isrDesc, "kbdisr", (unsigned)1, &isrKbdHandler, NULL,=
 0);
>   rt_intr_enable(&isrDesc);
>=20
>=20
>   return 0;
> }
>=20
>=20
>=20
> void cleanup_module (void) {
>=20
> =20
>   rt_intr_delete(&isrDesc);
>  =20
>   printk("module: exit\n");
> }
>=20
> MODULE_LICENSE("GPL");
>=20
>=20
>=20
>=20
> Makefile:
>=20
>=20
> obj-m  =3D module.o
>=20
>=20
> KDIR	=3D /lib/modules/$(shell uname -r)/build
> PWD		=3D $(shell pwd)
> EXTRA_CFLAGS =3D -I/usr/xenomai/include -I/usr/include/=20
> default:
> 	$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules
>=20
> clean:
> 	rm -f *.o *.ko *.mod.c *symvers *~
>=20
>=20
>=20
> Error message:
> make -C /lib/modules/2.6.25.11-default/build=20
> SUBDIRS=3D/home/bhatia/rtprog/interupt modules
> make[1]: Entering directory `/usr/src/linux-2.6.25.11'
>   CC [M]  /home/bhatia/rtprog/interupt/module.o
>   Building modules, stage 2.
>   MODPOST 1 modules
> WARNING: "rt_intr_enable" [/home/bhatia/rtprog/interupt/module.ko] unde=
fined!
> WARNING: "rt_intr_create" [/home/bhatia/rtprog/interupt/module.ko] unde=
fined!
> WARNING: "rt_intr_delete" [/home/bhatia/rtprog/interupt/module.ko] unde=
fined!
>   CC      /home/bhatia/rtprog/interupt/module.mod.o
>   LD [M]  /home/bhatia/rtprog/interupt/module.ko
> make[1]: Leaving directory `/usr/src/linux-2.6.25.11'
>=20
>=20
>=20
> Error while insmoding:
> insmod: error inserting './module.ko': -1 Unknown symbol in module
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> Thanks and Regards,
>=20
> Shashank
>=20
> -------------------------------------
> Hi-Tech Gears Limited, Gurgaon, India
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20



--------------enigF99E3396F95526BBD625C5F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKGp8wIPTw9rIdn6oRAlfeAJ9HBD7/jce74H5xju6g6aBobuk4KACfWl3X
ysZLvFC3k+jjYms2+z6HXbU=
=fHU+
-----END PGP SIGNATURE-----

--------------enigF99E3396F95526BBD625C5F0--

