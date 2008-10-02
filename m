Message-ID: <48E4F457.4000004@domain.hid>
Date: Thu, 02 Oct 2008 18:18:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48E4EE00.5080409@domain.hid> <48E4EE52.2000202@domain.hid>
	<48E4F2E9.2020909@domain.hid>
In-Reply-To: <48E4F2E9.2020909@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_set_priority vs. Linux priority
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
> AFAIC, I don't see how changing priorities on the fly within a time critical
> section could be considered as good programming practice; this would tend to
> indicate that somebody is playing with priorities to paper over an application
> design issue.

So, you mean PIP papers over application design issues ? Just kidding...


> For that reason, enduring a mode switch upon
> rt_task_set_priority() calls (and friends) would be ok for me. But that's
> certainly debatable.

Actually, we could trigger a signal for pthread_setschedparam to be
called for next switch to secondary mode. We could re-use the signal
already used to trigger a switch to primary mode for suspending a thread
running in secondary mode, finding a way to multiplex the information
passing, for instance, parameters to the siginfo structure.

-- 
                                                 Gilles.

