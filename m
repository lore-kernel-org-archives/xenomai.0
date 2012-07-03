MIME-Version: 1.0
In-Reply-To: <CAKKWdtdebEv14pJhTvr1qc7u3zTzjCPgZZu6h8k1nnrGnpHNdw@mail.gmail.com>
References: <CAKKWdtfz7+pRjjbE6Ev4zJNZpa45axMePyVar+3MyRyMvcp8aA@mail.gmail.com>
	<4FCF1517.3010904@xenomai.org>
	<CAKKWdtfRyuhDzmvCC-WM66+=ncs+ocbdUuop2TRNThsj6ZAy6g@mail.gmail.com>
	<4FCF1ED5.5000403@xenomai.org>
	<CAKKWdtd6p2-xHH1FdjVzbX-raNtDkvMemALrQBJMgoTb1dScnw@mail.gmail.com>
	<4FCF2751.5070700@xenomai.org> <4FCF4D05.3070502@xenomai.org>
	<4FCF58AF.5040106@xenomai.org> <4FCF5A4C.60704@xenomai.org>
	<4FCF5DED.8060007@xenomai.org> <4FCF60CD.8000709@xenomai.org>
	<4FCF6152.7010002@xenomai.org> <4FCF62DD.10102@xenomai.org>
	<4FCF68CA.8010206@xenomai.org> <4FCF713F.1030603@xenomai.org>
	<4FCF7418.4020805@xenomai.org> <4FCF7576.8030201@xenomai.org>
	<4FCF9A1E.6090706@xenomai.org> <4FCF9AAD.7020707@xenomai.org>
	<4FD1C3EE.1000005@xenomai.org> <4FD1C50D.5010906@xenomai.org>
	<4FD1C60D.401@xenomai.org> <4FD1C67E.5010600@xenomai.org>
	<4FD1C751.5070501@xenomai.org>
	<CAKKWdtdebEv14pJhTvr1qc7u3zTzjCPgZZu6h8k1nnrGnpHNdw@mail.gmail.com>
Date: Tue, 3 Jul 2012 18:01:43 +0200
Message-ID: <CAHue_TUHtzKZ6g1__=jB-y08TRnnZ93t2zY8+C-MAWy7QhH=Pg@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai-2.6.0 instrumentation commands not executing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

I will continue this topic since my problem looks similar.

I'm using linux kernel from *http://git.xenomai.org/ipipe-gch.git/* (ipipe
core-3.2 ) and xenomai 2.6 branch head. Compiling for versatile express
cortex-a9.
I tried to cross-compile a simple program bound_task (can be found in
documentation as example) but i received this:

*arm-unknown-linux-gnueabi-gcc -I/usr/xenomai/include -D_GNU_SOURCE
-D_REENTRANT -D__XENO__ -lnative -L/usr/xenomai/lib -lxenomai -lpthread
-lrt -lrtdk bound_task.c -o bound_task_VEXPRESS
In file included from /usr/xenomai/include/nucleus/trace.h:52,
                 from /usr/xenomai/include/nucleus/system.h:27,
                 from /usr/xenomai/include/asm/xenomai/system_64.h:137,
                 from /usr/xenomai/include/asm/xenomai/system.h:4,
                 from /usr/xenomai/include/nucleus/types.h:36,
                 from /usr/xenomai/include/nucleus/thread.h:25,
                 from /usr/xenomai/include/nucleus/sched.h:31,
                 from /usr/xenomai/include/native/task.h:25,
                 from bound_task.c:2:
/usr/xenomai/include/asm/xenomai/syscall.h: In function '__xn_rdtsc':
/usr/xenomai/include/asm/xenomai/syscall.h:327: warning: left shift count
>=3D width of type
/usr/xenomai/lib/libnative.so: file not recognized: File format not
recognized
collect2: ld returned 1 exit status
make: *** [bound_task] Error 1*

