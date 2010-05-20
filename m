Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
References: <4BF444C2.9090508@domain.hid>
	<4BF45174.7040802@domain.hid>
Date: Thu, 20 May 2010 09:48:36 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From: "Sinisa Denic" <sinisa.denic@domain.hid>
Message-ID: <op.vczunawf38inye@domain.hid>
In-Reply-To: <4BF45174.7040802@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 19 May 2010 23:00:36 +0200, Gilles Chanteperdrix  =

<gilles.chanteperdrix@xenomai.org> wrote:

> Michael Opdenacker wrote:
>> Bien le bonjour! Un message arriv=C3=A9 =C3=A0 ton adresse Free Elect=
rons....
>>
>> :-)
>>
>> Michael.
>>
>> -------- Original Message --------
>> Subject: 	Re: Xeno2.5 - 2.5.1 API mismatch?
>> Date: 	Wed, 19 May 2010 15:47:59 +0200
>> From: 	Sinisa Denic <sinisa.denic@domain.hid>
>> Organization: 	Advanced Control Systems Belgrade
>> To: 	Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>>
>>
>> On Fri, 05 Feb 2010 17:28:53 +0100, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>> Hi Gilles,
>> I had problems some time ago compiling some software against xeno 2.5=
.2,
>> Now same thing with X2.5.3, when I put include <sys/mman.h>, I've run=
  =

>> into
>> next error messages:
>
> Your makefile is probably not using xeno-config to obtain the
> compilation flags :-)
> Xenomai 2.5.3 introduces a new library, libxenomai, with which you nee=
d
> to link the programs. The issue is probably unrelated to sys/mman.h In=

> case it is, please send me a test program.
>
> Please do not use my address at free-electrons.com, I am no longer
> working for this company (yes, I know, it was short)...
>
>
Ok, was in hurry and it was short way to hear from you, excuse me for th=
at.
It's not such easy to sent you code because, it compiles against some  =

"big'n'ugly"  :-) :-( library of IEC communication protocol
I thought that our arm compiler make error but, the same error with  =

standard x86_64 gcc:

iec_main.c:1036: warning: implicit declaration of function =E2=80=98mloc=
kall=E2=80=99
iec_main.c:1036: error: =E2=80=98MCL_CURRENT=E2=80=99 undeclared (first =
use in this  =

function)
iec_main.c:1036: error: (Each undeclared identifier is reported only onc=
e
iec_main.c:1036: error: for each function it appears in.)
iec_main.c:1036: error: =E2=80=98MCL_FUTURE=E2=80=99 undeclared (first u=
se in this  =

function)

When I put #include <sys/mmap.h>, I get over this errors but run into th=
e  =

next:

Makefile handles xeno-config properly, it could retrieve include and lib=
  =

paths and there is -lxenomai,
take a look on this result of make command:

make MMSLITE_DIR=3D/opt/libMMSLITE-eabi/ XENO_DIR=3D/usr/xenomai-2.5.3-e=
abi  =

CROSS_COMPILE=3D/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-=


/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

iec_main.c -o obj_iecgoose_ld/iec_main.o >> cc.lst 2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

/opt/libMMSLITE-eabi//src/mms_arb.c -o obj_iecgoose_ld/mms_arb.o >> cc.l=
st  =

2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

/opt/libMMSLITE-eabi//src/mmsop_en.c -o obj_iecgoose_ld/mmsop_en.o >>  =

cc.lst 2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

/opt/libMMSLITE-eabi//mvl/src/mvlop_en.c -o obj_iecgoose_ld/mvlop_en.o >=
>  =

cc.lst 2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

/opt/libMMSLITE-eabi//mvl/src/acse/mvl_acse.c -o  =

obj_iecgoose_ld/mvl_acse.o >> cc.lst 2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

/opt/libMMSLITE-eabi//mvl/usr/event.c -o obj_iecgoose_ld/event.o >> cc.l=
st  =

2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

/opt/libMMSLITE-eabi//mvl/usr/logcfgx.c -o obj_iecgoose_ld/logcfgx.o >> =
 =

cc.lst 2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

rdwrind.c -o obj_iecgoose_ld/rdwrind.o >> cc.lst 2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

/opt/libMMSLITE-eabi//mvl/usr/reject.c -o obj_iecgoose_ld/reject.o >>  =

cc.lst 2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

startup.c -o obj_iecgoose_ld/startup.o >> cc.lst 2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc -c  -g   =

-I/opt/libMMSLITE-eabi//inc -DDEBUG_SISCO -DTRUNK_REV=3D\"6403M\"  =

-DCOMMIT_REV=3D\"1137:6318M\" -DMMS_LITE -DMOSI -DLEAN_T -I. -DMVL_UCA  =
 =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

uca_obj.c -o obj_iecgoose_ld/uca_obj.o >> cc.lst 2>&1
/opt/toolchains/arm926t-uclibcgnueabi/usr/bin/arm-linux-gcc      =

-I/usr/xenomai-2.5.3-eabi/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe=
  =

-D__XENO__ -lnative -L/usr/xenomai-2.5.3-eabi/lib -lxenomai -lpthread  =

-o./iecgoose_ld obj_iecgoose_ld/iec_main.o obj_iecgoose_ld/mms_arb.o  =

obj_iecgoose_ld/mmsop_en.o obj_iecgoose_ld/mvlop_en.o  =

obj_iecgoose_ld/mvl_acse.o obj_iecgoose_ld/event.o  =

obj_iecgoose_ld/logcfgx.o obj_iecgoose_ld/rdwrind.o  =

obj_iecgoose_ld/reject.o obj_iecgoose_ld/startup.o  =

obj_iecgoose_ld/uca_obj.o  /opt/libMMSLITE-eabi//lib/mvlu_ld.a  =

/opt/libMMSLITE-eabi//lib/mlogl_ld.a /opt/libMMSLITE-eabi//lib/mmsle_ld.=
a  =

/opt/libMMSLITE-eabi//lib/mmsl_ld.a /opt/libMMSLITE-eabi//lib/mem_ld.a  =

/opt/libMMSLITE-eabi//lib/slog_ld.a /opt/libMMSLITE-eabi//lib/util_ld.a =
 =

/opt/libMMSLITE-eabi//lib/ositp4e_ld.a  =

/opt/libMMSLITE-eabi//lib/asn1l_ld.a  -lm -lpthread -lrt -lnative -stati=
c  =

>> cc.lst 2>&1
make: *** [all] Error 1


I think that is everything all right about it but still getting this:

/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-heap.o): In functio=
n  =

