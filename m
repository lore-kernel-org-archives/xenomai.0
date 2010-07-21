Message-ID: <4C46F0D9.4030906@domain.hid>
Date: Wed, 21 Jul 2010 15:06:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>	<4C46D49F.6030102@domain.hid>
	<AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>
In-Reply-To: <AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected preemption of highest priority thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Bryant <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

Stephen Bryant wrote:
> On 21 July 2010 12:06, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> 
>     Stephen Bryant wrote:
>     > Hi,
>     >
>     > I have some code (simplified example below) which uses
>     > 'pthread_wait_np(&Overrun)' within a while loop, using a period of
>     > 1,000,000ns (1ms) which has been set using
>     'pthread_make_periodic_np()'.
>     > This wakes the thread up less than 2,000ns late in general, sometimes
>     > 20,000ns late, and at most less than 45,000ns late.
> 
>     Since you do not tell us, I guess you are running on x86. Depending on
>     the x86 you are running, 45 us may be high.
> 
> 
> Yes, it is x86, sorry for the omission. What sort of latencies would you
> expect me to see?

If it is for instance, a core 2 duo, it should be around, say, 10 or
20us. If on the other hand, it is a geode, then 45us may be OK. The
actual results also depend on the system load, an unloaded core 2 will
have average latencies under 10us.

>     This reasoning is flawed: you may be preempted by interrupts any time.
>     Including just about at the time where you were going to exit the busy
>     loop. Unless you spin irqs off, and only reenable irqs when the job the
>     thread is supposed to be doing is done. And if you have an SMI issue,
>     even turning off the interrupts will not help.
> 
> 
> I was under the (apparently flawed) impression that Adeos was used to
> prevent interrupts preempting a running high priority task in primary
> mode, only forwarding the interrupts to Linux once the task was waiting
> / finished. I guess that it only prevents a subset of all interrupts,
> and the rest must be specifically disabled then re-enabled by the
> program, or maybe it does not intercept any interrupts?

It prevents secondary domain interrupts from being executed, but the
primary domain interrupt such as the timer interrupt are still executed,
and the secondary domain interrupts are still ticking and cause a
context switch, even if masked immediately.

>     The question is: is the SMI workaround working for your chipset? If that
>     is the case, you should get messages in the kernel logs.
> 
> 
> I've had a look at dmesg, but cannot find any references to SMI - what
> should I be looking for?

What is described in the TROUBLESHOOTING file.

-- 
					    Gilles.

