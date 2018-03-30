MIME-Version: 1.0
In-Reply-To: <CAOuPNLjsR2rELk49orfVWJ2TVg_-66crVoc67eRZG9KEeCEcVg@mail.gmail.com>
References: <CAOuPNLjGFNwaCNa1zGQY4gZpLC7J=5M4EzGNS-YiK1UOx=+t0w@mail.gmail.com>
 <d8ad5e99-4097-4754-f443-de74f9653cb4@xenomai.org>
 <CAOuPNLgYEpHaoMMZ+Dx=WHqwMnRLwkx_hUZAj6Jtiqfq_1LTZw@mail.gmail.com>
 <5e40ba43-e8a0-1a2e-9020-d62788ad7c01@xenomai.org>
 <CAOuPNLjsR2rELk49orfVWJ2TVg_-66crVoc67eRZG9KEeCEcVg@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Fri, 30 Mar 2018 12:23:22 +0530
Message-ID: <CAOuPNLh_7X7jieLUN3vYRzKfvJMHO-60gC9mT_nS1O_K8m-iSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Problem with rt_cond_wait and rt_cond_signal
	combination
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Mar 30, 2018 at 12:12 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> On Wed, Mar 28, 2018 at 11:02 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 03/28/2018 07:20 PM, Pintu Kumar wrote:
>>> On Wed, Mar 28, 2018 at 8:37 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>>> On 03/28/2018 09:54 AM, Pintu Kumar wrote:
>>>>> Hi,
>>>>>
>>>>> We are facing one issue on Xenomai-3 on x86_64 system.
>>>>> Kernel: 4.9.51
>>>>> ipipe version: 4
>>>>> # /usr/xenomai/sbin/version
>>>>> Xenomai/cobalt v3.0.6 -- #5956064 (2018-03-20 12:13:33 +0100)
>>>>>
>>>>> Its a very simple API level test.
>>>>> We create a condition variable and wait for the condition inside a task.
>>>>> Then, we immediately signal the condition from the main thread, and simply
>>>>> wait for the test to finish.
>>>>>
>>>>> But we observed that condition task is never getting released, and the
>>>>> program hangs.
>>>>>
>>>>> This is the output:
>>>>> --------------------------
>>>>> # ./condsignal
>>>>> cond_task --> started
>>>>> main --> cond signal success: 0
>>>>> Waiting for task to finish....
>>>>> ^C
>>>>>
>>>>>
>>>>> This is the code snippet that was used.
>>>>> -----------------------------------------------------
>>>>> # cat condsignal.c
>>>>>
>>>>> /*
>>>>>  * 1. Create an condition variable and wait inside a task.
>>>>>  * 2. Delete the condition variable from main task.
>>>>>  * 3. Observe that the condition wait is released and task ends normally.
>>>>>  * 4. Finally main task should exit normally.
>>>>>  *
>>>>>  * */
>>>>> #include <stdio.h>
>>>>> #include <stdlib.h>
>>>>> #include <sys/mman.h>
>>>>> #include <alchemy/task.h>
>>>>> #include <alchemy/mutex.h>
>>>>> #include <alchemy/cond.h>
>>>>> #include <alchemy/task.h>
>>>>>
>>>>> static RT_COND cond;
>>>>> static RT_MUTEX mutex;
>>>>>
>>>>> static void cond_task(void *cookie)
>>>>> {
>>>>>         int err;
>>>>>
>>>>>         printf("%s --> started \n", __func__);
>>>>>         rt_mutex_acquire(&mutex, TM_INFINITE);
>>>>>         err = rt_cond_wait(&cond, &mutex, TM_INFINITE);
>>>>>         rt_mutex_release(&mutex);
>>>>>         if (err) {
>>>>>                 printf("rt_cond_wait failed, err = %d", err);
>>>>>                 return;
>>>>>         }
>>>>>         printf("%s --> cond wait done\n", __func__);
>>>>> }
>>>>>
>>>>> int main(int argc, char **argv)
>>>>> {
>>>>>         int err;
>>>>>         RT_TASK task1;
>>>>>
>>>>>         mlockall(MCL_CURRENT | MCL_FUTURE);
>>>>
>>>>         The line above is redundant with libcobalt inits. But you need:
>>>>
>>>>           err = rt_task_shadow(NULL, "main", <prio>, 0);
>>>>           ...
>>>
>>> OK thank you so much for this. I will try it.
>>> And, yes I am debugging this issue.
>>> I found that rt_cond_wait_timed, did not return from here:
>>
>> Ok, thanks for looking at this. The issue is that the app is missing the
>> call to rt_task_shadow() in the main thread. So that thread receives
>> -EPERM from rt_mutex_acquire(), and the rest is a fallout of that
>> original error.
>>
>
> Ok, we tried adding rt_task_shadow(NULL, "main", 99, 0), just before
> rt_task_create(),
> but it did not help.
> Still the tasks hangs under rt_cond_wait().
> So, we need to debug further.
>

OK. Good news :)
I changed as below and it worked.
rt_task_shadow(NULL, "main", 98, 0)

So, basically, I lowered the priority of main task and the cond_task
exited normally this time.
This indicates that cond_task should run first, then the main task.

But, now the question is:
when do we need rt_task_shadow() and why it is important only for this case?
We havent added this in any of our previous tests.
Is there any side effects of adding this in actual code ?


>
> Thanks,
> Pintu
>
>
>> --
>> Philippe.

