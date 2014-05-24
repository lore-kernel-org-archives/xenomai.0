Message-ID: <5380FAB2.5060809@xenomai.org>
Date: Sat, 24 May 2014 22:01:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1400958355.32393.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <5380F4E9.3010100@xenomai.org>
 <1400961335.63138.YahooMailNeo@web171605.mail.ir2.yahoo.com>
In-Reply-To: <1400961335.63138.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about scheduling and signals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/24/2014 09:55 PM, Matthias Schneider wrote:
> ----- Original Message -----
> 
>> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc: 
>> Sent: Saturday, May 24, 2014 9:37 PM
>> Subject: Re: [Xenomai] Question about scheduling and signals
>>
>> On 05/24/2014 09:05 PM, Matthias Schneider wrote:
>>>  Hi all,
>>>
>>>  currently I am trying to make the following FreeRTOS test case run on 
>>>  forge/mercury on linux preempt_rt:
>>>
>>>
>>>  //Task 1, prio 1 / SCHED_FIFO
>>>  for(;;) {
>>>    (*pulCounter)++;
>>>    if( *pulCounter >= priMAX_COUNT )
>>>       vTaskSuspend(NULL); // -> wait for signal SIGRESM
>>>  }
>>>
>>>  //Task 2, prio 0 / SCHED_OTHER
>>>  vTaskSuspendAll(); //-> sched_lock
>>>  vTaskResume(xLimitedIncrementHandle); //-> sends SIGRESM
>>>  xTaskResumeAll(); //-> sched_unlock, seems not to unlock the waiting 
>> task
>>>                    // right away (because signal is not yet delivered?)
>>
>> At this point, task 1 wakes up, increments ulCounter again, then suspend
>> again, so now ulCounter == priMAX_COUNT + 1
> 
> 
> Why priMAX_COUNT + 1? Shouldnt vTaskSuspend be triggered when 
> *pulCounter == priMAX_COUNT (which is actually is once task 1 gets
> scheduled while task 2 is raising abort - at least my debugger tells me 
> it is).

The task1 first suspends when pulCounter == priMAX_COUNT, right?
Then you wake it up, so, since there is a for loop, it will do

>>>    (*pulCounter)++;
>>>    if( *pulCounter >= priMAX_COUNT )
>>>       vTaskSuspend(NULL); // -> wait for signal SIGRESM

So, now task 1 is suspended again, and *pulCounter == priMAX_COUNT + 1

-- 
                                                                Gilles.

