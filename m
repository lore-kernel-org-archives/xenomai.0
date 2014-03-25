Message-ID: <53317338.60805@gmail.com>
Date: Tue, 25 Mar 2014 13:14:48 +0100
From: Wojciech Domski <wojciech.domski@gmail.com>
MIME-Version: 1.0
References: <CACKc53LDHUFyLAy5-=wW7Zy+rmB1gthujCORsY1w4zyzip1bmQ@mail.gmail.com>
 <53163439.6070608@gmail.com> <532DBBFF.9010900@xenomai.org>
 <53302093.9090503@gmail.com> <533022B7.9000405@xenomai.org>
 <533159E0.7090809@gmail.com> <53316570.5060600@xenomai.org>
 <5331685C.8030100@gmail.com> <53316A3F.1040601@xenomai.org>
 <53316E59.3000607@gmail.com> <53316F63.1030306@xenomai.org>
In-Reply-To: <53316F63.1030306@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sensoray 626 analogy driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

W dniu 25.03.2014 12:58, Gilles Chanteperdrix pisze:
> On 03/25/2014 12:54 PM, Wojciech Domski wrote:
>> W dniu 25.03.2014 12:36, Gilles Chanteperdrix pisze:
>>> On 03/25/2014 12:28 PM, Wojciech Domski wrote:
>>>> W dniu 25.03.2014 12:16, Gilles Chanteperdrix pisze:
>>>>> On 03/25/2014 11:26 AM, Wojciech Domski wrote:
>>>>>> W dniu 24.03.2014 13:19, Gilles Chanteperdrix pisze:
>>>>>>> The solution which would be acceptable is not to have busy waits, except
>>>>>>> for very short durations. But for instance transferring a byte on I2C
>>>>>>> takes around 20us at 400 kHz, a 20us masking section is unacceptable.
>>>>>>> rtdm_task_busy_sleep, as the name suggests is a busy wait loop, so, no,
>>>>>>> it is not acceptable either.
>>>>>>>
>>>>>>> Use a thread or a timer to reschedule while you wait for the end of the
>>>>>>> transfer, instead of busy waiting.
>>>>>> Dear Gilles,
>>>>>>
>>>>>> As you mentioned before the driver has few places like this:
>>>>>>
>>>>>> while(!FLAG1);
>>>>>> while(!FLAG2);
>>>>>>
>>>>>> Would a solution of creating a separate task for this purpose be ok?
>>>>>>
>>>>>> task()
>>>>>> {
>>>>>>         while(!FLAG1);
>>>>>>         while(!FLAG2);
>>>>>> }
>>>>> I was rather thinking about rtdm_task_sleep() instead.
>>>>>
>>>>>> In the place of those loops a piece of code responsible for creating and
>>>>>> joining task would be put instead:
>>>>>>
>>>>>> rtdm_task_init();
>>>>>> rtdm_task_join_nrt();
>>>>> This will not work for code currently running in interrupt handlers. An
>>>>> interrupt handler can not call rtdm_task_join_nrt(). You will rather
>>>>> have to wake up the thread, not reenabling the interrupt at the end of
>>>>> the handler, and reenable the interrupt in the thread when the job is
>>>>> done. Or alternatively, fire a timer instead of waking up a thread.
>>>>>
>>>>>
>>>> Dear Gilles,
>>>>
>>>> If what I have understood correctly, basically what you mean is changing:
>>>>
>>>> while(!FLAG) ;
>>>>
>>>> into
>>>>
>>>> while(!FLAG)
>>>>        rtdm_task_sleep();
>>>>
>>>> Xenomai's documentation that rtdm_task_sleep() can be always
>>>> rescheduled. In my opinion
>>>> this solution is sufficient and meets Xenomai requirements.
>>> This solution will not work if the busy loop was in an irq handler. You
>>> can not call rtdm_task_sleep from the context of an irq handler.
>>>
>>>
>> Ok, now I get your point.
>>
>> However, what do you mean exactly by rescheduling while waiting? Do you
>> mean something like
>> putting all irq services into another thread and only in irq handler
>> notify the separate thread
>> to do the job accordingly?
> Well, I do not know exactly, I have not looked at the details of the
> driver, you are supposed to do that. But you may be able to split the
> interrupt code in two parts: a first part that will run in interrupt
> mode, and a second part that will run as a thread. The irq handler would
> wake the thread up at the end of the first part, and return without
> reenabling the interrupt at interrupt controller level. The thread would
> execute, sleep during the I2C transfers as needed, and reenable the
> interrupt before going back to sleep.
>
>
So would it be a good practise to create a new task for irq service with

rtdm_task_init();

inside attach function and join it with

rtdm_task_join_nrt();

inside detach function?

Wojciech Domski

Domski.pl

Wojciech.Domski.pl


