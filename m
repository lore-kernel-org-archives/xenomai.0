MIME-Version: 1.0
In-Reply-To: <53FDFD27.2010207@xenomai.org>
References: <CACreCV+9seA7yp8gmjvOb6CQ7-Fbt-HyQ6YAoB_dqtmqmyvy7Q@mail.gmail.com>
 <53FDFD27.2010207@xenomai.org>
Date: Thu, 28 Aug 2014 21:45:27 +0800
Message-ID: <CACreCV+cQTO-5iFCCvC15VxNzXuvKkLN+_gUTex-r3Y1cByUkw@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] ODROID-U3 porting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Aug 27, 2014 at 11:45 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 08/27/2014 03:49 PM, GP Orcullo wrote:
>> Hi,
>>
>> I'm in the process of porting xenomai to Samsung Exynos 4420 based
>> ODROID-U3 board. I've followed the online manual and I was able to finish
>> up to the interrupt controller part.
>>
>> So far everything works when booting the board with CONFIG_IPIPE and
>> CONFIG_XENOMAI enabled. However, running the latency test gives the
>> following results:
>>
>> root@odroidu3:~# /usr/lib/xenomai/testsuite/latency -t 0 -T5
>> == Sampling period: 1000 us
>> == Test mode: periodic user-mode task
>> == All results in microseconds
>> warming up...
>> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
>> RTD|-1054607.854|-555107.854|-416666.667|       0|
>> 0|-1054607.854|-416666.667
>> RTD|-2054607.854|-1555107.854|-416666.667|       0|
>> 0|-2054607.854|-416666.667
>> RTD|1240359.443|1739859.443|-416666.667|       0|     0|1240359.443|-416666.667
>> RTD| 240359.443| 739859.443|-416666.667|       0|     0| 240359.443|-416666.667
>> ---|-----------|-----------|-----------|--------|------|-------------------------
>> RTS| 240359.443|-2055107.854|-416666.667|       0|     0|    00:00:05/00:00:05
>
> I would say you have a problem with the tsc emulation. Have you tried to
> run the "tsc" program?
>
>

Thanks for the tip! The problem was due to wrong physical address value.

>> [    0.000000] Linux version 3.8.13.11-xen (gemi@odroidu3) (gcc version 4.6.3 (Debian 4.6.3-14) ) #34 SMP PREEMPT Wed Aug 27 20:22:46 SGT 2014 ()
>
> 3.8.13 is a bit old, I would advise you to use 3.14 if you plan to get
> your changes merged.
>

Unfortunately this is the only stable version available. A newer version is
being worked on but it is based on 3.16. This will do for the time being,
I'm just using this as a test bed for machinekit.

>> [    0.000000] Kernel was built at commit id ''
>> [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
>
> So, this is a cortex a9. On Cortex a9, Xenomai tries to use the global
> timer for tsc emulation. Are you sure this processor has a global timer?
> Again, running the "tsc" program will help you see if the tsc emulation
> is working correctly.

AFAIK, the exynos soc doesn't use twd - they have a multi-core timer
instead. There is one global timer and a local timer for each core.

BTW, is it necessary that there should be an ipipe timer for each core
or a single
"global" one will do?

>
>
> --
>                                                                 Gilles.

Gemi

