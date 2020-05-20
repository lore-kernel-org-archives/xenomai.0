MIME-Version: 1.0
References: <CAAvDm6bFLEfm5wMxOpKwsQgn2+gTea=5CuHwGeRk3-X=nXLScg@mail.gmail.com>
 <CABk+T1sBMVKjDhmyJJ1N4Rpfh-9-mAc9OJhBYnDfjyBR2Xpoow@mail.gmail.com>
 <CAAvDm6ZHAwDqSR2CjunNFAPaWx33nF_241hiTdtRL9s_iXNRzQ@mail.gmail.com>
 <CABk+T1toVC75tyF=AbxHMtfTSXhUGCtP4_4fMMHGnNCQFNZ8Jg@mail.gmail.com>
In-Reply-To: <CABk+T1toVC75tyF=AbxHMtfTSXhUGCtP4_4fMMHGnNCQFNZ8Jg@mail.gmail.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Wed, 20 May 2020 14:02:05 +0800
Message-ID: <CAAvDm6aHLdBAOWWurpPuDuBVGmp=Q+8f+6A7ip8vc8ZjgcLC7w@mail.gmail.com>
Subject: Re: Question about the complie skin.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gbcwbz <cwbddzxx@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

Hi,Cheng

   Thank you so much for your reply.

>As I know from Xenomai documentation, the trank folder is for
>compatibility with Xenomai 2.
>And if you really want to write in Xenomai2 manner, you should
>include <native/alarm.h> maybe.
  I have followed your advice and have tried it.I find that the interface
of
*rt_alarm_create *is not same bettween xenomai 2 and xenomai 3.

