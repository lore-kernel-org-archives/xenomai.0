Message-ID: <43B5635B.9050706@domain.hid>
Date: Fri, 30 Dec 2005 17:42:03 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM interrupt programming practice
References: <1135950474.43b53a8a070f6@domain.hid>
	<43B54A89.1010808@domain.hid>
In-Reply-To: <43B54A89.1010808@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: vdkeybus <Jeroen.VandenKeybus@domain.hid>, xenomai@xenomai.org

Jan Kiszka wrote:
> vdkeybus wrote:
> 
>>I've programmed an RTDM PCI driver using interrupts. However, I've a 
>>few questions regarding the programming practices (especially because 
>>I'm not getting the performance I want). 
>>
>>1. The PCI system assigns an interrupt 177 which is totally outside the 
>>range 0..15 I'm used to. Is it ok to pass this value to rtdm_irq_request
>>() ?

$ cat /proc/ipipe/Linux ?

> 
> 
> Hmm, don't know if the underlying layers (Xenomai HAL, Ipipe patch) will
> accept them.

Xeno will accept anything the I-pipe does accept. IRQ 177 means that the 
IO-APIC is enabled, and I would bet CONFIG_MSI is too. If there is no 
Linux handler for this interrupt, then the solution is to ask Xeno not 
to relay the IRQ down the pipeline to Linux when it sees it.

  RTDM just forwards this value without looking further at
> it. If the return code is Ok but it doesn't work, someone else has to
> blamed. ;)
> 
> 
>>2. Is it obligatory to use a rtdm_toseq_t in rtdm_event_timedwait() and 
>>friends. Or, in other words, can I do rtdm_event_timedwait(&evt, 10000, 
>>NULL); ?
>>
> 
> 
> The latter is fine for most scenarios and will not cause oopses.
> 
> 
>>3. Currently, I register my ISR in the open() function. I unregister it 
>>in close(), after I've disabled the card's interrupt line. 
>>Nevertheless, I get a kernel message right after shutting down:
>>
>>irq 177: nobody cared (try booting with the "irqpoll" option)
>> [<c013a18f>] __report_bad_irq+0x24/0x7f
>> [<c013a26a>] note_interrupt+0x62/0xb8
>> [<c0139c70>] __do_IRQ+0xb7/0xc7
>> [<c010511b>] do_IRQ+0x53/0x8b
>> =======================
>> [<c011c045>] profile_tick+0x20/0x49
>> [<c0114908>] __ipipe_sync_stage+0xf1/0x13a
>> [<c011490d>] __ipipe_sync_stage+0xf6/0x13a
>> [<c0115187>] __ipipe_handle_irq+0x233/0x24c
>> [<c010104a>] default_idle+0x30/0x3b
>> [<c010101a>] default_idle+0x0/0x3b
>> [<c0103b30>] common_interrupt+0x18/0x30
>> [<c010101a>] default_idle+0x0/0x3b
>> [<c010104a>] default_idle+0x30/0x3b
>> [<c01010c2>] cpu_idle+0x3a/0x52
>> [<c0327785>] start_kernel+0x179/0x1df
>> [<c0327330>] unknown_bootoption+0x0/0x1b6
>>handlers:
>>[<f88ae638>] (snd_intel8x0_interrupt+0x0/0x23c [snd_intel8x0])
>>Disabling IRQ #177
>>
>>After this message, it is impossible to reuse the interrupt line (after 
>>e.g. rmmod and insmod of driver and xeno_... modules) and the computer 
>>becomes very slow. Also note that I have traces of snd_intel8x0 
>>appearing in this context.
>>
> 
> 
> Did you also disabled it inside your PCI hardware? Someone seems to
> continue producing IRQs. Anyway, calling rtdm_irq_disable should disable
> the line and prevent such alarms. What does the return value of the
> disable call says?
> 
> Hmm, is that IRQ line shared with non-RT hardware BTW? This is typically
> a no-go for hard-RT scenarios. Already tried to disable that sound
> interface (e.g. in the BIOS if on-chip)?
> 
> 
>>4. How can I verify the status of running xenomai processes (and the 
>>driver). I would like to find out why I'm not meeting my interrupt 
>>deadlines.
> 

$ cat /proc/xenomai/sched
$ cat /proc/xenomai/stat

> 
> Ha, that would be a good job for the latency tracer I recently posted.
> Put some ipipe_trace_begin() in the IRQ handler and an ipipe_trace_end()
> in the driver before waking up the user application (or just
> ipipe_trace_freeze() here could also help). With the pre- and
> post-tracing feature you will also be able to see what happens before
> and after that, e.g. if something delayed your IRQ handler.
> 
> I don't think Philippe has already rolled out some ipipe version with
> the patch included, but you can start with the version I posted two days
> ago as add-on to an existing Xeno-kernel. Feel free to ask me if things
> do not work - this could be a first interesting test case in the field! :)
> 

I've just rolled out two patches, the first issue of the 1.1 series for 
x86, and the accompanying tracer patch. Apply them in that order:

http://download.gna.org/adeos/patches/v2.6/adeos/i386/adeos-ipipe-2.6.14-i386-1.1-00.patch
http://download.gna.org/adeos/patches/v2.6/adeos/i386/tracer/ipipe-tracer-2.6.14-i386-1.1-00.patch

The core patch does not include Dmitry's work on the shared IRQ issues 
yet, but -01 will.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

