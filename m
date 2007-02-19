Subject: Re: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45D9989E.4070103@domain.hid>
References: <45D45AEA.50404@domain.hid>	<1171547803.24117.8.camel@domain.hid>
	<45D46704.9050109@domain.hid>	<1171560346.24117.77.camel@domain.hid>
	<45D5746C.1090003@domain.hid>	<45D8DF58.2090804@domain.hid>
	<17880.57781.152126.164326@domain.hid>
	<1171842613.13484.17.camel@domain.hid>
	<17880.60750.537420.707178@domain.hid>
	<45D95218.6000602@domain.hid> <45D9989E.4070103@domain.hid>
Content-Type: text/plain
Date: Mon, 19 Feb 2007 13:36:37 +0100
Message-Id: <1171888597.9958.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2007-02-19 at 13:31 +0100, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Gilles Chanteperdrix wrote:
> >> Philippe Gerum wrote:
> >>  > On Mon, 2007-02-19 at 00:31 +0100, Gilles Chanteperdrix wrote:
> >>  > > Jan Kiszka wrote:
> >>  > >  > Hi Philippe,
> >>  > >  > 
> >>  > >  > I just verfied that the mlockall issue persists. But it doesn't appear
> >>  > >  > to be a regression anymore. This little posix demo exposes it now on
> >>  > >  > both 2.6.20-1.7-02 and 2.6.19-1.6-06 against latest trunk:
> >>  > >  > 
> >>  > >  > #include <stdio.h>
> >>  > >  > #include <sys/mman.h>
> >>  > >  > #include <pthread.h>
> >>  > >  > 
> >>  > >  > int main(int argc, char *argv[])
> >>  > >  > {
> >>  > >  > 	struct sched_param param = { .sched_priority = 10 };
> >>  > >  > 
> >>  > >  > //	mlockall(MCL_CURRENT|MCL_FUTURE);
> >>  > >  > 
> >>  > >  > 	pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
> >>  > >  > 
> >>  > >  > 	printf("shouldn't be printed...\n");
> >>  > >  > 	pause();
> >>  > >  > }
> >>  > >  > 
> >>  > >  > 
> >>  > >  > In contrast, the same done via the native skin (rt_task_shadow) triggers
> >>  > >  > warning and program termination as expected.
> >>  > >  > 
> >>  > >  > It looks to me like the temporary mlockall during libpthread_rt init is
> >>  > >  > not really reverted (but munlockall is actually called) or not
> >>  > >  > propagated to the mm state that is later checked on xnshadow_map.
> >>  > > 
> >>  > > The problem is that the root thread is already shadowed in this program
> >>  > > when pthread_setschedparam is called. So, xnshadow_map is not called and
> >>  > > the flag is not checked.
> >>  > > 
> >>  > 
> >>  > Yep. This makes sense, since kernel-wise, sys_munlockall does clear the
> >>  > VM_LOCKED bit from the caller's mm default flags.
> >>  > 
> >>  > Since this behaviour is specific to the POSIX skin because it silently
> >>  > shadows the main thread as a Xenomai thread from the SCHED_NORMAL class,
> >>  > maybe we should check the mm state in the POSIX thread creation routine
> >>  > too, when SCHED_FIFO or SCHED_RR are passed as the scheduling class.
> >>
> >> The flag is checked if another thread is created, since xnshadow_map is
> >> called. The only solution I see at the moment is to remove the call to
> >> munlockall in the library initialization.
> >>
> > 
> > So this piece of code should trigger again?
> > 
> > #include <stdio.h>
> > #include <sys/mman.h>
> > #include <pthread.h>
> > 
> > void *thread(void *arg)
> > {
> >         struct sched_param param = { .sched_priority = 10 };
> > 
> >         pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
> >         printf("shouldn't be printed...\n");
> >         return NULL;
> > }
> > 
> > int main(int argc, char *argv[])
> > {
> >         pthread_t th;
> > 
> >         pthread_create(&th, NULL, thread, NULL);
> >         pthread_join(th, NULL);
> > }
> > 
> > 
> > Well, it doesn't in fact, and I think I found my regression again. This
> > demo behaves as expected over 1.6-06, but remains silent over I-pipe 1.7-02.
> 
> May this hunk explain the behaviour?
> 

Yes it is; the original version does overwrite the default flags
properly, not the modified one.

> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/arch/i386/patches/adeos-ipipe-2.6.20-i386-1.7-02.patch?a=i386;v=SVN-2.3.x#7755
> 
> munlockall is realised via mlockall, so OR'ing here would never take
> away any flag.
> 
> Jan
> 
-- 
Philippe.



