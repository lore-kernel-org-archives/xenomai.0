Date: Wed, 9 Jun 2010 20:11:53 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100609181153.GA27353@domain.hid>
References: <4C0692A9.2080806@domain.hid>
	<1276080083.18906.52.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276080083.18906.52.camel@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org, xenomai@xenomai.org

On Wed, Jun 09, 2010 at 12:41:23PM +0200, Philippe Gerum wrote:
> We definitely need user feedback on this. Typically, does arming the
> nucleus watchdog with that patch support in, properly recovers from your
> favorite "get me out of here" situation? TIA,
> 
> You can pull this stuff from
> git://git.xenomai.org/xenomai-rpm.git, queue/mayday branch.

manually build a kernel (timeout 1s) with your patches.
user space linked to 2.5.3 libraries without any patches.
Looks fine: the amok task is switched to secondary domain
(we catched the SIGXCPU) running the loop in secondary domain.
then, on a SIGTRAP the task leaves the loop.

also, if SIGTRAP arives before SIGXCPU it looks good,
apart from the latency of 1s.

did not check the ucontext within the exception handler, yet.
would like to setup a reproducible kernel build first...
we will go into deeper testing in 2 weeks.

maybe we need a finer granularity than 1s for the watchdog timeout.
is there a chance?

will your patches be merged in an official 2.5.x version?

thanks for your great support,

	Olli

