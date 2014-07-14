Message-ID: <53C43A52.7070702@xenomai.org>
Date: Mon, 14 Jul 2014 22:15:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53A3E8FE.5020005@xenomai.org>
 <1403519510.94410.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1403555262.58217.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1404233289.69461.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53BCF270.3010303@xenomai.org>
 <1405365539.41980.YahooMailNeo@web171603.mail.ir2.yahoo.com>
In-Reply-To: <1405365539.41980.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FreeRTOS skin #2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/14/2014 09:18 PM, Matthias Schneider wrote:
> 
> 
> 
> 
> ----- Original Message -----
>> From: Philippe Gerum <rpm@xenomai.org>
>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc: 
>> Sent: Wednesday, July 9, 2014 9:42 AM
>> Subject: Re: [Xenomai] FreeRTOS skin #2
>>
>> On 07/01/2014 06:48 PM, Matthias Schneider wrote:
>>>  Please find enclosed another calling the check_processors() only when 
>> starting
>>>  the scheduler and remembering its output. It is also adapted to the latest 
>> changes.
>>>  Any comments will be appreciated.
>>>
>>
>> - clusters allowing key dups are available using the *_dup() call form
>> - vTaskEndScheduler() can be simplified, and should not panic if it 
>> cannot lock a vanishing thread pulled from the task list.
>>  
>> -- 
> 
>> Philippe.
>>
> 
> The vTaskEndScheduler() patch unfortunately now leads to a frozen
> vTaskStartScheduler() function when shutting down in some tests.
> 
> This is probably due to freertos_scheduler.tasklist_end_cond not being
> triggered when the list gets empty in vTaskEndScheduler() ? also, 

That condvar is shared between the task finalizer and
vTaskStartScheduler() instead. If no task terminates after
vTaskEndScheduler() is called, then we will be missing the trigger
indeed. The logic needs some fixing. I also just noticed that the
start_cond variable seems redundant with the purpose of
threadobj_wait_start().

> freertos_scheduler.num_tasks seems not to be decremented when removing
> elemets from the list via pvlist_pop_entry().
> 

> Even when calling pthread_cond_signal() at the end of vTaskEndScheduler(),
> I still get the freeze. Any idea?
> 
> 

-- 
Philippe.

