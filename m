Message-ID: <4585A812.2060605@domain.hid>
Date: Sun, 17 Dec 2006 21:26:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Working example for direct memory mapped IO
References: <200612132248.36493.niklaus.giger@domain.hid>
	<45814E2A.9020106@domain.hid>
	<200612152125.09368.niklaus.giger@domain.hid>
In-Reply-To: <200612152125.09368.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig92A556789FF4465256415298"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92A556789FF4465256415298
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Am Donnerstag, 14. Dezember 2006 14:14 schrieb Jan Kiszka:
>> Niklaus Giger wrote:
>>> Hi
>>>
>>> To document basic Xenomai/Linux patterns I developed the attached sma=
ll
>>> example for our PPC405 board, which just rolls the 8 debug LEDs.
>>>
>>> Are there any comments about it?
>> I like the idea of having useful generic code patterns like this in th=
e
>> examples repos. But I also have a few wishes regarding this particular=
 one:
>>
>>  * I would prefer that generic patterns are coded against POSIX or may=
be
>>    Native, not against a special RTOS skin (not everyone know the
>>    VxWorks API by heart ;) ).
>>
>>  * Try to make use of as less additional patterns beyond the core aspe=
ct
>>    as possible. E.g., running the lights in main would avoid quite som=
e
>>    code for init/cleanup. This helps the reader to grab the essence of=

>>    the demo. Still, the demo should remain functional!
> I used the Linux "sleep" function and could eliminate all RT specifics =
and it=20
> still runs, albeit five times slower on my target.

You could replace sleep() with absolute clock_nanosleep(), kill the
printfs, do an appropriate pthread_setschedparam() on init, and you
would allow to gain determinism again by linking against the POSIX skin.

>>  * Please format your code according to kernel style (could be any
>>    style, but we need a standard, so pick that one)
> Tried, using Documentation/CodingStyle from the kernel. Hope I didn't m=
iss to=20
> many thinks

Just a few +80 char lines and some not-yet-tabs indentions.

>>> Shall I put it into the Wiki at http://www.xenomai.org/index.php/Exam=
ples
>>> or does somebody want to commit it to the examples part of the subver=
sion
>>> trunk?
>> I would happily merge a cleaned up version into the repos, e.g. under
>> the related skin.
> I hope the attached version satisfy you now. Also added some suggestion=
s made=20
> by Stephan Fillod.

Almost :). Find comments below.

>=20
>> PS: If you want to contribute VxWorks-specific code pattern, you are
>> welcome as well!
> Will come to this a little bit later, as I making good progress to port=
 our=20
> existing vxWorks application over to Xenomai. In any case, there is=20
> ksrc/skins/vxworks/demos/satch.c and the the simulator testsuite under
> sim/skins/vxworks/testsuite/. But if you open for each skin a directory=
 (what=20
> could be a good idea) one could add a README pointing to it.

The idea is that those demos get migrated to examples over the time to
let us focus on one repository. If there are some sim-tests that can
serve as examples as well, they could be copied and adopted. Once
someone posts the first vxworks code for inclusion (e.g. a reformatted
and commented existing demo), I'm going to create a new dir and push it
in. Again: all examples should focus on one core idea (one for simple
periodic tasks, one for message queues, ...).

>=20
> Best regards
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> /*
>  * This small examples shows how to access memory directly.
>  *
>  * Copyright (c) 2006 Niklaus Giger <niklaus.giger at member.fsf.org>
>  *
>  * It will only work on PPC405GPr based custom HW board of Nestal Masch=
inen AG
>  *
>  * It should, however, be easily adapted to similar HW
>  * It will scroll across 8 LEDs (interval 1/2 of second), which are map=
ped
>  * to some bit of the GPIO of the PPC405GPr processor.
>  * To sleep it uses the Linux sleep a second, so do not expect a real t=
ime behaviour.

See above.

>  * Compile it with at least -O to expand the inline assembler code.
>  *
>  * You may find another example at http://www.denx.de/wiki/bin/view/\
>  *     PPCEmbedded/DeviceDrivers#Section_AccessingPeripheralsFromUserSp=
ace
>  *     Wherefrom we stole the out_32 and iounmap procedures.
>  *
>  * Fillod Stephane recommends:
>  * "Personally, I always access hardware registers through in_[lbe]{8,1=
6,32}
>  * "out_[lbe]{8,16,32} macros, so the code is portable across machines =
of=20
>  * "different endianess, and thanks to the integrated memory barriers, =

>  * "I known exactly when the CPU will actually perform the I/O with res=
pect=20
>  * "to the other C instructions."=20
>  * These macros are defined e.g. asm-ppc/io.h, but only available to th=
e kernel

This is a user-space demo, right? In what way can the comment above help
the reader then? Might rather cause confusions.

>  *
>  */
>=20
> #include <stdio.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <unistd.h>
>=20
> void  *mapDirectIoRegister(unsigned long addr, size_t length);
> int    iounmap(volatile void *start, size_t length);
> void   sysLedSet(unsigned char value);

