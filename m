Message-ID: <528A446C.5060409@siemens.com>
Date: Mon, 18 Nov 2013 17:46:36 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1ViO8p-0004L8-4y@sd-51317.dedibox.fr>
 <528A156C.1070501@xenomai.org> <528A21A9.9050502@siemens.com>
 <528A2486.4030606@xenomai.org> <528A2567.2000105@siemens.com>
 <528A27AF.3060608@xenomai.org> <528A2BB3.9040902@siemens.com>
 <528A2F96.7080302@xenomai.org> <528A3918.4000902@siemens.com>
 <528A3CEB.80909@xenomai.org>
In-Reply-To: <528A3CEB.80909@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : switchtest: Account for
 invalid last_switch.from field
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2013-11-18 17:14, Gilles Chanteperdrix wrote:
> On 11/18/2013 04:58 PM, Jan Kiszka wrote:
>> On 2013-11-18 16:17, Gilles Chanteperdrix wrote:
>>> On 11/18/2013 04:01 PM, Jan Kiszka wrote:
>>>> On 2013-11-18 15:43, Gilles Chanteperdrix wrote:
>>>>> On 11/18/2013 03:34 PM, Jan Kiszka wrote:
>>>>>> On 2013-11-18 15:30, Gilles Chanteperdrix wrote:
>>>>>>> On 11/18/2013 03:18 PM, Jan Kiszka wrote:
>>>>>>>> On 2013-11-18 14:26, Gilles Chanteperdrix wrote:
>>>>>>>>> On 11/18/2013 01:41 PM, git repository hosting wrote:
>>>>>>>>>> Module: xenomai-jki
>>>>>>>>>> Branch: for-forge
>>>>>>>>>> Commit: 3e6d8ff9a99262e78655329dc043aacc607eb158
>>>>>>>>>> URL:
>>>>>>>>>> http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=3e6d8ff9a99262e78655329dc043aacc607eb158
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>> Date:   Mon Nov 18 13:19:34 2013 +0100
>>>>>>>>>>
>>>>>>>>>> switchtest: Account for invalid last_switch.from field
>>>>>>>>>>
>>>>>>>>>> If we close a test device early, no switch may have yet taken
>>>>>>>>>> place
>>>>>>>>>> when
>>>>>>>>>> the first call to rtswitch_to_rt/nrt happens. This can cause
>>>>>>>>>> to_idx to
>>>>>>>>>> become -1, and the system will crash. Handle this corner case
>>>>>>>>>> gracefully.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>>       kernel/drivers/testing/switchtest.c |   10 ++++++++--
>>>>>>>>>>       1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/kernel/drivers/testing/switchtest.c
>>>>>>>>>> b/kernel/drivers/testing/switchtest.c
>>>>>>>>>> index 6f77ee9..7d17c5f 100644
>>>>>>>>>> --- a/kernel/drivers/testing/switchtest.c
>>>>>>>>>> +++ b/kernel/drivers/testing/switchtest.c
>>>>>>>>>> @@ -147,8 +147,11 @@ static int rtswitch_to_rt(rtswitch_context_t
>>>>>>>>>> *ctx,
>>>>>>>>>>
>>>>>>>>>>           /* to == from is a special case which means
>>>>>>>>>>              "return to the previous task". */
>>>>>>>>>> -    if (to_idx == from_idx)
>>>>>>>>>> +    if (to_idx == from_idx) {
>>>>>>>>>>               to_idx = ctx->error.last_switch.from;
>>>>>>>>>> +        if (to_idx == -1)
>>>>>>>>>> +            return -EINVAL;
>>>>>>>>>> +    }
>>>>>>>>>
>>>>>>>>> I do not see how we can reach rtswitch_to_rt without having
>>>>>>>>> switched
>>>>>>>>> context, since the first task to run is not an rt task.
>>>>>>>>
>>>>>>>> Counter question: What should enforce this ordering? And via which
>>>>>>>> call
>>>>>>>> stack should last_switch.from be first updated?
>>>>>>>>
>>>>>>>> I suspect that the RT tasks overtake the non-RT one here, but -
>>>>>>>> granted
>>>>>>>> - I didn't understand the control flow and synchronization of this
>>>>>>>> driver yet.
>>>>>>>
>>>>>>> At any time, there is at most one task running on each cpu. This
>>>>>>> task
>>>>>>> then switches to every other task, in turn. The first task to run
>>>>>>> is the
>>>>>>> "sleeper" task, which calls nanosleep in order to avoid the system
>>>>>>> to be
>>>>>>> completely paralized.
>>>>>>>
>>>>>>> For instance, with 3 tasks you would get:
>>>>>>> 1(sleeper)
>>>>>>> 2
>>>>>>> 3
>>>>>>> 1(sleeper)
>>>>>>> 3
>>>>>>> 2
>>>>>>> 1(sleeper)
>>>>>>> 2
>>>>>>> 3
>>>>>>>
>>>>>>> etc...
>>>>>>
>>>>>> Ah, maybe this is the real bug:
>>>>>>
>>>>>> diff --git a/kernel/drivers/testing/switchtest.c
>>>>>> b/kernel/drivers/testing/switchtest.c
>>>>>> index 7d17c5f..b5080a6 100644
>>>>>> --- a/kernel/drivers/testing/switchtest.c
>>>>>> +++ b/kernel/drivers/testing/switchtest.c
>>>>>> @@ -404,7 +404,8 @@ static void rtswitch_ktask(void *cookie)
>>>>>>
>>>>>>         to = task->base.index;
>>>>>>
>>>>>> -    rtswitch_pend_rt(ctx, task->base.index);
>>>>>> +    if (rtswitch_pend_rt(ctx, task->base.index) != 0)
>>>>>> +        return;
>>>>>>
>>>>>>         for(;;) {
>>>>>>             if (task->base.flags & RTTST_SWTEST_USE_FPU)
>>>>>>
>>>>>> Still need to validate, will let you know.
>>>>>
>>>>> I do not think that it is the right fix either: we should not have an
>>>>> error in a ktask, because they are destroyed before anything else is
>>>>> destroyed.
>>>>
>>>> Not an error, a destroyed rtdm event, thus return code < 0. This didn't
>>>> matter so far as we kill the kernel task where it was blocked. Now it
>>>> has to properly leave its main function.
>>>
>>> The rtdm event is destroyed after the ktask. So, normally, this should
>>> not happen.
>>
>> True. OK, but rtdm_task_destroy calls xnthread_cancel, and that should
>> kick us out of rtdm_event_wait with -EINTR - to my understanding.
>>
>> In any case, the patch didn't help. Trying to get some traces now for a
>> better picture.
> 
> Have you tried to check rtdm_task_join return value and print a message
> if it returns an error? I believe for the task to be still running after
> it was expected to terminate, rtdm_task_join would have to fail, at least.

rtdm_task_join returns void. Also, rtdm_task_destroy already joins in
order to maintain the original synchronous behavior.

I'm breaking a trace now when idx is -1 or rtswitch_pend_rt returns
non-zero, slowly trying to dig deeper.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

