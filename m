From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B042121.2050509@domain.hid>
References: <4B042121.2050509@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Nov 2009 17:49:43 +0100
Message-ID: <1258562983.2348.168.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] ipipe_suspend_domain vs. pipeline state of caller
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Wed, 2009-11-18 at 17:30 +0100, Jan Kiszka wrote:
> Hi Philippe,
> 
> on x86, trace_hardirqs_on in safe_halt feels unhappy about the fact that
> it is called with neither real irqs disable nor the root domain stalled.
> Call path is cpu_idle -> default_idle -> safe_halt. We loose the
> stalling of the root domain in cpu_idle via ipipe_suspend_domain.
> 

Reinstating the stall bit upon return from suspension is the way to go.

> That raises the question how ipipe_suspend_domain is supposed to deal
> with the pipeline state of the calling domain. Currently it clears the
> stall unconditionally, which is obviously not correct for the idle path.
> My feeling is that it should not alter the state, rather restore it on
> exit. But this is an exported interface (though a widely unused today, I
> guess), and I don't claim to oversee all corner cases.
> 

At the core of the pipeline logic, there is the assumption that a domain
may never, ever suspend in stalled state, so that no interrupt lingers
unexpectedly in the log while it enters sleep, and this is what
suspend_domain() enforces before switching to the next domain.

> Jan
> 


-- 
Philippe.