Not needed.

>=20
> #define MAP_SIZE			4096UL
> #define MAP_MASK 			(MAP_SIZE - 1)
> #define HCU3_LED_REGISTER               0xEF600700
>=20
> volatile unsigned long *ledRegister;
>=20
> #ifdef __PPC__
> extern inline void out_32(volatile unsigned long *addr, unsigned val)
> {
>         __asm__ __volatile__("stw%U0%X0 %1,%0; eieio" : "=3Dm" (*addr) =
: "r" (val));

Maybe some explanation on this code would be helpful. It contains a
memory barrier, right? The user should find a notice that other arch
/may/ require barriers as well.

> }
> /* etc., cf asm/io.h */
> #else
> extern inline void out_32(volatile unsigned long *addr, unsigned val)
> { * which shows you how to use PPC assembler code to ensure correct IO =
ordering.

???

>=20
>         *addr =3D val & 0xff;

????

> }
> #endif
>=20
> void  *mapDirectIoRegister(unsigned long addr, size_t length)
> {
> 	void *map_base, * virtAddr;
> 	off_t target =3D ((unsigned int) addr) & ~MAP_MASK;
> 	int fd;
> =09
> 	if ((fd =3D open("/dev/mem", O_RDWR | O_SYNC)) =3D=3D -1) {
> 		printf("/dev/mem could not be opened.\n");
> 		exit(1);
> 	}
> =09
> 	// Map one page

/* */ please.

> 	map_base =3D mmap((void *)target, length, PROT_READ | PROT_WRITE, MAP_=
SHARED,
> 			fd, target);
> 	if(map_base =3D=3D (void *) -1) {
> 		printf("Memory map failed for address 0x%lx\n", addr);
> 		return map_base;
> 	}
> =09
> 	virtAddr =3D (void *) ((unsigned long)map_base + ( (unsigned long)addr=
 & MAP_MASK));
> 	printf("Memory map 0x%lx -> %p offset 0x%lx virtual %p\n", addr, map_b=
ase,
> 		addr & MAP_MASK, virtAddr);
> 	return virtAddr;
> }
>=20
> int iounmap(volatile void *start, size_t length)
> {
> 	unsigned long ofs_addr;
> 	ofs_addr =3D (unsigned long)start & (getpagesize()-1);
> =09
> 	/* do some cleanup when you're done with it */
> 	return munmap((void*)start-ofs_addr, length+ofs_addr);
> }
>=20
> void   sysLedSet(unsigned char value)
> {
> 	/* For obscure HW reasons, we have to negated it and shift the value 2=
3 bits to the left  */

Means: on your specific board? Please make this explicit.

> 	*ledRegister =3D (( unsigned long ) ~value << 23) ;
>         out_32(ledRegister, ( unsigned long ) ~value << 23);
> }
>=20
> int main (int argc, char *argv[])
> {
> 	unsigned char j;
> 	printf("%s: %s %s\n", __FUNCTION__, __DATE__, __TIME__ );=20
> =09
> 	/* HW initialisation */
> 	ledRegister     =3D (unsigned long *)mapDirectIoRegister(HCU3_LED_REGI=
STER, MAP_SIZE);
> 	/* next we set the correct control mask in the GPIO_TCR */
> 	ledRegister[1]  =3D 0x7ffe0000; /* Three State Control */
> =09
> 	/* Now scroll our leds and pause a little bit between */
> 	for (j=3D0; j <=3D 8; j++) {
> 		sleep(1);
>                 printf("."); fflush(stdout);
> 		sysLedSet(1 << j);
> 	}
> 	iounmap((volatile void *)HCU3_LED_REGISTER, MAP_SIZE);
> 	printf("\n%s:done\n", __FUNCTION__);=20
> 	return 0;
> }

Thanks again,
Jan


--------------enig92A556789FF4465256415298
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFhagXniDOoMHTA+kRAsIqAJ9dpappywn16j3bF/2ns/2tcNC9lwCfSBuZ
zM88B3IT3HRu6BKzY3v6utU=
=KJHv
-----END PGP SIGNATURE-----

--------------enig92A556789FF4465256415298--

