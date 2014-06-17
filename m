Message-ID: <539FED01.2040609@xenomai.org>
Date: Tue, 17 Jun 2014 09:23:45 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1WwZye-0002zC-2B@sd-51317.dedibox.fr>
 <539F3F60.5040304@xenomai.org> <539F4283.8020602@xenomai.org>
 <539F5E35.8080706@xenomai.org>
In-Reply-To: <539F5E35.8080706@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 06/16/2014 11:14 PM, Gilles Chanteperdrix wrote:
> On 06/16/2014 09:16 PM, Philippe Gerum wrote:
>> On 06/16/2014 09:02 PM, Gilles Chanteperdrix wrote:
>>> On 06/16/2014 06:41 PM, git repository hosting wrote:
>>>> Module: xenomai-forge
>>>> Branch: next
>>>> Commit: a4a6ff9a9c9614d3e8ac860386fa3b168c649af0
>>>> URL:    http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=a4a6ff9a9c9614d3e8ac860386fa3b168c649af0
>>>>
>>>> Author: Philippe Gerum <rpm@xenomai.org>
>>>> Date:   Mon Jun 16 18:39:44 2014 +0200
>>>>
>>>> cobalt/posix: drop pthread_make_periodic_np/wait_period_np services
>>>>
>>>> We have no more in-tree users of these calls.
>>>>
>>>> With the introduction of services to support real-time signals, those
>>>> two non-portable calls have become redundant. Instead, Cobalt-based
>>>> applications should create a periodic timer using the timer_create()
>>>> call, and wait for release points via sigwaitinfo(), checking for
>>>> overruns by looking at the siginfo.si_overrun field.
>>>>
>>>> Alternatively, applications may include a timer source in a
>>>> synchronous multiplexing operation, by passing a file descriptor
>>>> returned by the timerfd() service to a select() call.
>>>
>>> Actually, read is more direct than select + read, and it allows to get
>>> the count of overruns too.
>>>
>>>
>>
>> As mentioned in the log, the illustration given is about synchronous
>> multiplexing, e.g. waiting for a release point in a timeline _and_ other
>> I/O event at the same time, not about single-sourced wait on a timer.
>> Otherwise you would just don't care a dime about using select(), I guess.
>>
> timerfd_create / read is a strict replacement for
> pthread_make_periodic_np/pthread_wait_period_np. Adding a call to select
> simply adds some overhead that was not here in the first place. It
> should be made clear in the documentation that calling select is not
> necessary, otherwise users reading the documentation may assume that
> they have to call select, and suddenly observe a larger latency and at
> best complain, or at worst decide to stay with the old API.
>

Which documentation mentioning select + read are you referring to?

-- 
Philippe.

