Message-ID: <2ff1a98a0712030552y1c9b10b8p54730d45f6245906@domain.hid>
Date: Mon, 3 Dec 2007 14:52:35 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D375EEC@slcmail.slc.mew.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int>
	<2ff1a98a0711270657y63482de1ref80ba849f172918@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375D71@domain.hid>
	<18259.5205.292521.503167@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int>
	<2ff1a98a0712030235vfc316b8nff4b1e422db82c96@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375EEC@slcmail.slc.mew.int>
Subject: Re: [Xenomai-help] wathcdog
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Dec 3, 2007 2:35 PM, Steven Seeger
<sseeger@domain.hid> wrote:
> > Now that I think about it, there is little you can safely do when the
> > nucleus kills a runaway thread. Imagine that the killed thread held a
> > mutex: if you try to lock this mutex in the cleanup routines, you will
> > wait forever. So, the only thing you can do safely is call exit and
> > rely on xenomai to cleanup things properly.
>
> Stupid me. I've never used Xenomai handlers (only read about them) so I
> forgot that you can register handlers for signals. Stupid me. :(

The rt_task_catch service is only available to kernel-space tasks. In
order to register a handler for SIGRTMAX in user-space, you will have
to use the posix services, i.e. signal or sigaction. Actually, I am
the one to blame since I sent a patch and did not explain how to use
it.

What you have to do is to call rt_task_set_mode (respectively
pthread_set_mode_np) to arm the T_SIGWDG (respectively
PTHREAD_SIG_WDG) bit. Upon deletion of a thread by Xenomai watchdog,
the thread which called rt_task_set_mode or pthread_set_mode_np will
be notified with a SIGRTMAX signal. You are then free to run any
cleanup you want.

>
> I see what you mean by this. Perhaps we need a notion of cleanup
> handlers for when a thread is killed? This way you can release a mutex.

This is way more complicated than the current implementation of the
watchdog: it calls xnpod_delete_thread, which leaves no chance to the
thread to execute any user-space code.

> Of course, you could simply make a rule by documentation that any
> cleanup handlers you call can't depend on certain mutexes being
> unlocked. In my case, all I want to do is something in the Linux domain
> to log the fault and then abort(). Can we use the approach you came up
> with in your other email and send a siginfo with the PID of the thread
> killed? Ultimately what I want to do is print the name of the thread to
> my logfile.

Currently, the nucleus offers no way to pass a struct siginfo when
sending a signal to a user-space
but I guess this could be changed. Philippe what do you think, should
we extend the current lostage_apc to support passing a siginfo
structure ? Or should we use another apc ? (Actually, the posix skin
uses another apc to pass the siginfo structure, so what we could do is
simply move the posix apc to shadow.c).
>
> Steven
>
>



-- 
                                               Gilles Chanteperdrix

