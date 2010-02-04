From: Sinisa Denic <sinisa.denic@domain.hid>
Date: Thu, 4 Feb 2010 17:36:56 +0100
References: <fd55ced7db48fe30f8139df895fb9d4c.squirrel@domain.hid>
	<201002041515.13220.sinisa.denic@domain.hid>
	<4B6AD8CF.4060706@domain.hid>
In-Reply-To: <4B6AD8CF.4060706@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201002041736.56657.sinisa.denic@domain.hid>
Subject: Re: [Xenomai-help] xenomai 2.5.0 uclibc 0.30 compatibility?
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
Cc: xenomai@xenomai.org.

On Thursday 04 February 2010 15:25:19 you wrote:
> Sinisa Denic wrote:
> > On Thursday 04 February 2010 14:21:27 you wrote:
> >> Sinisa Denic wrote:
> >>> On Wednesday 03 February 2010 19:30:00 you wrote:
> >>>> Sinisa Denic wrote:
> >>>>> On Monday 01 February 2010 14:07:15 Gilles Chanteperdrix wrote:
> >>>>>> Sinisa Denic wrote:
> >>>>>>> On Sunday 31 January 2010 11:31:28 Gilles Chanteperdrix wrote:
> >>>>>>>> This is bad news, the problem is that uclibc's stdio.h needs
> >>>>>>>> pthread.h, which because of the -I flags we pass is xenomai's
> >>>>>>>> pthread.h, which includes asm/syscall.h, which needs stdio.h.
> >>>>>>>
> >>>>>>> Same thing,
> >>>>>>> I can't figure out which file to include in pthread.h
> >>>>>>> posix/init.c - same error
> >>>>>>> include/asm-arm/xenomai/syscall.h - produce error from start
> >>>>>>> building rtdm ...
> >>>>>>
> >>>>>> In every .c file where you get the error, you should try and inclu=
de
> >>>>>> pthread.h before anything else.
> >>>>>
> >>>>> Ok, now I've got it built. In attach there is a patch, maybe usefull
> >>>>> to someone.
> >>>>
> >>>> Xenomai v2.5.1 should include a cleaner fix (along with the I-pipe f=
or
> >>>> Linux 2.6.30 fixed for the arm926ejs issue, as well as some
> >>>> improvements on at91). So, it would be nice if you could test this
> >>>> release and report.
> >>>
> >>> Ok , previos problems didn't appear, but now I'm getting this:
> >>>
> >>> latency.c:12:22: error: execinfo.h: No such file or directory
> >>> latency.c: In function =E2=80=98mode_sw=E2=80=99:
> >>> latency.c:460: warning: implicit declaration of function =E2=80=98bac=
ktrace=E2=80=99
> >>> latency.c:461: warning: implicit declaration of
> >>> function =E2=80=98backtrace_symbols_fd=E2=80=99
> >>> make[3]: *** [latency-latency.o] Error 1
> >>> make[3]: Leaving directory
> >>> `/opt/pct210_build/xenomai-2.5.1-eabi/src/testsuite/latency'
> >>> make[2]: *** [all-recursive] Error 1
> >>> make[2]: Leaving directory
> >>> `/opt/pct210_build/xenomai-2.5.1-eabi/src/testsuite'
> >>> make[1]: *** [all-recursive] Error 1
> >>> make[1]: Leaving directory `/opt/pct210_build/xenomai-2.5.1-eabi/src'
> >>> make: *** [all-recursive] Error 1
> >>>
> >>> In order to compile xeno2.5.1 I skipped testsuite building and it
> >>> passed
> >>
> >> Ok. Could you try the following patch?
> >>
> >> diff --git a/src/testsuite/latency/latency.c
> >> b/src/testsuite/latency/latency.c
> >> index ca5f1bf..f397b42 100644
> >> --- a/src/testsuite/latency/latency.c
> >> +++ b/src/testsuite/latency/latency.c
> >> @@ -9,7 +9,9 @@
> >>  #include <sys/time.h>
> >>  #include <unistd.h>
> >>
> >> +#ifndef __UCLIBC__
> >>  #include <execinfo.h>
> >> +#endif /* !__UCLIBC__ */
> >>
> >>  #include <native/task.h>
> >>  #include <native/timer.h>
> >> @@ -447,7 +449,13 @@ void faulthand(int sig)
> >>
> >>  void mode_sw(int sig)
> >>  {
> >> +#ifndef __UCLIBC__
> >>  	const char buffer[] =3D "Mode switch, aborting. Backtrace:\n";
> >> +#else /* __UCLIBC__ */
> >> +	const char buffer[] =3D "Mode switch, aborting."
> >> +		" Backtrace unavailable with uclibc.\n";
> >> +#endif /* __UCLIBC__ */
> >> +
> >>  	static void *bt[200];
> >>  	unsigned n;
> >>
> >> @@ -457,8 +465,10 @@ void mode_sw(int sig)
> >>  	}
> >>
> >>  	write(STDERR_FILENO, buffer, sizeof(buffer));
> >> +#ifndef __UCLIBC__
> >>  	n =3D backtrace(bt, sizeof(bt)/sizeof(bt[0]));
> >>  	backtrace_symbols_fd(bt, n, STDERR_FILENO);
> >> +#endif /* !__UCLIBC__ */
> >>
> >>  	signal(sig, SIG_DFL);
> >>  	kill(getpid(), sig);
> >
> > Could you sand as attachment I have malformed patch problem, thanks.
>
> Here it comes.

Ok ,with this patch everthing seems good, I could build without problems.
Thank you Gilles

