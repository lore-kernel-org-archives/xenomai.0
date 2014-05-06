Message-ID: <5368953E.50204@xenomai.org>
Date: Tue, 06 May 2014 09:54:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org> <53679427.90603@xenomai.org>
 <1399360194.79292.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53689342.2050005@xenomai.org>
In-Reply-To: <53689342.2050005@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FreeRTOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/06/2014 09:46 AM, Philippe Gerum wrote:
> On 05/06/2014 09:09 AM, Matthias Schneider wrote:
>> ----- Original Message -----
>>> From: Philippe Gerum <rpm@xenomai.org>
>>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org"
>>> <xenomai@xenomai.org>
>>> Cc:
>>> Sent: Monday, May 5, 2014 3:37 PM
>>> Subject: Re: [Xenomai] FreeRTOS skin
>>>
>>> On 05/05/2014 12:33 PM, Philippe Gerum wrote:
>>>>    On 05/04/2014 06:59 PM, Matthias Schneider wrote:
>>>>>    Hi all,
>>>>>
>>>>>    please find enclosed a patch with a FreeRTOS skin for
>>>>> xenomai-forge I
>>>>>    have
>>>>>    been  working on for some time. I would like to get some
>>>>> feedback and
>>>>>    advice
>>>>>    what still needs to be done to get it accepted in Xenomai. There
>>>>> is a
>>>>>    set of
>>>>>    unit tests included and the possibility to download the original
>>>>>    FreeRTOS package
>>>>>    in order to run most of its (platform independent) test suite.
>>>>> Until
>>>>>    now I have
>>>>>    been working under mercury only. Documentation is available in
>>>>> form of
>>>>>    a README
>>>>>    file in lib/freertos/README, which should also be a good starting
>>> point.
>>>>
>>>>    Ok, thanks for this. Let's address issues gradually, starting
>>>> with the
>>>>    task module.
>>>>
>>>
>>> In addition to the above, there are a few coding style items:
>>>
>>> - Please always take the fastest possible path when exiting on error,
>>>     so that we don't have to cripple the normal processing following the
>>>     failure point with error-specific checks. e.g. what is done with the
>>>     "task" variable in vTaskStartScheduler(), within the thread
>>>     cancellation loop, ends up being convoluted and confusing, compared
>>>     to unwinding and leaving the routine immediately after the error is
>>>     detected.
>>
>>
>> I will review the code and simplify occurrences of the mentioned pattern.
>> However I do not see this pattern in this particular code fragment,
>> since it basically does the following:
>>
>> * take the first entry of the task list
>
> The first check for list emptiness looks racy, as it is not covered by
> the scheduler.lock.
>
>> * check if the task object can be locked
>> * unlock the scheduler lock
>> * if it was possible to lock the task, cancel it
>> * else wait 1ms and try to lock it again
>
> If you found it in your task queue but can't lock it, then call Houston
> because we have a problem: the task finalizer where this task is dropped
> from the list runs prior to deleting the lock.

No, I'm wrong. There is still a race which could allow that. So we need 
both checks.

-- 
Philippe.

