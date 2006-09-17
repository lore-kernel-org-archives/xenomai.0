From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17677.34698.949600.873431@domain.hid>
Date: Sun, 17 Sep 2006 19:36:10 +0200
Subject: Re: [Xenomai-core] official TSC model on SMP
In-Reply-To: <1158513328.4979.45.camel@domain.hid>
References: <450D3764.80601@domain.hid>
	<1158513328.4979.45.camel@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > On Sun, 2006-09-17 at 13:54 +0200, Jan Kiszka wrote:
 > > Hi,
 > > 
 > > reading through timer code of Xenomai I just wondered (again) what our
 > > official model of TSCs on multiprocessor boxes are:
 > > 
 > > 1) (practically) perfectly synchronised without offset
 > > 
 > > 2) synchronised but with (unknown?) offset
 > > 
 > > 3) unsynchronised
 > 
 > The current model is unsynchronized. If anything from the codebase is
 > found relying on the opposite, be it partially or fully, then it's
 > utterly broken in the SMP case, and I'm likely the one to blame.
 > IOW, we don't currently provide any guarantee to anyone that a timestamp
 > could be interpreted anywhere else than the CPU it was read from, and
 > leave all the related burden to the application developer (e.g. by mean
 > of managing CPU affinity constraints and the like).

I think xntimer_set_sched assumes some continuity, since it reenqueues
on a different CPU a timer whose date has been set up on one cpu. If we
wanted strict unsynchronized tsc, we would have to :
- compute the difference between the current date and the timer date
- enqueue the timer on a migration queue
- send an IPI to the distant CPU
- on the distant CPU, iterate over the migration queue, recompute the
  expiration dates and reenqueue the timers.

-- 


					    Gilles Chanteperdrix.

