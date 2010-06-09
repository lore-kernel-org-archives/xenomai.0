From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100609133841.GA24216@domain.hid>
References: <4C0692A9.2080806@domain.hid>
	<1276080083.18906.52.camel@domain.hid>
	<20100609133841.GA24216@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Jun 2010 16:01:11 +0200
Message-ID: <1276092071.18906.99.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PATCH] Mayday support (was: Re: [RFC] Break out
 of endless user space loops)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-06-09 at 15:38 +0200, Tschaeche IT-Services wrote:
> Not quite sure if i understood correctly. Trying to summarize:
> 
> Triggering the syscall code (to get out of the loop) is initiated
> by the nucleus watchdog (available with CONFIG_XENO_OPT_WATCHDOG)
> and can't be forced manually yet. Right?

Yes.

> 
> Your (Philippe's) commit message says:
> > ...
> > runaway thread situation detected by the nucleus watchdog. Instead of
> > killing the runaway thread bluntly, this feature allows to force a
> > relax on it, despite the syscall-less nature of the code it was
> > ...
> 
> How do i choose between "killing" and "force a relax"?
> Or does the watchdog already set a Linux signal,
> which is handled when the task gets relaxed?
> 

There is no more killing of the runaway task, it always get a SIGXCPU,
after the nucleus forced it to relax, so that you can decide what's
next, but the system does not lock up anymore.

> Then, for testing, i have to do the following:
> - apply patches ;-)

Including the new I-pipe patch.

> - setup the watchdog with an appropriate timeout
> 	(wd_timeout_arg/CONFIG_XENO_OPT_WATCHDOG_TIMEOUT)
> - no changes in our user space application
> - just wait until watchdog forces relaxing the task
> 	which will initiate linux signal handling
> 
> correct?

Correct.

> 
> Thanks for your support,
> 
> 	Olli
> 
> On Wed, Jun 09, 2010 at 12:41:23PM +0200, Philippe Gerum wrote:
> > 
> > I've toyed a bit to find a generic approach for the nucleus to regain
> > complete control over a userland application running in a syscall-less
> > loop.
> > 
> > The original issue was about recovering gracefully from a runaway
> > situation detected by the nucleus watchdog, where a thread would spin in
> > primary mode without issuing any syscall, but this would also apply for
> > real-time signals pending for such a thread. Currently, Xenomai rt
> > signals cannot preempt syscall-less code running in primary mode either.
> > 
> > The major difference between the previous approaches we discussed about
> > and this one, is the fact that we now force the runaway thread to run a
> > piece of valid code that calls into the nucleus. We do not force the
> > thread to run faulty code or at a faulty address anymore. Therefore, we
> > can reuse this feature to improve the rt signal management, without
> > having to forge yet-another signal stack frame for this.
> > 
> > The code introduced only fixes the watchdog related issue, but also does
> > some groundwork for enhancing the rt signal support later. The
> > implementation details can be found here:
> > http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=4cf21a2ae58354819da6475ae869b96c2defda0c
> > 
> > The current mayday support is only available for powerpc and x86 for
> > now, more will come in the next days. To have it enabled, you have to
> > upgrade your I-pipe patch to 2.6.32.15-2.7-00 or 2.6.34-2.7-00 for x86,
> > 2.6.33.5-2.10-01 or 2.6.34-2.10-00 for powerpc. That feature relies on a
> > new interface available from those latest patches.
> > 
> > The current implementation does not break the 2.5.x ABI on purpose, so
> > we could merge it into the stable branch.
> > 
> > We definitely need user feedback on this. Typically, does arming the
> > nucleus watchdog with that patch support in, properly recovers from your
> > favorite "get me out of here" situation? TIA,
> > 
> > You can pull this stuff from
> > git://git.xenomai.org/xenomai-rpm.git, queue/mayday branch.
> > 
> > 
> > -- 
> > Philippe.
> > 
> > 


-- 
Philippe.



