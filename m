MIME-Version: 1.0
Date: Tue, 4 Jun 2013 22:26:16 +0200
Message-ID: <CAONLcG3gGo=vPGe+x_XBhs2ovXF9nzSkq+jvGP8zZR4daa0_4g@mail.gmail.com>
From: Tom Philips <tom.philips1311@gmail.com>
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
To: xenomai@xenomai.org

We have made a core dump and the crash occurs in pvfree().
See call sequence explanation below.

The actual problem however, seems to be in the libc library.

I'll elaborate.
The crash occurs when using the timer function tm_evafter()

This is the code call sequence of tm_evafter(), pseudo code, annotated a
bit:

tm_evafter()              called from our app
  start_evtimer()
    timerobj_init()       calls timer_create() POSIX function
    timerobj_start()      calls timer_settime() POSIX function
    if (error)            we get an error from timerobj_start()
      timerobj_destroy()  destroy's POSIX timer
      pvlist_remove()
      pvfree()            ==> crashes (but not always)

So in our tests, timer_setime() sometimes returns an error code,
while the timer does seem to be started.
I.e. we get a negative return code from timer_settime(),
errno is set to 22 (EINVAL), but the timer is started anyhow.
All of this was checked in the debugger.

This does not seem correct behaviour of the timer_settime() system call.

Obviously, you will run into problems eventually.
I.e. the above code will clean up the the timer and pv objects and
the code that is called at timer elapse does the same thing.
So you will get a double free of the pv structures.

This only occurs under heavy load.
Not all false timer_settime() errors result in a crash.
I guess it all depends in which order the destruction takes place.

If I ignore the error returned by timerobj_start(), all works fine.

I've tried this on different architectures (ARM, MIPS, x86),
different LIBC versions (2.10, 2.11.3, 2.12, 2.15),
different kernel versions (2.6.29, 2.6.32, 3.2, 3.4.24)
They all exibit the same problem.

We might need to contact the LIBC guys...

--
Tom
