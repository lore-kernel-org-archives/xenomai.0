Message-ID: <54D1DA55.9010808@xenomai.org>
Date: Wed, 04 Feb 2015 09:37:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAEMXjGxMn6s=LA=_a63KPn2vwBOCpxvcDGmys_o+dtMeeGjYHg@mail.gmail.com>
In-Reply-To: <CAEMXjGxMn6s=LA=_a63KPn2vwBOCpxvcDGmys_o+dtMeeGjYHg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Setting execution time limit of task?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>, xenomai <xenomai@xenomai.org>

On 02/04/2015 12:46 AM, Steve B wrote:
> Hello,
> 
> Related to my troubleshooting thread of the last couple days, but this is a
> separate and simple question.
> 
> In POSIX skin is there a way of assigning a high-priority RT thread/task a
> timeslice such that it must yield execution if it exceeds its allotted
> time? Or is this only possible in the native skin?
> 


> 
> Is this what SCHED_RR allows us to do?
> 

I'd say this differently: SCHED_RR is available to share the CPU evenly
between FIFO threads which belong to the same priority group. So this
won't limit the CPU time consumed by a high-priority thread with respect
to low priority threads, the former would keep running indefinitely
until it blocks, or there is a runnable thread with equal or higher
priority.

The equivalent for SCHED_RR in the native skin is implemented by
rt_task_slice().

An option to actually cap the execution time of a thread at a certain
priority level would be to use the sporadic server scheduling
(SCHED_SPORADIC). When the time limit is reached, the thread priority is
lowered, until some conditions are met to switch it back to normal
priority. Both Xenomai 2.x and 3.x implement this
(pthread_setschedparam_ex()).

In addition, Xenomai 3 implements the SCHED_QUOTA policy, which assigns
user-defined percentages of the available CPU time to thread groups,
within a given period of time. The execution time of a thread is charged
to the group it belongs to, until the quota is exceeded, at which point
all threads from that group are de-scheduled, until the next period
starts. And so on.

-- 
Philippe.