>>     I complied source code with xenomai *native skin* for months.
>> I did not notice any complie error indeed and the
>> * final binary programs could run well*.
>>     But, i encoutered some problems this time while the source
>> code had called *rt_alarm_create*(still complie the source code with
>> xenomai native skin).Though i have include the corresponding header
>> file(#include <alchemy/timer.h>),gcc complier still complained,
>> "*warning: implicit declaration of function =E2=80=98rt_alarm_create=E2=
=80=99*".
>> (For g++ complier, i got another kind of complie error:
>> " error: =E2=80=98rt_alarm_create=E2=80=99 was not declared in this scop=
e".)
>> Ignore of the warning aforementioned,
>>
>>
>> I could complie the source code successfully with gcc indeed.The the
>> binary program could be started up.But you could not see any output
>> produced by the routine started by rt_alarm_create in the terminal.

*    I still hope to dig deep. I wanna find out why the code
aforementioned *
*in the first email could be compiled  successfully with gcc indeed (and
why *
*the **binary program **could be started up).*
*    Do you have a interest in it?*

    Best regards.
    Look forward to hearing from you.

gbcwbz <cwbddzxx@gmail.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8820=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8811:58=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>   As I know from Xenomai documentation, the trank folder is for
> compatibility with Xenomai 2.
> And if you really want to write in Xenomai2 manner, you should include
> <native/alarm.h> maybe.
>
> xeno-config --native --cflags
> -I/opt/xenomai-3.1/include/trank -D__XENO_COMPAT__
> -I/opt/xenomai-3.1/include/cobalt -I/opt/xenomai-3.1/include
> -D_GNU_SOURCE -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__
> -I/opt/xenomai-3.1/include/alchemy
>
> You wan to use Xenomai2 API, and included header <alchemy/alarm.h> for
> Xenomai3
>
> Regards
> Bryan Cheng
>
> =E5=AD=99=E4=B8=96=E9=BE=99 <sunshilong369@gmail.com> =E4=BA=8E2020=E5=B9=
=B45=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8811:19=E5=86=99=
=E9=81=93=EF=BC=9A
> >
> >      Thank you for the reply.
> > >>     I complied source code with xenomai *native skin* for months.
> > >> I did not notice any complie error indeed and the
> > >> * final binary programs could run well*.
> > >>     But, i encoutered some problems this time while the source
> > >> code had called *rt_alarm_create*(still complie the source code with
> > >> xenomai native skin).Though i have include the corresponding header
> > >> file(#include <alchemy/timer.h>),gcc complier still complained,
> > >> "*warning: implicit declaration of function =E2=80=98rt_alarm_create=
=E2=80=99*".
> > >> (For g++ complier, i got another kind of complie error:
> > >> " error: =E2=80=98rt_alarm_create=E2=80=99 was not declared in this =
scope".)
> > >> Ignore of the warning aforementioned,
> > >>
> > >>
> > >> I could complie the source code successfully with gcc indeed.The the
> > >> binary program could be started up.But you could not see any output
> > >> produced by the routine started by rt_alarm_create in the terminal.
> >
> > > The compatibility wrappers are not very complete.
> >
> >      But, there are wrappers for rt_alarm_create and rt_alarm_start
> indeed.
> > You are able to see the related source code on
> >
> https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/include/trank/native/a=
larm.h
> > and
> https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.1/lib/trank/native.c .
> >
> >     Thank you for your attention to this question.
> >     I would be thankful for any hint on it.
> >
> >
> >
> > gbcwbz <cwbddzxx@gmail.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=889:48=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Hi,
> >>     According to
> >>
> https://xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.h=
tml
> >>
> >> > --native and --skin=3Dnative are accepted for backward compatibility
> purpose. They are stricly equivalent to passing --alchemy --compat.
> >>
> >> You should not use --native in new xenomai3 programs, use --alchemy
> instead.
> >>
> >>
> >> > --compat
> >> >    Enable the Xenomai 2.x compatibility mode for the API/skin
> selected. This switch affects the Alchemy and POSIX APIs, turning on a se=
t
> of source-level compatibility wrappers when present.
> >>
> >> The compatibility wrappers are not very complete.
> >>
> >> Regards
> >> Bryan Cheng
> >>
> >> =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai <xenomai@xenomai.org> =E4=BA=
=8E2020=E5=B9=B45=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881=
:35=E5=86=99=E9=81=93=EF=BC=9A
> >> >
> >> > Hi,
> >> >     I am using xenomai-3.1.
> >> >     I complied source code with xenomai *native skin* for months.
> >> > I did not notice any complie error indeed and the
> >> > * final binary programs could run well*.
> >> >     But, i encoutered some problems this time while the source
> >> > code had called *rt_alarm_create*(still complie the source code with
> >> > xenomai native skin).Though i have include the corresponding header
> >> > file(#include <alchemy/timer.h>),gcc complier still complained,
> >> > "*warning: implicit declaration of function =E2=80=98rt_alarm_create=
=E2=80=99*".
> >> > (For g++ complier, i got another kind of complie error:
> >> > " error: =E2=80=98rt_alarm_create=E2=80=99 was not declared in this =
scope".)
> >> > Ignore of the warning aforementioned,
> >> >
> >> >
> >> > *I could complie the source code successfully with gcc indeed.The th=
e
> >> > binary program could be started up.But you could not see any output
> >> > produced by the routine started by rt_alarm_create in the terminal.*
> >> >
> >> >
> >> > *The source code, retated cmakelist and the complie error are listed
> at the
> >> > end of this email.*
> >> >
> >> > In addition, I noticed that the *usage Options of xeno-config*
> >> > shows it supports these skins:
> >> > posix|vxworks|psos|alchemy|rtdm|smokey|cobalt(*no native skin
> indeed*).
> >> > But,if you* pass "--skin=3Dnative" to xeno-config, it is ok*(no erro=
r
> >> > message outputs) and the final complied binary program could run
> >> > normally in the most cases.
> >> >
> >> >
> >> > * I have sloved this problem by use alchemy skin instead.I have
> thought
> >> > over and over, but i still could not understand.*
> >> > My heart would be full of thanks if you could do me a favor.
> >> >
> >> >
> >> > //source code
> >> > //filename=EF=BC=9A rt_alarmtest.c
> >> > #include <unistd.h>
> >> > #include <stdio.h>
> >> > #include <stdlib.h>
> >> > #include <alchemy/task.h>
> >> > #include <alchemy/timer.h>
> >> > #include <alchemy/alarm.h>
> >> >
> >> > static void alarm_handler(void *arg)
> >> > {
> >> >     printf("enter alarm_routine\n");
> >> > }
> >> >
> >> > int main(int argc, char* argv[])
> >> > {
> >> >     RT_TASK rtMainTask;
> >> >     int ret =3D 0;
> >> >     RT_ALARM alrm;
> >> >
> >> >     rt_task_shadow(&rtMainTask, "main", 1, 0);
> >> >     ret =3D rt_alarm_create(&alrm, "ALARM", alarm_handler, NULL);
> >> >     if(ret !=3D 0)
> >> >     {
> >> >         printf("rt_alarm_create returned error, ret=3D%d\n", ret);
> >> >     }
> >> >
> >> >     ret =3D rt_alarm_start(&alrm, 200000000ULL, 200000000ULL);
> >> >     if(ret !=3D 0)
> >> >     {
> >> >         printf("rt_alarm_start returned error, ret=3D%d\n", ret);
> >> >     }
> >> >
> >> >     printf("loop begin\n");
> >> >     while(1)
> >> >     {
> >> > //      rt_printf("loop ");
> >> >         sleep(1);
> >> >     }
> >> > }
> >> >
> >> > //CMakeList.txt
> >> > cmake_minimum_required(VERSION 3.6)
> >> >
> >> > project(rt_alarmtest)
> >> >
> >> > set(SRCS rt_alarmtest.c)
> >> >
> >> > set(XENO_CONFIG  /usr/xenomai/bin/xeno-config)
> >> > set(XENO_SKIN  native)
> >> >
> >> > execute_process(COMMAND ${XENO_CONFIG} --${XENO_SKIN} --cflags
> >> > OUTPUT_VARIABLE XENO_CFLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
> >> > execute_process(COMMAND ${XENO_CONFIG} --${XENO_SKIN} --ldflags
> >> > OUTPUT_VARIABLE XENO_LDFLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
> >> >
> >> > message(STATUS "Xeno Skin: ${XENO_SKIN}")
> >> > message(STATUS "Xeno cflags: ${XENO_CFLAGS}")
> >> > message(STATUS "Xeno ldflags: ${XENO_LDFLAGS}")
> >> >
> >> > message(STATUS "Xeno source files: ${SRCS}")
> >> >
> >> > set(CMAKE_C_FLAGS "-g")
> >> >
> >> > set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${XENO_CFLAGS}")
> >> > message(STATUS "C_FLAGS: ${CMAKE_C_FLAGS}")
> >> > set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS}
> ${XENO_LDFLAGS}")
> >> > add_executable(rt_alarm_test ${SRCS})
> >> >
> >> > //log of compiling the source code
> >> > #make
> >> > [ 50%] Building C object CMakeFiles/rt_alarm_test.dir/rt_alarm.c.o
> >> > /home/joy/xenomai/rt_alarm/rt_alarm.c: In function =E2=80=98main=E2=
=80=99:
> >> > /home/joy/xenomai/rt_alarm/rt_alarm.c:23:11: warning: implicit
> declaration
> >> > of function =E2=80=98rt_alarm_create=E2=80=99 [-Wimplicit-function-d=
eclaration]
> >> >      ret =3D rt_alarm_create(&alrm, "ALARM", alarm_handler, NULL);
> >> >            ^
> >> > [100%] Linking C executable rt_alarm_test
> >> > [100%] Built target rt_alarm_test
> >> >
> >> > //running log
> >> > $ ./rt_alarm_test
> >> > loop begin
> >> > #No more log, though the program is still running.
> >> > #No output could be seen from the routine which started by the
> >> > rt_alarm_create
> >> > #And you case see the increasement of XSC and CSW indeed.Why?
> >> >
> >> >
> >> > //some related information
> >> > joy@ubt-16-04-wk:~/xenomai$ cat /proc/xenomai/sched/stat
> >> > CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU
> NAME
> >> >   0  44552  38         40         121        0     000480c0    0.0
> main
> >> >   0  44554  2          52         58         0     00048042    0.0
> >> >  timer-internal
> >> >
> >> > joy@ubt-16-04-wk:~/xenomai$ cat /proc/xenomai/sched/stat
> >> > CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU
> NAME
> >> >   0  44552  38         40         121        0     000480c0    0.0
> main
> >> >   0  44554  2          106        112        0     00048042    0.0
> >> >  timer-internal
>
