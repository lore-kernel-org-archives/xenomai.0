Message-ID: <4BB1C719.4000305@domain.hid>
Date: Tue, 30 Mar 2010 11:40:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507168.65506.qm@domain.hid>,
	<4BAF58F7.7070707@domain.hid>
	<B66DE711C138E84F96E6A2EDD078830B5F2A4D39D0@domain.hid>
	<4BB1287B.6020205@domain.hid>
	<4BB1BEF2.5040600@domain.hid>
In-Reply-To: <4BB1BEF2.5040600@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem to cross-compile
	Xenomai	user-space	support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrice Kadionik <kadionik@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Patrice Kadionik wrote:
> Le 30/03/2010 00:23, Gilles Chanteperdrix a =C3=A9crit :
>> Huan Fang wrote:
>>   =20
>>> eck_vdso-check-vdso.o ../../skins/native/libnative.la -lpthread -lm
>>> libtool: link: ../../../scripts/wrap-link.sh nios2-linux-gcc -Wl,-elf=
2flt -o check-vdso check_vdso-check-vdso.o  ../../skins/native/.libs/libn=
ative.a -lpthread -lm
>>> check-vdso.elf2flt(.text+0x16c): In function `main':
>>> : undefined reference to `xeno_sem_heap'
>>> check-vdso.elf2flt(.text+0x170): In function `main':
>>> : undefined reference to `xeno_sem_heap'
>>> collect2: ld returned 1 exit status
>>> make[3]: *** [check-vdso] Erreur 1
>>> make[3]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xenom=
ai-2.5.1/src/testsuite/unit =C2=BB
>>> make[2]: *** [all-recursive] Erreur 1
>>> make[2]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xenom=
ai-2.5.1/src/testsuite =C2=BB
>>> make[1]: *** [all-recursive] Erreur 1
>>> make[1]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xenom=
ai-2.5.1/src =C2=BB
>>> make: *** [all-recursive] Erreur 1
>>>
>>> what can I do? Please help
>>>     =20
>> Please try xenomai 2.5.2
>>
>>
>>   =20
> Hi Gilles,
>=20
> I've done this with the 2.5.2 version and I have had the same problem. =

> It is the consequence of another one earlier in the compilation process=
=2E
> After the xenomai configuration for NIOS II:
> $ ./configure --host=3Dnios2-linux
>=20
> the generated src/include/xeno_config.h configuration file has=20
> CONFIG_XENO_FASTSYNCH not configured:
> ...
> /* config */
> /* #undef CONFIG_XENO_FASTSYNCH */
> ...
>=20
> If you make the compilation, it fails on the src/skins/common/sem_heap.=
c=20
> compilation.
> You have in this files 2 similar functions
> line 100: static void xeno_init_sem_heaps_inner(void)
> and
> line 118: void xeno_init_sem_heaps(void)
>=20
> There is a mismatch in the src/skins/common/sem_heap.h file according t=
o=20
> the CONFIG_XENO_FASTSYNCH definition (during Xenomai configuration).
> In this case it conflits with the macro #define xeno_init_sem_heaps()=20
> line 9 in the src/skins/common/sem_heap.h file and the void=20
> xeno_init_sem_heaps(void) in the src/skins/common/sem_heap.c
>=20
> I don't know what in the right correction to do in the=20
> src/skins/common/sem_heap.h file according to the CONFIG_XENO_FASTSYNCH=
=20
> definition.
>=20
> If I suppress the line 9 (#define ...) in the=20
> src/skins/common/sem_heap.h file, it compiles until problems for=20
> src/testsuite/unit  tool:
> cond-torture.c file. Line 56: problem with the  "if else" structure whe=
n=20
> HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL is not defined (the case here).

Could you show me the compilation log? I think the "else" is simply wrong=
=2E

--=20
					    Gilles.


