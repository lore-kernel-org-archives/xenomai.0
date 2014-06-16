Message-ID: <539F4732.5090100@xenomai.org>
Date: Mon, 16 Jun 2014 21:36:18 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1WwZye-0002zC-2B@sd-51317.dedibox.fr>
 <539F3F60.5040304@xenomai.org> <539F4283.8020602@xenomai.org>
In-Reply-To: <539F4283.8020602@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : cobalt/posix: drop
 pthread_make_periodic_np/ wait_period_np services
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 06/16/2014 09:16 PM, Philippe Gerum wrote:
> On 06/16/2014 09:02 PM, Gilles Chanteperdrix wrote:
>> On 06/16/2014 06:41 PM, git repository hosting wrote:
>>> Module: xenomai-forge
>>> Branch: next
>>> Commit: a4a6ff9a9c9614d3e8ac860386fa3b168c649af0
>>> URL:
>>> http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=a4a6ff9a9c9614d3e8ac860386fa3b168c649af0
>>>
>>>
>>> Author: Philippe Gerum <rpm@xenomai.org>
>>> Date:   Mon Jun 16 18:39:44 2014 +0200
>>>
>>> cobalt/posix: drop pthread_make_periodic_np/wait_period_np services
>>>
>>> We have no more in-tree users of these calls.
>>>
>>> With the introduction of services to support real-time signals, those
>>> two non-portable calls have become redundant. Instead, Cobalt-based
>>> applications should create a periodic timer using the timer_create()
>>> call, and wait for release points via sigwaitinfo(), checking for
>>> overruns by looking at the siginfo.si_overrun field.
>>>
>>> Alternatively, applications may include a timer source in a
>>> synchronous multiplexing operation, by passing a file descriptor
>>> returned by the timerfd() service to a select() call.
>>
>> Actually, read is more direct than select + read, and it allows to get
>> the count of overruns too.
>>
>>
>
> As mentioned in the log, the illustration given is about synchronous
> multiplexing, e.g. waiting for a release point in a timeline _and_ other
> I/O event at the same time, not about single-sourced wait on a timer.
> Otherwise you would just don't care a dime about using select(), I guess.
>

FWIW, this hint is also aimed at applications which insist on 
implementing their own threaded software timer subsystem. This pattern 
is typically found in legacy telecom software running over traditional 
embedded RTOSes, which tend to instantiate a truckload of threads, each 
one serving a particular periodic source. In that case, mentioning 
timerfd + select may help decreasing the level of non-sense, without 
having to change the basic pattern.

-- 
Philippe.

