Message-ID: <4803BF62.7010905@domain.hid>
Date: Mon, 14 Apr 2008 22:32:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4802D528.5090404@domain.hid> <48031412.2000409@domain.hid>
	<48031545.6050106@domain.hid> <4803B821.6050101@domain.hid>
In-Reply-To: <4803B821.6050101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Suspended task resumed without rt_task_resume ?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai@xenomai.org

Tomas Kalibera wrote:
> 
> Hi Philippe,
> 
> does your patch fix also the situation when the task is suspended via
> T_SUSP flag from rt_task_shadow (and calls which start tasks, for that
> matter) ?
>

No, that is a different case; this patches only ensures that rt_task_suspend()
shall be automatically restarted upon signal receipt when called for the running
task.

> Then I've applied your patch to task.c in my kernel tree, recompiled the
> kernel, and my task is still getting resumed too early, returning 0.
> Even when I use rt_task_suspend. Could this be caused by something else ?
> 

No, it does happen due to the shadowed task receiving SIGALRM. If you don't want
this to happen, just block the signals before calling rt_task_shadow(). There is
no other way, we may not restart the shadow mapping request upon signal receipt
anyway.

> Thanks,
> Tomas
> 
> 
> 
> Philippe Gerum wrote:
>> Philippe Gerum wrote:
>>  
>>> Tomas Kalibera wrote:
>>>    
>>>> Hi,
>>>>
>>>> what can, besides an explicit call, resume a suspended task ? I
>>>> created and started a child task, then shadowed the current thread
>>>> with T_SUSP flag. The child was supposed to call rt_task_resume to
>>>> wake-up the parent and let it terminate the process, but, the parent
>>>> was resumed before this call. The call to rt_task_suspend in parent
>>>> returned 0. The program uses SIGALRM signal. Could this be the cause ?
>>>>
>>>>       
>>> Yes, but the syscall should be silently restarted by default. This
>>> patch should
>>> fix the issue:
>>>
>>>     
>>
>> This one will compile:
>>
>> --- ksrc/skins/native/task.c    (revision 3698)
>> +++ ksrc/skins/native/task.c    (working copy)
>> @@ -410,11 +410,17 @@
>>   * A nesting count is maintained so that rt_task_suspend() and
>>   * rt_task_resume() must be used in pairs.
>>   *
>> + * Receiving a Linux signal causes the suspended task to resume
>> + * immediately.
>> + *
>>   * @param task The descriptor address of the affected task. If @a task
>>   * is NULL, the current task is suspended.
>>   *
>>   * @return 0 is returned upon success. Otherwise:
>>   *
>> + * - -EINTR is returned if a Linux signal has been received by the
>> + * suspended task.
>> + *
>>   * - -EINVAL is returned if @a task is not a task descriptor.
>>   *
>>   * - -EPERM is returned if the addressed @a task is not allowed to sleep
>> @@ -463,9 +469,12 @@
>>          goto unlock_and_exit;
>>      }
>>
>> -    if (task->suspend_depth++ == 0)
>> +    if (task->suspend_depth++ == 0) {
>>          xnpod_suspend_thread(&task->thread_base, XNSUSP,
>>                       XN_INFINITE, XN_RELATIVE, NULL);
>> +        if (xnthread_test_info(&task->thread_base, XNBREAK))
>> +            err = -EINTR;
>> +    }
>>
>>        unlock_and_exit:
>>
>>
>>   
> 
> 


-- 
Philippe.

