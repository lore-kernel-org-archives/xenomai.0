Message-ID: <4DF8DC11.9000102@domain.hid>
Date: Wed, 15 Jun 2011 17:21:37 +0100
From: Jakub Nowacki <j.s.nowacki@domain.hid>
MIME-Version: 1.0
References: <4DF5EA11.5010006@domain.hid> <4DF64C3A.6080407@domain.hid>
	<4DF65FC8.1000703@domain.hid> <4DF6F87E.7000500@domain.hid>
	<4DF7436D.6040706@domain.hid> <4DF74640.5070802@domain.hid>
In-Reply-To: <4DF74640.5070802@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/14/2011 12:30 PM, Jan Kiszka wrote:
> On 2011-06-14 13:18, Jakub Nowacki wrote:
>> On 06/14/2011 06:58 AM, Jan Kiszka wrote:
>>>
>>> Do you have the irqbalance daemon running? If yes, disable it and retry.
>>
>> Yes I had. Disabling it helped, namely system works now. I just think I
>> have a slightly higher latencies. Namely, in the 100 us period the
>> average is most of the times about -0.4 us, whereas min and max are
>> approx. -2.5 us and 22 us, respectively. They are still quite good but I
>> think I had slightly lower, especially the max was around 11 us, for no
>> PM. But is not that important for me now.
>
> How long did each of those tests run? And under which load?
>
>>
>>> If it helps, you may also want to try
>>>
>>> git://git.kiszka.org/ipipe.git queues/2.6.38-x86
>>>
>>> If that doesn't help, try to disable CONFIG_DMAR (though it should left
>>> off by default during boot) and CONFIG_INTR_REMAP.
>>
>> They are now both on. Since the kernel works now should I let them be or
>> still switch them off?
>
> It will at least prevent you from accidentally using it.
>
>>
>>> Regarding CONFIG_HPET_TIMER: That's not selectable on x86-64. If you
>>> have "enough" cores, the kernel will run out of HPET timers and won't
>>> select them as clock events. With 8 cores, you should be safe, but
>>> better check the kernel boot messages for "hpet" or the state of
>>> /proc/timer_list regarding "Clock Event Device" when booting the same
>>> kernel without Xenomai support.
>>
>> Thanks for clarifying that. BTW my /proc/timer_list says for 'Clock
>> Event Device' 'pit' for the first one and 'lapic' for other on both
>> ubuntu and ipipe kernel. Hence, looks like no 'hpet' is involved. Also I
>> didn't find any 'hpet' messages in the kernel log.
>>
>> Since a new Adeos patch has just arrived, I'll give it a try with kernel
>> 2.6.38.8 and see how it behaves.
>
> That /should/ make irqbalance work - though I'm not 100% sure, we are
> still hunting bugs in our 2.6.35-based kernel here.

I managed to compile kernel 2.6.38.8 with ipipe without any problems. 
The irqbalance now works correctly, namely, when it is switched on 
system does not freeze any more. Moreover, I have all cores working now. 
I also switched off CONFIG_DMAR and CONFIG_INTR_REMAP as suggested.

I did some latency tests on these new kernels, that is, I have 2.6.38.8 
kernel compiled for generic and core2 (just for testing). Below I show 
summary.

Linux-2.6.38.8-generic-ipipe, user task
RTS|     -2.495|     -0.416|     62.433|       0|     0| 
00:30:00/00:30:00

Linux-2.6.38.8-generic-ipipe, kernel task
RTS|     -3.008|     -1.499|     15.214|       0|     0| 
00:30:00/00:30:00

Linux-2.6.38.8-core2-ipipe, user task
RTS|     -2.528|     -0.431|     18.153|       0|     0| 
00:30:00/00:30:00

Linux-2.6.38.8-core2-ipipe, kernel task
RTS|     -2.962|     -1.433|     14.501|       0|     0| 
00:30:00/00:30:00

They look pretty good but for user task in generic kernel I have about 
once in 30 min a task with maximum latency approx. 70 us (I did a couple 
of test and it was there). I didn't see it for core2 but I did only one 
test, so it actually can be there. It is not what you define as 
'pathological' latency and I'm not sure what can cause that. I have SMI 
workaround switched on. On the other hand I have MSI enabled (because I 
cannot disable them in *config) and Legacy USB in BIOS, because, for 
some reason, my USB keyboard doesn't work in grub without it (I cannot 
select anything in grub but it works later in the system correctly).

Best wishes,

Jakub



