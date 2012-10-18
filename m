MIME-Version: 1.0
In-Reply-To: <CANKLDmsMPqKm6c-a8ekCa2NmaVCe-Qp+SvW0k=7fhCTsfVycCg@mail.gmail.com>
References: <mailman.1.1350468001.6812.xenomai@xenomai.org>
	<507F2930.9020709@gmail.com> <507F8379.3070505@xenomai.org>
	<CANKLDmuX+n_XMJAqTQA75rdv5ezN89V=8aaASUGis1rM90N70Q@mail.gmail.com>
	<CANKLDmsMPqKm6c-a8ekCa2NmaVCe-Qp+SvW0k=7fhCTsfVycCg@mail.gmail.com>
Date: Thu, 18 Oct 2012 11:07:10 +0200
Message-ID: <CANKLDmsxawDVFGBR7e5=hf6q9UjSC+OcrL9A9wPjnP6DUHeH+w@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] ARM kernel issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Stefan Videv <videvstefan@gmail.com>, xenomai@xenomai.org

On Thu, Oct 18, 2012 at 11:00 AM, Henri Roosen <henriroosen@gmail.com> wrote:
> On Thu, Oct 18, 2012 at 10:21 AM, Henri Roosen <henriroosen@gmail.com> wrote:
>> On Thu, Oct 18, 2012 at 6:20 AM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On 10/17/2012 11:54 PM, Stefan Videv wrote:
>>>
>>>> Uncompressing Linux... done, booting the kernel.
>>>> [    0.000000] Initializing cgroup subsys cpuset
>>>> [    0.000000] Initializing cgroup subsys cpu
>>>> [    0.000000] Linux version 3.2.31-psp24 (stefan@stefan-VirtualBox)
>>>> (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #1 Wed Oct 17
>>>> 17:09:40 BST 2012
>>>> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7),
>>>> cr=10c53c7d
>>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
>>>> instruction cache
>>>> [    0.000000] Machine: am335xevm
>>>
>>>
>>> You are trying to run Xenomai on a machine for which the I-pipe patch
>>> does not contain the support. There is no miracle:
>>> - either you add that support yourself
>>
>> I am currently trying to bring up Xenomai on the AM335x EVM board too.
>> It seems Stephan from the thread referred to in the post was able to
>> successfully port Xenomai on the Beaglebone which uses the same chip.
>> So I'm using a similar approach:
>>
>> - kernel sources from
>> git://arago-project.org/git/projects/linux-am33x.git, tag
>> v3.2_AM335xPSP_04.06.00.08, .config am335x_evm_defconfig.
>> - merged v3.2.21
>> - merged core-3.2
>> - changed arch/arm/mach-omap2/irq.c omap_intc_handle_irq to call
>> ipipe_handle_multi_irq instead of handle_IRQ.
>> - cnanged arch/arm/mach-omap2/timer.c OMAP_SYS_TIMER_INIT(3_am33xx,
>> like Stephan suggested.
>>
>> With all this, the kernel boots correctly only without the ipipe.
>>
>> With the ipipe it hangs after 1 second during boot
>> ..
>> [    0.000000] OMAP clockevent source: GPTIMER2 at 24000000 Hz
>> [    0.000000] OMAP clocksource: GPTIMER3 at 24000000 Hz
>> [    0.000000] I-pipe, 24.000 MHz clocksource
>> [    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
>> every 178956ms
>> [    0.000000] Interrupt pipeline (release #1)
>> [    0.000000] Console: colour dummy device 80x30
>> [    0.000519] Calibrating delay loop... 718.02 BogoMIPS (lpj=3590144)
>> [ 0.119053] pid_max: default: 32768 minimum: 301
>> [    0.119208] Security Framework initialized
>> [    0.119329] Mount-cache hash table entries: 512
>> ...
>> [    1.002498] _regulator_get: 2-0018 supply Vdd not found, using
>> dummy regulator
>> [    1.010148] _regulator_get: 2-0018 supply Vdd_IO not found, using
>> dummy regulator
>>
>> A printk in __ipipe_tsc_update which prints every 4096 calls shows:
>>
>> Any suggestions how to debug the clocksource? I put a printk in
>>
>> [    0.996420] Configure Bluetooth Enable pin...
>> [    1.002498] _regulator_get: 2-0018 supply Vdd not found, using
>> dummy regulator
>> [    1.010148] _regulator_get: 2-0018 supply Vdd_IO not found, using
>> dummy regulator
>> [   82.133193] __ipipe_tsc_update
>> [  164.071647] __ipipe_tsc_update
>> [   67.053119] __ipipe_tsc_update
>> [  148.991560] __ipipe_tsc_update
>> [   51.973047] __ipipe_tsc_update
>>
>
> Forcing clocksource="gp timer" at the kernel commandline makes the
> board boot with the ipipe enabled.

Ok, the board boots now with clocksource ipipe_tsc. I had to change:

OMAP_SYS_TIMER_INIT(3_am33xx, 2, AM33XX_CLKEV_SOURCE, 3, AM33XX_MPU_SOURCE)
to
OMAP_SYS_TIMER_INIT(3_am33xx, 2, AM33XX_CLKEV_SOURCE, 1, AM33XX_MPU_SOURCE)

Can someone explain why / confirm this is correct?

Thanks,
Henri.

>
>> Something wrong with the clocksource, right? __ipipe_tsc_update is
>> only called at 50Hz. Shouldn't this be called at the 24Mhz?
>> Any suggestions what to check / debug?
>>
>> Henri.
>>
>>> - or you use a patch provided by the original user, which adds this support.
>>>
>>> --
>>>                                                                 Gilles.
>>>
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> http://www.xenomai.org/mailman/listinfo/xenomai

