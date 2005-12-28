Message-ID: <43B30DB0.3080104@domain.hid>
Date: Wed, 28 Dec 2005 23:12:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 2.4.32 compilation error + old timer
	example	problem
References: <43B1F5CE.7030407@domain.hid> <43B27936.2000108@domain.hid>
	<43B303A8.7010903@domain.hid>
In-Reply-To: <43B303A8.7010903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Hannes Mayer wrote:
> Hi Jan!
> 
> Jan Kiszka wrote:
> 
>> Hannes Mayer wrote:
>>
>>> I checked out xeno.trunk just a few minutes ago.
>>> With kernel 2.4.32, kernel compilation fails with this:
>>>
>>> mq.c: In function `mq_notify':
>>> mq.c:475: error: `SIGEV_SIVNAL' undeclared (first use in this function)
>>> mq.c:475: error: (Each undeclared identifier is reported only once
>>> mq.c:475: error: for each function it appears in.)
>>>
>>> kernel/xenomai/skins/posix/mq.c
>>> SIGEV_SIVNAL => SIGEV_SIGNAL
>>>
>>> ..with that it succeeds.
>>>
>>> But still my timer example doesn't work - see:
>>> https://mail.gna.org/public/xenomai-help/2005-12/msg00020.html
>>>
>>
>>
>> Is this problem only related to the periodic timer mode?
> 
> 
> I've modified my example with rt_task_set_periodic as in the
> rt_serial_uprog example
> http://www.captain.at/xenomai-timer-task.php
> and this variant is working.
> I'm just curious why the original example (#2 on my page) suddenly
> stopped working (rt_task_sleep seems to do nothing, so the messages
> from the task are flooding the screen).

It would be nice to have the error codes possibly returned by 
rt_timer_start() and/or rt_task_sleep() if any.

-- 

Philippe.

