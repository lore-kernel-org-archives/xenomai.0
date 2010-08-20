From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C6E8C79.1050501@domain.hid>
References: <6FCCA913376DD7488F4139A4D11B8F4801465AC9@domain.hid>
	<1282149528.1730.348.camel@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801465AF8@domain.hid>
	<1282164261.1730.359.camel@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801465B76@domain.hid>
	<1282236153.1730.474.camel@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801465C00@domain.hid>
	<1282282775.1730.504.camel@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801465CFD@troe2k1.cs.myharris.net>
	<1282312185.1730.598.camel@domain.hid>
	<4C6E8A1B.4090006@domain.hid>
	<1282313187.1730.611.camel@domain.hid>
	<4C6E8C79.1050501@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Aug 2010 16:24:22 +0200
Message-ID: <1282314262.1730.619.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM task blocks when connecting gdb to realtime
	task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, 2010-08-20 at 16:08 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2010-08-20 at 15:58 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>>>  However, terminating gdb and restarting app outside gdb
> >>>> does make RTDM task resume execution. Before, the driver had to be reloaded.
> >>>>
> >>>> So gdb appears to be causing timer to block even if no breakpoint is set,
> >>>> probably signals?
> >>>>
> >>> There is no reason for that. Sending "continue" to gdb is expected to
> >>> unblock the timers, until the code is single-stepped again (e.g. after
> >>> ^C or any breakpoint).
> >> gdb silently intercepts a traced program for various reasons, e.g.
> >> thread creation or library loading. Even if no user breakpoint is set,
> >> the program may briefly be stopped nevertheless. If that happens
> >> frequently enough, and every stop can add latencies to running timers...
> > 
> > We are talking about permanent freeze of timers, not transient (at least
> > this is what I got from the ongoing discussion).
> 
> Yes, but what would happen if the interruption rate is higher than the
> timer delay? Wouldn't we effectively end up with a permanent freeze?

If the _signal_ rate is higher than the timer delay and continuous, then
either the guy sending ^C via the keyboard should go easier on the
coffee, or gdb has a severe problem and should be fixed, whichever comes
first.

> 
> Jan
> 

-- 
Philippe.



