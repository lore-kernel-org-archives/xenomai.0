Message-ID: <4C234679.10209@domain.hid>
Date: Thu, 24 Jun 2010 13:50:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>	<4C1B7EB1.2040006@domain.hid>	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>	<AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>	<4C1B8C04.3010900@domain.hid>
	<4C1BCCBF.7010400@domain.hid>	<AANLkTilBt1fx4MFJ_Tmuz-fUl1D190u_FYDfLn09JaA3@domain.hid>	<1277330401.2453.145.camel@domain.hid>
	<AANLkTincrp1q4RbmCoijrummF3IS_tfBJ-YGZnGFbpw0@domain.hid>
In-Reply-To: <AANLkTincrp1q4RbmCoijrummF3IS_tfBJ-YGZnGFbpw0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fwd: problem in pthread_mutex_lock/unlock
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Nero Fernandez <grimlynch@domain.hid>
Cc: xenomai@xenomai.org

Nero Fernandez wrote:
> Thanks for your response, Philippe.
> 
> The concerns while the carrying out my experiments were to:
> 
>  - compare xenomai co-kernel overheads (timer and context switch latencies)
>    in xenomai-space vs similar native-linux overheads. These are
> presented in
>    the first two sheets.

On what ARM system do you get these latency figures? I really doubt the
linux kernel has a bounded latency under 35us. Because:
- the preempt_rt people, which work on getting a bounded latency get
something around 200us on AT91, an ARM9;
- there would be no reason of the preempt_rt effort if the linux kernel
interrupt latency was already bounded.

So, I take it that you do your measurement without generating a load. We
do our measurements using the latency test, while generating a load for
several hours. And on the average ARM, we usually get an interrupt
latency around 50us.

Please add some load on the system, and do the measurments again. The
best source of load we have found so far is to load the LTP testsuite
while running the latency test.

If you tell me what ARM SOC, or at least what ARM architecture revision
you use (the ARM920T core is an armv4, and the ARM926EJS is an armv5, so
ARM 9 does not tell us much), I can provide you with the root filesystem
we use for our tests.

-- 
					    Gilles.

