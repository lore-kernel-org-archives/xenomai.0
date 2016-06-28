References: <20160627164604.GH18662@hermes.click-hack.org>
 <577235C4.2080507@sigmatek.at> <20160628083404.GI18662@hermes.click-hack.org>
 <57724022.8010904@sigmatek.at> <20160628091747.GK18662@hermes.click-hack.org>
 <57724333.6010608@sigmatek.at> <20160628092955.GL18662@hermes.click-hack.org>
 <577248AB.5070601@sigmatek.at> <20160628095543.GM18662@hermes.click-hack.org>
 <57724CFE.2050401@sigmatek.at> <20160628101957.GO18662@hermes.click-hack.org>
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <5772520E.8010407@sigmatek.at>
Date: Tue, 28 Jun 2016 12:31:42 +0200
MIME-Version: 1.0
In-Reply-To: <20160628101957.GO18662@hermes.click-hack.org>
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
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org



Am 2016-06-28 um 12:19 schrieb Gilles Chanteperdrix:
> On Tue, Jun 28, 2016 at 12:10:06PM +0200, Wolfgang Netbal wrote:
>>
>> Am 2016-06-28 um 11:55 schrieb Gilles Chanteperdrix:
>>> On Tue, Jun 28, 2016 at 11:51:39AM +0200, Wolfgang Netbal wrote:
>>>> Am 2016-06-28 um 11:29 schrieb Gilles Chanteperdrix:
>>>>> On Tue, Jun 28, 2016 at 11:28:19AM +0200, Wolfgang Netbal wrote:
>>>>>> Am 2016-06-28 um 11:17 schrieb Gilles Chanteperdrix:
>>>>>>> On Tue, Jun 28, 2016 at 11:15:14AM +0200, Wolfgang Netbal wrote:
>>>>>>>> Am 2016-06-28 um 10:34 schrieb Gilles Chanteperdrix:
>>>>>>>>> On Tue, Jun 28, 2016 at 10:31:00AM +0200, Wolfgang Netbal wrote:
>>>>>>>>>> Am 2016-06-27 um 18:46 schrieb Gilles Chanteperdrix:
>>>>>>>>>>> On Mon, Jun 27, 2016 at 05:55:12PM +0200, Wolfgang Netbal wrote:
>>>>>>>>>>>> Am 2016-06-07 um 19:00 schrieb Gilles Chanteperdrix:
>>>>>>>>>>>>> On Tue, Jun 07, 2016 at 04:13:07PM +0200, Wolfgang Netbal wro=
te:
>>>>>>>>>>>>>> Am 2016-06-06 um 17:35 schrieb Gilles Chanteperdrix:
>>>>>>>>>>>>>>> On Mon, Jun 06, 2016 at 09:03:40AM +0200, Wolfgang Netbal w=
rote:
>>>>>>>>>>>>>>>> Am 2016-06-02 um 10:23 schrieb Gilles Chanteperdrix:
>>>>>>>>>>>>>>>>> On Thu, Jun 02, 2016 at 10:15:41AM +0200, Wolfgang Netbal=
 wrote:
>>>>>>>>>>>>>>>>>> Am 2016-06-01 um 16:12 schrieb Gilles Chanteperdrix:
>>>>>>>>>>>>>>>>>>> On Wed, Jun 01, 2016 at 03:52:06PM +0200, Wolfgang Netb=
al wrote:
>>>>>>>>>>>>>>>>>>>> Am 2016-05-31 um 16:16 schrieb Gilles Chanteperdrix:
>>>>>>>>>>>>>>>>>>>>> On Tue, May 31, 2016 at 04:09:07PM +0200, Wolfgang Ne=
tbal wrote:
>>>>>>>>>>>>>>>>>>>>>> Dear all,
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> we have moved our application from "XENOMAI 2.6.2.1 =
+ Linux 3.0.43" to
>>>>>>>>>>>>>>>>>>>>>> "XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i=
.MX6DL. The system
>>>>>>>>>>>>>>>>>>>>>> is now up and running and works stable. Unfortunatel=
y we see a
>>>>>>>>>>>>>>>>>>>>>> difference in the performance. Our old combination (=
XENOMAI 2.6.2.1 +
>>>>>>>>>>>>>>>>>>>>>> Linux 3.0.43) was slightly faster.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> At the moment it looks like that XENOMAI 2.6.4 calls
>>>>>>>>>>>>>>>>>>>>>> xnpod_schedule_handler much more often then XENOMAI =
2.6.2.1 in our old
>>>>>>>>>>>>>>>>>>>>>> system.  Every call of xnpod_schedule_handler interr=
upts our main
>>>>>>>>>>>>>>>>>>>>>> XENOMAI task with priority =3D 95.
>>>>>>>>>>>>>> As I wrote above, I get interrupts 1037 handled by rthal_apc=
_handler()
>>>>>>>>>>>>>> and 1038 handled by xnpod_schedule_handler() while my realti=
me task
>>>>>>>>>>>>>> is running on kernel 3.10.53 with Xenomai 2.6.4.
>>>>>>>>>>>>>> On kernel 3.0.43 with Xenomai 2.6.4 there are no interrupts,=
 except the
