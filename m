Message-ID: <4FFD950A.8090700@xenomai.org>
Date: Wed, 11 Jul 2012 17:00:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdteZWSdH2dywoj6Ro8BTfYmV0HOC6-Gt6jjjVH_UV9VUKg@mail.gmail.com>
In-Reply-To: <CAKKWdteZWSdH2dywoj6Ro8BTfYmV0HOC6-Gt6jjjVH_UV9VUKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] questions: system timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: Xenomai@xenomai.org

On 07/11/2012 04:02 PM, ali hagigat wrote:
> 1) How the system clock is set, i mean weather it is
> periodic/aperiodic and the period? It is done by the extra code which
> is added by Xenomai? or it is done by mainline kernel after boot-up
> first time.

The hardware timer is taken over by xenomai, when xenomai is started. It
is set to aperiodic mode, whatever the configuration options.

> 
> 2) Can rt_timer_set_mode() set the period to one nano second?!

Yes, but that means that xenomai will try to reprogram the timer every
nano second, which will probably lock-up, on most machines I run Xenomai
on, at least. Anyway, with the hardware timer set to aperiodic mode,
decreasing the tick period to increase the resolution is rather silly:
simply use an aperiodic timer and you will get the maximum resolution.

> 
> 3) Native-API_Tour manual is not updated. It talks about one variable
> CONFIG_XENO_OPT_TIMING_PERIOD which can be 0 or a number.
> 
> 4) Why each skin has a different period? Which one is used after boot-up?

Since xenomai 2.6, the time management is layered: the hardware timer is
set to aperiodic mode, and if a skin request periodic mode, a software
timer is started to provide the skin timebase. So, if each skin has a
different period, each skin will get a tick at the period it requested.

-- 
					    Gilles.

