Subject: =?UTF-8?Q?Re=3a_Compile_time_error_=22error=3a_call_to_=e2=80=98=5f?=
 =?UTF-8?B?X2NvbXBpbGV0aW1lX2Fzc2VydF8xOTbigJki?=
References: <112066790.3610290.1562394005713.ref@mail.yahoo.com>
 <112066790.3610290.1562394005713@mail.yahoo.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <540c9c03-ade6-923f-bce7-942050080082@web.de>
Date: Sat, 6 Jul 2019 10:48:04 +0200
MIME-Version: 1.0
In-Reply-To: <112066790.3610290.1562394005713@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alex Martin <alex.martin92@ymail.com>, xenomai@xenomai.org

On 06.07.19 08:20, Alex Martin via Xenomai wrote:
> Hi,I get following error during compilation.Compiling on Ubuntu 16.04ker=
nel version 4.19.57 xenomai 3.0.9

You need git master for 4.19 support.

Jan

> Alex
> -------------=3D=3D=3D=3D=3D=3D making target debian/stamp/build/kernel =
[new prereqs: vars]=3D=3D=3D=3D=3D=3D
> This is kernel package version 13.018.
> restore_upstream_debianization
> test ! -f scripts/package/builddeb.kpkg-dist ||=C2=A0=C2=A0 =C2=A0mv -f =
scripts/package/builddeb.kpkg-dist scripts/package/builddeb
> test ! -f scripts/package/Makefile.kpkg-dist ||=C2=A0=C2=A0 =C2=A0mv -f =
scripts/package/Makefile.kpkg-dist scripts/package/Makefile
> /usr/bin/make -j5 EXTRAVERSION=3D-xenomai-3.0.9=C2=A0 ARCH=3Dx86_64 \
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bzImage
> make[1]: Entering directory '/home/user1/src/linux-4.19.57'
> scripts/kconfig/conf=C2=A0 --syncconfig Kconfig
> =C2=A0 DESCEND=C2=A0 objtool
> =C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
> =C2=A0 CHK=C2=A0=C2=A0=C2=A0=C2=A0 include/generated/compile.h
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/xenomai/rtdm/core.o
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/xenomai/posix/thread.o
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/xenomai/rtdm/device.o
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/xenomai/posix/timerfd.o
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/xenomai/rtdm/drvlib.o
> In file included from ./include/trace/define_trace.h:96:0,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/trace/events/cobalt-posix.h:1068,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from kernel/xenomai/posix/thread.c:33:
> ./include/trace/events/cobalt-posix.h: In function =E2=80=98trace_event_=
define_fields_cobalt_void=E2=80=99:
> ./include/linux/compiler.h:348:38: error: call to =E2=80=98__compiletime=
_assert_196=E2=80=99 declared with attribute error: BUILD_BUG_ON failed: 0=
 <=3D 0
> =C2=A0 _compiletime_assert(condition, msg, __compiletime_assert_, __LINE=
__)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^
> ./include/trace/trace_events.h:455:2: note: in definition of macro =E2=
=80=98DECLARE_EVENT_CLASS=E2=80=99
> =C2=A0 tstruct;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0 ^
> ./include/trace/events/cobalt-posix.h:189:2: note: in expansion of macro=
 =E2=80=98TP_STRUCT__entry=E2=80=99
> =C2=A0 TP_STRUCT__entry(
> =C2=A0 ^
> ./include/linux/compiler.h:336:2: note: in expansion of macro =E2=80=98_=
_compiletime_assert=E2=80=99
> =C2=A0 __compiletime_assert(condition, msg, prefix, suffix)
> =C2=A0 ^
> ./include/linux/compiler.h:348:2: note: in expansion of macro =E2=80=98_=
compiletime_assert=E2=80=99
> =C2=A0 _compiletime_assert(condition, msg, __compiletime_assert_, __LINE=
__)
> =C2=A0 ^
> ./include/linux/build_bug.h:45:37: note: in expansion of macro =E2=80=98=
compiletime_assert=E2=80=99
> =C2=A0#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), ms=
g)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> ./include/linux/build_bug.h:69:2: note: in expansion of macro =E2=80=98B=
UILD_BUG_ON_MSG=E2=80=99
> =C2=A0 BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> =C2=A0 ^
> ./include/trace/trace_events.h:425:3: note: in expansion of macro =E2=80=
=98BUILD_BUG_ON=E2=80=99
> =C2=A0=C2=A0 BUILD_BUG_ON(len <=3D 0);=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0 ^
> ./include/trace/events/cobalt-posix.h:190:3: note: in expansion of macro=
 =E2=80=98__array=E2=80=99
> =C2=A0=C2=A0 __array(char, dummy, 0)
> =C2=A0=C2=A0 ^
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/cpu.o
> scripts/Makefile.build:303: recipe for target 'kernel/xenomai/posix/thre=
ad.o' failed
> make[4]: *** [kernel/xenomai/posix/thread.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/xenomai/rtdm/fd.o
> scripts/Makefile.build:544: recipe for target 'kernel/xenomai/posix' fai=
led
> make[3]: *** [kernel/xenomai/posix] Error 2
> make[3]: *** Waiting for unfinished jobs....
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/xenomai/rtdm/wrappers.o
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/exit.o
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/softirq.o
> =C2=A0 AR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel/xenomai/rtdm/built-in.a
> scripts/Makefile.build:544: recipe for target 'kernel/xenomai' failed
> make[2]: *** [kernel/xenomai] Error 2
> make[2]: *** Waiting for unfinished jobs....
> Makefile:1044: recipe for target 'kernel' failed
> make[1]: *** [kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
> ----------------------------
>


