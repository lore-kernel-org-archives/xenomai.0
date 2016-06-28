References: <20160601141238.GC14103@hermes.click-hack.org>
 <574FEB2D.5010509@sigmatek.at> <20160602082318.GB1801@hermes.click-hack.org>
 <5755204C.6090701@sigmatek.at> <20160606153545.GA376@hermes.click-hack.org>
 <5756D673.4080408@sigmatek.at> <20160607170050.GA13922@hermes.click-hack.org>
 <57714C60.4070407@sigmatek.at> <20160627164604.GH18662@hermes.click-hack.org>
 <577235C4.2080507@sigmatek.at> <20160628083404.GI18662@hermes.click-hack.org>
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <57724022.8010904@sigmatek.at>
Date: Tue, 28 Jun 2016 11:15:14 +0200
MIME-Version: 1.0
In-Reply-To: <20160628083404.GI18662@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Performance impact after switching from 2.6.2.1 to
 2.6.4
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



Am 2016-06-28 um 10:34 schrieb Gilles Chanteperdrix:
> On Tue, Jun 28, 2016 at 10:31:00AM +0200, Wolfgang Netbal wrote:
>>
>> Am 2016-06-27 um 18:46 schrieb Gilles Chanteperdrix:
>>> On Mon, Jun 27, 2016 at 05:55:12PM +0200, Wolfgang Netbal wrote:
>>>> Am 2016-06-07 um 19:00 schrieb Gilles Chanteperdrix:
>>>>> On Tue, Jun 07, 2016 at 04:13:07PM +0200, Wolfgang Netbal wrote:
>>>>>> Am 2016-06-06 um 17:35 schrieb Gilles Chanteperdrix:
>>>>>>> On Mon, Jun 06, 2016 at 09:03:40AM +0200, Wolfgang Netbal wrote:
>>>>>>>> Am 2016-06-02 um 10:23 schrieb Gilles Chanteperdrix:
>>>>>>>>> On Thu, Jun 02, 2016 at 10:15:41AM +0200, Wolfgang Netbal wrote:
>>>>>>>>>> Am 2016-06-01 um 16:12 schrieb Gilles Chanteperdrix:
>>>>>>>>>>> On Wed, Jun 01, 2016 at 03:52:06PM +0200, Wolfgang Netbal wrote:
>>>>>>>>>>>> Am 2016-05-31 um 16:16 schrieb Gilles Chanteperdrix:
>>>>>>>>>>>>> On Tue, May 31, 2016 at 04:09:07PM +0200, Wolfgang Netbal wro=
te:
>>>>>>>>>>>>>> Dear all,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> we have moved our application from "XENOMAI 2.6.2.1 + Linux =
3.0.43" to
>>>>>>>>>>>>>> "XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i.MX6DL. =
The system
>>>>>>>>>>>>>> is now up and running and works stable. Unfortunately we see=
 a
>>>>>>>>>>>>>> difference in the performance. Our old combination (XENOMAI =
2.6.2.1 +
>>>>>>>>>>>>>> Linux 3.0.43) was slightly faster.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> At the moment it looks like that XENOMAI 2.6.4 calls
>>>>>>>>>>>>>> xnpod_schedule_handler much more often then XENOMAI 2.6.2.1 =
in our old
>>>>>>>>>>>>>> system.  Every call of xnpod_schedule_handler interrupts our=
 main
