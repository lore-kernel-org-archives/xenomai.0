References: <574D9B03.8080706@sigmatek.at>
 <20160531141646.GG5951@hermes.click-hack.org> <574EE886.2020907@sigmatek.at>
 <20160601141238.GC14103@hermes.click-hack.org> <574FEB2D.5010509@sigmatek.at>
 <20160602082318.GB1801@hermes.click-hack.org> <5755204C.6090701@sigmatek.at>
 <20160606153545.GA376@hermes.click-hack.org> <5756D673.4080408@sigmatek.at>
 <20160607170050.GA13922@hermes.click-hack.org>
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <57714C60.4070407@sigmatek.at>
Date: Mon, 27 Jun 2016 17:55:12 +0200
MIME-Version: 1.0
In-Reply-To: <20160607170050.GA13922@hermes.click-hack.org>
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



Am 2016-06-07 um 19:00 schrieb Gilles Chanteperdrix:
> On Tue, Jun 07, 2016 at 04:13:07PM +0200, Wolfgang Netbal wrote:
>>
>> Am 2016-06-06 um 17:35 schrieb Gilles Chanteperdrix:
>>> On Mon, Jun 06, 2016 at 09:03:40AM +0200, Wolfgang Netbal wrote:
>>>> Am 2016-06-02 um 10:23 schrieb Gilles Chanteperdrix:
>>>>> On Thu, Jun 02, 2016 at 10:15:41AM +0200, Wolfgang Netbal wrote:
>>>>>> Am 2016-06-01 um 16:12 schrieb Gilles Chanteperdrix:
>>>>>>> On Wed, Jun 01, 2016 at 03:52:06PM +0200, Wolfgang Netbal wrote:
>>>>>>>> Am 2016-05-31 um 16:16 schrieb Gilles Chanteperdrix:
>>>>>>>>> On Tue, May 31, 2016 at 04:09:07PM +0200, Wolfgang Netbal wrote:
>>>>>>>>>> Dear all,
>>>>>>>>>>
>>>>>>>>>> we have moved our application from "XENOMAI 2.6.2.1 + Linux 3.0.=
43" to
>>>>>>>>>> "XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i.MX6DL. The =
system
>>>>>>>>>> is now up and running and works stable. Unfortunately we see a
>>>>>>>>>> difference in the performance. Our old combination (XENOMAI 2.6.=
2.1 +
>>>>>>>>>> Linux 3.0.43) was slightly faster.
>>>>>>>>>>
>>>>>>>>>> At the moment it looks like that XENOMAI 2.6.4 calls
>>>>>>>>>> xnpod_schedule_handler much more often then XENOMAI 2.6.2.1 in o=
ur old
>>>>>>>>>> system.  Every call of xnpod_schedule_handler interrupts our main
>>>>>>>>>> XENOMAI task with priority =3D 95.
>> As I wrote above, I get interrupts 1037 handled by rthal_apc_handler()
>> and 1038 handled by xnpod_schedule_handler() while my realtime task
>> is running on kernel 3.10.53 with Xenomai 2.6.4.
>> On kernel 3.0.43 with Xenomai 2.6.4 there are no interrupts, except the
>> once that are send by my board using GPIOs, but this virtual interrupts
>> are assigned to Xenomai and Linux as well but I didn't see a handler
>> installed.
>> I'm pretty sure that these interrupts are slowing down my system, but
>> where do they come from ?
>> why didn't I see them on Kernel 3.0.43 with Xenomai 2.6.4 ?
>> how long do they need to process ?
> How do you mean you do not see them? If you are talking about the
> rescheduling API, it used no to be bound to a virq (so, it would
> have a different irq number on cortex A9, something between 0 and 31
> that would not show in the usual /proc files), I wonder if 3.0 is
> before or after that. You do not see them in /proc, or you see them
> and their count does not increase?
Sorry for the long delay, we ran a lot of tests to find out what could=20
be the reason for
the performance difference.

