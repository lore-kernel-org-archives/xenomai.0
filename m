From: Wojciech Domski <wojciech.domski@gmail.com>
Message-ID: <53C42ADE.7040204@gmail.com>
Date: Mon, 14 Jul 2014 21:09:18 +0200
MIME-Version: 1.0
References: <mailman.653.1404749254.5713.xenomai@xenomai.org>
 <53C3E6CE.2040306@xenomai.org>
In-Reply-To: <53C3E6CE.2040306@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] analogy: sensory 626 patch [Re: Xenomai Digest, Vol 27,
 Issue 12]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>, xenomai@xenomai.org

W dniu 2014-07-14 16:18, Jorge Ramirez Ortiz pisze:
> ---------------------------------------------------------------------- 
> Message: 1 Date: Mon, 07 Jul 2014 12:38:42 +0200 From: Wojciech Domski 
> <> To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> Cc: 
> xenomai@xenomai.org Subject: Re: [Xenomai] Sensoray 626 analogy driver 
> Message-ID: <53BA78B2.2010802@gmail.com> Content-Type: text/plain; 
> charset="utf-8"; Format="flowed" W dniu 11.04.2014 00:01, Gilles 
> Chanteperdrix pisze:
>>> On 04/10/2014 02:25 PM, Wojciech Domski wrote:
>>>> 2014-03-25 13:33 GMT+01:00 Gilles Chanteperdrix <
>>>> gilles.chanteperdrix@xenomai.org>:
>>>>
>>>>> On 03/25/2014 01:14 PM, Wojciech Domski wrote:
>>>>>> W dniu 25.03.2014 12:58, Gilles Chanteperdrix pisze:
>>>>>>> On 03/25/2014 12:54 PM, Wojciech Domski wrote:
>>>>>>>> W dniu 25.03.2014 12:36, Gilles Chanteperdrix pisze:
>>>>>>>>> On 03/25/2014 12:28 PM, Wojciech Domski wrote:
>>>>>>>>>> W dniu 25.03.2014 12:16, Gilles Chanteperdrix pisze:
>>>>>>>>>>> On 03/25/2014 11:26 AM, Wojciech Domski wrote:
>>>>>>>>>>>> W dniu 24.03.2014 13:19, Gilles Chanteperdrix pisze:
>>>>>>>>>>>>> The solution which would be acceptable is not to have busy 
>>>>>>>>>>>>> waits,
>>>>> except
>>>>>>>>>>>>> for very short durations. But for instance transferring a 
>>>>>>>>>>>>> byte on
>>>>> I2C
>>>>>>>>>>>>> takes around 20us at 400 kHz, a 20us masking section is
>>>>> unacceptable.
>>>>>>>>>>>>> rtdm_task_busy_sleep, as the name suggests is a busy wait 
>>>>>>>>>>>>> loop,
>>>>> so, no,
>>>>>>>>>>>>> it is not acceptable either.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Use a thread or a timer to reschedule while you wait for 
>>>>>>>>>>>>> the end
>>>>> of the
>>>>>>>>>>>>> transfer, instead of busy waiting.
>>>>>>>>>>>> Dear Gilles,
>>>>>>>>>>>>
>>>>>>>>>>>> As you mentioned before the driver has few places like this:
>>>>>>>>>>>>
>>>>>>>>>>>> while(!FLAG1);
>>>>>>>>>>>> while(!FLAG2);
>>>>>>>>>>>>
>>>>>>>>>>>> Would a solution of creating a separate task for this 
>>>>>>>>>>>> purpose be
>>>>> ok?
>>>>>>>>>>>> task()
>>>>>>>>>>>> {
>>>>>>>>>>>>           while(!FLAG1);
>>>>>>>>>>>>           while(!FLAG2);
>>>>>>>>>>>> }
>>>>>>>>>>> I was rather thinking about rtdm_task_sleep() instead.
>>>>>>>>>>>
>>>>>>>>>>>> In the place of those loops a piece of code responsible for
>>>>> creating and
>>>>>>>>>>>> joining task would be put instead:
>>>>>>>>>>>>
>>>>>>>>>>>> rtdm_task_init();
>>>>>>>>>>>> rtdm_task_join_nrt();
>>>>>>>>>>> This will not work for code currently running in interrupt
>>>>> handlers. An
>>>>>>>>>>> interrupt handler can not call rtdm_task_join_nrt(). You 
>>>>>>>>>>> will rather
>>>>>>>>>>> have to wake up the thread, not reenabling the interrupt at 
>>>>>>>>>>> the end
>>>>> of
>>>>>>>>>>> the handler, and reenable the interrupt in the thread when 
>>>>>>>>>>> the job
>>>>> is
>>>>>>>>>>> done. Or alternatively, fire a timer instead of waking up a 
>>>>>>>>>>> thread.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>> Dear Gilles,
>>>>>>>>>>
>>>>>>>>>> If what I have understood correctly, basically what you mean is
>>>>> changing:
>>>>>>>>>> while(!FLAG) ;
>>>>>>>>>>
>>>>>>>>>> into
>>>>>>>>>>
>>>>>>>>>> while(!FLAG)
>>>>>>>>>>          rtdm_task_sleep();
>>>>>>>>>>
>>>>>>>>>> Xenomai's documentation that rtdm_task_sleep() can be always
>>>>>>>>>> rescheduled. In my opinion
>>>>>>>>>> this solution is sufficient and meets Xenomai requirements.
>>>>>>>>> This solution will not work if the busy loop was in an irq 
>>>>>>>>> handler.
>>>>> You
>>>>>>>>> can not call rtdm_task_sleep from the context of an irq handler.
>>>>>>>>>
>>>>>>>>>
>>>>>>>> Ok, now I get your point.
>>>>>>>>
>>>>>>>> However, what do you mean exactly by rescheduling while 
>>>>>>>> waiting? Do you
>>>>>>>> mean something like
>>>>>>>> putting all irq services into another thread and only in irq 
>>>>>>>> handler
>>>>>>>> notify the separate thread
>>>>>>>> to do the job accordingly?
>>>>>>> Well, I do not know exactly, I have not looked at the details of 
>>>>>>> the
>>>>>>> driver, you are supposed to do that. But you may be able to 
>>>>>>> split the
>>>>>>> interrupt code in two parts: a first part that will run in 
>>>>>>> interrupt
>>>>>>> mode, and a second part that will run as a thread. The irq 
>>>>>>> handler would
>>>>>>> wake the thread up at the end of the first part, and return without
>>>>>>> reenabling the interrupt at interrupt controller level. The 
>>>>>>> thread would
>>>>>>> execute, sleep during the I2C transfers as needed, and reenable the
>>>>>>> interrupt before going back to sleep.
>>>>>>>
>>>>>>>
>>>>>> So would it be a good practise to create a new task for irq 
>>>>>> service with
>>>>>>
>>>>>> rtdm_task_init();
>>>>>>
>>>>>> inside attach function and join it with
>>>>>>
>>>>>> rtdm_task_join_nrt();
>>>>>>
>>>>>> inside detach function?
>>>>> I do not know the details about analogy drivers, so, again, it is 
>>>>> left
>>>>> to you to read other analogy drivers and see where is the best 
>>>>> place to
>>>>> do what you want to do.
>>>>>
>>>>>
>>>>> -- 
>>>>> Gilles.
>>>>>
>>>> Dear Gilles,
>>>>
>>>> I have altered the driver according to your advices.
>>>> If I had omitted something please let me know.
>>>>
>>>> Please find a patch enclosed in the attachment.
>>>>
>>>> Best regards,
>>>> Wojciech Domski
>>>>
>>>> Domski.pl
>>>>
>>>> Wojciech.Domski.pl
>>>> -------------- next part --------------
>>>> A non-text attachment was scrubbed...
>>>> Name: s626_patch.patch
>>>> Type: text/x-patch
>>>> Size: 141659 bytes
>>>> Desc: not available
>>>> URL: 
>>>> <http://www.xenomai.org/pipermail/xenomai/attachments/20140410/e7191247/attachment.bin>
>>> scripts/checkpatch.pl attchment.bin:
>>>
>>> total: 325 errors, 392 warnings, 3991 lines checked
>>>
>>> Please fix these errors.
>>>
>>>
>> Dear Gilles,
>>
>> In the attachment you will find patch for xenomai including support for
>> analogy Sensoray 626.
>>
>> May I ask you to include this patch to main xenomai tree?
>>
>> Best regards,
>>
>> Wojciech Domski
>>
>> Domski.pl
>>
>> Wojciech.Domski.pl
>>
>
>
> Hi Wojciech
>
> I did some changes to the patch that you sent and pushed it to my 
> Xenomai 3 tree (branch sensoray) as work in progress; however we have 
> no means to test or validate any of the changes.
> http://git.xenomai.org/xenomai-jro.git/log/?h=sensoray
>
> is this something that you can do? ie, do you have access to the 
> sensoray device?
>
> In any case after reviewing the Comedi implementation in 3.12 staging 
> I think it would make sense to base off that newer release instead.
>
> jro
>
>
>
Thank you for committing the driver.
I have access to the Sensoray 626 board and I will test the remarks you 
have proposed. It will take me sometime, however. First of all I would 
like to test my driver with two Sensoray boards. For now, I see that it 
won't work with more than one card. It requires some changes to the 
attach and probe function. After I implement this functionality I will 
take a look into the interrupt handling service.

Seizing the opportunity, I would like to ask you a question about 
handling PCI device. When I'm calling pci_register_driver() and I have 
two exactly the same PCI devices will this function call appropriate 
probe() function two times? If yes, then is the probe() function an 
appropriate place to make list of available devices?

Wojciech Domski

Domski.pl

Wojciech.Domski.pl


