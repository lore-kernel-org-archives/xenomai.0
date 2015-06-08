Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <5574585D.90803@xenomai.org>
Date: Mon, 8 Jun 2015 11:28:57 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <92E2440A-6B28-4352-B6E9-F9B5ED130340@gmail.com>
References: <CADvZd9YUCnLcuwndRrsEY=Po1AL7nm_3Z+7daBOaCucRAJgT0w@mail.gmail.com>
 <5574585D.90803@xenomai.org>
Subject: Re: [Xenomai] Q on scheduling - rt_task_wait_period vs
	rtdm_wait_event
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>


> Am 07.06.2015 um 16:42 schrieb Philippe Gerum <rpm@xenomai.org>:
> 
> On 06/07/2015 02:39 PM, Michael Haberler wrote:
>> so far  we had multiple periodic RT threads of different priority, so a
>> lower-priority thread would not preempt a higher-priority one
>> 
>> we are switching the scheduling of a low-priority thread from periodic to
>> event-based - instead of rt_task_wait_period(), this task will now wait in
>> an RTDM driver ioctl in rtdm_event_wait()
>> 
>> I assume the following to be true:
>> 
>> even if the rtdm_even_wait() terminates while a higher priority thread is
>> running, the lower priority thread will not be scheduled until all
>> higher-priority threads have entered rt_task_wait_period().
>> 
>> correct?
>> 
> 
> Yes, assuming SCHED_FIFO for all of these threads. There is no reason
> for implicitly changing the priority of a sleeper as a result of waking
> it up from a blocking service.

thanks! yes, SCHED_FIFO used here. Just preventing a possible blunder ;)


> 
> -- 
> Philippe.


