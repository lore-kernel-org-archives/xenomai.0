Message-ID: <4BF4EF31.4060302@domain.hid>
Date: Thu, 20 May 2010 10:13:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BF444C2.9090508@domain.hid>
	<4BF45174.7040802@domain.hid> <op.vczunawf38inye@domain.hid>
In-Reply-To: <op.vczunawf38inye@domain.hid>
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
Cc: xenomai@xenomai.org

Sinisa Denic wrote:
> On Wed, 19 May 2010 23:00:36 +0200, Gilles Chanteperdrix =20
> <gilles.chanteperdrix@xenomai.org> wrote:
>=20
>> Michael Opdenacker wrote:
>>> Bien le bonjour! Un message arriv=C3=A9 =C3=A0 ton adresse Free Elect=
rons....
>>>
>>> :-)
>>>
>>> Michael.
>>>
>>> -------- Original Message --------
>>> Subject: 	Re: Xeno2.5 - 2.5.1 API mismatch?
>>> Date: 	Wed, 19 May 2010 15:47:59 +0200
>>> From: 	Sinisa Denic <sinisa.denic@domain.hid>
>>> Organization: 	Advanced Control Systems Belgrade
>>> To: 	Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>
>>>
>>>
>>> On Fri, 05 Feb 2010 17:28:53 +0100, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Hi Gilles,
>>> I had problems some time ago compiling some software against xeno 2.5=
=2E2,
>>> Now same thing with X2.5.3, when I put include <sys/mman.h>, I've run=
 =20
>>> into
>>> next error messages:
>> Your makefile is probably not using xeno-config to obtain the
>> compilation flags :-)
>> Xenomai 2.5.3 introduces a new library, libxenomai, with which you nee=
d
>> to link the programs. The issue is probably unrelated to sys/mman.h In=

>> case it is, please send me a test program.
>>
>> Please do not use my address at free-electrons.com, I am no longer
>> working for this company (yes, I know, it was short)...
>>
>>
> /opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc     =20
> -I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pip=
e =20
> -D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

> -o./iecgoose_ld obj_iecgoose_ld/iec_main.o obj_iecgoose_ld/mms_arb.o =20
> obj_iecgoose_ld/mmsop_en.o obj_iecgoose_ld/mvlop_en.o =20
> obj_iecgoose_ld/mvl_acse.o obj_iecgoose_ld/event.o =20
> obj_iecgoose_ld/logcfgx.o obj_iecgoose_ld/rdwrind.o =20
> obj_iecgoose_ld/reject.o obj_iecgoose_ld/startup.o =20
> obj_iecgoose_ld/uca_obj.o  /opt/libMMSLITE-eabi//lib/mvlu_ld.a =20
> /opt/libMMSLITE-eabi//lib/mlogl_ld.a /opt/libMMSLITE-eabi//lib/mmsle_ld=
=2Ea =20
> /opt/libMMSLITE-eabi//lib/mmsl_ld.a /opt/libMMSLITE-eabi//lib/mem_ld.a =
=20
> /opt/libMMSLITE-eabi//lib/slog_ld.a /opt/libMMSLITE-eabi//lib/util_ld.a=
 =20
> /opt/libMMSLITE-eabi//lib/ositp4e_ld.a =20
> /opt/libMMSLITE-eabi//lib/asn1l_ld.a  -lm -lpthread -lrt -lnative -stat=
ic =20

link order is wrong here: the list of -l should come after the list of
=2Eo, and if you do that, you will not need to repeat the list of -l.

Your problem is that -lnative is missing in the list of -l you repeat,
but it is better to put the result of xeno-config --xeno-ldflags after
the list of .o (if you are using built-in makefile rules, this means
puttin this in the LOADLIBES variable instead of putting it in LDFLAGS),
and remove the repetition.

--=20
					    Gilles.


