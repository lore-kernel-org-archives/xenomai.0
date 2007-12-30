Message-ID: <4777F7CA.3000305@domain.hid>
Date: Sun, 30 Dec 2007 20:55:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4776D48E.7050002@domain.hid> <4777785F.2030903@domain.hid>
	<4777D22A.1090805@domain.hid>
In-Reply-To: <4777D22A.1090805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 4/5] remove legacy code
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> This patch gets rid of code that is no longer needed or valid:
>>>
>>>  - x86_64 APIC frequency is now delivered via ipipe_request_tickdev
>> Ack.
>>
>>>  - __ipipe_tick_irq is maintained via ipipe_update_tick_evtdev also on
>>>    x86_64
>> Client RTOS may/do assume that timing is always delivered through the
>> local APIC timer on x86_64. We could merge that and allow the 8253 to be
>> used as the timer device, but this would not work in practice.
> 
> For forget HPET. There is no wiring of the timer IRQ to the APIC
> anymore.

My point is that whatever timer IRQs the kernel routes to INT0, be them
from the HPET in legacy route replacement mode or from the i8253 with
some former routing, we currently rely on the local APIC timer vector.
No matter what, HPET it's just unsupported by Xenomai right now, so we
can't see any IRQ0 registered as our tick device interrupt.

If your point is about allowing HPET to be used, then your patch
currently expects the HPET to be used in legacy replacement route mode,
which is no more the default setup. In short, TIMER_IRQ may not be the
right -constant- value in the common case.

 The result is that there is no difference between x86_32 and
> x86_64 anymore, and that's what the code reflects.
> 
> If the client RTOS is not yet fully prepared for this, this has to be
> fixed. And only if there is no valid Linux configuration (e.g. HPET off)
> that results in the same timer assignment as with 2.6.23, we need a
> workaround at I-pipe level IMHO.
> 

Again, I see no basic issue in merging that patch, but the message is:
Xenomai still has to support more timer devices than the local APIC one
on x86_64 (e.g. HPET), before this patch has any real upside for it. In
short, it's ok with me, but I feel that we are still half-way from the
complete support.

-- 
Philippe.