`rt_heap_inquire':
heap.c:(.text+0x6c): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-heap.o): In functio=
n  =

`rt_heap_free':
heap.c:(.text+0xfc): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-heap.o): In functio=
n  =

`rt_heap_alloc':
heap.c:(.text+0x198): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-heap.o): In functio=
n  =

`rt_heap_delete':
heap.c:(.text+0x220): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-heap.o): In functio=
n  =

`rt_heap_bind':
heap.c:(.text+0x3b8): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-heap.o):heap.c:(.te=
xt+0x47c):  =

more undefined references to `__xnsig_dispatch' follow
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-init.o): In functio=
n  =

`__init_xeno_interface':
init.c:(.text+0x18): undefined reference to `xeno_bind_skin_opt'
init.c:(.text+0x98): undefined reference to `xeno_handle_mlock_alert'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-task.o): In functio=
n  =

`rt_task_reply':
task.c:(.text+0x84): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-task.o): In functio=
n  =

`rt_task_receive':
task.c:(.text+0x110): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-task.o): In functio=
n  =

`rt_task_send':
task.c:(.text+0x1a8): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-task.o): In functio=
n  =

`rt_task_slice':
task.c:(.text+0x238): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-task.o): In functio=
n  =

`rt_task_set_mode':
task.c:(.text+0x2cc): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-task.o):task.c:(.te=
xt+0x35c):  =

more undefined references to `__xnsig_dispatch' follow
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-task.o): In functio=
n  =

`rt_task_trampoline':
task.c:(.text+0xbec): undefined reference to `xeno_sigshadow_install_onc=
e'
task.c:(.text+0xc34): undefined reference to `xeno_init_current_mode'
task.c:(.text+0xcb4): undefined reference to `__xnsig_dispatch'
task.c:(.text+0xd00): undefined reference to `xeno_set_current'
task.c:(.text+0xd64): undefined reference to `__xnsig_dispatch'
task.c:(.text+0xdd8): undefined reference to `__xnsig_dispatch'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-task.o): In functio=
n  =

`rt_task_shadow':
task.c:(.text+0xe48): undefined reference to `xeno_fault_stack'
task.c:(.text+0xea8): undefined reference to `xeno_sigshadow_install_onc=
e'
task.c:(.text+0xec4): undefined reference to `xeno_init_current_mode'
task.c:(.text+0xf38): undefined reference to `__xnsig_dispatch'
task.c:(.text+0xf80): undefined reference to `xeno_set_current'
/usr/xenomai-2.5.3-eabi/lib/libnative.a(libnative_la-task.o): In functio=
n  =

`rt_task_create':
task.c:(.text+0xff8): undefined reference to `__xnsig_dispatch'
task.c:(.text+0x1158): undefined reference to `__xnsig_dispatch'
collect2: ld returned 1 exit status




-- =

Using Opera's revolutionary e-mail client: http://www.opera.com/mail/

