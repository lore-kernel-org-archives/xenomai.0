Message-ID: <508AA828.8050702@xenomai.org>
Date: Fri, 26 Oct 2012 17:11:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMVghhVFiQNbPLgS5zpLw7Bu5t9mxdY5U9htVOOrRxQt_RWgVQ@mail.gmail.com>	<CAHzTO8nxt5KcK_mekgArQXqdLGQC=d3bWFBse=H6cZmpRvon-A@mail.gmail.com>
	<CAMVghhVXP=VckoAcgSjYBxO=2i2gsAse-or0xvBbNJNuodu2yA@mail.gmail.com>
In-Reply-To: <CAMVghhVXP=VckoAcgSjYBxO=2i2gsAse-or0xvBbNJNuodu2yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Seeking recommendations for SBC with precision timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Howard Lee Harkness <howard.lee.harkness@gmail.com>
Cc: Xenomai@xenomai.org

On 10/26/2012 04:46 PM, Howard Lee Harkness wrote:
> Thank you for your fast responses!
> 
> 1) Not necessarily fanless, but that would be nice.
> 
> 2) Don't need a timestamp. All I need is a precision interval. I want to be
> able to send a signal to a device, and read a measurement exactly 11 us (or
> 5 us, or 17 us, or 31 us, etc.) later, plus or minus no more than about 1
> us. <1 us precision would be better, but I think for now 1 us resolution is
> sufficient. Reliably, repeatably.

What you are asking is a latency of less than 1us, not a resolution.
Here is a graph showing the (user-space wake-up) latencies we get with
various configurations of Xenomai 2.6.1 over Linux 3.4.6 on an atom 230:

http://xenomai.org/~gch/core-3.4-latencies/atom.png

These are user-space wake-up latencies, you get better result with irqs
handlers. But 1us, that is a bit hard. The only way I know to do this,
is, for instance, if you know that the maximum irq latency is 15us,
wake-up 15us before the wanted wake-up date, and spin in the timer
handler until the time you want, using a clocksource which has a better
resolution than 1us. x86 generally use the tsc which is such a clocksource.


-- 
					    Gilles.

