Message-ID: <5458DD39.5040102@xenomai.org>
Date: Tue, 04 Nov 2014 15:05:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5458ABC7.2080201@ixblue.com> <5458BBC4.9080802@xenomai.org>
 <20141104114605.GB14961@sisyphus.hd.free.fr> <5458D32E.4020301@xenomai.org>
 <5458D96B.8000605@ixblue.com>
In-Reply-To: <5458D96B.8000605@ixblue.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Round robin scheduling seem not working in a specific
 case...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christophe Carton <christophe.carton@ixblue.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 11/04/2014 02:49 PM, Christophe Carton wrote:
> 
> Le 04/11/2014 14:22, Philippe Gerum a écrit :
>> On 11/04/2014 12:46 PM, Gilles Chanteperdrix wrote:
>>> On Tue, Nov 04, 2014 at 12:43:00PM +0100, Philippe Gerum wrote:
>>>> On 11/04/2014 11:34 AM, Christophe Carton wrote:
>>>>> Hello,
>>>>>
>>>>> I am currently working with Xenomai 2.6.4 with native skin and with a
>>>>> Linux kernel 3.14.17.
>>>>> The linux and the xenomai have been taken from the following Git
>>>>> repositories :
>>>>> * http://git.xenomai.org/xenomai-2.6.git - tag v2.6.4
>>>>> * http://git.xenomai.org/ipipe.git - tag ipipe-core-3.14.17-x86-4
>>>>>
>>>>> I am encountering a problem to enable the Round Robin scheduler in a
>>>>> specific case :
>>>>> * Two tasks ("rr task 1" and "rr task 2") of priority 10 are
>>>>> launched by
>>>>> a task ("init task") of priority 90.
>>>>> * All 3 of them are configured with a RR scheduler via "rt_task_slice"
>>>>> API before they are started.
>>>>> In this case the FIFO scheduling seems to be applied (could be seen
>>>>> via
>>>>> rt_printf logs).
>>>>>
>>>>> I have found a thread on the mailing list that gives an example
>>>>> demonstrating the good behavior of the RR scheduler.
>>>>> http://www.xenomai.org/pipermail/xenomai/2011-November/024897.html
>>>>> http://www.xenomai.org/pipermail/xenomai/2011-November/024899.html
>>>>> This example implies that the tasks are locked via a semaphore at
>>>>> startup and that this semaphore is unlocked by the main when all
>>>>> threads
>>>>> have been started.
>>>>> This is necessary in this case due to the fact that the main
>>>>> function is
>>>>> no an RT task.
>>>>>
>>>>> This implementation (with the semaphore) applied to my test works. Why
>>>>> is the semaphore needed in my case?
>>>> init_task() is switched to non-rt mode by rt_task_create(), so that a
>>>> regular pthread is first created by the glibc, prior to extending it
>>>> with Xenomai capabilities. In 2.6.x, this operation leaves the caller
>>>> (i.e. init_task() in your case) in relaxed/secondary mode, which means
>>>> that it is assigned the lowest priority level in the Xenomai scheduler,
>>>> below the RR class.
>>>>
>>>> Given that, in your code, no Xenomai syscall following the first
>>>> rt_task_create() have the requirement to switch the caller back to
>>>> primary/rt mode, including rt_task_start() which is issued for task_1.
>>>> Hence init_task() won't compete with task() which is assigned the
>>>> real-time RR priority you asked for on entry.
>>>>
>>>> IOW, if you don't make the children wait on a barrier until the parent
>>>> has set the whole thing up, the first call to rt_task_start() will
>>>> unleash task_1, which will in turn start spinning immediately in its
>>>> work loop as init_task() is on a lower priority level, locking up
>>>> CPU#1.
>>>>
>>> Right. You can probably avoid that by enabling the deprecated option
>>> CONFIG_XENO_OPT_PRIOCPL in the kernel configuration.
>>>
>> I would not recommend to rely on this option, as you know we killed it
>> in 3.x because we could never have it working 100% reliably. The only
>> sane way otherwise is to synchronize the parent and the child thread
>> internally at thread creation to preserve the priority order, without
>> requiring the start call to switch to secondary mode, but only 3.x
>> implements this.
>>
> 
> Thanks for your replies.
> I do now understand why my code example is not working like I supposed
> it should have.
> 
> It looks like rt_task_create() and rt_task_start() switches the caller
> in relaxed/secondary mode. This explains the behavior that I have noticed.
> I have read the doxygen documentation about those two API and I did not
> find this behavior explained.
> How could we know which API switches the caller's mode to primary/rt or
> to relaxed/secondary or maybe does not affect the mode?
> 

This behavior was not documented in the 2.6.x series, which is clearly
unfortunate. As a suggestion, here is fallback option :

- first refer to the 3.x documentation for the same call, looking for
the service "Tags" section, e.g. for rt_task_create() that would be:
http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__task.html#ga03387550693c21d0223f739570ccd992
with tags mentioning "thread-unrestricted, switch-secondary".
Clicking on the tags will get you the explanation:
http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/api-tags.html

- then cross-check with the 2.x -> 3.x migration info that the
documented behavior did not change, or in which way it did change. For
the task-related stuff from the API you are using, the info would be there:
http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Task_management

Well, ok. I agree in advance that it's not that handy.

-- 
Philippe.

