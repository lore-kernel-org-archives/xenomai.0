Message-ID: <4A1BCD08.8080505@domain.hid>
Date: Tue, 26 May 2009 13:05:44 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <200905251736.07951.shashank.bhatia@domain.hid>
	<4A1A9F29.8050806@domain.hid>
	<200905261113.24697.shashank.bhatia@domain.hid>
In-Reply-To: <200905261113.24697.shashank.bhatia@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA8CA583E88A783B28CBB2A5D"
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
--------------enigA8CA583E88A783B28CBB2A5D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Shashank Bhatia schrieb:
> Thanks a lot, i got my ISR working. I was also looking for some tutoria=
l on=20
> RTDM, do you have any source for it ?

this helped me to implement a rtdm driver:

1) captain.at: Hard Real Time Driver Example Tutorial with MMAP using the=
 RTDM [1]
   -> simple examples

2) Ondrej Cevan: Installation and Implementation of Xenomai on an Industr=
ial
   Component and Porting a Driver for an Industrial IO-Card to the Xenoma=
i
   Infrastructure [2]
 -> See chapter 4 "Linux Driver" and Chapter 5 "Xenomai RTDM Driver"

3) Xenomai Source: ksrc/drivers/*

[1] http://www.captain.at/xenomai-real-time-driver-example.php
[2] http://stud3.tuwien.ac.at/~e0226686/xenomai/xenomai_implementation.pd=
f

good luck
kisda


> Thanks ,
> Shashank
>=20
>=20
>=20
> On Mon May 25 2009 07:07:45 pm you wrote:
>> Hi,
>>
>> the rt_intr_* functions are disabled by default in the kernel configur=
ation
>> [1].
>>
>> You can enable them here:
>> Real-time subsystem -> Interfaces -> Native API -> Interrupts
>>
>> For device drivers its suggested that you use the RTDM skin and not th=
e
>> rt_intr_* calls from the native API.
>>
>> kisda
>>
>> [1] https://mail.gna.org/public/xenomai-help/2006-07/msg00197.html
>>
>> Shashank Bhatia schrieb:
>>> Dear All,
>>>
>>> I was trying to make a simple kernel module, and was unable to insert=
 it
>>> into the kernel space. The code and Error messages are provided
>>> hereunder:
>>>
>>>
>>> Code:
>>> #include <native/task.h>
>>> #include <native/timer.h>
>>> #include <native/intr.h>
>>>
>>> #define STACK_SIZE         0
>>>
>>> RT_INTR isrDesc;
>>>
>>>
>>> int isrKbdHandler(struct xnintr* _idesc) {
>>>
>>>
>>>   printk("module: catch a key\n");
>>>
>>>   return RT_INTR_PROPAGATE;
>>>
>>> }
>>>
>>>
>>>
>>> int init_module (void) {
>>>
>>>   printk("module: Init\n");
>>>   rt_intr_create(&isrDesc, "kbdisr", (unsigned)1, &isrKbdHandler, NUL=
L,
>>> 0); rt_intr_enable(&isrDesc);
>>>
>>>
>>>   return 0;
>>> }
>>>
>>>
>>>
>>> void cleanup_module (void) {
>>>
>>>
>>>   rt_intr_delete(&isrDesc);
>>>
>>>   printk("module: exit\n");
>>> }
>>>
>>> MODULE_LICENSE("GPL");
>>>
>>>
>>>
>>>
>>> Makefile:
>>>
>>>
>>> obj-m  =3D module.o
>>>
>>>
>>> KDIR	=3D /lib/modules/$(shell uname -r)/build
>>> PWD		=3D $(shell pwd)
>>> EXTRA_CFLAGS =3D -I/usr/xenomai/include -I/usr/include/
>>> default:
>>> 	$(MAKE) -C $(KDIR) SUBDIRS=3D$(PWD) modules
>>>
>>> clean:
>>> 	rm -f *.o *.ko *.mod.c *symvers *~
>>>
>>>
>>>
>>> Error message:
>>> make -C /lib/modules/2.6.25.11-default/build
>>> SUBDIRS=3D/home/bhatia/rtprog/interupt modules
>>> make[1]: Entering directory `/usr/src/linux-2.6.25.11'
>>>   CC [M]  /home/bhatia/rtprog/interupt/module.o
>>>   Building modules, stage 2.
>>>   MODPOST 1 modules
>>> WARNING: "rt_intr_enable" [/home/bhatia/rtprog/interupt/module.ko]
>>> undefined! WARNING: "rt_intr_create"
>>> [/home/bhatia/rtprog/interupt/module.ko] undefined! WARNING:
>>> "rt_intr_delete" [/home/bhatia/rtprog/interupt/module.ko] undefined! =
CC =20
>>>    /home/bhatia/rtprog/interupt/module.mod.o
>>>   LD [M]  /home/bhatia/rtprog/interupt/module.ko
>>> make[1]: Leaving directory `/usr/src/linux-2.6.25.11'
>>>
>>>
>>>
>>> Error while insmoding:
>>> insmod: error inserting './module.ko': -1 Unknown symbol in module
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>> Thanks and Regards,
>>>
>>> Shashank
>>>
>>> -------------------------------------
>>> Hi-Tech Gears Limited, Gurgaon, India
>>>
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>=20
>=20
>=20
> -------------------------------------
> Hi-Tech Gears Limited, Gurgaon, India
>=20
>=20
>=20
>=20
>=20



--------------enigA8CA583E88A783B28CBB2A5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKG80PIPTw9rIdn6oRAueuAJ4zBEva4XMPiQA9nGHUEDpYS9IEzQCffyv6
K+RZQF0iZX/q2jI2454D48E=
=JcOO
-----END PGP SIGNATURE-----

--------------enigA8CA583E88A783B28CBB2A5D--

