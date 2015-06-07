Message-ID: <5574585D.90803@xenomai.org>
Date: Sun, 07 Jun 2015 16:42:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CADvZd9YUCnLcuwndRrsEY=Po1AL7nm_3Z+7daBOaCucRAJgT0w@mail.gmail.com>
In-Reply-To: <CADvZd9YUCnLcuwndRrsEY=Po1AL7nm_3Z+7daBOaCucRAJgT0w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: Michael Haberler <haberlerm@gmail.com>, xenomai <xenomai@xenomai.org>

On 06/07/2015 02:39 PM, Michael Haberler wrote:
> so far  we had multiple periodic RT threads of different priority, so a
> lower-priority thread would not preempt a higher-priority one
> 
> we are switching the scheduling of a low-priority thread from periodic to
> event-based - instead of rt_task_wait_period(), this task will now wait in
> an RTDM driver ioctl in rtdm_event_wait()
> 
> I assume the following to be true:
> 
> even if the rtdm_even_wait() terminates while a higher priority thread is
> running, the lower priority thread will not be scheduled until all
> higher-priority threads have entered rt_task_wait_period().
> 
> correct?
> 

Yes, assuming SCHED_FIFO for all of these threads. There is no reason
for implicitly changing the priority of a sleeper as a result of waking
it up from a blocking service.

-- 
Philippe.

