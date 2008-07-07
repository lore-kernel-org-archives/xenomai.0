Message-ID: <48722B1E.2080201@domain.hid>
Date: Mon, 07 Jul 2008 16:41:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48722544.7090203@domain.hid>
	<a01245292d763fa02c3e6b9a79b67348@domain.hid>
In-Reply-To: <a01245292d763fa02c3e6b9a79b67348@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
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
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

Matthieu wrote:
> On Mon, 07 Jul 2008 16:16:36 +0200, Philippe Gerum <rpm@xenomai.org> wrote:
>> Matthieu wrote:
>>> On Mon, 07 Jul 2008 15:55:33 +0200, Philippe Gerum <rpm@xenomai.org>
>> wrote:
>>>> Matthieu wrote:
>>>>>>> I need a clock to get the time with a 10 µs precision. I tought
>> using
>>>>>> this
>>>>>>> master timebase, as it gives me a time in nanoseconds, irrespective
>> of
>>>>>>> vxworks timebase.
>>>>>> That will work. The master timebase is always active and does return
>>>>>> nanoseconds
>>>>>> when inquired.
>>>>> What instruction I use to get this time ?
>>>>> I tried :
>>>>>
>>>>> #include <native/timer.h>
>>>> #include <nucleus/timebase.h>, but that's not the point.
>>>>
>>>>> xntbase_get_time(&nktbase);
>>>>>
>>>>> But it doesn't work
>>>> It ought to work, otherwise nothing would. What's the issue? Unpected
>>>> result?
>>> I want to get the actual time at a 10µs precision. I will truncate the
>>> result as the master timebase is a nanosecond precision time.
>>>
>> xntbase_get_time(&nktbase) will get you that value. Really. What does not
>> work
>> for you?
> 
> error: 'nktbase' undeclared (first use in this function)
> I include #include <nucleus/timebase.h> but when I look at the source code,
> I see that I need to be un KERNEL space ??
>

Of course you do, that's Xenomai nucleus code. You need to return that value
from your ioctl.

>>>> --
>>>> Philippe.
>>> Matthieu
>>>
>> --
>> Philippe.
> 
> Matthieu
> 
> 
> 


-- 
Philippe.

