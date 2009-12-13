From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B252909.9090304@domain.hid>
References: <4B240D0B.50603@domain.hid>
	<1260723757.2216.2.camel@domain.hid>
	<4B252909.9090304@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 13 Dec 2009 19:05:02 +0100
Message-ID: <1260727502.2216.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [pull request] x86: critical fix for
	native_safe_halt
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Sun, 2009-12-13 at 18:48 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Sat, 2009-12-12 at 22:37 +0100, Jan Kiszka wrote:
> >> Recent moving of ipipe_suspend_domain finally exposed a deeper flaw in
> >> cpu_idle on x86: We failed to check the pipeline log before issuing the
> >> real hlt. This caused IRQ latencies or even drops for Linux,
> >> specifically on SMP. Credits go to plain QEMU whose slow SMP mode caused
> >> ipipe_critical_enter to deadlock frequently enough.
> >>
> >> The first patch of this series fixes this (see below), the second one
> >> simply removes the two useless ipipe_suspend_domain calls.
> >>
> > 
> > What your patch does as well, is killing the ability to run low priority
> > domains below the root level.
> 
> Yes, I'm killing the dream.
> 
> I heavily doubt that the functions I removed in the second patch ever
> contributed something good to this. It's always the job of the lowest
> domain to issue hardware halt, not of some arbitrary mid-prio domain.
> Moreover, what would be the practical use for such model in the context
> of Linux?

That is _not_ the point. The point is, when submitting a patch, please
make sure to raise all the concerns it might introduce wrt to changing
the base features. I'm not opposed to make the feature set evolve, but I
don't want this to happen "by mistake".

> 
> Jan
> 


-- 
Philippe.



