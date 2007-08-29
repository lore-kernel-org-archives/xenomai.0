From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46D58382.5020201@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F1@domain.hid>
	<46D58382.5020201@domain.hid>
Content-Type: text/plain
Date: Wed, 29 Aug 2007 17:07:07 +0200
Message-Id: <1188400027.6009.147.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] RTDM timeout value
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
Cc: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>, xenomai@xenomai.org

On Wed, 2007-08-29 at 16:32 +0200, Jan Kiszka wrote:
> Markus Osterried (BA/EDD) wrote:
> > Hi,
> > 
> > it seems that in the RTDM API, all the timeout functions which use
> > nanosecs_rel_t have a strange behaviour.
> > The timeout in nanoseconds is converted to ticks and the number of ticks
> > is rounded down. So when we want to wait e.g. 500000 nanoseconds and the
> > timertick is 1 ms, xnpod_ns2ticks() rounds down to 0. But 0 is the
> > special value RTDM_TIMEOUT_INFINITE, so we wait forever. I use Xenomai
> > 2.3.1, but I think it's basically the same in trunk.
> 
> It should even impact other skins as well when in tick-based timing
> mode. I would bet more users of xnpod_ns2ticks() may have overseen this
> rounding issue - like RTDM did.
> 

Other skins may only mean POSIX and native, since the other ones only
deal with ticks.

> > Wouldn't it be better to round up the ticks instead of round it down?
> 
> Hmm, probably. Mind to work out a patch for xnpod_ticks2ns()?
> 
> What do others think about this issue? Can/should we change the rounding
> behaviour at nucleus level?
> 

Clearly not. You don't change the core rounding policy for fixing
shortcomings in the higher levels, especially to fix invalid application
requests. I do want to be able to round down at nucleus level, which I
would not be able to do anymore with a rounding up policy at core level.
This change belongs to the skin which wants this behaviour.

> Thanks for reporting,
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



