Message-ID: <54635DD7.9090800@free.fr>
Date: Wed, 12 Nov 2014 14:17:11 +0100
From: Thierry Bultel <tbultel@free.fr>
MIME-Version: 1.0
References: <20141107095222.GD6724@sisyphus.hd.free.fr>
 <586279251.109308096.1415364479248.JavaMail.root@zimbra90-e16.priv.proxad.net>
 <20141107195807.GD17476@sisyphus.hd.free.fr> <545FA90B.4040407@free.fr>
 <20141110123657.GJ17476@sisyphus.hd.free.fr> <54626A2E.6020307@free.fr>
 <20141111200358.GL17476@sisyphus.hd.free.fr>
In-Reply-To: <20141111200358.GL17476@sisyphus.hd.free.fr>
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

Le 11/11/2014 21:03, Gilles Chanteperdrix a écrit :
> On Tue, Nov 11, 2014 at 08:57:34PM +0100, Thierry Bultel wrote:
>> Le 10/11/2014 13:36, Gilles Chanteperdrix a écrit :
>>> You can use printascii in the timer interrupt acknowledge routine to
>>> print a character every HZ ticks, this will give bad latency, but
>>> should work.
>>>
>>
>> For unknown reason, the kernel gets stuck after
>> "console [tty0] enabled, bootconsole disabled" if I use printascii
>> in do_local_timer().
>> earlyprintk seems broken as well.
>
> Without doing this, does earlyprintk work?

No it does not. In fact, this kernel is strange with early debug.
Namely, even without earlyprintk, when it comes to disable the 
bootconsole to use the normal one, it uses then re-prints everything was 
printed before, making think that it has restarted from the beginning.

I confirm that calling printascii in do_local_timer() leads to a kernel 
panic. Same thing if I use __ipipe_serial_debug instead.
I have used a counter (one per cpu) to start logging after 30000 ticks 
and it crashes after that delay.

>
>>> If this is indeed the broadcast timer, it should never tick, because
>>> we should never switch to broadcast mode.
>>
>> I have found out why it was ticking.
>> This is due to tick_broadcast_switch_to_oneshot() in
>> kernel/time/tick-broadcast.c
>>
>> This sets the oneshot mode to the time, and leads to a call of
>> mxc_set_mode()
>>
>> In that function, there is that comment:
>> 	if (mode != clockevent_mode) {
>> 		/* Set event time into far-far future */
>> 		if (timer_is_v2())
>>
>> ... and I estimate "far-far future" to be about 20 minutes.
>>
>> As a correction, I have made that change to
>> tick_broadcast_switch_to_oneshot():
>>
>> @@ -603,11 +610,21 @@ void tick_broadcast_setup_oneshot(struct
>> clock_event_device *bc)
>>   {
>>          int cpu = smp_processor_id();
>>
>> +#if defined(CONFIG_IPIPE) && defined(CONFIG_SMP)
>> +       printk(KERN_ALERT "%s cpu %d -> dev %s
>> IGNORED\n",__PRETTY_FUNCTION__, cpu, bc->name);
>> +       return;
>> +#endif
>>
>> ... and that makes the job, the iMX Timer is no longer armed.
>> What do you think about it ?
>>
>> Still currently stress-testing to see if things are getting better.
>
> I am afraid this should not change anything. This timer ticking is
> not a problem by itself, it is a problem if the twd gets disabled.
>
> Note that we discovered in another thread that CONFIG_TRACE_IRQFLAGS
> should not be enabled. So, if it is enabled, you should disable it.
>
> Also, are you running with all I-pipe and Xenomai debugs?

That is how I am running now. For now, I am unable to reproduce the 
freeze. Still testing.

>


