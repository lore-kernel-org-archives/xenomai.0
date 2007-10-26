Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Oct 2007 11:11:48 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0DC1C37@domain.hid>
In-Reply-To: <4721A4C8.4070406@domain.hid>
References: <200710251535.l9PFZYpF021256@domain.hid>	<18208.54980.748005.291295@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0DC1C23@domain.hid>
	<4721A4C8.4070406@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: Re: [Xenomai-help] Event flag from ISR
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
Cc: xenomai@xenomai.org

>-----Original Message-----
>From: Jan Kiszka [mailto:jan.kiszka@domain.hid]
>Sent: vendredi 26 octobre 2007 10:27
>To: ROSSIER Daniel
>Cc: Gilles Chanteperdrix; Patrick; xenomai@xenomai.org
>Subject: Re: [Xenomai-help] Event flag from ISR
>
>ROSSIER Daniel wrote:
>>> -----Original Message-----
>>> From: xenomai-help-bounces@domain.hid
>> [mailto:xenomai-help-bounces@domain.hid]
>>> On Behalf Of Gilles Chanteperdrix
>>> Sent: jeudi 25 octobre 2007 19:48
>>> To: Patrick
>>> Cc: xenomai@xenomai.org
>>> Subject: Re: [Xenomai-help] Event flag from ISR
>>>
>>> Patrick wrote:
>>>> Hi all,
>>>>
>>>>
>>>>
>>>> I am using a RT event flag structure to start a task from an ISR.
>>>>
>>>> The task waits on rt_event_wait and when the IRQ occurs the ISR
>>> executes
>>>> rt_event_signal (the ISR code only clears the flag and calls
>>>> rt_event_signal).
>>>>
>>>> I'm using an oscilloscope to measure the length of the ISR and the
>>> first
>>>> occurrence lasts about 20us and all the next occurrences last about
>>> 4us.
>>>>
>>>>
>>>> My question is why the first ISR is so long?
>>>>
>>>>
>>>>
>>>> For information I use xenomai 2.4 rc4 on ARM pxa270 machine with
>>> 2.6.20
>>>> kernel.
>>> Typical worst case interrupt latency on ARM is around 50 us, so 20
us
>> is
>>> not that long. What you are observing is probably a cache effect. In
>>> this case, you should observe 20us after each user-space context
>switch
>>> since on ARM, cache is flushed at each user-space context switch.
>>
>> It could make sense to have a look at the L4-embedded microkernel
>which
>> uses the Fast Context Switch Extension (FCSE) of ARM
>> and to adapt the mm switch accordingly. But as far as I remember,
this
>> could introduce some limitations to a process
>> size since all threads are sharing a same virtual address space
>> subdivided into smaller virtual regions.
>> Benchmarks with FCSE reported some significant improvements and I
know
>> this technics is commonly used for virtualization layer on ARM.
>
>There is already ongoing work toward FCSE for current Linux, which
could
>then be used by Xenomai as well, see linux-arm-kernel and xenomai-core
>[1] archives. I guess anyone willing to join this effort is welcome.
>

Thanks for the update Jan; great to see that there is some interest
(BTW, I realized that I mix=20
the FCSE with DACR feature which allows to share an address space;
limitations of 32 MB process
address space is bound to DACR ;-)).
We will then see if we can put some efforts on this topic. We keep you
posted.

Daniel