If I call cat /proc/ipipe/Xenomai I dont see the IRQ handler assigned to=20
the virtual
IRQ on Kernel 3.0.43, but it looks like thats an issue of the Kernel
> As for where they come from, this is not a mystery, the reschedule
> IPI is triggered when code on one cpu changes the scheduler state
> (wakes up a thread for instance) on another cpu. If you want to
> avoid it, do not do that. That means, do not share mutex between
> threads running on different cpus, pay attention for timers to be
> running on the same cpu as the thread they signal, etc...
>
> The APC virq is used to multiplex several services, which you can
> find by grepping the sources for rthal_apc_alloc:
> ./ksrc/skins/posix/apc.c:       pse51_lostage_apc =3D rthal_apc_alloc("ps=
e51_lostage_handler",
> ./ksrc/skins/rtdm/device.c:     rtdm_apc =3D rthal_apc_alloc("deferred RT=
DM close", rtdm_apc_handler,
> ./ksrc/nucleus/registry.c:          rthal_apc_alloc("registry_export", &r=
egistry_proc_schedule, NULL);
> ./ksrc/nucleus/pipe.c:      rthal_apc_alloc("pipe_wakeup", &xnpipe_wakeup=
_proc, NULL);
> ./ksrc/nucleus/shadow.c:            rthal_apc_alloc("lostage_handler", &l=
ostage_handler, NULL);
> ./ksrc/nucleus/select.c:        xnselect_apc =3D rthal_apc_alloc("xnselec=
tors_destroy",
>
> It would be interesting to know which of these services is triggered
> a lot. One possibility I see would be root thread priority
> inheritance, so it would be caused by mode switches. This brings the
> question: do your application have threads migrating between primary
> and secondary mode, do you see the count of mode switches increase
> with the kernel changes, do you have root thread priority
> inheritance enabled?
>
Here a short sum up of our tests and the results and at the end a few=20
questions :-)

we are using a Freescale imx6dl on our hardware and upgraded our operating =
system from
Freescale Kernel 3.0.43 with Xenomai 2.6.2.1 and U-Boot 2013.04 as compiler=
 we use GCC 4.7.2
Freescale Kernel 3.10.53 with Xenomai 2.6.4 and U-Boot 2016.01 as compiler =
we use GCC 4.8.2
On both Kernels the CONFIG_SMP is set.

What we see is that when we running a customer project in a Xenomai task wi=
th priority 95
tooks 40% of the CPU time on Kernel 3.0.43
and 47% of CPU time on Kernel 3.10.53

so the new system is slower by 7% if we sum up this to 100% CPU load we hav=
e a difference of 15%
To find out what is the reason for this difference we ran the following tes=
t.
We tried to get the new system faster by change some components of the syst=
em.

-Changing U-Boot on new system                -> still 7% slower
-Copy Kernel 3.0.43 to new system            -> still 7% slower
-Creating Kernel 3.0.43 with
     Xenomai 2.6.4 and copy it to new system    -> still 7% slower
-Compiling the new system with
     old GCC version                                        -> still 7% slo=
wer
-We also checked the settings for RAM and CPU clock -> these are equal

It looks like that is not one of the big components,
so we started to test some special functions like rt_timer_tsc()
In the following example we stay for 800=B5s in the while loop and
start this loop again after 200=B5s delay.
The task application running this code has priotity 95.

Here a simplified code snipped
start =3D rt_timer_tsc();
do
{
	current =3D rt_timer_tsc();
	i++;=09
} while((current - start) < 800)

i is on old system at 1464
i is on new system at 1392
this means a difference of 5%

Is it possible that the prefetching of code change between the two Kernel v=
ersions,
because our customer application is bigger then our testcode the difference=
 can be greater.

Any hints what can be the reason for this slowdown ?

  Kind regards
  Wolfgang



