Date: Wed, 11 May 2016 08:05:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160511060545.GH13285@hermes.click-hack.org>
References: <573204D1.4060202@siemens.com>
 <20160510160837.GA29741@hermes.click-hack.org>
 <57320A7D.1060105@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57320A7D.1060105@siemens.com>
Subject: Re: [Xenomai] Resuming nanosleep & Co. after ignored signals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, May 10, 2016 at 06:21:17PM +0200, Jan Kiszka wrote:
> On 2016-05-10 18:08, Gilles Chanteperdrix wrote:
> > On Tue, May 10, 2016 at 05:57:05PM +0200, Jan Kiszka wrote:
> >> Hi,
> >>
> >> originally, this effect was only reported for debugged applications, but
> >> I think it affects more:
> >>
> >> clock_nanosleep (as well as nanosleep and sleep) should return -EINTR if
> >> they were interrupted by signal while sleeping. OK. But what if that
> >> signal was SIGSTOP, maybe even related to ptrace? Right now the function
> >> just bails out, and applications behave differently from native Linux.
> >> There we resume the sleep transparently if the signal is not delivered
> >> to some handler (or actually terminates the process).
> >>
> >> How could we model this properly with Xenomai? And could there be more
> >> services affected than clock_nanosleep?
> > 
> > I was going to say, this is unspecified by POSIX, but actually it
> > is:
> > http://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_nanosleep.html
> > 
> > The relevant sentence is:
> > "the clock_nanosleep() function shall cause the current thread to be
> > suspended from execution until either the time interval specified by
> > the rqtp argument has elapsed, or a signal is delivered to the
> > calling thread and its action is to invoke a signal-catching
> > function"
> > 
> > Clearly, the action of SIGSTOP is not "a signal-catching function",
> > and the sleep should not appear to have been interrupted.
> > 
> > Just saying, I have no idea whatsoever on how to get this working.
> 
> It's at least not trivial: The kernel has per-thread restart blocks
> where it pushes the timer state of an interrupted relative
> clock_nanosleep so that the restarted syscall will not restart the timer
> at 0.
> 
> And then we still need to differentiate between those two signal types
> (delivered to handler vs. internally processed).

Since we will return from the xenomai syscall in secondary mode, we
could conceivably go through the plain Linux syscall epilogue with
the restart block, using a specific restart block which piggy backs
into xenomai kernel. I wonder if xenomai syscall returning in
secondary mode do not go through the plain Linux syscall epilogue
already, actually.

-- 
					    Gilles.
https://click-hack.org

