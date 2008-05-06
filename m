Message-ID: <4820875B.30807@domain.hid>
Date: Tue, 06 May 2008 12:29:15 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <481F6C7D.1050908@domain.hid> <481F884E.5080201@domain.hid>
	<481F9B32.9060003@domain.hid> <48200048.7010604@domain.hid>
In-Reply-To: <48200048.7010604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Loosing serial interrupt
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


Hi Jan,

the problem was that the previous interrupt was not correctly served 
(IIR was not read). UART still reported the new interrupt in its IIR 
register, but probably did not send the INTR signal to the PIC.

Cheers,

Tomas

Jan Kiszka wrote:
> Tomas Kalibera wrote:
>> Hi Jan,
>>> Try to pass I_EDGE to rt_intr_create. The UART IRQs are edge-triggered,
>>> so you have to enable the appropriate handling at kernel IRQ handler 
>>> level.
>>>
>>> Jan
>>>   
>>
>> I'm calling rt_intr_create from user space, so I cannot specify 
>> I_EDGE. But even if I could, looking at the code I assumed that 
>> I_EDGE was only applicable together with I_SHARED, and should be only 
>> used when I need to share and edge IRQ among multiple rt_intr 
>> objects/interrupt handlers.  Is that correct ?
>
> Yeah, that was nonsense. It's a shared-IRQ thing, and those won't work 
> via the native API anyway.
>
> If you can identify a point when something interesting just happened 
> (which means much less than 10 seconds ago), try placing a 
> xntrace_user_freeze() at that location and use the I-pipe tracer to 
> analyse the history of the system (of the last few milliseconds). That 
> can help to understand what does or does not go on at lower levels. 
> Find more infos on the tracer in the wiki.
>
> BTW, there is also a test case available for IRQ delivery via 
> null-modem, check irqbench. It doesn't use the rt_intr API, but the 
> same hardware.
>
> Jan
>


