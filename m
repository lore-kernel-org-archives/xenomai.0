Date: Tue, 10 May 2016 18:08:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160510160837.GA29741@hermes.click-hack.org>
References: <573204D1.4060202@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573204D1.4060202@siemens.com>
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

On Tue, May 10, 2016 at 05:57:05PM +0200, Jan Kiszka wrote:
> Hi,
> 
> originally, this effect was only reported for debugged applications, but
> I think it affects more:
> 
> clock_nanosleep (as well as nanosleep and sleep) should return -EINTR if
> they were interrupted by signal while sleeping. OK. But what if that
> signal was SIGSTOP, maybe even related to ptrace? Right now the function
> just bails out, and applications behave differently from native Linux.
> There we resume the sleep transparently if the signal is not delivered
> to some handler (or actually terminates the process).
> 
> How could we model this properly with Xenomai? And could there be more
> services affected than clock_nanosleep?

I was going to say, this is unspecified by POSIX, but actually it
is:
http://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_nanosleep.html

The relevant sentence is:
"the clock_nanosleep() function shall cause the current thread to be
suspended from execution until either the time interval specified by
the rqtp argument has elapsed, or a signal is delivered to the
calling thread and its action is to invoke a signal-catching
function"

Clearly, the action of SIGSTOP is not "a signal-catching function",
and the sleep should not appear to have been interrupted.

Just saying, I have no idea whatsoever on how to get this working.

Regards.

-- 
					    Gilles.
https://click-hack.org

