MIME-Version: 1.0
In-Reply-To: <51AEF0A5.6010402@xenomai.org>
References: <CAONLcG3gGo=vPGe+x_XBhs2ovXF9nzSkq+jvGP8zZR4daa0_4g@mail.gmail.com>
	<51AEF0A5.6010402@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Wed, 5 Jun 2013 10:28:38 +0200
Message-ID: <CAMJ=MEe-gaqb-wUeVPnx-9O+bL+LyCBsndrBucji5c9vqwiJDQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [xenomai-forge] psos: crash while stressing event
	timers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Jun 5, 2013 at 10:02 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 06/04/2013 10:26 PM, Tom Philips wrote:
> > We have made a core dump and the crash occurs in pvfree().
> > See call sequence explanation below.
> >
> > The actual problem however, seems to be in the libc library.
> >
> > I'll elaborate.
> > The crash occurs when using the timer function tm_evafter()
> >
> > This is the code call sequence of tm_evafter(), pseudo code, annotated a
> > bit:
> >
> > tm_evafter()              called from our app
> >    start_evtimer()
> >      timerobj_init()       calls timer_create() POSIX function
> >      timerobj_start()      calls timer_settime() POSIX function
> >      if (error)            we get an error from timerobj_start()
> >        timerobj_destroy()  destroy's POSIX timer
> >        pvlist_remove()
> >        pvfree()            ==> crashes (but not always)
> >
> > So in our tests, timer_setime() sometimes returns an error code,
> > while the timer does seem to be started.
> > I.e. we get a negative return code from timer_settime(),
> > errno is set to 22 (EINVAL), but the timer is started anyhow.
> > All of this was checked in the debugger.
> >
> > This does not seem correct behaviour of the timer_settime() system call.
> >
> > Obviously, you will run into problems eventually.
> > I.e. the above code will clean up the the timer and pv objects and
> > the code that is called at timer elapse does the same thing.
> > So you will get a double free of the pv structures.
> >
> > This only occurs under heavy load.
> > Not all false timer_settime() errors result in a crash.
> > I guess it all depends in which order the destruction takes place.
> >
> > If I ignore the error returned by timerobj_start(), all works fine.
> >
> > I've tried this on different architectures (ARM, MIPS, x86),
> > different LIBC versions (2.10, 2.11.3, 2.12, 2.15),
> > different kernel versions (2.6.29, 2.6.32, 3.2, 3.4.24)
> > They all exibit the same problem.
> >
> > We might need to contact the LIBC guys...
> >
>
> Thanks for the detailed analysis, it makes sense for sure. However,
> since timer_settime() should resolve as a plain kernel syscall with
> these glibc/kernel combos, I would first suspect Xenomai rather
> than the regular kernel. A few questions more:
>
> - does the patch below cause assertions to be raised when the bug happens?
> (you will need to mention --enable-assert or --enable-debug when
> configuring).
>
> diff --git a/lib/copperplate/timerobj.c b/lib/copperplate/timerobj.c
> index a367cb1..b917a47 100644
> --- a/lib/copperplate/timerobj.c
> +++ b/lib/copperplate/timerobj.c
> @@ -306,8 +306,12 @@ int timerobj_start(struct timerobj *tmobj,
>         write_unlock(&svlock);
>         timerobj_unlock(tmobj);
>
> -       if (__RT(timer_settime(tmobj->timer, TIMER_ABSTIME, it, NULL)))
> +       if (__RT(timer_settime(tmobj->timer, TIMER_ABSTIME, it, NULL))) {
> +               assert(timer_getoverrun(tmobj->timer) >= 0);
> +               assert(it->it_value.tv_sec >= 0 && it->it_value.tv_nsec <
> 1000000000);
> +               assert(it->it_interval.tv_sec >= 0 &&
> it->it_interval.tv_nsec < 1000000000);
>                 return __bt(-errno);
> +       }
>
>         return 0;
>  }
>
> - does valgrind detect anything bad when running your test case (e.g. over
> x86)?
>
> - do you have a reasonably simple test case illustrating the bug,
> you could send me?
>

Philippe,

the testcode is attached to the initial mail.
The issue can be reproduced in all kinds of environments.

Ronny


>
> TIA,
>
> --
> Philippe.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
