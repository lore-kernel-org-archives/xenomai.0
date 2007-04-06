Message-ID: <46164F5D.4080301@domain.hid>
Date: Fri, 06 Apr 2007 15:47:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Getting the clock model right
References: <46163817.3060007@domain.hid>
In-Reply-To: <46163817.3060007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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
> Hi,
> 
> recent announcement of some new TSC synchronisation feature in RTAI made
> me stick my nose into this and think about the whole issue of clock
> synchronisation again. Well, let's not talk about RTAI details here, but
> they got one thing right: as long as we cannot handle unsynch'ed TSC on
> SMP, we need some detection and alarming as the bare minimum.
> 
> Why can't we handle such cases yet? First, there seems to be still some
> bugs hidden in the core (one example: xntimer_start_aperiodic() uses the
> local time stamp to start a remote timer).

Reading the code, there seem to be only two places where the local tsc
is used to set a remote timer, it is xntimer_start_aperiodic, and
xntimer_move_aperiodic, which is used by xntimer_migrate. So we are left
with only one bug: starting a timer on the remote CPU, this could easily
be implemented with a queue which would be handled by the timer IPI.


> (...)
> for smoothly adjusting clocks during runtime would be great. I'm
> thinking about a generic infrastructure to synchronise the Xenomai time
> on external sources (=>distributed clocks).

What do you want, NTP ? Or calling xnpod_settime periodically ?

-- 
                                                 Gilles Chanteperdrix

