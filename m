MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17635.21607.931068.951138@domain.hid>
Date: Wed, 16 Aug 2006 19:22:47 +0200
Subject: Re: [Xenomai-core] [RFC][PATCH 4/4] shorten overrun loops of periodic
	timers
In-Reply-To: <44E345D7.4070904@domain.hid>
References: <44D19F3D.9060700@domain.hid>
	<17618.12731.97405.118098@domain.hid>
	<44D24257.10605@domain.hid>
	<17635.15652.735628.299134@domain.hid>
	<44E345D7.4070904@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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

Jan Kiszka wrote:
 > > I am thinking again about this patch: some handlers need to be
 > > rewritten, for example the posix timers handler, because the handler
 > > relies on the fact that it is called for every timer expiry to compute
 > > the overruns count. So maybe this patch should come with the addition of
 > > an xntimer_getoverrun service that computes the overrun count using the
 > > tsc ?
 > > 
 > 
 > Mmh, that gets close to hrtimer_forward now: push an overdue timer to an
 > expiry date that is in the future and return the number of overruns. But
 > do we still want this optimisation of the broken path then? It starts
 > getting complex, probably adding more code than it is worth. I'm
 > starting to vote against my own patch...

The code to compute the number of overruns from the tsc exists in
xnpod_wait_thread_period, is not this just a matter of refactoring this
code in an xntimer_getoverrun ?

-- 


					    Gilles Chanteperdrix.

