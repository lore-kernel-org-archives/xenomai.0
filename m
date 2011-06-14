Message-ID: <4DF7436D.6040706@domain.hid>
Date: Tue, 14 Jun 2011 12:18:05 +0100
From: Jakub Nowacki <j.s.nowacki@domain.hid>
MIME-Version: 1.0
References: <4DF5EA11.5010006@domain.hid> <4DF64C3A.6080407@domain.hid>
	<4DF65FC8.1000703@domain.hid> <4DF6F87E.7000500@domain.hid>
In-Reply-To: <4DF6F87E.7000500@domain.hid>
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

On 06/14/2011 06:58 AM, Jan Kiszka wrote:
>
> Do you have the irqbalance daemon running? If yes, disable it and retry.

Yes I had. Disabling it helped, namely system works now. I just think I 
have a slightly higher latencies. Namely, in the 100 us period the 
average is most of the times about -0.4 us, whereas min and max are 
approx. -2.5 us and 22 us, respectively. They are still quite good but I 
think I had slightly lower, especially the max was around 11 us, for no 
PM. But is not that important for me now.

> If it helps, you may also want to try
>
> git://git.kiszka.org/ipipe.git queues/2.6.38-x86
>
> If that doesn't help, try to disable CONFIG_DMAR (though it should left
> off by default during boot) and CONFIG_INTR_REMAP.

They are now both on. Since the kernel works now should I let them be or 
still switch them off?

> Regarding CONFIG_HPET_TIMER: That's not selectable on x86-64. If you
> have "enough" cores, the kernel will run out of HPET timers and won't
> select them as clock events. With 8 cores, you should be safe, but
> better check the kernel boot messages for "hpet" or the state of
> /proc/timer_list regarding "Clock Event Device" when booting the same
> kernel without Xenomai support.

Thanks for clarifying that. BTW my /proc/timer_list says for 'Clock 
Event Device' 'pit' for the first one and 'lapic' for other on both 
ubuntu and ipipe kernel. Hence, looks like no 'hpet' is involved. Also I 
didn't find any 'hpet' messages in the kernel log.

Since a new Adeos patch has just arrived, I'll give it a try with kernel 
2.6.38.8 and see how it behaves. BTW maybe it's a silly question but 
should I rebuild Xenomai each time I install new kernel? Or rephrasing 
it, when should I rebuild Xenomai?

Once more thank you very much for the help.

Best wishes,

Jakub

