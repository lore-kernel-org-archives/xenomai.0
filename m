Message-ID: <4F97B34C.4010004@domain.hid>
Date: Wed, 25 Apr 2012 10:18:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F965FA6.2070009@domain.hid>	<4F966094.9070709@domain.hid>	<4F96652D.1080401@domain.hid>	<4F966A00.8090307@domain.hid>	<4F9672FA.4050003@domain.hid>
	<4F96753C.8060608@domain.hid> <4F970E3F.7000907@domain.hid>
	<4F97B202.8020609@domain.hid>
In-Reply-To: <4F97B202.8020609@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 3/3] Fix imx time reprogramming issue
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Michael Trimarchi <michael@domain.hid>
Cc: Adeos <adeos-main@gna.org>, b.morelli@domain.hid

On 04/25/2012 10:12 AM, Michael Trimarchi wrote:
> Hi Gilles
> 
> On 04/24/2012 10:34 PM, Gilles Chanteperdrix wrote:
>> On 04/24/2012 11:41 AM, Gilles Chanteperdrix wrote:
>>> On 04/24/2012 11:31 AM, Michael Trimarchi wrote:
>>>> Hi
>>>>
>>>> On 04/24/2012 10:53 AM, Gilles Chanteperdrix wrote:
>>>>> On 04/24/2012 10:32 AM, Michael Trimarchi wrote:
>>>>>> On 04/24/2012 10:13 AM, Gilles Chanteperdrix wrote:
>>>>>>> On 04/24/2012 10:09 AM, Michael Trimarchi wrote:
>>>>>>>> This patch includes:
>>>>>>>>
>>>>>>>> * Fix invalid virtual address base of MX1_2_TCM * Fix the
>>>>>>>> minimum delay below which the hardware timer can not be
>>>>>>>> reprogrammed. The value is the same of that one that is used
>>>>>>>> to calculate the min_delta_ns
>>>>>>>>
>>>>>>>> arch/arm/plat-mxc/time.c 414: clockevent_mxc.min_delta_ns =
>>>>>>>> clockevent_delta2ns(0xff, &clockevent_mxc);
>>>>>>>
>>>>>>> I do not think we can use this value, it is way to high for
>>>>>>> xenomai needs. In latest releases we use 2us instead of 1us,
>>>>>>> and according to what a user posted recently, this should be
>>>>>>> enough, could you test with 2us? And 2us is already what we
>>>>>>> have in the 3.2 repository.
>>>>>>>
>>>>>> As I understood the min delays is in tick and not depend on the
>>>>>> clock rate.
>>>>>>
>>>>>> This is from atmel at91_ipipe_time
>>>>>>
>>>>>> min_delta_ticks = ((unsigned long long) clkevt.min_delta_ns *
>>>>>> clkevt.mult) >> clkevt.shift;
>>>>>>
>>>>>> this is exaclty the reverse calculation of
>>>>>> clockevent_mxc.min_delta_ns
>>>>>>
>>>>>> I have already the result in the previous calculation: 0xff is
>>>>>> the minimun in ticks
>>>>>
>>>>> 0xff is too large, it corresponds to 30us on some platforms, could
>>>>> you please try with 2us? The delay is given as a count of ticks or
>>>>> as a duration in ns depending on the architecture, it does not
>>>>> really matter.
>>>>>
>>>>
>>>> Ok, with 0x85 is working (2 uS). I don't find in the documentation
>>>> the min_delta_ns for this architecture. I will rebase the patch on
>>>> core-3.2
>>>
>>> This is not really a specified constant, finding this minimum value is
>>> more of a hit and miss. Anyway, on core 3.2, the timers have been
>>> substantially reworked, and we are able to reuse the clockevent callback
>>> which has a safety mechanism in addition to the minimum value to avoid
>>> loosing ticks (in short, the timer is re-read after programming it, and
>>> if the delay has already passed, the callback returns a negative value,
>>> which the timer subsystem uses to trigger the irq).
>>>
>>> Core-3.2 is not yet supported on ARM for xenomai 2.6. I will do the
>>> changes and keep you informed.
>>>
>> Ok, I have just pushed the changes to the 2.6 branch repository to
>> support I-pipe core on ARM.
>>
>> So, the repository for xenomai is:
>> git://git.xenomai.org/xenoami-2.6.git branch master
>> and the repository for the core-3.2 ipipe series is:
>> git://git.denx.de/ipipe.git branch core-3.2
>>
> 
> Thanks
> I will rebase the the embedded board on top of the ipipe core-3.2 so I can
> test again the ipipe layer.

Ok. In fact, please use the ipipe-core from this branch:
git://git.xenomai.org/ipipe-gch.git branch for-ipipe-3.2-arm, it is
generally more up to date for arm (in this case, it contains some fixes
for imx).

> 
> Michael
> 


-- 
                                                                Gilles.

