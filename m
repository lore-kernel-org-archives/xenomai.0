MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18349.43833.667687.260737@domain.hid>
Date: Sat, 9 Feb 2008 14:31:37 +0100
In-Reply-To: <47ACD0FF.8000601@domain.hid>
References: <47ACD0FF.8000601@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH] Optional timer freeze during ptracing
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
 > Freezing all Xenomai timers while just a single RT application is under
 > ptrace control can be helpful in certain debugging scenarios, but it can
 > as well be harmful when other parts of the systems have to continue to work.
 > 
 > I brought this concern up back in 2006, and I originally thought we may
 > address this by freezing per process. But this is far too complex for a
 > simple problem like this: Just make the whole thing configurable, and
 > keep it off by default so that -ideally- only users who are aware of the
 > side effects will arm it.
 > 
 > Gilles, you recently stumbled over such a side effect and introduced
 > XNTIMER_NOBLCK (for customized timer instrumentations as far as I
 > understood this). Do you think we still need that knob when we have
 > CONFIG_XENO_OPT_PTRACE_TIMER_FREEZE?

Yes, the feature allowing to block all timers makes my debugging
possible, so I want it, except for one timer.

-- 


					    Gilles Chanteperdrix.

