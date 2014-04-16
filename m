Message-ID: <534EAD14.9000906@xenomai.org>
Date: Wed, 16 Apr 2014 18:17:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140416180205.C2109F56@centrum.cz>
In-Reply-To: <20140416180205.C2109F56@centrum.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] non-blocking rt_task_suspend(NULL)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: Xenomai <xenomai@xenomai.org>

On 04/16/2014 06:02 PM, Petr Cervenka wrote:
>> Od: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>> CC: "Xenomai" <xenomai@xenomai.org>
>> On 04/16/2014 04:20 PM, Petr Cervenka wrote:
>>>> Od: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>
>>>> CC: "Xenomai" <xenomai@xenomai.org> On 04/16/2014 02:22 PM, Petr
>>>> Cervenka wrote:
>>>>>> Od: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>>>
>>>>>> CC: "Xenomai" <xenomai@xenomai.org> On 04/15/2014 02:42 PM,
>>>>>> Petr Cervenka wrote:
>>>>>>> Hello I have a problem with the rt_task_suspend(NULL) call.
>>>>>>> I'm using it for synchronization of two (producer / consumer
>>>>>>> like) tasks. 1) When the consumer task has no work to do, it
>>>>>>> stops itself by calling of the rt_task_suspend(NULL). 2) When
>>>>>>> the producer creates new work for consumer, it wakes it up by
>>>>>>> calling of rt_task_resume(&consumerTask). The problem is,
>>>>>>> that consumer seldom switches to a state, that it sleeps by
>>>>>>> rt_task_suspend no more. And the task then takes all the CPU
>>>>>>> time. The return code is 0. But I already have seen couple of
>>>>>>> -4 (-EINTR) values in the past also. Consumer task status was
>>>>>>> 00300380 before and 00300184 (if there is small safety sleep
>>>>>>> present). I can use for example RT_EVENT variable instead,
>>>>>>> but I'm curious if you by chance don't know, what is
>>>>>>> happening? Xenomai 2.6.3, Linux 3.5.7
>>>>>>
>>>>>> Could you post the example of code you are using to get this
>>>>>> issue?
>>>>>>
>>>>>
>>>>> It's and application with many threads, mutexes and others. It's
>>>>> also special measuring HW dependent. I can post here some
>>>>> simplified example. But I don't think it would be possible to
>>>>> reproduce the same behavior easily. It happens in my
>>>>> configuration only probably once per day and very unpredictably.
>>>>> But I have more details. I replaced rt_task_suspend /
>>>>> rt_task_resume by rt_event_wait / rt_event_signal. It failed
>>>>> similar way, but this time the result of wait was -4 (-EINTR).
>>>>> And (after several millions of invocations) it recovered itself.
>>>>
>>>> -EINTR is a valid return value for both rt_event_wait and
>>>> rt_task_suspend. In case you get this error, you should loop to
>>>> call rt_event_wait again, and not call rt_event_clear, as you risk
>>>> clearing an event which has been signaled afterwards.
>>>>
>>> You are right. It was just very quick replace of waiting and
>>> waking-up functions. But I'm checking the "work queue" anyway and it
>>> also doesn't need exact timing here. My problem it that the slow
>>> consumer task seems to be "interrupted by signal" (or whatever) for
>>> several minutes. I mean, that it doesn't wait for the event anymore
>>> and it always returns immediately (with -EINTR return code).
>>
>> Are you running inside gdb? Does the task receive the SIGDEBUG signal?
>> Do you have the XNWARNSW bit armed?
>>
>
> gdb: No.
> SIGDEBUG, XNWARNSW: I don't even know what it is ;-).

See examples/native/sigdebug.c in xenomai sources. Try installing the 
same signal handler in your application to be notified upon reception of 
this signal.


-- 
					    Gilles.

