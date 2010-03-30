Message-ID: <4BB1C88D.8060506@domain.hid>
Date: Tue, 30 Mar 2010 11:46:53 +0200
From: Patrice Kadionik <kadionik@domain.hid>
MIME-Version: 1.0
References: <507168.65506.qm@domain.hid>,
	<4BAF58F7.7070707@domain.hid>
	<B66DE711C138E84F96E6A2EDD078830B5F2A4D39D0@domain.hid>
	<4BB1287B.6020205@domain.hid>
	<4BB1BEF2.5040600@domain.hid>
	<4BB1C719.4000305@domain.hid>
In-Reply-To: <4BB1C719.4000305@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 30/03/2010 11:40, Gilles Chanteperdrix a =C3=A9crit :
> Patrice Kadionik wrote:
>   =20
>> Le 30/03/2010 00:23, Gilles Chanteperdrix a =C3=A9crit :
>>     =20
>>> Huan Fang wrote:
>>>
>>>       =20
>>>> eck_vdso-check-vdso.o ../../skins/native/libnative.la -lpthread -lm
>>>> libtool: link: ../../../scripts/wrap-link.sh nios2-linux-gcc -Wl,-el=
f2flt -o check-vdso check_vdso-check-vdso.o  ../../skins/native/.libs/lib=
native.a -lpthread -lm
>>>> check-vdso.elf2flt(.text+0x16c): In function `main':
>>>> : undefined reference to `xeno_sem_heap'
>>>> check-vdso.elf2flt(.text+0x170): In function `main':
>>>> : undefined reference to `xeno_sem_heap'
>>>> collect2: ld returned 1 exit status
>>>> make[3]: *** [check-vdso] Erreur 1
>>>> make[3]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xeno=
mai-2.5.1/src/testsuite/unit =C2=BB
>>>> make[2]: *** [all-recursive] Erreur 1
>>>> make[2]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xeno=
mai-2.5.1/src/testsuite =C2=BB
>>>> make[1]: *** [all-recursive] Erreur 1
>>>> make[1]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xeno=
mai-2.5.1/src =C2=BB
>>>> make: *** [all-recursive] Erreur 1
>>>>
>>>> what can I do? Please help
>>>>
>>>>         =20
>>> Please try xenomai 2.5.2
>>>
>>>
>>>
>>>       =20
>> Hi Gilles,
>>
>> I've done this with the 2.5.2 version and I have had the same problem.
>> It is the consequence of another one earlier in the compilation proces=
s.
>> After the xenomai configuration for NIOS II:
>> $ ./configure --host=3Dnios2-linux
>>
>> the generated src/include/xeno_config.h configuration file has
>> CONFIG_XENO_FASTSYNCH not configured:
>> ...
>> /* config */
>> /* #undef CONFIG_XENO_FASTSYNCH */
>> ...
>>
>> If you make the compilation, it fails on the src/skins/common/sem_heap=
.c
>> compilation.
>> You have in this files 2 similar functions
>> line 100: static void xeno_init_sem_heaps_inner(void)
>> and
>> line 118: void xeno_init_sem_heaps(void)
>>
>> There is a mismatch in the src/skins/common/sem_heap.h file according =
to
>> the CONFIG_XENO_FASTSYNCH definition (during Xenomai configuration).
>> In this case it conflits with the macro #define xeno_init_sem_heaps()
>> line 9 in the src/skins/common/sem_heap.h file and the void
>> xeno_init_sem_heaps(void) in the src/skins/common/sem_heap.c
>>
>> I don't know what in the right correction to do in the
>> src/skins/common/sem_heap.h file according to the CONFIG_XENO_FASTSYNC=
H
>> definition.
>>
>> If I suppress the line 9 (#define ...) in the
>> src/skins/common/sem_heap.h file, it compiles until problems for
>> src/testsuite/unit  tool:
>> cond-torture.c file. Line 56: problem with the  "if else" structure wh=
en
>> HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL is not defined (the case here).
>>     =20
> Could you show me the compilation log? I think the "else" is simply wro=
ng.
>
>   =20
That is:
nios2-linux-gcc -DHAVE_CONFIG_H -I. -I../../../src/include =20
-I../../../include/posix -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=20
-D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -g -DXENO_POSIX=20
-I../../../include    -MT cond_torture_posix-cond-torture.o -MD -MP -MF=20
.deps/cond_torture_posix-cond-torture.Tpo -c -o=20
cond_torture_posix-cond-torture.o `test -f 'cond-torture.c' || echo=20
'./'`cond-torture.c
cond-torture.c: In function `mutex_init':
cond-torture.c:56: error: syntax error before "else"
make[3]: *** [cond_torture_posix-cond-torture.o] Erreur 1
make[3]: quittant le r=C3=A9pertoire =C2=AB=20
/home/kadionik/Altera/nios2-xenomai/tests/xenomai-2.5.2/src/testsuite/uni=
t =C2=BB

yes the #else is wrong...

Patrice

--=20
--
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" +
+----------------------------------------------------------------------+
+ Patrice Kadionik             http://www.enseirb-matmeca.fr/~kadionik +
+ IMS Laboratory               http://www.ims-bordeaux.fr/             +
+ ENSEIRB-MATMECA              http://www.enseirb-matmeca.fr           +
+ PO BOX 99                    fax   : +33 5.56.37.20.23               +
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               +
+ FRANCE                       mailto:patrice.kadionik@domain.hid +
+----------------------------------------------------------------------+


