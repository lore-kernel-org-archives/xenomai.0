Message-ID: <2ff1a98a0708290816l1c0dc275v8f0da5188f315640@domain.hid>
Date: Wed, 29 Aug 2007 17:16:26 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1188400027.6009.147.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F1F1@domain.hid>
	<46D58382.5020201@domain.hid> <1188400027.6009.147.camel@domain.hid>
Subject: Re: [Xenomai-core] RTDM timeout value
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: "Markus Osterried (BA/EDD)" <markus.osterried@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On 8/29/07, Philippe Gerum <rpm@xenomai.org> wrote:
> On Wed, 2007-08-29 at 16:32 +0200, Jan Kiszka wrote:
> > Markus Osterried (BA/EDD) wrote:
> > > Hi,
> > >
> > > it seems that in the RTDM API, all the timeout functions which use
> > > nanosecs_rel_t have a strange behaviour.
> > > The timeout in nanoseconds is converted to ticks and the number of ticks
> > > is rounded down. So when we want to wait e.g. 500000 nanoseconds and the
> > > timertick is 1 ms, xnpod_ns2ticks() rounds down to 0. But 0 is the
> > > special value RTDM_TIMEOUT_INFINITE, so we wait forever. I use Xenomai
> > > 2.3.1, but I think it's basically the same in trunk.
> >
> > It should even impact other skins as well when in tick-based timing
> > mode. I would bet more users of xnpod_ns2ticks() may have overseen this
> > rounding issue - like RTDM did.
> >
>
> Other skins may only mean POSIX and native, since the other ones only
> deal with ticks.

AFAICT, the posix skin deals with this, most timeouts use
ts_2ticks_ceil(timeout)+1
which round the timeout (expressed as a struct timespec) to the next
tick, and add an additional tick to be sure to sleep at least the
specified duration, as required by the posix spec.

Of course, there may be places in the posix skin where I forgot about
this issue.
-- 
                                               Gilles Chanteperdrix

