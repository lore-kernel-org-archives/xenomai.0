Message-ID: <5082DED2.1050405@xenomai.org>
Date: Sat, 20 Oct 2012 19:26:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50812949.5040403@openwide.fr> <50814532.5090408@xenomai.org>
	<5082CD5C.1040409@openwide.fr>
In-Reply-To: <5082CD5C.1040409@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] s3c24xx with clocksource/clockevent (kernel 3.2.21)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 10/20/2012 06:12 PM, Romain Naour wrote:

> Le 19/10/2012 14:18, Gilles Chanteperdrix a =C3=A9crit :
>> On 10/19/2012 12:19 PM, Romain Naour wrote:
>>> Hi Gilles,
>>>
>>> First, I followed your advice and I converted the timers to
>>> clocksouce/clockevent framework.
>>>> Other things which could be done for s3c24xx are:
>>>> - convert the timers to clocksource/clockevent: since this platform =
is
>>>> the only one not to use clocksource/clockevent, we have to keep code=

>>>> around for this case in xenomai-forge which could be removed. Having=
 two
>>>> different timers for clocksource and clockevent would allow to avoid=
 the
>>>> tsc emulation based on the decrementer, which I am not sure is reall=
y
>>>> reliable since the conversion to CONFIG_IPIPE_ARM_KUSER_TSC.
>>> I had to reduce timers frequency to 4,21MHz in order to produce an
>>> timer's overflow every 15,5ms.
> As timers are previously used to produce an IRQ at 200Hz, some board us=
e=20
> an external 12MHz signal to clock the timers.
> So it is not possible to reduce the overflow period... (use_tclk1_12() =

> =3D=3D 1).
> I need to check if I can use internal clock instead.


Well, you can get the clock to tick at a higher rate, and ensure that it
is always reprogrammed (for instance in order to get __ipipe_tsc_update
called frequently enough) by reprogramming the timer systematically when
it is not "stolen", in the "ack" handler.

>> For such overflow period, I would recommend running __ipipe_update_tsc=

>> in the acktimer routine.
> What is the recommended frequency for the TSC timer?
> I can reduce timers frequency to 1MHz in order to have a longer overflo=
w=20
> period.


__ipipe_update_tsc has nothing to do with the TSC frequency. It should
simply be called often enough (that is once before the timer overflows)
in order to avoid the tsc going back in time when the hardware timer
overflows.

As for the TSC frequency itself, 1MHz is probably enough, it gives you a
1us resolution, which I would guess is enough for pratical needs.

>>> At 8,45Mhz it does not work.
>>> Thanks to this, I am able to activate hrtimer on Linux :)
>>>
>>> Secondly, I adapted the code for Adeos (Xenomai 2.6.1).
>>> But I'm not sure about the tsc emulation...
>>> Should I keep using the IPIPE_TSC_TYPE_DECREMENTER ?
>>> Do you think we need something like
>>> IPIPE_TSC_TYPE_FREERUNNING_COUNTDOWN_16 ?
>> The type should correspond to the type of the hardware timer you are
>> using, I do not know if you are using the decrementer as clocksource, =
or
>> a separate freerunning countdown timer, so, I can not answer.
> There are five 16bits down counter (decrementer) timers in the s3c2440.=

> I'm using the timer 3 as clocksource with auto-reload mode (reload valu=
e=20
> is 0xFFFF).
> (Which is not exactly an free-running down counter...)


Well, if when it reaches 0, it counts down to 0xFFFF, it looks very much
like a free-running down counter to me.

> Timer 4 is the clockevent.
>> You should run tsc -w to see if the tsc is wrapping correctly.
> tsc -w with latency test in parallel (test-tsc.txt):
> min: 0, max: 14, avg: 0.923722 -> 0.218956 us
> it's good.


The point is not really to check the tsc latency, but to check that the
wrapping takes place correctly, and that there is no hardware bug
causing the timer to go back. For this, the "tsc" test has to be run
without anything else running.

210ns looks good indeed.

>>> In order to adjust scheduling latency, I set /proc/xenomai/latency to=
 0
