References: <777d8ed5-7f6a-4e56-7f65-7677f089527e@cs.ru.nl>
 <916ef19a754d4e42b0eaefa8a1a26060@EXPRD08.hosting.ru.nl>
 <5faff965-afc6-f70a-8d10-8f55c570fbf6@cs.ru.nl>
 <b60f35a8-c6ea-20c2-57b6-8d1f667ee14b@siemens.com>
 <0efdb308f2414013882d20061d07a2d7@EXPRD08.hosting.ru.nl>
 <2ac93f8d-770a-52a4-ba63-e6c9252b7b23@cs.ru.nl>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: rt_task_set_priority does not increase priority of other task
In-reply-to: <2ac93f8d-770a-52a4-ba63-e6c9252b7b23@cs.ru.nl>
Date: Sun, 27 Sep 2020 11:24:42 +0200
Message-ID: <87ft731sit.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Harco Kuppens <h.kuppens@cs.ru.nl>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>, "Hooman,
 J.J.M. (Jozef)" <jozef.hooman@tno.nl>


Harco Kuppens <h.kuppens@cs.ru.nl> writes:

> On 17/09/2020 19:49, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 17.09.20 14:01, Harco Kuppens wrote:
>>>> On 17/09/2020 13:51, Jan Kiszka wrote:
>>>>> On 16.09.20 20:12, Harco Kuppens via Xenomai wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I found a problem with rt_task_set_priority function which does not
>>>>>> increase priority of another task.
>>>>>> However it works fine if you increase the priority of another task.
>>>>>>
>>>>>> Below is an en example program and its output, and we run this program
>>>>>> on xenomai 3.08.
>>>>>> The problem appears if we run the program on our xenomai image for the
>>>>>> raspberry pi 3,
>>>>>> and is also appears in our virtual box image.
>>>>>> Both images can be found at :
>>>>>>
>>>>>>     * http://www.cs.ru.nl/lab/xenomai/raspberrypi.html
>>>>>>     * http://www.cs.ru.nl/lab/xenomai/virtualbox.html
>>>>>>
>>>>>> The easiest way is to run the virtualbox image.
>>>>>>
>>>>>> The final question I have: is there an wrong usage of xenomai API in the
>>>>>> example program,
>>>>>> or is this a bug in xenomai?
>>>>>>
>>>>> Something is inconsistent here. Did you also check via
>>>>> /proc/xenomai/sched/threads if that view is consistent with the result
>>>>> of inquire?
>>>> yes, and they also said the priority was not increased.
>>>> You can repeat the experiment in the virtualbox image.
>>>> Note: we use virtualbox so that students can do some exercise at
>>>> home. The exerecises on hardware they must do on raspberry pi 3 in
>>>> the lab.
>>>> Normally a rt os on virtualbox would make no sense.
>>> I'm doing most of Xenomai development in KVM, including kernel
>>> debugging - no need to explain ;).
>>>
>>>>> I vaguely recall issues of the latter but I also do not
>>>>> recall any fix to 3.1, not to speak of anything that was not backported.
>>>>> BTW, tried 3.1 as well?
>>>> no, because I don't have it  installed. Could someone who has it
>>>> running try this example on it, and check whether this   problem
>>>> also occurs there?
>>>>
>>> There is something unexpected with master and also with
>>> --enable-lazy-setsched. It's important to note that without that
>>> feature, include for 3.0 which lacked that, the setprio call will
>>> switch the caller into secondary mode. Still, that alone does not
>>> explain the result to me yet. Thanks in advanced to Philippe to
>>> picking this up!
>> Tricky.
>>
>> In absence of --enable-lazy-setsched, we know that t2 switches to
>> secondary mode as a result of calling rt_task_set_priority(), for the
>> purpose of eagerly propagating the priority update first to the main
>> (kernel) scheduler, _before_ telling Cobalt about it.
>>
>> t1 then t0 - which are still controlled by the Cobalt scheduler - may
>> preempt t2, which runs code somewhere between
>> __STD(pthread_setschedparam()) and
>> XENOMAI_SYSCALL(sc_cobalt_thread_setschedparam_ex) in
>> pthread_setschedparam_ex(), as they wake up from rt_timer_spin().
>>
>> The printf() output may be confusing, because as we see the "change prio
>> task X to Y" message, we still cannot assume the operation was completed
>> just yet. As mentioned earlier, t2 is crawling on the root stage at this
>> point (low priority stage of the pipeline).
>>
>> As t1 then t0 grab the CPU which t2 just yielded, they manage to run
>> their respective loop entirely before t2 has a chance to leave the
>> (low-priority) secondary mode, displaying the old priority value
>> Cobalt-wise, which is still pending update.
>>
>> In short, building with --enable-lazy-setsched may mitigate the issue in
>> most cases, but there is no way to strictly synchronize the main and
>> Cobalt schedulers when it comes to updating thread priorities only using
>> the plain rt_task_set_priority()/pthread_setschedparam_ex() calls. There
>> will always be a delay between the two updates, you only get to chose
>> whether you want the main (linux) scheduler to be updated first at the
>> expense of a mode switch, or Cobalt should be told first about the
>> change (sparing a transition to secondary mode in the process), and the
>> main kernel would be notified next.
>>
>> In the latter case, there is another gotcha involving glibc's caching of
>> a pthread priority value: with --enable-lazy-setsched, that cached value
>> won't be updated with the new value passed to rt_task_set_priority(), so
>> __STD(pthread_getschedparam()) may return the old priority. Some
>> comments in pthread_getschedparam_ex() give details.
>
> I found a mistake in original problem statement
>
>   I found a problem with rt_task_set_priority function which does not
>   increase priority of another task.
>   However it works fine if you increase the priority of another task.
>
> The second line should have been:
>
>  However it works fine if you increase the priority of the current task from the task itself.
>
> I didn't completely understand the responses I got,
> but can I conclude that  setting the priority of another task with the
> rt_task_set_priority function just doesn't work?

This is not a bug per se but a limitation which is inherent to the dual
kernel design: there are two schedulers which should receive the
priority change request, and there is no way to apply such change
atomically to both kernels while keeping them running asynchronously, so
that the real-time core is not affected by the main kernel latency.

By default, libcobalt assumes that it is ok to temporarily switch a
thread issuing such a request to secondary mode, in order to first tell
the main kernel about the change, then tell Cobalt eventually. The
behavior you observed is directly related to that switch, which causes
the caller priority to drop below any real-time priority for a while
(i.e. until the request is sent to Cobalt, which causes a converse
switch to primary mode).

At build time, you may pass --enable-lazy-setsched to the configure
script to override the default setting, telling libcobalt to defer
priority change requests to the main kernel until after the calling
thread issues a regular (non-Cobalt) system call, at some point in the
future. The net effect doing so is that the Cobalt scheduler would
receive the priority change first, and no demotion to secondary mode
would happen as a result of calling rt_task_set_priority(), therefore
the test program should behave the expected way.

> Should that be fixed? Or must that be pointed out in the documentation?
>

I believe you just pointed out a valuable contribution from anyone who
would care helping the project they benefit from. Updates to the
documentation can be sent to the list.

Thanks,

-- 
Philippe.

