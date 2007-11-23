Message-ID: <4746FD21.9000507@domain.hid>
Date: Fri, 23 Nov 2007 17:17:37 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
References: <474540B2.9050208@domain.hid>	
	<2ff1a98a0711220202q66a624aufeec60d246172a75@domain.hid>	
	<474566B5.4050105@domain.hid>	
	<2ff1a98a0711230214s5f9d4456n98912d2c6d87aea8@domain.hid>	
	<4746E171.2040208@domain.hid>
	<2ff1a98a0711230641l3357ab7em1bc3527f42678e86@domain.hid>
In-Reply-To: <2ff1a98a0711230641l3357ab7em1bc3527f42678e86@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CLOCK_REALTIME initialization
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On Nov 23, 2007 3:19 PM, Theo Veenker <Theo.Veenker@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>> On Nov 22, 2007 12:23 PM, Theo Veenker <Theo.Veenker@domain.hid> wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> On Nov 22, 2007 9:41 AM, Theo Veenker <Theo.Veenker@domain.hid> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I understand in the Xenomai posix skin CLOCK_REALTIME gets initialized
>>>>>> on startup of the system and then left alone. There is a problem if the
>>>>>> system's hwclock is storing local time as opposed to UTC. In this case
>>>>>> the Xenomai clock gets initialized with local time instead of UTC.
>>>>>> I use local time in the hwclock because my systems are dual-boot with
>>>>>> MS Windows XP and XP aparently still can't properly deal with hwclock
>>>>>> set to UTC.
>>>>> We use do_getttimeofday at Xenomai initialization time to get the
>>>>> system time. Do you know what we should call to get UTC time ?
>>>> Well I think the call is correct, but I suspect it is done before the
>>>> system time is initialized from the hwtimer. Or doesn't that make sense?
>>>> On my system (Ubuntu) hwclock is called from /etc/rcS.d/S50hwclock.sh
>>>> (rather late). It does something like /sbin/hwclock --hctosys --localtime
>>>> (the latter option indicates hwclock is supposed to store local time).
>>>>
>>>> I would suggest to supply a Xenomai init.d start script which reinitializes
>>>> the xenomai realtime clock. This should then obviously be scheduled
>>>> after Linux has called /sbin/hwclock --hctosys.
>>> I had a look at hwclock code, it gets the timezone from localtime
>>> (which probably gets it from glibc's /etc/localtime) and calls
>>> settimeofday with this timezone. sys_settimeofday sets the global
>>> variable sys_tz with the timezone passed by hwclock.
>>>
>>> So, if we want Xenomai to get the UTC time independently from the
>>> timezone setting, we should take sys_tz into account.
>>>
>>> The problem is that it will work when Xenomai is compiled as module,
>>> since the module will probably be loaded after hwclock is called, but
>>> with Xenomai compiled in kernel, Xenomai initlization will take place
>>> before hwclock is called.
>>>
>>> So, either we should provide, as you suggest, a user-space tool to be
>>> called  in init scripts, but this mean that we have to develop an
>>> interface (probably a driver) for this tool (using any skin would
>>> create an unwanted dependency). Another solution is to generate an
>>> I-pipe event when settimeofday is called, and call xnpod_settime in
>>> this event's handler.
>> Would this mean the real-time clock would also be able to follow the
>> real-time linux clock? I think that would be the thing to do, since
>> the real-time clock is supposed to reflect the number of ns since the
>> epoch. And if the xenomai real-time clock runs on a different pace than
>> the NTP corrected real-time clock in linux, then that means it will
>> gradually drift away from the correct time, and you couldn't call
>> it a real-time clock.
> 
> AFAIK, ntp tries hard not to call settimeofday, but has rather a mean
> to slow down or speed up the clock. If we wanted to track exactly
> Linux time, we would need to intercept the slow down/speed up events
> as well and apply them to xenomai clock. This is another story.

That's right. Thinking a bit further; If xenomai would follow settimeofday
then one could run ntpdate instead of ntpd (with the right flags ntpdate
can be instructed to use settimeofday instead of adjtime) and have the
clocks synchronized regularly, if desired.

> 
>> A slightly related question; I'm doing some calibration in a real-time
>> module which takes a long time (50..100ms). The function repeatedly
>> spins but also and sleeps where possible. It is only done once. Could
>> such a module disturb the linux timekeeping in any way?
> 
> Normally this should not happen, Linux has a mechanism to compensate
> for lost ticks. Except if there is a bug in the I-pipe patch.

Thanks.
Theo


