Subject: Re: Question about gdb and timeout
References: <6c79c68d-fa03-28cd-71e5-d02f1be7d6a2@mitrol.it>
 <1908941175.1265140.1602174703558.JavaMail.zimbra@wolfram.com>
 <1e3763d4-2355-af63-dc19-8be1edb07b13@siemens.com>
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Message-ID: <f2a052fd-bef2-3385-7b58-60dd3e2bd0a2@mitrol.it>
Date: Tue, 13 Oct 2020 08:44:31 +0200
MIME-Version: 1.0
In-Reply-To: <1e3763d4-2355-af63-dc19-8be1edb07b13@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Per Oberg <pero@wolfram.com>
Cc: xenomai <xenomai@xenomai.org>

Il 12/10/2020 12:36, Jan Kiszka ha scritto:
> On 08.10.20 18:31, Per Oberg via Xenomai wrote:
>>
>> ----- Den 8 okt 2020, på kl 14:47, xenomai xenomai@xenomai.org skrev:
>>
>>> Hi to all,
>>> I have an ARM board (iMX6SX).
>>> - kernel 4.9.88
>>> - xenomai 3.0.9
>>> - ipipe-core-4.9.51-arm-4
>>> I have run a simple xenomai alchemy test :
>>> - a task that wait an event (timeout 10 secs)
>>> - a task that signal the event (every 100 msecs)
>>> All works correctly.
>>> When I use the example with gdb:
>>> b 56 (at usleep(10000) in the main)
>>> r
>>> c
>>> c
>>> ...
>>> If I stay stopped in gdb for more that 10 seconds (that is the timeout
>>> of the rt_event_wait), I get -110 (= -ETIMEDOUT).
>>> This because I think the timer counts also when tasks are stopped in gdb.
>>> Is there a way to avoid this behavior ? When I'm stopped in gdb, the
>>> real-time"world" should be stopped.
>> This is not exactly my home arena, but I'm waiting for a kernel compile so I'll give you my two cents...
>>
>> Not easily, or plainly just no. At least not without rewriting your timeout code. I'm not sure what alchemy uses as base clock for it's timers, but for the posix skin you have the option of CLOCK_HOST and CLOCK_HOST_REALTIME, CLOCK_MONOTONIC and CLOCK_REALTIME (and maybe others) that represents the Linux kernel time and the Xenomai kernel time. Gdb just stops your application while the kernel timers will keep running.
>>
> Right. We used to stop system timers, but that's not straightforward
> either, e.g. when there are multiple applications on the system which
> would then be affected as well. In addition, this stopping doesn't help
> with the real world continuing to run.
>
> We are internally experimenting with debug callbacks that an application
> can register and which are run prior to the stop and right before the
> application resumes. Those may help with "cleaning up" (resynchronizing)
> the application with the rest of the system after a breakpoint stop.
>
> A simpler alternative is making the application robust against timeouts,
> at least in some debug mode.
>
> Jan
Thanks Jan and Per for your time.
I realize that all timing during debugging are not correct.
Maybe the best solution is to set all timeout to infinite in the debug 
case, without search complicated solutions.
Best regards,
Paolo

