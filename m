Message-ID: <4FABEE1E.9000200@domain.hid>
Date: Thu, 10 May 2012 18:34:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1274569547.144858251.1336665852058.JavaMail.root@domain.hid>
In-Reply-To: <1274569547.144858251.1336665852058.JavaMail.root@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: aubin.rebillat@domain.hid
Cc: xenomai@xenomai.org

On 05/10/2012 06:04 PM, aubin.rebillat@domain.hid wrote:
> I'm not that experienced with initrd/initramfs and that was what the
> manufacturer recommended and i followed it so i can have support from
> them. But yes, at first, i think it can boot from another device.

Could you wrap your lines around 72 characters ? I have to do it for you
when I want to reply your posts.

> 
>>
>>> I will look into the OABI and EABI settings then. I will also set
>>> up
>>> an NFS file system to mount debian from and see what is happening.
>>>
>>> Thank you Gilles for your reply. I will keep posting about my
>>> progresses.
>>
>> The issue may simply well be that your timer code does not work.
>> Could
>> you post the code for your port? That is, the code you added to get
>> it
>> work with the I-pipe patch. 
>> Have you checked that linux timer is
>> still
>> ticking after Xenomai has been started?
> 
> No, i did not check that the linux timer is still ticking.
> But i think it is because parts of the init script are executed and
> it is a shell script calling several sub-processes.

If subprocesses were an issue, nobody would be able to run xenomai.

> Nevertheless, I will put some printk in the linux timer handler to be sure.
> 
>>
>> You can also try to boot with CONFIG_IPIPE but without
>> CONFIG_XENOMAI.
> 
> I did, and it's booting just fine.

Ok. Then it is really likely the timer code which is broken. As the only
difference when xenomai is started is that linux timer is handled by
xenomai.


> void ipipe_mach_update_tsc(void)
> {
>   union tsc_reg *local_tsc;
>   unsigned long stamp;
>   unsigned long flags;
> 
>   local_irq_save_hw(flags);
>   local_tsc = &tsc[ipipe_processor_id()];
>   stamp = str8100_read_timer_counter();
>   if (stamp < local_tsc->low)
>     local_tsc->high++;
>   local_tsc->low = stamp;
>   local_irq_restore_hw(flags);
> }

Since this code is called from the timer ack routine, the interrupts are
already off, so, you should not need local_irq_save_hw. On the other
hand, calling ipipe_mach_update_tsc in the timer ack routine adds to the
timer interrupt latency, so, should be done only if the time source is
wrapping really fast. As your timesource is a 32 bits timesource
(according to what you wrote in __ipipe_mach_get_tscinfo), it is
probably not wrapping fast, and you can call ipipe_mach_update_tsc from
linux timer interrupt.

> 
> void __ipipe_mach_acktimer(void)
> {
> #ifndef CONFIG_VIC_INTERRUPT
>   write_seqlock(&xtime_lock);
>   str8100_clear_timer_interrupt_status(__ipipe_mach_timerint);
>   write_sequnlock(&xtime_lock);
> #endif
> 
>   ipipe_mach_update_tsc();
> }

Wrong: you can not call write_seqlock from the acktimer routine. The
seqlock are reserved to usage by Linux. Also note that you should remove
the call to str8100_clear_timer_interrupt_status from Linux timer interrupt.


> void __ipipe_mach_set_dec(unsigned long delay)
> {
>   unsigned long flags;
> 
>   if (delay > 8)
>   {
>     local_irq_save_hw(flags);
>     TIMER1_MATCH_VALUE1_REG = TIMER1_COUNTER_REG + delay;
>     local_irq_restore_hw(flags);
>   }
>   else
>     ipipe_trigger_irq(__ipipe_mach_timerint);
> }

ipipe_mach_set_dec is called with interrupts already off, so there is no
need to call local_irq_save_hw/local_irq_restore_hw.

Also, from the sources I could gather (snakeos-sdk), the hardware timer
for str8100 is programmed in periodic, auto-reload mode. Obviously, when
CONFIG_IPIPE is on, you have to change this to make the timer run in
one-shot mode, as required by Xenomai.

> #ifdef CONFIG_IPIPE
> void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
> {
>   // No cascaded interrupt using the VIC
> }
> #endif /* CONFIG_IPIPE */

You probably do not need to define this function if you #define
ipipe_mach_irq_mux_p to always be 0.

-- 
					    Gilles.