>>>>>>>>>>>>>> once that are send by my board using GPIOs, but this virtual=
 interrupts
>>>>>>>>>>>>>> are assigned to Xenomai and Linux as well but I didn't see a=
 handler
>>>>>>>>>>>>>> installed.
>>>>>>>>>>>>>> I'm pretty sure that these interrupts are slowing down my sy=
stem, but
>>>>>>>>>>>>>> where do they come from ?
>>>>>>>>>>>>>> why didn't I see them on Kernel 3.0.43 with Xenomai 2.6.4 ?
>>>>>>>>>>>>>> how long do they need to process ?
>>>>>>>>>>>>> How do you mean you do not see them? If you are talking about=
 the
>>>>>>>>>>>>> rescheduling API, it used no to be bound to a virq (so, it wo=
uld
>>>>>>>>>>>>> have a different irq number on cortex A9, something between 0=
 and 31
>>>>>>>>>>>>> that would not show in the usual /proc files), I wonder if 3.=
0 is
>>>>>>>>>>>>> before or after that. You do not see them in /proc, or you se=
e them
>>>>>>>>>>>>> and their count does not increase?
>>>>>>>>>>>> Sorry for the long delay, we ran a lot of tests to find out wh=
at could
>>>>>>>>>>>> be the reason for
>>>>>>>>>>>> the performance difference.
>>>>>>>>>>>>
>>>>>>>>>>>> If I call cat /proc/ipipe/Xenomai I dont see the IRQ handler a=
ssigned to
>>>>>>>>>>>> the virtual
>>>>>>>>>>>> IRQ on Kernel 3.0.43, but it looks like thats an issue of the =
Kernel
>>>>>>>>>>>>> As for where they come from, this is not a mystery, the resch=
edule
>>>>>>>>>>>>> IPI is triggered when code on one cpu changes the scheduler s=
tate
>>>>>>>>>>>>> (wakes up a thread for instance) on another cpu. If you want =
to
>>>>>>>>>>>>> avoid it, do not do that. That means, do not share mutex betw=
een
>>>>>>>>>>>>> threads running on different cpus, pay attention for timers t=
o be
>>>>>>>>>>>>> running on the same cpu as the thread they signal, etc...
>>>>>>>>>>>>>
>>>>>>>>>>>>> The APC virq is used to multiplex several services, which you=
 can
