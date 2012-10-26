MIME-Version: 1.0
In-Reply-To: <508AA828.8050702@xenomai.org>
References: <CAMVghhVFiQNbPLgS5zpLw7Bu5t9mxdY5U9htVOOrRxQt_RWgVQ@mail.gmail.com>
	<CAHzTO8nxt5KcK_mekgArQXqdLGQC=d3bWFBse=H6cZmpRvon-A@mail.gmail.com>
	<CAMVghhVXP=VckoAcgSjYBxO=2i2gsAse-or0xvBbNJNuodu2yA@mail.gmail.com>
	<508AA828.8050702@xenomai.org>
From: Howard Lee Harkness <howard.lee.harkness@gmail.com>
Date: Fri, 26 Oct 2012 11:34:04 -0500
Message-ID: <CAMVghhUq3KUEEK32aSfap3jKbsgaZCDMErQqhzpeOSJ8pYz3Ng@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Seeking recommendations for SBC with precision timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Ah, that looks like it might be the solution. Need to dig a bit deeper on
this subject.

Back last time I was doing this sort of thing, I was using a 286, which
didn't have a TSC. Plus I only had to do about 500 us resolution on the
timings. I contracted with a friend to do a simple countdown timer for the
PC bus, which did the trick. That was more than 15 years ago. The
semiconductor testing business has gotten a little more complex since then.

On Fri, Oct 26, 2012 at 10:11 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> The only way I know to do this,
> is, for instance, if you know that the maximum irq latency is 15us,
> wake-up 15us before the wanted wake-up date, and spin in the timer
> handler until the time you want, using a clocksource which has a better
> resolution than 1us. x86 generally use the tsc which is such a clocksource.
>



-- 
Howard Lee Harkness
(214) 390-4896
