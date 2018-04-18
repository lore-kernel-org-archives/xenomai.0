References: <1524051320838.89517@kth.se>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4830699a-eda9-1406-01ae-e7da40fff629@xenomai.org>
Date: Wed, 18 Apr 2018 19:54:09 +0200
MIME-Version: 1.0
In-Reply-To: <1524051320838.89517@kth.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Scheduling timer period Xenomai RPI3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gustav Johansson <gusjohan@kth.se>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 04/18/2018 01:35 PM, Gustav Johansson wrote:
> Hi!
> 
> 
> I'm running Xenomai on Raspberry Pi 3 given by: http://www.cs.ru.nl/lab/xenomai/ and I
> 
>  have some questions.
> 
> 
> Where can I find information on how often the system timer interrupts for scheduling
> 
> regarding rt tasks? When using command "dmesg | grep pipe -i" I get :
> 
> 
> 
> "[    0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 ms
> [    0.000000] clocksource ipipe_tsc: mask: 0xffffffffffffffff max_cycles: 0x46d987e47,
> 
> max_idle_ns: 440795202767 ns
> [    0.000894] Interrupt pipeline (release #9)
> [    0.171104] Switched to clocksource ipipe_tsc"
> 
> 
> Is the frequency 19.200MHz how often the scheduler will execute?
> 

19.2Mhz indirectly gives you the resolution of the hardware clock device
Xenomai refers to for determining the current machine time, expressing
timestamps and delays. This is not directly related to the timer device
issuing IRQs.

Xenomai always programs the core timer in oneshot mode with the date of
the next (i.e. closest) event scheduled in the timeline; there is no
periodic rescheduling, only scheduling when needed. If the next event is
due when hell freezes, the scheduler might then be considered as dead code.

-- 
Philippe.

