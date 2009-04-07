From: Vikesh Rambaran <vikesh.rambaran@domain.hid>
In-Reply-To: <49D9E000.4070009@domain.hid>
References: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
	<49C7899F.5030306@domain.hid>
	<b131c9f0903240037q446193f5hbfdd3ade40ea2af4@domain.hid>
	<49C91B24.2020304@domain.hid>
	<b131c9f0903241437s661b9bd3v504b14f83b1b9c86@domain.hid>
	<49C95A76.4020802@domain.hid>
	<b131c9f0903250636o85af46au240a04ab33ebb599@domain.hid>
	<b131c9f0904060126n12158c5dqd37d71769cc8aff5@domain.hid>
	<49D9E000.4070009@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Apr 2009 12:19:54 +0200
Message-Id: <1239099594.9869.65.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai LTTng support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Mon, 2009-04-06 at 12:57 +0200, Jan Kiszka wrote:
> vikesh rambaran wrote:
> > Hi
> > Apologies for being quiet for a while. Was away for a few days...
> > 
> >>>> Besides that, the kernel does boot although X + keyboard + mouse seems
> >>> to
> >>>> lock up occasionally.
> >>> Is the lockup permanent then, or does the system recover from it later?
> >>>
> >> Lockup is permanent and requires a reboot. I unfortunately do not have a
> >> network connection to a second PC on this setup to see what else is alive.
> >>
> > 
> >>>> It does not seem to be LTTng specific, as i've noticed it with a xenomai
> >>>> enabled kernel only as well. Will try
> >>>> isolating the problem with a vanilla kernel soon.
> >>>>
> >>>> For reference, the other LTT tools used are
> >>>> LTT control  : ltt-control-0.62-23122008
> >>>> LTTV          : lttv-0.12.9-29012009
> >>>>
> >>>> Both obtained from  http://ltt.polymtl.ca/
> >>>>
> > Some feedback
> > 
> > I've managed to test the kernel on three different PCs :
> > intel core 2, intel core duo, amd athlon 64 x 2 (all running 32 bit
> > kernels).
> > 
> > The lockup occurs after a few minutes and is permanent with no network
> > access after the lockup.
> > 
> > Vanilla kernel did not lock up during the hour that i used it
> > 
> > I've just noticed on the intel core 2 PC, dmesg gives an error setting up
> > the hardware clock.
> > Will investigate this one further.
> > 
> > The kernel config is attached.
> > If anyone else has experienced similar issues and found a solution, please
> > let me know
> 
> We've an open ticket from our customer about some mysterious "lockup
> when starting xosview". But the current state is "no longer
> reproducible", even at customer site. :-|
> 
> Your lockup only happens when X is running? Are there any last words on
> the serial console if you redirect kernel messages to it? Otherwise,
> could you also try with nmi_watchdog=2 and
> CONFIG_XENO_HW_NMI_DEBUG_LATENCY enabled?
> 

Latency test ran overnight on the console screen (tty1)
(without logging into X at the gdm login)

Lockup occurs after logging into X. This happens anywhere from a few
seconds to a few minutes after login.

Will try your other two suggestions and provide feedback.

Thanx
Vicki




