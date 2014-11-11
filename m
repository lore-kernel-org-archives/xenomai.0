Message-ID: <54626A2E.6020307@free.fr>
Date: Tue, 11 Nov 2014 20:57:34 +0100
From: Thierry Bultel <tbultel@free.fr>
MIME-Version: 1.0
References: <20141107095222.GD6724@sisyphus.hd.free.fr>
 <586279251.109308096.1415364479248.JavaMail.root@zimbra90-e16.priv.proxad.net>
 <20141107195807.GD17476@sisyphus.hd.free.fr> <545FA90B.4040407@free.fr>
 <20141110123657.GJ17476@sisyphus.hd.free.fr>
In-Reply-To: <20141110123657.GJ17476@sisyphus.hd.free.fr>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
 adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: nicolas Mabire <nicolas.mabire@basystemes.fr>, xenomai@xenomai.org

Le 10/11/2014 13:36, Gilles Chanteperdrix a écrit :
> On Sun, Nov 09, 2014 at 06:48:59PM +0100, Thierry Bultel wrote:
>> Le 07/11/2014 20:58, Gilles Chanteperdrix a écrit :
>>> On Fri, Nov 07, 2014 at 01:47:59PM +0100, tbultel@free.fr wrote:
>>>>
>>>>
>>>> ----- Mail original -----
>>>>> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>>>>> À: tbultel@free.fr
>>>>> Cc: xenomai@xenomai.org, "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
>>>>> Envoyé: Vendredi 7 Novembre 2014 10:52:22
>>>>> Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 + adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
>>>>>
>>>>> On Fri, Nov 07, 2014 at 10:48:43AM +0100, tbultel@free.fr wrote:
>>>>>>
>>>>>>
>>>>>> ----- Mail original -----
>>>>>>> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>>>>>>> À: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
>>>>>>> Cc: tbultel@free.fr, xenomai@xenomai.org
>>>>>>> Envoyé: Jeudi 6 Novembre 2014 17:08:21
>>>>>>> Objet: Re: [Xenomai] IMX kernel 3.0.35_4.1.0 +
>>>>>>> adeos-ipipe-3.0.43-mx6q-1.18-14 -> very slow boot
>>>>>>>
>>>>>>> On Thu, Nov 06, 2014 at 11:04:57AM -0500, Lennart Sorensen wrote:
>>>>>>>> On Thu, Nov 06, 2014 at 03:41:47PM +0100, tbultel@free.fr
>>>>>>>> wrote:
>>>>>>>>> Gilles, we do not have CONFIG_ARM_ERRATA_754327 enabled
>>>>>>>>> It is -not- enabled in the evaluation kernel that is provided
>>>>>>>>> by
>>>>>>>>> the
>>>>>>>>> manufacturer.
>>>>>>>>> That errata is said to be for CPU revs < r2p0
>>>>>>>>>
>>>>>>>>> I am a little bit puzzled about the naming conventions for
>>>>>>>>> the
>>>>>>>>> CPU revision,
>>>>>>>>> uboot says rev1.2, the kernel says
>>>>>>>>>
>>>>>>>>> Processor	: ARMv7 Processor rev 10 (v7l)
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>> CPU implementer	: 0x41
>>>>>>>>> CPU architecture: 7
>>>>>>>>> CPU variant	: 0x2
>>>>>>>>> CPU part	: 0xc09
>>>>>>>>> CPU revision	: 10
>>>>>>>>>
>>>>>>>>> how can I do the matching ?
>>>>>>>>>
>>>>>>>>> Meanwhile, we noticed that compared to the evaluation kernel,
>>>>>>>>> we
>>>>>>>>> were missing
>>>>>>>>> CONFIG_ARM_ERRATA_754322 and CONFIG_PL310_ERRATA_769419
>>>>>>>>>
>>>>>>>>> Adding them helps a lot, but the freeze still happens on one
>>>>>>>>> machine
>>>>>>>>>
>>>>>>>>> We are currently trying with 754322 + 769419 + 754327 + 5
>>>>>>>>> nops in
>>>>>>>>> fec ...
>>>>>>>>> but not sure if we need 754327.
>>>>>>>>>
>>>>>>>>> Regards
>>>>>>>>> Thierry
>>>>>>>>>
>>>>>>>>> PS: Regarding the thermal issue, we have changed our
>>>>>>>>> supplier, we
>>>>>>>>> now have
>>>>>>>>> a dissipator that is big enough (it is the AMOS820 from Via
>>>>>>>>> Embedded)
>>>>>>>>
>>>>>>>> I am not sure how to read the A9 revision.  I have this on a
>>>>>>>> system:
>>>>>>>
>>>>>>> I have found the method I gave in ARM documentation. I am pretty
>>>>>>> sure this is how it works.
>>>>>>>
>>>>>>> --
>>>>>>> 					    Gilles.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> Gille,
>>>>>> we agree that as we have a r2p10, the 754327 does not apply.
>>>>>> Thus the only erratas I was missing are CONFIG_ARM_ERRATA_754322
>>>>>> and CONFIG_PL310_ERRATA_769419,
>>>>>> that are in ./arch/arm/configs/imx6_defconfig
>>>>>> They are now part of my config.
>>>>>> Unfortunately, the network stress test still makes the freeze
>>>>>> happen with CONFIG_IPIPE enabled
>>>>>>
>>>>>> How come can that freeze only happen on -some- machines (they all
>>>>>> have the same CPU rev),
>>>>>> and that the time they stay up is dependent on them ?
>>>>>> If the freeze was reproducible without CONFIG_IPIPE, we could
>>>>>> easily say that it is simply
>>>>>> an hardware bug but unfortunately with is not the case.
>>>>>>
>>>>>> A new info: the machine that freezes the most also freezes with
>>>>>> ethernet fec unplugged.
>>>>>> All these machines work fine with CONFIG_IPIPE disabled.
>>>>>
>>>>> Well, you told me that you had freezes because of the mb() in the
>>>>> FEC code, all that I can tell you is that the bug I know related to
>>>>> mb() would probably be fixed by adding nops before the mb(). It is
>>>>> not clear to me, have you tried that?
>>>>>
>>>>> --
>>>>
>>>> The freeze happens faster with he mb(), yes.
>>>> But it is still there without it, or when adding the 5 nops before.
>>>> And if the ethernet is unplugged (which normally leads to the code
>>>> we mention not to be called),  we have the bug, too.
>>>> I have just made a test with a ethernet on USB adapter and it freezes the same way.
>>>
>>> When the freeze happens, is the timer still ticking?
>>
>> I will attempt to do some led debugging by next week, because I do
>> not have a JTAG yet
>
> You can use printascii in the timer interrupt acknowledge routine to
> print a character every HZ ticks, this will give bad latency, but
> should work.
>

