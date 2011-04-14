From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4DA6F0DD.1080403@domain.hid>
References: <4DA6F0DD.1080403@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Apr 2011 15:31:26 +0200
Message-ID: <1302787886.2083.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] kernel threads crash - possible race condition?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jesper Christensen <jbc@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, 2011-04-14 at 15:04 +0200, Jesper Christensen wrote:
> I wrote about some problems concerning stack corruption when running
> xenomai on ppc. I have found out that if i disable hardware interrupts
> while running "rthal_thread_switch" the problem seems to dissapear
> somewhat. I saw a crash yesterday after running for 3 hours, and i'm
> currently running a test (has been running for 3 hours). Usually it
> would fail after 30-40 minutes. My question is: could there be a problem
> if we receive an interrupt between updating the stack pointer and the
> sprg3 register with the new thread pointer?
> 

Normally, there should not be any issue (famous last words), since we
would run Xenomai-only code over the preempted context, and we don't
depend on SPRG3 to fetch the current phys address. In fact, at this
stage we simply don't care about the linux context, only referring to
the current Xenomai thread, which is obtained differently.

Try switching off CONFIG_XENO_HW_UNLOCKED_SWITCH, in the "machine"
config area, if this ends up being rock-solid, then this would be a hint
that something may be fishy in this area. Raising your k-thread stack
sizes in a separate test may be interesting to check too, if not already
done.


> /Jesper
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