And as far as I'm concerned that means (the underlined line) that my
xenomai libraries are not cross-compiled for ARM (which now I assume have
to be) as well. I know that they are not, cause i omitted the
README.INSTALL of xenomai and run common *./configure* (which I assume
compiles xenomai for x86 or smth) instead of *./configure CFLAGS=3D"...."
LDFLAGS=3D"....." --build=3Di686-pc-linux-gnu --host=3Darm-unknown-linux-gn=
ueabi *or
something similar. So I run the proper configure according to
README.INSTALL for ARM and this is what i receive:

*# ./configure CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3 *" LDFLAGS=3D"-march=
=3Darmv4t"
--build=3Di686-pc-linux-gnu --host=3Darm-unknown-linux-gnueabi

checking build system type... i686-pc-linux-gnu
checking host system type... arm-unknown-linux-gnueabi
checking for a BSD-compatible install... /usr/bin/install -c
checking for arm-unknown-linux-gnueabi-gcc... arm-unknown-linux-gnueabi-gcc
checking whether the C compiler works... no
configure: error: in `/home/marcin/arm/tarballs/xenomai-2.6-5942064':
configure: error: C compiler cannot create executables
See `config.log' for more details*
*
*I've already tried the *-fno-omit-frame-pointer *option and the result is
the same.

