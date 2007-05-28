Message-ID: <465B13F0.90109@domain.hid>
Date: Mon, 28 May 2007 19:40:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <f3es61$8a2$1@domain.hid>
In-Reply-To: <f3es61$8a2$1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE12EFDDE0139DA897B95A5D2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] add tut02-skeleton
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: trem <tremyfr@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE12EFDDE0139DA897B95A5D2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

trem wrote:
> Hi
>=20
> Here is the second part of the tutorial serie about rtdm. I've just
> added rt-task and semaphore. It's still a very very simple example.

Thanks again for your contribution. I have a few comments below.

>=20
> Now, I don't know how to continue, have you got any idea of
> "topic/subject" that could help people to understand xenomai ?

I think it would be good to dive into IRQ handling as this is part of
most drivers. Have a look at irqbench, specifically the UART part of it,
and the 16550A serial driver. Maybe you can try to create some topics
around a basic null-modem link between a Xenomai box and some other PC.
That would give you an IRQ source, a data source (the transmitted
characters), and enough food for things like synchronisation (mutexes,
spinlocks). Don't reimplement the full 16550A driver, only pick simple
aspects.

>=20
> regards,
> Philippe
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
=2E..
> Index: tut02-skeleton-drv.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- tut02-skeleton-drv.c	(r=E9vision 0)
> +++ tut02-skeleton-drv.c	(r=E9vision 0)
> @@ -0,0 +1,245 @@
> +/*********************************************************************=
******
> + *   Copyright (C) 2007 by trem (Philippe Reynes)                     =
     *
> + *   tremyfr@domain.hid                                                 =
     *
> + *                                                                    =
     *
> + *   This program is free software; you can redistribute it and/or mod=
ify  *
> + *   it under the terms of the GNU General Public License as published=
 by  *
> + *   the Free Software Foundation; either version 2 of the License, or=
     *
> + *   (at your option) any later version.                              =
     *
> + *                                                                    =
     *
> + *   This program is distributed in the hope that it will be useful,  =
     *
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of   =
     *
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the    =
     *
> + *   GNU General Public License for more details.                     =
     *
> + *                                                                    =
     *
> + *   You should have received a copy of the GNU General Public License=
     *
> + *   along with this program; if not, write to the                    =
     *
> + *   Free Software Foundation, Inc.,                                  =
     *
> + *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.        =
     *
> + *********************************************************************=
******/
> +
> +/**
> + * This kernel driver demonstrates how an RTDM device can be set up.

This sounds familiar, like the first example. Doesn't this emphasis a
new, different topic?

> + *
> + * It is a simple device, only 4 operation are provided:
> + *  - open:  start device usage
> + *  - close: ends device usage
> + *  - write: store transfered data in an internal buffer (realtime con=
text)
> + *  - read:  return previously stored data and erase buffer (realtime =
context)
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <rtdm/rtdm_driver.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("trem");
> +
> +#define SIZE_MAX		1024
> +#define DEVICE_NAME		"tut02-skeleton-drv01"
> +#define SOME_SUB_CLASS		4711
> +
> +/**
> + * The structure of the buffer
> + *
> + */
> +typedef struct buffer_s {
> +	int size;
> +	char data[SIZE_MAX];
> +} buffer_t;
> +
> +/**
> + * The global buffer
> + *
> + */
> +buffer_t buffer;
> +
> +/**
> + * The global semaphore
> + *
> + */
> +rtdm_sem_t sem;

Having plain global variables doesn't scale well. That actually makes me
think of further topcis for tutorials:
 o Handling multiple devices with one driver
 o Making use of device context buffers (rtdm_device::context_size)

