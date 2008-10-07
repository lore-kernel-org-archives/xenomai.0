Message-ID: <48EB4FD8.30006@domain.hid>
Date: Tue, 07 Oct 2008 14:02:32 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7AD38398@domain.hid>	<1743f3b40809230122u177e9aaeyb0cbc53f81793929@domain.hid>	<48D8A7EC.7000502@domain.hid>
	<1743f3b40810060744v7d55f706m62b46a1e27498524@domain.hid>
In-Reply-To: <1743f3b40810060744v7d55f706m62b46a1e27498524@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt latency questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antonio Del Cinque <adelcinque@domain.hid>
Cc: xenomai@xenomai.org

Hello,

Antonio Del Cinque wrote:
> Hi,
> sorry, I needed time to implement your suggestions, but finally I got
> some results. I checked for cache related issues, and found that latency
> is highly related to cache misses.
> 
> I found the way to disable the instruction cache (the e300 powerpc core
> has a 32 KB i-cache and a 32 KB d-cache, but I couldn't disable the
> d-cache because of segmentation faults), and I changed the test to
> measure interrupt latency.

What system are you exactly using. Your latency figures are already
really good.

> Now I have a Xenomai real time task. The task is periodic (I used
> rt_task_set_periodic() and rt_task_wait_period()) and, at every period,
> it toggles a GPIO pin configured as an output, by calling the GPIO rtdm
> driver ioctl command. The pin is short circuited with another pin which
> is configured as an input, generating an interrupt in the powerpc. The
> interrupt routine, registerd via rtdm_irq_request() in the same GPIO
> rtdm driver, toggles another GPIO pin configured as an output, so I see
> the two IO pins on the oscilloscope, the first generating the interrupt,
> and the second indicating that the interrupt routine has been executed.

I have done similar tests with gpioirqbench:

  http://www.denx.de/wiki/DULG/AN2008_03_Xenomai_gpioirqbench

> When the cache is enabled I see a latency between 2 and 5 uS with no
> load, but if I create a non real time load the latency raises (for
> example to 12 uS with the cache calibrator running), and this is non
> deterministic, since it dependes on the cache use.

Additionally try to run "while ls; do ls /bin; done" in a telnet session.

> When I disable the i-cache the latency goes to 16 uS with no load, this
> is 11 to 14 uS over latency! Non real time task now only sligthly affect
> the latency, but I have the following problem: if I start real time
> tasks (for example I run
> /usr/local/xenomai/share/xenomai/testsuite/cyclic/run) the GPIO
> interrupt latency is not commonly affected, but occasionally it gets to
> 50 uS. I can't explain this. Could you help me?

Running the systems with caches disabled does make little sense because
it would make the system very very slow (apart from the fact that it's
not easily possible with Linux).

> The delay is not continuos, it jumps from 16-20 to 38-50 uS. Now the
> i-cache is disabled, so it seems another interrupt routine, running in
> Xenomai domain, gets interleaved with the GPIO interrupt rountine.
> 
> Is there any way to track these kind of latency in the ipipe, a kind of
> worst latency case tracker? I see only "virtual" IRQs 512 and 515
> running in Xenomai domain. I cannot see where they are set up. I guess
> one of them is the system timer, and I know this is commonly driven by
> the powerpc decrementer. Is the GPIO interrupt latency due to the system
> timer interrupt? If this is the case, where can I disable the system
> timer in Xenomai, or modify the interrupt routine? I must run in
> interrupt context because of latency requirements (they asked me for
> deterministic latencies under 20 uS).

As I see it, the main latencies are caused by cache refills. If the
latencies are not good enough, choose a faster system (more MHz, bigger
L1 or L2 cache or faster memory) but 20 us is very challenging already
for a PC. Moving your task to kernel space or even to the ISR gives
better result, of course, as you can see from:

  http://www.denx.de/wiki/DULG/AN2008_03_Xenomai_gpioirqbench

Wolfgang.