As I mentioned I'm compiling for cortex-a9 so the *CFLAGS *should be set as
omap4 setting? as long there is no cortex-a9 setting described...
*(CFLAGS=3D"-march=3Darmv7-a
-mfpu=3Dvfp3 *")

*Any suggestions?

Thank you in advantage!

2012/6/9 ali hagigat <hagigatali@gmail.com>

> I did "make clean" for building the Xenomai user space components and
> now every thing seems OK.
> Xenomai version is 2.6.0.
>
> Thank you.
>
> On Fri, Jun 8, 2012 at 2:05 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On 06/08/2012 11:31 AM, Philippe Gerum wrote:
> >> On 06/08/2012 11:29 AM, Philippe Gerum wrote:
> >>> On 06/08/2012 11:25 AM, Gilles Chanteperdrix wrote:
> >>>> On 06/08/2012 11:20 AM, Philippe Gerum wrote:
> >>>>> On 06/06/2012 08:00 PM, Gilles Chanteperdrix wrote:
> >>>>>> On 06/06/2012 07:57 PM, Gilles Chanteperdrix wrote:
> >>>>>>> On 06/06/2012 05:21 PM, Philippe Gerum wrote:
> >>>>>>>> On 06/06/2012 05:15 PM, Gilles Chanteperdrix wrote:
> >>>>>>>>> On 06/06/2012 05:03 PM, Philippe Gerum wrote:
> >>>>>>>>>> On 06/06/2012 04:27 PM, Gilles Chanteperdrix wrote:
> >>>>>>>>>>> On 06/06/2012 04:02 PM, Gilles Chanteperdrix wrote:
> >>>>>>>>>>>> On 06/06/2012 03:55 PM, Gilles Chanteperdrix wrote:
> >>>>>>>>>>>>> On 06/06/2012 03:53 PM, Philippe Gerum wrote:
> >>>>>>>>>>>>>> On 06/06/2012 03:41 PM, Gilles Chanteperdrix wrote:
> >>>>>>>>>>>>>>> On 06/06/2012 03:25 PM, Philippe Gerum wrote:
> >>>>>>>>>>>>>>>> On 06/06/2012 03:18 PM, Gilles Chanteperdrix wrote:
> >>>>>>>>>>>>>>>>> On 06/06/2012 02:28 PM, Philippe Gerum wrote:
> >>>>>>>>>>>>>>>>>> On 06/06/2012 11:48 AM, Philippe Gerum wrote:
> >>>>>>>>>>>>>>>>>>> On 06/06/2012 11:18 AM, ali hagigat wrote:
> >>>>>>>>>>>>>>>>>>>> Much appreciate for the reply, Mr. Gerum. Here is th=
e
> >>>>>>>>>>>>>>>>>>>> result of ldd
> >>>>>>>>>>>>>>>>>>>> command:
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>
> http://www.xenomai.org/pipermail/xenomai-help/2011-12/msg00012.html
> >>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Alternatively, this patch may work as well (not tested=
,
> >>>>>>>>>>>>>>>>>> but this
> >>>>>>>>>>>>>>>>>> looks like a former issue we had with aggressive
> >>>>>>>>>>>>>>>>>> optimizers):
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> diff --git a/src/skins/posix/init.c
> >>>>>>>>>>>>>>>>>> b/src/skins/posix/init.c
> >>>>>>>>>>>>>>>>>> index 7a338a0..9c7849e 100644
> >>>>>>>>>>>>>>>>>> --- a/src/skins/posix/init.c
> >>>>>>>>>>>>>>>>>> +++ b/src/skins/posix/init.c
> >>>>>>>>>>>>>>>>>> @@ -43,6 +43,7 @@ void pse51_clock_init(int);
> >>>>>>>>>>>>>>>>>> static __attribute__ ((constructor))
> >>>>>>>>>>>>>>>>>> void __init_posix_interface(void)
> >>>>>>>>>>>>>>>>>> {
> >>>>>>>>>>>>>>>>>> + volatile pthread_t tid =3D pthread_self();
> >>>>>>>>>>>>>>>>>> #ifndef CONFIG_XENO_LIBS_DLOPEN
> >>>>>>>>>>>>>>>>>> struct sched_param parm;
> >>>>>>>>>>>>>>>>>> int policy;
> >>>>>>>>>>>>>>>>>> @@ -80,14 +81,14 @@ void __init_posix_interface(void)
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> /* Don't use auto-shadowing if we are likely invoked
> >>>>>>>>>>>>>>>>>> from dlopen. */
> >>>>>>>>>>>>>>>>>> #ifndef CONFIG_XENO_LIBS_DLOPEN
> >>>>>>>>>>>>>>>>>> - err =3D
> >>>>>>>>>>>>>>>>>>
> __real_pthread_getschedparam(pthread_self(),&policy,&parm);
> >>>>>>>>>>>>>>>>>> + err =3D __real_pthread_getschedparam(tid,&policy,&pa=
rm);
> >>>>>>>>>>>>>>>>>> if (err) {
> >>>>>>>>>>>>>>>>>> fprintf(stderr, "Xenomai Posix skin init: "
> >>>>>>>>>>>>>>>>>> "pthread_getschedparam: %s\n", strerror(err));
> >>>>>>>>>>>>>>>>>> exit(EXIT_FAILURE);
> >>>>>>>>>>>>>>>>>> }
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> - err =3D __wrap_pthread_setschedparam(pthread_self(),
> >>>>>>>>>>>>>>>>>> policy,&parm);
> >>>>>>>>>>>>>>>>>> + err =3D __wrap_pthread_setschedparam(tid, policy,&pa=
rm);
> >>>>>>>>>>>>>>>>>> if (err) {
> >>>>>>>>>>>>>>>>>> fprintf(stderr, "Xenomai Posix skin init: "
> >>>>>>>>>>>>>>>>>> "pthread_setschedparam: %s\n", strerror(err));
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> There should not be any issue here, as the pthread_self=
()
> >>>>>>>>>>>>>>>>> is passed as
> >>>>>>>>>>>>>>>>> an argument to the called functions, the syscall is not
> >>>>>>>>>>>>>>>>> inlined directly.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Did you get any disassembly of the faulty code when
> >>>>>>>>>>>>>>>> suggesting
> >>>>>>>>>>>>>>>> -fno-omit-frame-pointer last time you did?
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> No, but I had experienced the problem first hand.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> It would be interesting to know why we have to force a fra=
me
> >>>>>>>>>>>>>> pointer in
> >>>>>>>>>>>>>> there. I'm not comfortable with voodoo fixing, that bug
> >>>>>>>>>>>>>> might bite later
> >>>>>>>>>>>>>> on as gcc's optimizer is unlikely to become less aggressiv=
e
> >>>>>>>>>>>>>> over time.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>> Ah this, I know. I have posted a mail where I explained the
> >>>>>>>>>>>>> problem. I
> >>>>>>>>>>>>> am a bit in a short schedule here, will post the link
> tonight.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> http://xenomai.org/pipermail/xenomai-core/2011-08/msg00029.html
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> In the mails following this one, I found how to fix the
> >>>>>>>>>>> assembly to work
> >>>>>>>>>>> in the omit-frame-pointer case. The real problem is that, at
> >>>>>>>>>>> compilation
> >>>>>>>>>>> time, we have no command-line #defined variable telling us
> whether
> >>>>>>>>>>> compiling with frame pointers enabled. And it does not seem
> >>>>>>>>>>> easy to
> >>>>>>>>>>> write a configure test script, which tests whether frame
> >>>>>>>>>>> pointers are
> >>>>>>>>>>> enabled or not.
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I'd suggest that at some point, we move all the syscall
> >>>>>>>>>> trampolines out
> >>>>>>>>>> of line, and specifically build the resulting file forcing
> >>>>>>>>>> -fno-omit-frame-pointer. Such inlining will always be fragile
> >>>>>>>>>> until we
> >>>>>>>>>> actually control the way that compilation unit is built,
> >>>>>>>>>> regardless of
> >>>>>>>>>> the general settings for CFLAGS.
> >>>>>>>>>>
> >>>>>>>>> In the current 2.6 repository, we force -fno-omit-frame-pointer
> >>>>>>>>> on x86_32.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Yes, but that is crappy. The point is that we don't want to forc=
e
> >>>>>>>> this
> >>>>>>>> for all userland bits. We'd only need this for syscall
> trampolines.
> >>>>>>>>
> >>>>>>> We currently have different flags for compiling xenomai than for
> >>>>>>> passing
> >>>>>>> to the applications (via xeno-config). The problem is that I am n=
ot
> >>>>>>> sure
> >>>>>>> it will not break for instance calling "backtrace" in gdb when
> >>>>>>> breaking
> >>>>>>> inside a xenomai function.
> >>>>>>>
> >>>>>> (mixing code compiled without frame pointers with code compiled wi=
th
> >>>>>> frame pointers I mean).
> >>>>>>
> >>>>>
> >>>>> The only issue is with frame elimination starting with -O2 and abov=
e,
> >>>>> otherwise the backtraces are clean over gdb (just checked), at leas=
t
> >>>>> there does not seem to be any additional problem introduced by
> mixing bp
> >>>>> and no-bp. At any rate, -O0 -g is recommended to get clean and
> detailed
> >>>>> (back)traces anyway, and this is what we pick when --enable-debug i=
s
> >>>>> given.
> >>>>>
> >>>>> We should move each existing inline XENOMAI_SYS/SKINCALL macro into
> its
> >>>>> own C trampoline, group all trampolines into separate compilation
> units,
> >>>>> and build each of these units with -fno-omit-frame-pointer
> >>>>> unconditionally.
> >>>>>
> >>>>> -forge is a good candidate for this, since the number of syscall
> >>>>> trampolines shrunk dramatically compared to 2.x. If any issue would
> be
> >>>>> easily detected based on the output of the new "slackspot" tracer w=
e
> >>>>> have there.
> >>>>>
> >>>> It looks to me like we can simply build xenomai libraries with
> >>>> -fno-omit-frame-pointer, and compile the rest without this option.
> After
> >>>> all, implementation of xenomai services are little more than syscall
> >>>> trampolines.
> >>>>
> >>>
> >>> This is true for 2.x, however -forge will need the other approach.
> >>>
> >>
> >> Unless you only mean lib/cobalt for 3.x, in which case I would agree.
> >>
> > I was thinking 2.x. But yes, we can do the same with lib/cobalt.
> >
> > --
> >                                            Gilles.
> >
> > _______________________________________________
> > Xenomai mailing list
> > Xenomai@xenomai.org
> > http://www.xenomai.org/mailman/listinfo/xenomai
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>



--=20
Marcin Ku=B6ka
