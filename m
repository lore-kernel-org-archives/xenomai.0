Date: Thu, 7 Apr 2011 22:12:04 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110407201204.GA4913@domain.hid>
References: <20110407170855.GA22659@domain.hid>
	<4D9E0354.4010600@domain.hid>
	<20110407190258.GA27879@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110407190258.GA27879@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] ARM IXP: ipipe regression from
 2.6.31 to .33 and .35
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

On Thu, Apr 07, 2011 at 09:02:58PM +0200, Richard Cochran wrote:
> On Thu, Apr 07, 2011 at 08:32:52PM +0200, Gilles Chanteperdrix wrote:
> > I think the ixp is a 32 bits free-running counter with match register,
> > wich is a configuration I tested. So, I would tend to think that the
> > issue is rather in the clock_events implementation.
> 
> The IXP425 has one shot, count down timer (see below). Does that make
> any difference?
> 
> (It might be that one of the other IXPxxx chips does have a match
> register, but not this one.)

What I meant to say:

Yes, the time register is a 32 bits free-running counter.

But, the interrupt source is a count down register, with or without
automatic reload.

Richard