>>>>>>>>>>>>> find by grepping the sources for rthal_apc_alloc:
>>>>>>>>>>>>> ./ksrc/skins/posix/apc.c:       pse51_lostage_apc =3D rthal_a=
pc_alloc("pse51_lostage_handler",
>>>>>>>>>>>>> ./ksrc/skins/rtdm/device.c:     rtdm_apc =3D rthal_apc_alloc(=
"deferred RTDM close", rtdm_apc_handler,
>>>>>>>>>>>>> ./ksrc/nucleus/registry.c:          rthal_apc_alloc("registry=
_export", &registry_proc_schedule, NULL);
>>>>>>>>>>>>> ./ksrc/nucleus/pipe.c:      rthal_apc_alloc("pipe_wakeup", &x=
npipe_wakeup_proc, NULL);
>>>>>>>>>>>>> ./ksrc/nucleus/shadow.c:            rthal_apc_alloc("lostage_=
handler", &lostage_handler, NULL);
>>>>>>>>>>>>> ./ksrc/nucleus/select.c:        xnselect_apc =3D rthal_apc_al=
loc("xnselectors_destroy",
>>>>>>>>>>>>>
>>>>>>>>>>>>> It would be interesting to know which of these services is tr=
iggered
>>>>>>>>>>>>> a lot. One possibility I see would be root thread priority
>>>>>>>>>>>>> inheritance, so it would be caused by mode switches. This bri=
ngs the
>>>>>>>>>>>>> question: do your application have threads migrating between =
primary
>>>>>>>>>>>>> and secondary mode, do you see the count of mode switches inc=
rease
>>>>>>>>>>>>> with the kernel changes, do you have root thread priority
>>>>>>>>>>>>> inheritance enabled?
>>>>>>>>>>>>>
>>>>>>>>>>>> Here a short sum up of our tests and the results and at the en=
d a few
>>>>>>>>>>>> questions :-)
>>>>>>>>>>>>
>>>>>>>>>>>> we are using a Freescale imx6dl on our hardware and upgraded o=
ur operating system from
>>>>>>>>>>>> Freescale Kernel 3.0.43 with Xenomai 2.6.2.1 and U-Boot 2013.0=
4 as compiler we use GCC 4.7.2
>>>>>>>>>>>> Freescale Kernel 3.10.53 with Xenomai 2.6.4 and U-Boot 2016.01=
 as compiler we use GCC 4.8.2
>>>>>>>>>>>> On both Kernels the CONFIG_SMP is set.
>>>>>>>>>>>>
>>>>>>>>>>>> What we see is that when we running a customer project in a Xe=
nomai task with priority 95
>>>>>>>>>>>> tooks 40% of the CPU time on Kernel 3.0.43
>>>>>>>>>>>> and 47% of CPU time on Kernel 3.10.53
>>>>>>>>>>>>
>>>>>>>>>>>> so the new system is slower by 7% if we sum up this to 100% CP=
U load we have a difference of 15%
>>>>>>>>>>>> To find out what is the reason for this difference we ran the =
following test.
>>>>>>>>>>>> We tried to get the new system faster by change some component=
s of the system.
>>>>>>>>>>>>
>>>>>>>>>>>> -Changing U-Boot on new system                -> still 7% slow=
er
>>>>>>>>>>>> -Copy Kernel 3.0.43 to new system            -> still 7% slower
>>>>>>>>>>>> -Creating Kernel 3.0.43 with
>>>>>>>>>>>>            Xenomai 2.6.4 and copy it to new system    -> still=
 7% slower
>>>>>>>>>>>> -Compiling the new system with
>>>>>>>>>>>>            old GCC version                                    =
    -> still 7% slower
>>>>>>>>>>>> -We also checked the settings for RAM and CPU clock -> these a=
re equal
>>>>>>>>>>>>
>>>>>>>>>>>> It looks like that is not one of the big components,
>>>>>>>>>>>> so we started to test some special functions like rt_timer_tsc=
()
>>>>>>>>>>>> In the following example we stay for 800=B5s in the while loop=
 and
>>>>>>>>>>>> start this loop again after 200=B5s delay.
>>>>>>>>>>>> The task application running this code has priotity 95.
>>>>>>>>>>>>
>>>>>>>>>>>> Here a simplified code snipped
>>>>>>>>>>>> start =3D rt_timer_tsc();
>>>>>>>>>>>> do
>>>>>>>>>>>> {
>>>>>>>>>>>> 	current =3D rt_timer_tsc();
>>>>>>>>>>>> 	i++;=09
>>>>>>>>>>>> } while((current - start) < 800)
>>>>>>>>>>> If your CPU is running at 1 GHz and uses the global timer as cl=
ock
>>>>>>>>>>> source, the clock source runs at 500 MHz, so 800 ticks of the t=
sc is
>>>>>>>>>>> something around 1.6 us
>>>>>>>>>> Sorry I simplified the code snippet a little bit to much.
>>>>>>>>>> Thats the correct code.
>>>>>>>>>>
>>>>>>>>>> current =3D rt_timer_tsc2ns(rt_timer_tsc());
>>>>>>>>>>
>>>>>>>>>>> So, I do not really understand what you are talking about. But =
are
>>>>>>>>>>> you sure the two kernels use the same clocksource for xenomai?
>>>>>>>>>>>
>>>>>>>>>>> Could you show us the result of "dmesg | grep I-pipe" with the =
two
>>>>>>>>>>> kernels ?
>>>>>>>>>> Output of Kernel 3.10.53 with Xenomai 2.6.4
>>>>>>>>>> I-pipe, 3.000 MHz clocksource
>>>>>>>>>> I-pipe, 396.000 MHz clocksource
>>>>>>>>>> I-pipe, 396.000 MHz timer
>>>>>>>>>> I-pipe, 396.000 MHz timer
>>>>>>>>>> I-pipe: head domain Xenomai registered.
>>>>>>>>>>
>>>>>>>>>> Output of Kernel 3.0.43 with Xenomai 2.6.2.1
>>>>>>>>>> [    0.000000] I-pipe 1.18-13: pipeline enabled.
>>>>>>>>>> [    0.331999] I-pipe, 396.000 MHz timer
>>>>>>>>>> [    0.335720] I-pipe, 396.000 MHz clocksource
>>>>>>>>>> [    0.844016] I-pipe: Domain Xenomai registered.
>>>>>>>>>>
>>>>>>>>>> The controller is a imx6dl, this controller can run maximum 800M=
Hz
>>>>>>>>> Ok, so the new kernel registers two tsc emulations, could you run
>>>>>>>>> the "tsc" regression test to measure the tsc latency? The two tsc
>>>>>>>>> emulations have very different latencies, so the result would be
>>>>>>>>> unmistakable.
>>>>>>>>>
>>>>>>>> Output of Kernel 3.10.53 with Xenomai 2.6.4
>>>>>>>> /usr/xenomai/bin/latency
>>>>>>> This test is named "latency", not "tsc". As the different names
>>>>>>> imply, they are not measuring the same thing.
>>>>>>>
>>>>>> Sorry for the stupied question,
>>>>>> but where do I find the "tsc" test, because in folder /usr/xenomai/b=
in/
>>>>>> is it not located
>>>>> You have millions of files on your target? Or you compiled busybox
>>>>> without support for the "find" utility ?
>>>>>
>>>> Sorry I searched for tsc befor but didn't find any executable called "=
tsc"
>>>> what I find is /usr/share/ghostscript and its config files and
>>>> /usr/bin/xtscal.
>>>>
>>>> I find in the xenomai sources the file tsc.c, could you please tell me
>>>> what option do I have to enable that this will be build ?
>>> There is no option that can disable its compilation/installation as
>>> far as I know.
>>>
>>> It is normally built and installed under
>>> @XENO_TEST_DIR@/regression/native
>>>
>>> So the installation directory depends on the value you passed to
>>> configure --with-testdir option (the default being /usr/bin).
>>>
>> Thanks a lot I found it and downloaded it to my target
>>
>> Here are the output for Kernel 3.10.53 and Xenomai 2.6.4
>>
>> #> ./tsc
>> Checking tsc for 1 minute(s)
>> min: 10, max: 596, avg: 10.5056
>> min: 10, max: 595, avg: 10.5053
>> min: 10, max: 603, avg: 10.5053
>> min: 10, max: 630, avg: 10.5052
>> min: 10, max: 600, avg: 10.505
>> min: 10, max: 595, avg: 10.5056
>> min: 10, max: 562, avg: 10.505
>> min: 10, max: 605, avg: 10.5056
>> min: 10, max: 602, avg: 10.5055
>> min: 10, max: 595, avg: 10.5052
> Could you let the test run until the end ? (1 minute is not so long).
>
Sorry I dont want to overload the mail

Here are the output for Kernel 3.10.53 and Xenomai 2.6.4


#> ./tsc
Checking tsc for 1 minute(s)
min: 10, max: 595, avg: 10.5055
min: 10, max: 596, avg: 10.5048
min: 10, max: 595, avg: 10.5048
min: 10, max: 563, avg: 10.5047
min: 10, max: 594, avg: 10.505
min: 10, max: 652, avg: 10.5047
min: 10, max: 604, avg: 10.505
min: 10, max: 595, avg: 10.5045
min: 10, max: 595, avg: 10.5046
min: 10, max: 594, avg: 10.5046
min: 10, max: 582, avg: 10.5045
min: 10, max: 599, avg: 10.5046
min: 10, max: 379, avg: 10.5046
min: 10, max: 571, avg: 10.5046
min: 10, max: 534, avg: 10.5051
min: 10, max: 591, avg: 10.5046
min: 10, max: 595, avg: 10.5048
min: 10, max: 630, avg: 10.5049
min: 10, max: 534, avg: 10.5047
min: 10, max: 564, avg: 10.5048
min: 10, max: 520, avg: 10.5049
min: 10, max: 255, avg: 10.5047
min: 10, max: 594, avg: 10.5047
min: 10, max: 677, avg: 10.505
min: 10, max: 128, avg: 10.5053
min: 10, max: 530, avg: 10.5046
min: 10, max: 595, avg: 10.5047
min: 10, max: 595, avg: 10.5048
min: 10, max: 121, avg: 10.5044
min: 10, max: 595, avg: 10.5053
min: 10, max: 598, avg: 10.505
min: 10, max: 595, avg: 10.505
min: 10, max: 595, avg: 10.505
min: 10, max: 598, avg: 10.5047
min: 10, max: 143, avg: 10.5058
min: 10, max: 125, avg: 10.505
min: 10, max: 202, avg: 10.5047
min: 10, max: 595, avg: 10.5047
min: 10, max: 295, avg: 10.5049
min: 10, max: 156, avg: 10.5047
min: 10, max: 546, avg: 10.5049
min: 10, max: 547, avg: 10.5048
min: 10, max: 153, avg: 10.5048
min: 10, max: 116, avg: 10.5046
min: 10, max: 591, avg: 10.5052
min: 10, max: 594, avg: 10.5046
min: 10, max: 563, avg: 10.5048
min: 10, max: 101, avg: 10.5046
min: 10, max: 117, avg: 10.5048
min: 10, max: 608, avg: 10.505
min: 10, max: 593, avg: 10.5048
min: 10, max: 617, avg: 10.5047
min: 10, max: 596, avg: 10.505
min: 10, max: 529, avg: 10.5048
min: 10, max: 557, avg: 10.5052
min: 10, max: 104, avg: 10.5047
min: 10, max: 595, avg: 10.5048
min: 10, max: 595, avg: 10.5046
min: 10, max: 115, avg: 10.5045
min: 10, max: 196, avg: 10.5046
min: 10, max: 677, avg: 10.5048 -> 0.0265273 us

Here are the output for Kernel 3.0.43 and Xenomai 2.6.2.1

#> ./tsc
Checking tsc for 1 minute(s)
min: 10, max: 141, avg: 11.5371
min: 10, max: 181, avg: 11.5377
min: 10, max: 512, avg: 11.5444
min: 10, max: 93, avg: 11.5335
min: 10, max: 578, avg: 11.5581
min: 10, max: 81, avg: 11.5838
min: 10, max: 290, avg: 11.5455
min: 10, max: 105, avg: 11.5441
min: 10, max: 543, avg: 11.5648
min: 10, max: 111, avg: 11.5602
min: 10, max: 96, avg: 11.5607
min: 10, max: 77, avg: 11.5758
min: 10, max: 122, avg: 11.5601
min: 10, max: 78, avg: 11.5494
min: 10, max: 142, avg: 11.581
min: 10, max: 95, avg: 11.5513
min: 10, max: 142, avg: 11.5825
min: 10, max: 580, avg: 11.5829
min: 10, max: 104, avg: 11.5656
min: 10, max: 77, avg: 11.5833
min: 10, max: 667, avg: 11.5623
min: 10, max: 91, avg: 11.5742
min: 10, max: 656, avg: 11.5742
min: 10, max: 78, avg: 11.5866
min: 10, max: 428, avg: 11.5958
min: 10, max: 77, avg: 11.5945
min: 10, max: 81, avg: 11.5948
min: 10, max: 96, avg: 11.5787
min: 10, max: 85, avg: 11.5975
min: 10, max: 122, avg: 11.6049
min: 10, max: 516, avg: 11.5776
min: 10, max: 95, avg: 11.597
min: 10, max: 550, avg: 11.5868
min: 10, max: 147, avg: 11.6125
min: 10, max: 582, avg: 11.611
min: 10, max: 541, avg: 11.6105
min: 10, max: 154, avg: 11.5942
min: 10, max: 94, avg: 11.6217
min: 10, max: 74, avg: 11.6066
min: 10, max: 91, avg: 11.653
min: 10, max: 539, avg: 11.6248
min: 10, max: 166, avg: 11.5915
min: 10, max: 81, avg: 11.6156
min: 10, max: 111, avg: 11.6099
min: 10, max: 578, avg: 11.6348
min: 10, max: 95, avg: 11.6329
min: 10, max: 640, avg: 11.629
min: 10, max: 597, avg: 11.6336
min: 10, max: 95, avg: 11.615
min: 10, max: 555, avg: 11.5757
min: 10, max: 94, avg: 11.5749
min: 10, max: 530, avg: 11.5542
min: 10, max: 82, avg: 11.5346
min: 10, max: 119, avg: 11.5466
min: 10, max: 94, avg: 11.5169
min: 10, max: 173, avg: 11.5044
min: 10, max: 147, avg: 11.5309
min: 10, max: 196, avg: 11.4833
min: 10, max: 542, avg: 11.4979
min: 10, max: 95, avg: 11.4895
min: 10, max: 667, avg: 11.5755 -> 0.029231 us



