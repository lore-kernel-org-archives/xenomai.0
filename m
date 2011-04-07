Message-ID: <4D9E0354.4010600@domain.hid>
Date: Thu, 07 Apr 2011 20:32:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110407170855.GA22659@domain.hid>
In-Reply-To: <20110407170855.GA22659@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Richard Cochran <richardcochran@domain.hid>
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

Richard Cochran wrote:
> I have been trying to bring my IXP425 based system up to date, and I
> have found an apparent regression. Everything worked fine with ipipe
> 2.6.30 and Xenomai 2.4. With 2.6.31 an ipipe kernel still boots, but
> starting with 2.6.33 the trouble begins (see below).
> 
> I see that Gilles refactored the TSC emulation starting with
> 2.6.33. I wonder whether this could be the cause?

What this modification does is that:
- there is only one clocksource, which is now xenomai tsc, with a very
high rating;
- the tsc read code is written in assembly, and copied in the vectors
page, the one at 0xffff0000.

I think the ixp is a 32 bits free-running counter with match register,
wich is a configuration I tested. So, I would tend to think that the
issue is rather in the clock_events implementation.


-- 
					    Gilles.