> +
> +/**
> + * Open the device
> + *
> + * This function is called when the device shall be opened.
> + *
> + */
> +static int simple_rtdm_open_nrt(struct rtdm_dev_context *context,
> +				rtdm_user_info_t * user_info, int oflags)
> +{
> +	return 0;
> +}
> +
> +/**
> + * Open the device
> + *
> + * This function is called when the device shall be opened in realtime=
-context.
> + *
> + */
> +static int simple_rtdm_open_rt(struct rtdm_dev_context *context,
> +				rtdm_user_info_t * user_info, int oflags)
> +{
> +	return 0;
> +}

Don't register separate handlers for the same operation if they are
identical.

> +
> +/**
> + * Close the device
> + *
> + * This function is called when the device shall be closed.
> + *
> + */
> +static int simple_rtdm_close_nrt(struct rtdm_dev_context *context,
> +				 rtdm_user_info_t * user_info)
> +{
> +	return 0;
> +}
> +
> +/**
> + * Close the device
> + *
> + * This function is called when the device shall be closed in realtime=
-context.
> + *
> + */
> +static int simple_rtdm_close_rt(struct rtdm_dev_context *context,
> +				 rtdm_user_info_t * user_info)
> +{
> +	return 0;
> +}

Same here.

> +
> +/**
> + * Read from the device
> + *
> + * This function is called when the device is read in non-realtime con=
text.
> + *
> + */
> +static ssize_t simple_rtdm_read_nrt(struct rtdm_dev_context *context,
> +				    rtdm_user_info_t * user_info, void *buf,
> +				    size_t nbyte)
> +{
> +	rtdm_printk("DEBUG : read is not implemented in non-realtime context\=
n");
> +	return 0;

Don't do this. If there is no nrt handler registered, Xenomai will
nicely switch a shadowed caller into RT mode (when required) and call
simple_rtdm_read_rt instead. With this handler registered, nothing
useful happens. Rather demonstrate context-sensitive handlers by doing
different things with them (but that's advanced stuff anyway).

> +}
> +
> +/**
> + * Read from the device
> + *
> + * This function is called when the device is read in realtime context=
=2E
> + *
> + */
> +static ssize_t simple_rtdm_read_rt(struct rtdm_dev_context *context,
> +				    rtdm_user_info_t * user_info, void *buf,
> +				    size_t nbyte)
> +{
> +	int size;
> +
> +	/* take the semaphore */
> +	rtdm_sem_down(&sem);
> +
> +	/* read the kernel buffer and sent it to user space */
> +	size =3D (buffer.size > nbyte) ? nbyte : buffer.size;
> +	if (rtdm_safe_copy_to_user(user_info, buf, buffer.data, size))
> +		rtdm_printk("ERROR : can't copy data from driver\n");

Send the error code to the user instead of dumping it to the log. The
user will then be able to react on it.

> +
> +	/* clean the kernel buffer */
> +	buffer.size =3D 0;
> +
> +	return size;
> +}
> +
> +/**
> + * Write in the device
> + *
> + * This function is called when the device is written in non-realtime =
context.
> + *
> + */
> +static ssize_t simple_rtdm_write_nrt(struct rtdm_dev_context *context,=

> +				     rtdm_user_info_t * user_info,
> +				     const void *buf, size_t nbyte)
> +{
> +	rtdm_printk("DEBUG : write is not implemented in non-realtime context=
\n");
> +	return 0;
> +}

See above.

> +
> +/**
> + * Write in the device
> + *
> + * This function is called when the device is written in realtime cont=
ext.
> + *
> + */
> +static ssize_t simple_rtdm_write_rt(struct rtdm_dev_context *context,
> +				     rtdm_user_info_t * user_info,
> +				     const void *buf, size_t nbyte)
> +{
> +	/* release the semaphore */
> +	rtdm_sem_up(&sem);

Oops, that creates a race: Data will be written to the buffer AFTER you
signal some reader that there is data available...

> +
> +	/* write the user buffer in the kernel buffer */
> +	buffer.size =3D (nbyte > SIZE_MAX) ? SIZE_MAX : nbyte;
> +	if (rtdm_safe_copy_from_user(user_info, buffer.data, buf, buffer.size=
))
> +		rtdm_printk("ERROR : can't copy data to driver\n");
> +
> +	return nbyte;
> +}
> +
> +/**
> + * This structure describe the simple RTDM device
> + *
> + */
> +static struct rtdm_device device =3D {
> +	.struct_version =3D RTDM_DEVICE_STRUCT_VER,
> +
> +	.device_flags =3D RTDM_NAMED_DEVICE,
> +	.context_size =3D 0,
> +	.device_name =3D DEVICE_NAME,
> +
> +	.open_nrt =3D simple_rtdm_open_nrt,
> +	.open_rt  =3D simple_rtdm_open_rt,
> +
> +	.ops =3D {
> +		.close_nrt =3D simple_rtdm_close_nrt,
> +		.close_rt  =3D simple_rtdm_close_rt,
> +		.read_nrt  =3D simple_rtdm_read_nrt,
> +		.read_rt   =3D simple_rtdm_read_rt,
> +		.write_nrt =3D simple_rtdm_write_nrt,
> +		.write_rt  =3D simple_rtdm_write_rt,
> +	},
> +
> +	.device_class =3D RTDM_CLASS_EXPERIMENTAL,
> +	.device_sub_class =3D SOME_SUB_CLASS,
> +	.profile_version =3D 1,
> +	.driver_name =3D "SimpleRTDM",
> +	.driver_version =3D RTDM_DRIVER_VER(0, 1, 2),
> +	.peripheral_name =3D "Simple RTDM example",
> +	.provider_name =3D "trem",
> +	.proc_name =3D device.device_name,
> +};
> +
> +/**
> + * This function is called when the module is loaded
> + *
> + * It simply registers the RTDM device.
> + *
> + */
> +int __init simple_rtdm_init(void)
> +{
> +	buffer.size =3D 0;		/* clear the buffer */
> +	rtdm_sem_init(&sem, 0);	/* init the global semaphore */
> +
> +	return rtdm_dev_register(&device);
> +}
> +
> +/**
> + * This function is called when the module is unloaded
> + *
> + * It unregister the RTDM device, polling at 1000 ms for pending users=
=2E
> + *
> + */
> +void __exit simple_rtdm_exit(void)
> +{
> +	rtdm_dev_unregister(&device, 1000);
> +}
> +
> +module_init(simple_rtdm_init);
> +module_exit(simple_rtdm_exit);
>=20
> Modification de propri=E9t=E9s sur tut02-skeleton-drv.c
> ___________________________________________________________________
> Nom : svn:eol-style
>    + native
>=20
> Index: Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- Makefile	(r=E9vision 2484)
> +++ Makefile	(copie de travail)
> @@ -1,13 +1,13 @@
>  ###### CONFIGURATION ######
> =20
>  ### List of applications to be build
> -APPLICATIONS =3D tut01-skeleton-app
> +APPLICATIONS =3D tut01-skeleton-app tut02-skeleton-app
> =20
>  ### Note: to override the search path for the xeno-config script, use =
"make XENO=3D..."
> =20
> =20
>  ### List of modules to be build
> -MODULES =3D heartbeat-x86 tut01-skeleton-drv
> +MODULES =3D heartbeat-x86 tut01-skeleton-drv tut02-skeleton-drv
> =20
>  ### Note: to override the kernel source path, use "make KSRC=3D..."
> =20
> @@ -86,6 +86,6 @@
> =20
>  clean::
>  	$(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers
> -	$(RM) -R .tmp*
> +	$(RM) -R *~ .tmp*

This last hunk looks unrelated.

Jan


--------------enigE12EFDDE0139DA897B95A5D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGWxPxniDOoMHTA+kRAlNtAJ9oD42oLOrTtwj4R5HOWfzUL2cajwCdEkei
4INaHwHQ72hUrOp0iypUVtc=
=Mkcb
-----END PGP SIGNATURE-----

--------------enigE12EFDDE0139DA897B95A5D2--