For unknown reason, the kernel gets stuck after
"console [tty0] enabled, bootconsole disabled" if I use printascii in 
do_local_timer().
earlyprintk seems broken as well.

>>
>> Have you
>>> checked that all the tricks in the idle function are disabled, in
>>> particular the switch to timer broadcast mode?
>>
>> Could you please be more specific ?
>
> On imx6, as on all cortex a9, Xenomai uses twd timers as local
> timers. Imx6 can be configured so that twd interrupts do not wake up
> a processor from wfi. So, the idle routine switches to "broadcast
> mode", that is disables the local timers, and gets another timer to
> send ipis to all cups when ticking. Since xenomai relies on local
> timers only, this breaks xenomai. So, we try to avoid that, by
> setting enable_wait_mode to false in arch/arm/mach-mx6/cpu.c and
> putting a BUG() in the function which switches to broadcast mode,
> just in case it is invoked another way.
>
>
>>
>> But as you are talking about timer broadcast, I do not know if you
>> remember, but in a previous mail, I said that I saw strange
>> behaviour
>> in the statistics of /proc/interrupts.
>>
>> The 'iMX Timer Tick' interrupt, which is executed on CPU0,
>> increases its counter very slowly, less than 1 per minute.
>> We did not pay too much attention to it.
>> I see in /proc/timer_list that its handler is tick_handle_oneshot_broadcast
>>
>> Could that be related ?
>
> If this is indeed the broadcast timer, it should never tick, because
> we should never switch to broadcast mode.

I have found out why it was ticking.
This is due to tick_broadcast_switch_to_oneshot() in 
kernel/time/tick-broadcast.c

This sets the oneshot mode to the time, and leads to a call of 
mxc_set_mode()

In that function, there is that comment:
	if (mode != clockevent_mode) {
		/* Set event time into far-far future */
		if (timer_is_v2())

... and I estimate "far-far future" to be about 20 minutes.

As a correction, I have made that change to 
tick_broadcast_switch_to_oneshot():

@@ -603,11 +610,21 @@ void tick_broadcast_setup_oneshot(struct 
clock_event_device *bc)
  {
         int cpu = smp_processor_id();

+#if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
+       printk(KERN_ALERT "%s cpu %d -> dev %s 
IGNORED\n",__PRETTY_FUNCTION__, cpu, bc->name);
+       return;
+#endif

... and that makes the job, the iMX Timer is no longer armed.
What do you think about it ?

Still currently stress-testing to see if things are getting better.

>
>>
>> Also, one of our application runs in linux domain (not linked with
>> xenomai), and uses clock_nanosleep to be woken up each 30 ms.
>> We initially used CONFIG_NO_HZ, and found out that sometimes it took
>> up to 200ms to be woken up. LTTng showed that it was not a
>> preemption, and that the thread was really sched-switched, but that
>> it took the CPU only after the next coming interrupt, for instance a
>> network one.
>> Again, I probably should have looked deeper to understand why, but
>> the workaround of using CONFIG_HZ=1000 did it (which I guess hides the
>> bug, but makes that the thread only looses 1 ms in the worse case)
>> I wonder if that bug could be another symptom or not.
>
> This seems to be something different. This usually happens when a
> scheduling of the softirqs at the end of irqs is missing. If you can
> obtain a trace with the I-pipe tracer between the moment the timer
> ticks and the moment the task is really scheduled, we can probably
> find where the softirqs are missing.
>


