Message-ID: <2ff1a98a0804070614j38f44092ka038c3456ecb1288@domain.hid>
Date: Mon, 7 Apr 2008 15:14:41 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47FA1515.2020702@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47FA1515.2020702@domain.hid>
Subject: Re: [Xenomai-help] Xenomai 2.4.3 on Arm926 based SoC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Neil Armstrong <narmstrong@domain.hid>
Cc: xenomai@xenomai.org

On Mon, Apr 7, 2008 at 2:35 PM, Neil Armstrong <narmstrong@domain.hid> wrote:
> Hi,
>  First of all, I'm quite new to linux real-time.
>  I'm trying to port the I-pipe patch for my company's arm926ejs based
>  Soc, i successfully run the 2.6.24 kernel with the I-pipe 1.9-01 patch
>  for arm.
>
>  While running the testsuite on the platform I have some negative values
>  (for latency for example), so I'm not sure of my patch.

Small negative latencies may be normal, but something like -110 us is
completely abnormal. There is definitely something wrong with your
implementation.

>
>  I based my work on the integrator patch for a decrementer timer. The
>  timer available is a 16bit decrementer with a 256 ticks prescaler with
>  the ARM clock running at 144Mhz. (decrementer's initial value for 1ms is
>  5636 ticks).
>
>  I joined the full output and the board specific I-pipe functions.
>  Gilles Chanteperdrix told me it would be better to use an one-shot timer
>  instead of the autoreload feature

What I meant is that the autoreload feature is dangerous when the
timer is used in one-shot mode: if the programmed shot is short, you
have a risk of spurious timer interrupt. It the programmed shot is
very short, you have a risk to hog the box completely.

, but the kernel stops right after
>  adeos takes control of the timer !

What do you mean ? Adeos alwyas has control of the timer. You know
when Xenomai takes control of the timer when the variale
__ipipe_mach_timer_stolen is non zero. So, what you should do is
program the timer in periodic mode (using autoreload feature if you
want, if you do not want, you will have to program next shot in the
timer interrupt code) as long as __ipipe_mach_timer_stolen is 0, and
stop using the autoreload feature when __ipipe_mach_timer_stolen is 1
(or when ipipe_mach_set_dec is called).

>
>  I read it could be useful to benchmark the Scheduling latency, but where
>  do I find the correct value ?

The correct value is the maximum value returned by the latency test.
But, there is probably a problem with your implementation, so the
figures are irrelevant.

-- 
 Gilles