>>>>>>>>>>>>>> XENOMAI task with priority =3D 95.
>>>>>> As I wrote above, I get interrupts 1037 handled by rthal_apc_handler=
()
>>>>>> and 1038 handled by xnpod_schedule_handler() while my realtime task
>>>>>> is running on kernel 3.10.53 with Xenomai 2.6.4.
>>>>>> On kernel 3.0.43 with Xenomai 2.6.4 there are no interrupts, except =
the
>>>>>> once that are send by my board using GPIOs, but this virtual interru=
pts
>>>>>> are assigned to Xenomai and Linux as well but I didn't see a handler
>>>>>> installed.
>>>>>> I'm pretty sure that these interrupts are slowing down my system, but
>>>>>> where do they come from ?
>>>>>> why didn't I see them on Kernel 3.0.43 with Xenomai 2.6.4 ?
>>>>>> how long do they need to process ?
>>>>> How do you mean you do not see them? If you are talking about the
>>>>> rescheduling API, it used no to be bound to a virq (so, it would
>>>>> have a different irq number on cortex A9, something between 0 and 31
>>>>> that would not show in the usual /proc files), I wonder if 3.0 is
>>>>> before or after that. You do not see them in /proc, or you see them
>>>>> and their count does not increase?
>>>> Sorry for the long delay, we ran a lot of tests to find out what could
>>>> be the reason for
>>>> the performance difference.
>>>>
>>>> If I call cat /proc/ipipe/Xenomai I dont see the IRQ handler assigned =
to
>>>> the virtual
>>>> IRQ on Kernel 3.0.43, but it looks like thats an issue of the Kernel
>>>>> As for where they come from, this is not a mystery, the reschedule
>>>>> IPI is triggered when code on one cpu changes the scheduler state
>>>>> (wakes up a thread for instance) on another cpu. If you want to
>>>>> avoid it, do not do that. That means, do not share mutex between
>>>>> threads running on different cpus, pay attention for timers to be
>>>>> running on the same cpu as the thread they signal, etc...
>>>>>
>>>>> The APC virq is used to multiplex several services, which you can
>>>>> find by grepping the sources for rthal_apc_alloc:
>>>>> ./ksrc/skins/posix/apc.c:       pse51_lostage_apc =3D rthal_apc_alloc=
("pse51_lostage_handler",
>>>>> ./ksrc/skins/rtdm/device.c:     rtdm_apc =3D rthal_apc_alloc("deferre=
d RTDM close", rtdm_apc_handler,
>>>>> ./ksrc/nucleus/registry.c:          rthal_apc_alloc("registry_export"=
, &registry_proc_schedule, NULL);
>>>>> ./ksrc/nucleus/pipe.c:      rthal_apc_alloc("pipe_wakeup", &xnpipe_wa=
keup_proc, NULL);
>>>>> ./ksrc/nucleus/shadow.c:            rthal_apc_alloc("lostage_handler"=
, &lostage_handler, NULL);
>>>>> ./ksrc/nucleus/select.c:        xnselect_apc =3D rthal_apc_alloc("xns=
electors_destroy",
>>>>>
>>>>> It would be interesting to know which of these services is triggered
>>>>> a lot. One possibility I see would be root thread priority
>>>>> inheritance, so it would be caused by mode switches. This brings the
>>>>> question: do your application have threads migrating between primary
>>>>> and secondary mode, do you see the count of mode switches increase
>>>>> with the kernel changes, do you have root thread priority
>>>>> inheritance enabled?
>>>>>
>>>> Here a short sum up of our tests and the results and at the end a few
>>>> questions :-)
>>>>
>>>> we are using a Freescale imx6dl on our hardware and upgraded our opera=
ting system from
>>>> Freescale Kernel 3.0.43 with Xenomai 2.6.2.1 and U-Boot 2013.04 as com=
piler we use GCC 4.7.2
>>>> Freescale Kernel 3.10.53 with Xenomai 2.6.4 and U-Boot 2016.01 as comp=
iler we use GCC 4.8.2
>>>> On both Kernels the CONFIG_SMP is set.
>>>>
>>>> What we see is that when we running a customer project in a Xenomai ta=
sk with priority 95
>>>> tooks 40% of the CPU time on Kernel 3.0.43
>>>> and 47% of CPU time on Kernel 3.10.53
>>>>
>>>> so the new system is slower by 7% if we sum up this to 100% CPU load w=
e have a difference of 15%
>>>> To find out what is the reason for this difference we ran the followin=
g test.
>>>> We tried to get the new system faster by change some components of the=
 system.
>>>>
>>>> -Changing U-Boot on new system                -> still 7% slower
>>>> -Copy Kernel 3.0.43 to new system            -> still 7% slower
>>>> -Creating Kernel 3.0.43 with
>>>>        Xenomai 2.6.4 and copy it to new system    -> still 7% slower
>>>> -Compiling the new system with
>>>>        old GCC version                                        -> still=
 7% slower
>>>> -We also checked the settings for RAM and CPU clock -> these are equal
>>>>
>>>> It looks like that is not one of the big components,
>>>> so we started to test some special functions like rt_timer_tsc()
>>>> In the following example we stay for 800=B5s in the while loop and
>>>> start this loop again after 200=B5s delay.
>>>> The task application running this code has priotity 95.
>>>>
>>>> Here a simplified code snipped
>>>> start =3D rt_timer_tsc();
>>>> do
>>>> {
>>>> 	current =3D rt_timer_tsc();
>>>> 	i++;=09
>>>> } while((current - start) < 800)
>>> If your CPU is running at 1 GHz and uses the global timer as clock
>>> source, the clock source runs at 500 MHz, so 800 ticks of the tsc is
>>> something around 1.6 us
>> Sorry I simplified the code snippet a little bit to much.
>> Thats the correct code.
>>
>> current =3D rt_timer_tsc2ns(rt_timer_tsc());
>>
>>> So, I do not really understand what you are talking about. But are
>>> you sure the two kernels use the same clocksource for xenomai?
>>>
>>> Could you show us the result of "dmesg | grep I-pipe" with the two
>>> kernels ?
>> Output of Kernel 3.10.53 with Xenomai 2.6.4
>> I-pipe, 3.000 MHz clocksource
>> I-pipe, 396.000 MHz clocksource
>> I-pipe, 396.000 MHz timer
>> I-pipe, 396.000 MHz timer
>> I-pipe: head domain Xenomai registered.
>>
>> Output of Kernel 3.0.43 with Xenomai 2.6.2.1
>> [    0.000000] I-pipe 1.18-13: pipeline enabled.
>> [    0.331999] I-pipe, 396.000 MHz timer
>> [    0.335720] I-pipe, 396.000 MHz clocksource
>> [    0.844016] I-pipe: Domain Xenomai registered.
>>
>> The controller is a imx6dl, this controller can run maximum 800MHz
> Ok, so the new kernel registers two tsc emulations, could you run
> the "tsc" regression test to measure the tsc latency? The two tsc
> emulations have very different latencies, so the result would be
> unmistakable.
>

Output of Kernel 3.10.53 with Xenomai 2.6.4
/usr/xenomai/bin/latency
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|     -3.048|     -1.960|      4.053|       0|     0|     -3.048|      4=
.053
RTD|     -3.064|     -1.874|      5.936|       0|     0|     -3.064|      5=
.936
RTD|     -3.137|     -1.963|      3.545|       0|     0|     -3.137|      5=
.936
RTD|     -3.069|     -1.968|      5.805|       0|     0|     -3.137|      5=
.936
RTD|     -3.064|     -1.945|      4.371|       0|     0|     -3.137|      5=
.936
RTD|     -3.071|     -1.905|      3.613|       0|     0|     -3.137|      5=
.936
RTD|     -3.119|     -1.766|      4.967|       0|     0|     -3.137|      5=
.936
RTD|     -3.119|     -1.910|      3.883|       0|     0|     -3.137|      5=
.936
RTD|     -3.102|     -1.910|      5.494|       0|     0|     -3.137|      5=
.936
RTD|     -3.107|     -1.907|      3.795|       0|     0|     -3.137|      5=
.936
RTD|     -3.066|     -1.935|      4.068|       0|     0|     -3.137|      5=
.936
RTD|     -2.960|     -1.920|      4.270|       0|     0|     -3.137|      5=
.936
RTD|     -3.190|     -2.003|      3.436|       0|     0|     -3.190|      5=
.936
RTD|     -3.026|     -2.003|      4.679|       0|     0|     -3.190|      5=
.936
RTD|     -3.149|     -2.011|      3.861|       0|     0|     -3.190|      5=
.936
RTD|     -3.059|     -1.990|      3.651|       0|     0|     -3.190|      5=
.936
RTD|     -3.119|     -1.940|      4.249|       0|     0|     -3.190|      5=
.936
RTD|     -3.192|     -1.983|      4.270|       0|     0|     -3.192|      5=
.936
RTD|     -3.026|     -2.003|      3.568|       0|     0|     -3.192|      5=
.936
RTD|     -3.096|     -1.973|      6.376|       0|     0|     -3.192|      6=
.376
RTD|     -3.258|     -1.953|      5.131|       0|     0|     -3.258|      6=
.376
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)

Can be the two timers the reason for the -3.xxx at lat min ?
Is it possible to disable one of the two timers ?

Output of Kernel 3.0.43 with Xenomai 2.6.2.1

/usr/xenomai/bin/latency
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      3.060|      5.098|     10.255|       0|     0|      3.060|     10=
.255
RTD|      3.073|      5.146|     10.742|       0|     0|      3.060|     10=
.742
RTD|      2.999|      5.146|     10.818|       0|     0|      2.999|     10=
.818
RTD|      3.249|      5.146|     10.936|       0|     0|      2.999|     10=
.936
RTD|      3.169|      5.184|     11.656|       0|     0|      2.999|     11=
.656
RTD|      3.133|      5.156|     10.881|       0|     0|      2.999|     11=
.656
RTD|      3.123|      5.068|      9.835|       0|     0|      2.999|     11=
.656
RTD|      3.032|      5.101|     10.628|       0|     0|      2.999|     11=
.656
RTD|      3.088|      5.047|     10.492|       0|     0|      2.999|     11=
.656
RTD|      3.068|      5.159|     11.681|       0|     0|      2.999|     11=
.681
RTD|      2.967|      5.073|     11.648|       0|     0|      2.967|     11=
.681
RTD|      3.073|      5.106|     11.499|       0|     0|      2.967|     11=
.681
RTD|      3.053|      5.063|     10.727|       0|     0|      2.967|     11=
.681
RTD|      3.159|      5.113|     10.560|       0|     0|      2.967|     11=
.681
RTD|      3.020|      5.078|     11.578|       0|     0|      2.967|     11=
.681
RTD|      3.227|      5.146|     10.856|       0|     0|      2.967|     11=
.681
RTD|      3.186|      5.118|     10.335|       0|     0|      2.967|     11=
.681
RTD|      3.116|      5.108|     10.782|       0|     0|      2.967|     11=
.681
RTD|      2.954|      5.095|     11.921|       0|     0|      2.954|     11=
.921
RTD|      2.952|      5.156|     10.631|       0|     0|      2.952|     11=
.921
RTD|      2.898|      5.121|     10.699|       0|     0|      2.898|     11=
.921
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)