>>> But I still have negative latency
>>>
>>> (test-latency.txt)
>>> # echo 0 >/proc/xenomai/latency
>>> # latency
>>> =3D=3D Sampling period: 1000 us
>>> =3D=3D Test mode: periodic user-mode task
>>> =3D=3D All results in microseconds
>>> warming up...
>>> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99=
)
>>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
>>> best|--lat worst
>>> RTD|     -0.238|     16.592|     57.599|       0|     0| -0.238|     =
57.599
>>> RTD|      5.925|     16.829|     83.911|       0|     0| -0.238|     =
83.911
>>> RTD|      5.688|     16.829|     78.696|       0|     0| -0.238|     =
83.911
>>> RTD|      5.688|     16.829|     80.355|       0|     0| -0.238|     =
83.911
>>> RTD|      5.925|     17.066|     75.140|       0|     0| -0.238|     =
83.911
>>> RTD|     -0.712|     18.251|     84.622|       0|     0| -0.712|     =
84.622
>>> RTD|      5.925|     16.829|     76.088|       0|     0| -0.712|     =
84.622
>>> RTD|      5.688|     16.829|     73.481|       0|     0| -0.712|     =
84.622
>>> ...
>>>
>>> Can you tell me If this seems good.
>> You can look at /proc/xenomai/timer to see if the timer calibration do=
es
>> not give a too large value.
> # cat /proc/xenomai/timer
> status=3Don+watchdog:setup=3D3555:clock=3D126115699801:timerdev=3Ds3c24=
xx_event_timer:clockdev=3Dipipe_tsc
>=20
> Setup =3D nklatency =3D 3555 (ns)


That is a bit high.

>>   As a general advice, the "set_next_event"
>> callback should make as few register accesses as possible, sometimes
>> register accesses may be slow.
> I understand, but I have to do a "manual update" to reload the timer=20
> with a new value.
> Which requires 1 read and 3 write.


The current code seems to only require 3 writes:

static inline void set_dec(unsigned long reload)
{
        __raw_writel(reload, S3C2410_TCNTB(4));
        /* Manual update */
        __raw_writel(free_running_tcon | S3C2410_TCON_T4MANUALUPD,
S3C2410_TCON);
        /* Start timer */
        __raw_writel(free_running_tcon | S3C2410_TCON_T4START,
S3C2410_TCON);
}


>>> Finally, I add a last patch because I had a problem with the debug po=
rt.
>>> The Tx IRQ was not unmasked by root domain in some circumstances.
>>> Therefore, the debug console hangs when you type "dmesg", "ls"...
>>> kernel 2.6.38.8 is not affected by this bug, but i found It with kern=
el
>>> 3.0.36.
>> That is a nice work, however working with 3.0 was maybe not the best
>> choice. Please:
>> - upgrade to the latest linux version (3.7) and post your patches
>> (converting to clockevent/clocksource) on the linux arm kernel mailing=

>> list, you will probably go over several iterations before the patches
>> are accepted;
>> - when they are accepted, backport them to the latest version of the
>> I-pipe kernel (it is currently 3.4, but could be 3.5 soon).
>>
>> Note that moving the clockevent/clocksource code to 3.7 is probably no=
t
>> a lot of work, and getting this work integrated in mainline means that=

>> you can benefit from other people using and testing the code you wrote=
=2E
>>
>> We currently have an up to date documentation on how to port the I-pip=
e
>> patch to a new arm board for such recent versions:
>> http://xenomai.org/index.php/I-pipe-core:ArmPorting
>>
> Thank you very much, I appreciate your comment.
> I'll try to do that, I'm preparing 3.7-rc1 kernel for my mini2440.
>=20
> Until now, I used the latest supported kernel 3.2.21 with Xenomai 2.6.1=
=2E
> Without rework timer system with clocksource and clockevent,
> I need to set "s3c2410_itimer.min_delay_ticks" value=20
> (s3c24xx_fix_itimer.patch)
> Otherwise the timer hangs.
> And also, the last patch of my previous mail.


You mean the patch for the UART ? I can not take that patch. You have to
understand what goes wrong in the I-pipe core, or irq chip callbacks
implementation for this processor, and fix it there, not in the irq
handler for the serial interrupt. That is clearly the wrong place.

>=20
> Regards,
> Romain
>=20



--=20
                                                                Gilles.


