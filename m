Message-ID: <46827843.8000405@domain.hid>
Date: Wed, 27 Jun 2007 16:46:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0706270727m41d21637tc3030ae2c4f6cf06@domain.hid>
In-Reply-To: <7289437c0706270727m41d21637tc3030ae2c4f6cf06@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAC2875BB176D593B54BB9F1E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Problem to compile rtdm module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC2875BB176D593B54BB9F1E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
> Hello,
>=20
> Currently, I use xenomai 2.3.1 on an ARM9.
> I try to cross compile a module for my kernel and I don't find the righ=
t
> way
> to do it, I guess.
>=20
> Here is the code (it's to put the led off and on) :
>=20
> #include <rtdm/rtdm_driver.h>
> MODULE_LICENSE("GPL");
>=20
> rtdm_task_t heartbeat_task;
> int         end =3D 0;
>=20
> #define HEARTBEAT_PERIOD    100000000   /* 100 ms */
> void heartbeat(void *cookie)
> {
> int state =3D 0;
> int led_state[] =3D { 0, 1 };
> while (!end) {
>  rtdm_task_wait_period();
>=20
>  at91_set_gpio_value(AT91_PIN_PB2,led_state[state++]);
>=20
>  if (state > 1)
>   state =3D 0;
> }
> }
>=20
> int init_module(void)
> {
>=20
> leds_init();
> return rtdm_task_init(&heartbeat_task, "heartbeat", heartbeat, NULL,99,=

> HEARTBEAT_PERIOD);
> }
>=20
> void cleanup_module(void)
> {
> end =3D 1;
> rtdm_task_join_nrt(&heartbeat_task, 100);
> at91_led_off(AT91_PIN_PB2);
> }
>=20
> And here is my Makefile :
>=20
> CFLAGS =3D -g -D__KERNEL__ -DMODULE -I/usr/xenomai_arm-2.3.1uClibc/incl=
ude
>=20
> LDFLAGS =3D -D__KERNEL__ -DMODULE
>=20
> test:test_leds.o
>=20
> ld -r -o test.ko -L/usr/xenomai_arm-2.3.1uClibc/lib -lnative -lrtdm
> test_leds.o
>=20
> test_leds.o:test_leds.c
>=20
> arm-linux-gcc $(CFLAGS) -c test_leds.c
>=20
>=20
> When I compile, I have a lot of errors whose the begin is :
>=20
>=20
> In file included from
> /usr/src/ELDK_arm/usr/../arm/usr/include/linux/capability.h:45,
>=20
> from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:46,
>=20
> from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,
>=20
> from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,
>=20
> from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,
>=20
> from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/bitops.h:9,
>=20
> from /usr/xenomai_arm-2.3.1uClibc/include/asm/atomic.h:29,
>=20
> from /usr/xenomai_arm-2.3.1uClibc/include/rtdm/rtdm_driver.h:33,
>=20
> from test_leds.c:21:
>=20
> /usr/src/ELDK_arm/usr/../arm/usr/include/linux/spinlock.h:280: error: p=
arse
> error before '*' token
>=20
> In file included from
> /usr/src/ELDK_arm/usr/../arm/usr/include/linux/jiffies.h:4,
>=20
> from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:51,
>=20
> from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,
>=20
> from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,
>=20
> from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,
>=20
> from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/bitops.h:9,
>=20
> from /usr/xenomai_arm-2.3.1uClibc/include/asm/atomic.h:29,
>=20
> from /usr/xenomai_arm-2.3.1uClibc/include/rtdm/rtdm_driver.h:33,
>=20
> from test_leds.c:21:
>=20
> /usr/src/ELDK_arm/usr/../arm/usr/include/linux/calc64.h: In function
> 'do_div_llr':
>=20
> /usr/src/ELDK_arm/usr/../arm/usr/include/linux/calc64.h:25: error: pars=
e
> error before '__asmeq'
>=20
> In file included from
> /usr/src/ELDK_arm/usr/../arm/usr/include/linux/sched.h:51,
>=20
> from /usr/src/ELDK_arm/usr/../arm/usr/include/linux/ptrace.h:81,
>=20
> from /usr/xenomai_arm-2.3.1uClibc/include/asm/system.h:28,
>=20
> from /usr/src/ELDK_arm/usr/../arm/usr/include/asm/bitops.h:23,
>=20
>=20
>=20
> I think it's a problem of option in the Makefile but I don't see. It's =
the
> first time I do a module for Linux so ...

Have you seen this version of "hearbeat" already?

http://svn.gna.org/viewcvs/xenomai/trunk/examples/rtdm/driver-api/

It's now prepared to handle more than just x86 keyboards. Maybe you want
to put your LED show into this framework as well.

You can build it with the provided Makefile, calling "make
KSRC=3D<kernel-srcdir> XENO=3D<xenomai-userland-instdir> CROSS_COMPILE=3D=
=2E.
ARCH=3D...".

Jan


--------------enigAC2875BB176D593B54BB9F1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgnhDniDOoMHTA+kRAqxuAJ92zZWEpbDT+feWynebT8FW6rL4BgCdF6gc
TsgwzbfIaaeAvBJIYbyMhAw=
=KCM5
-----END PGP SIGNATURE-----

--------------enigAC2875BB176D593B54BB9F1E--

