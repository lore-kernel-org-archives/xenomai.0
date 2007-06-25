Message-ID: <467F5CCE.8070806@domain.hid>
Date: Mon, 25 Jun 2007 08:12:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <f48df4840706240643j2046afa0pd69452874264fb1f@domain.hid>	<18046.43281.454448.814965@domain.hid>
	<3f027d060706241451g70504604o6f4cfb7e1997398e@domain.hid>
In-Reply-To: <3f027d060706241451g70504604o6f4cfb7e1997398e@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig768D77D8467CC5DCAE24722A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Problem building and running demos
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Zany Super Chimp <zanychimp@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig768D77D8467CC5DCAE24722A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Zany Super Chimp wrote:
> 2007/6/24, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>
>> Bruno Rouchouse wrote:
>> > Hi Xeno users !
>> >
>> > just trying to play with Xenomai's demos but I'm having some problem=
s
>> > compiling and running some of them.
>> >
>> > Satch for the native skin
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > I have some troubles here compiling satch.
>> >
>> > bruno@domain.hid$ make
>> > cc -o satch satch.c -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRAN=
T
>> > -D__XENO__ -L/usr/xenomai/lib -lpthread -lnative
>> > /usr/lib/gcc/i486-linux-gnu/4.1.2/../../../../lib/crt1.o: In functio=
n
>> > `_start':
>> > ../sysdeps/i386/elf/start.S:115: undefined reference to `main'
>> > collect2: ld returned 1 exit status
>> >
>> > Satch for the posix skin
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > Building process works fine but running satch fails :
>> > My .runinfo file looks like:
>> > satch:posix:!./satch_rt;popall:control_c
>> >
>> > bruno@domain.hid$ xeno-load ./:satch
>> > *
>> > *
>> > * Type ^C to stop this application.
>> > *
>> > *
>> > Satch: producer module not running, please launch producer module
>> before
>> > launching consumer application.
>> > __xeno_user_init: 2
>> >
>> > I understand from xenomai/ksrc/skins/posix/demos/Kbuild and going
>> quickly
>> > through satch.c code that there should be a first module to insmod
>> before
>> > using the consumer module but how/when is the producer module suppos=
ed
>> to be
>> > built? I don't find any other module in my xenomai built tree or in =
my
>> > /lib/modules/*-ipipe kernel.
>>
>> You are supposed to run:
>> make -C /path/to/your/kernel/sources M=3D$PWD modules
>> because you know how to compile kernel modules outside of the kernel
>> tree. You then have a ksatch.ko kernel module. It does not even work
>> with 2.4 kernels.
>=20
>=20
> Well, shame  on me then because I'm not too familiar with kernel module=

> build process ;)
>=20
> I get some warnings though which prevent me from insmoding
> ksatch.koafterwards:
>=20
> bruno@domain.hid$ make -C /usr/src/linux-
> 2.6.20.14-ipipe M=3D$PWD modules
> make: Entering directory `/usr/src/linux-2.6.20.14-ipipe'
>  CC [M]  /home/bruno/xenomai/ksrc/skins/posix/demos/satch.o
>  LD [M]  /home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.o
>  Building modules, stage 2.
>  MODPOST 1 modules
> WARNING: "shm_unlink"
> [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko]
> undefined!
> WARNING: "mmap" [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko]
> undefined!
> WARNING: "ftruncate" [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch=
=2Eko]
> undefined!
> WARNING: "pse51_shm_close"
> [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko] undefined!
> WARNING: "shm_open" [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.=
ko]
> undefined!
> WARNING: "munmap" [/home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko=
]
> undefined!
>  CC      /home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.mod.o
>  LD [M]  /home/bruno/xenomai/ksrc/skins/posix/demos/ksatch.ko
> make: Leaving directory `/usr/src/linux-2.6.20.14-ipipe'
>=20
> Something missing in the Kbuild file? How to reference symbols of the p=
osix
> lib?
>=20
> And then of course, insmoding ksatch.ko fails...
>=20
> sudo modprobe xeno_posix
>=20
> sudo insmod ./ksatch.ko
>=20
> tail -f /var/log/message
>=20
> Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol munmap
> Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol shm_open
> Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol pse51_shm_clos=
e
> Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol ftruncate
> Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol mmap
> Jun 24 23:45:09 localhost kernel: ksatch: Unknown symbol shm_unlink
>=20
> This was more intended as a test for posix shared memory and
>> message queues support, than as a real demo for users. I just did not
>> find anywhere else to put it.
>=20
>=20
> An interesting use case in fact.
>=20
> What we could do is to compile the default version with -DPRODUCER
>> -DCONSUMER so that it would be standalone.
>=20
>=20
> Well from my point of view  a short README on how to build the applicat=
ion
> would be just fine.
> I'll document that in my short "getting started guide" anyway.

Why not move the demos over into the examples repository and integrate
them into the existing build system? Would be a good chance to start
populating the posix folder over there.

Jan


--------------enig768D77D8467CC5DCAE24722A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGf1zOniDOoMHTA+kRAtgaAJ9J9/h3mS7o8CLRxd6DDLhRxeojHACZAbLp
DbuK0gP5PD1piMlC/Di7DCE=
=wmlk
-----END PGP SIGNATURE-----

--------------enig768D77D8467CC5DCAE24722A--

