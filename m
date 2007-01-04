From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <459D14C4.40300@domain.hid>
References: <459D14C4.40300@domain.hid>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 16:16:08 +0100
Message-Id: <1167923768.6722.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [BUG] timerbench tests don't work with SVN
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
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2007-01-04 at 15:52 +0100, Jan Kiszka wrote:
> Hi Philippe,
> 
> likely a regression of latest timer base patches: with periodic support
> enabled (haven't tested the off case yet), latency -t1/2 no longer work.
> I have no time to look at this, so I just dump my report here. :)
> 
> Jan
> 
> 
> PS: Is there an official nucleus API to convert dates between timebases?
> I'm asking because of the open question how to share RTDM drivers
> between skins on different timer bases. Right now it looks to me like
> RTDM is locked to one base (configured at compile or module load time)
> and cannot be shared.
> 

This is the same situation than before, except that now, RTDM can choose
the timebase it is locked on. There is no conversion API right now, but
we could define xntbase_convert(inbase, rtdm_base), with inbase being
extracted from xnthread_timebase(xnpod_current_thread()) for primary
context services. The question remains open on how to get the inbase
pointer for seconday mode callers though.

-- 
Philippe.



