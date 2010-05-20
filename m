Message-ID: <4BF5070B.8010402@domain.hid>
Date: Thu, 20 May 2010 11:55:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BF444C2.9090508@domain.hid>
	<4BF45174.7040802@domain.hid> <op.vczunawf38inye@domain.hid>
	<4BF4EF31.4060302@domain.hid> <op.vczxulyi38inye@domain.hid>
	<4BF4FB97.5000809@domain.hid> <op.vcz0decz38inye@domain.hid>
In-Reply-To: <op.vcz0decz38inye@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Fwd: Re: Xeno2.5  -  2.5.1 API mismatch?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sinisa Denic <sinisa.denic@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sinisa Denic wrote:
> On Thu, 20 May 2010 11:06:31 +0200, Gilles Chanteperdrix =20
> <gilles.chanteperdrix@xenomai.org> wrote:
>=20
>> Sinisa Denic wrote:
>>>>> /opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc
>>>>> -I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall =
=20
>>>>> -pipe
>>>>> -D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthre=
ad
>>>>> -o./iecgoose_ld obj_iecgoose_ld/iec_main.o obj_iecgoose_ld/mms_arb.=
o
>>>>> obj_iecgoose_ld/mmsop_en.o obj_iecgoose_ld/mvlop_en.o
>>>>> obj_iecgoose_ld/mvl_acse.o obj_iecgoose_ld/event.o
>>>>> obj_iecgoose_ld/logcfgx.o obj_iecgoose_ld/rdwrind.o
>>>>> obj_iecgoose_ld/reject.o obj_iecgoose_ld/startup.o
>>>>> obj_iecgoose_ld/uca_obj.o  /opt/libMMSLITE-eabi//lib/mvlu_ld.a
>>>>> /opt/libMMSLITE-eabi//lib/mlogl_ld.a
>>>>> /opt/libMMSLITE-eabi//lib/mmsle_ld.a
>>>>> /opt/libMMSLITE-eabi//lib/mmsl_ld.a /opt/libMMSLITE-eabi//lib/mem_l=
d.a
>>>>> /opt/libMMSLITE-eabi//lib/slog_ld.a =20
>>>>> /opt/libMMSLITE-eabi//lib/util_ld.a
>>>>> /opt/libMMSLITE-eabi//lib/ositp4e_ld.a
>>>>> /opt/libMMSLITE-eabi//lib/asn1l_ld.a  -lm -lpthread -lrt -lnative
>>>>> -static
>>>> link order is wrong here: the list of -l should come after the list =
of
>>>> .o, and if you do that, you will not need to repeat the list of -l.
>>>>
>>>> Your problem is that -lnative is missing in the list of -l you repea=
t,
>>>> but it is better to put the result of xeno-config --xeno-ldflags aft=
er
>>>> the list of .o (if you are using built-in makefile rules, this means=

>>>> puttin this in the LOADLIBES variable instead of putting it in =20
>>>> LDFLAGS),
>>>> and remove the repetition.
>>>>
>>> Oh thank you, sorry, this is my fault, this isn't my peace of code, j=
ust
>>> working around.
>>> I saw it and it was suspicious to me, but It was supposed to look mor=
e
>>> closely,
>>> Makefile came with library and it is modified to use Xenomai, because=
 of
>>> that it seems such a messy..
>>>
>>> Now it's compiling but, have you idea why these errors appear from
>>> xeno-2.5.1 version,
>>> the same code compiling in xeno-2.4.x even xeno-2.5.0 without errors =
and
>>> no need to add <sys/mman.h> .
>>>
>>> iec_main.c:1037: warning: implicit declaration of function =E2=80=98m=
lockall=E2=80=99
>>> iec_main.c:1037: error: =E2=80=98MCL_CURRENT=E2=80=99 undeclared (fir=
st use in this
>>> function)
>>> iec_main.c:1037: error: (Each undeclared identifier is reported only =
=20
>>> once
>>> iec_main.c:1037: error: for each function it appears in.)
>>> iec_main.c:1037: error: =E2=80=98MCL_FUTURE=E2=80=99 undeclared (firs=
t use in this
>>> function)
>> Before 2.5.2 there was no libxenomai library, so, the list of -l you
>> add: -lpthread -lrt -lnative is sufficient to workaround the fact that=

>> your link order was wrong. It explains the link error.
>>
>> Before 2.5.2, what is now implemented in C files was implemented in
>> header files, which got included all over the place, and these header
>> files included sys/mman.h, but this caused all sort of troubles with
>> some versions of uclibc toolchains, this explains the error about the
>> missing include.
>>
>>
> Gilles thank you very much,
> does it mean that including mman.h is necessary.

Yes, and mlockall man page says so.

--=20
					    Gilles.


