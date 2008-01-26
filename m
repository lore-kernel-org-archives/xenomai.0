Message-ID: <479B4B16.4090909@domain.hid>
Date: Sat, 26 Jan 2008 16:00:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <BF58A8AFB316514587D61EADBFBF4C4101746780@domain.hid>
	<4799F056.8030005@domain.hid> <479A122D.7080509@domain.hid>
In-Reply-To: <479A122D.7080509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] x86_64 user/system process accounting
Reply-To: rpm@xenomai.org
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
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Kyle Howell wrote:
>>>> Jan Kiszka wrote:
>>>>>>>>>> Kyle Howell wrote:
>>>>>>>>>> I'm running Xenomai 2.4.1 against Linux 2.6.23.12 on an
>>>>>>>>>> x86_64 (Core2)
>>>>>>>>>> system. I'm finding that all of my CPU cycles are being 
>>>>>>>>>> accounted as kernel time rather than user time. The correct 
>>>>>>>>>> processes are still billed, but the system is always 0% user. 
>>>> And here comes a fix:
>>>>
>>>> In rthal_timer_set_oneshot() we assume that the hijacked APIC 
>>>> timer will also be used to for emulating host ticks, thus 
>>>> __ipipe_tick_irq is set accordingly. But this is not true for 
>>>> x86-64 over non-clockevent kernels (2.6.23...), so we have to 
>>>> fixup __ipipe_tick_irq with the correct number (first patch).
>>> cat /proc/stat
>>> cpu  9562 0 418 166028 12 0 2 0
>>> cpu0 1208 0 118 20706 0 0 0 0 
>>>
>>> Ahh... That feels much better. Thanks a lot, Jan. I think that would
>>> have taken me a long, long time to find on my own. BTW, I hope that you
>>> didn't stay up until 5 in the morning on my account.
>> Not till 5... :->
>>
>> Unfortunately I just had to learn from my colleague that the problem is
>> not fully solved (for good-old 2.6.23).
>>
>> So I'm banging my head against it again, and I think I understood that
>> SMP can still account the load to the wrong context any CPU except the
>> one that receives its ticks via RTHAL_BCAST_TICK_IRQ. Back to the
>> drawing board to design a better workaround...
>>
>> Jan - who's happy that 2.6.24 cleans up with the timer mess
>>
> 
> Here is a reworked patch set for this issue. It takes into account that,
> on SMP, Linux receives tick IRQs both via the PIT as well as the APIC
> (forwarded from the PIT). Due to this two sources, I-pipe now has to be
> adopted as well. And it has to be adopted in a way, that the locally
> forwarded timer IRQ is not used by I-pipe to update the registers. That
> property required an extra development cycle here...
> 
> Granted, this approach is ugly. It hacks a bit of Xenomai timer usage
> patterns into I-pipe, but it is currently the only solution I see. And
> it is a temporary workaround for only this kernel series. Philippe, how
> bad is your feeling? Anyone any better idea?
> 

These patches make sense. The entire timer broadcast thingy is working
around an Intel CPU issue regarding C3 mode, so I see no reason why we
should not work around the kernel work-around for the accounting issue
the latter eventually introduces for the I-pipe... Will merge, thanks.

-- 
Philippe.

