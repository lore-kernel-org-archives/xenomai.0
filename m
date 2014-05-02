Message-ID: <53638FC9.7050909@xenomai.org>
Date: Fri, 02 May 2014 14:30:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140502141307.B6A14EC0@centrum.cz>
In-Reply-To: <20140502141307.B6A14EC0@centrum.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] non-blocking rt_task_suspend(NULL)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: Xenomai <xenomai@xenomai.org>

Le 02/05/2014 14:13, Petr Cervenka a écrit :
>> Od: "Petr Cervenka" <grugh@centrum.cz>
>>
>> CC: "Xenomai" <xenomai@xenomai.org>
>>> Od: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>
>>> CC: "Xenomai" <xenomai@xenomai.org>
>>> On 04/24/2014 05:06 PM, Petr Cervenka wrote:
>>>>> Od: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>>
>>>>>> SIGDEBUG signal was not received. Task status from
>>>>>> rt_task_inquire() was 0x300180 or 0x300380 (depends where it is
>>>>>> placed) When the task is in the "wrong" state, also the call of
>>>>>> rt_task_sleep(100000) is returning permanently -EINTR code. Do
>>>>>> you have any other idea what to check or what can cause perhaps
>>>>>> every xenomai call fail with -EINTR in one task?
>>>>>
>>>>> If I had to debug this issue, I would enable the I-pipe tracer and
>>>>> trigger a trace freeze when the -EINTR code is received. With
>>>>> enough trace points, it should be possible to understand what
>>>>> happens.
>>>>>
>>>> I called a xntrace_user_freeze() immediately when the issue occurs,
>>>> but I simply don't understand what is happening there. The trace
>>>> output is in the attachment. Could you please help me to understand
>>>> it?
>>>>
>>>> I also got some minor problem with xntrace_user_freeze, because the
>>>> linker was not able to find it: asyncwriter.cpp:(.text+0x843):
>>>> undefined reference to `xntrace_user_freeze(unsigned long, int)' It
>>>> is defined in src/skins/common/trace.c and (should be) contained in
>>>> libxenomai.so. But I was not successful and I had to define it myself
>>>> (under different name). Version of xenomai is 2.6.3.
>>>
>>> We see that xnpod_suspend_thread returns immediately, likely because it 
>>> has the XNKICKED bit set. Could you add more back trace points? So that 
>>> we see what is setting the XNKICKED bit?
>>>
>>
>> I have added (maybe too much) back trace points. But as last time, I'm not able to see (almost) anything in it ;-)
>> Previous xnpod_suspend_thread (on line 3713, probably caused by rt_mutex_aquire) seems to be fine (for me;-) ).
>>
> 
> Could you please help me with analysis, what is happening in the trace log?
> I only see at the end only peaces of log, which are already contained somewhere before.
> For example lines 3832-3993 are the same as 2901-3062.
> Also 3697-3861 and 3065-3229.
> Also 3596-3692 and 2935-3058
> Also 3065-3550 and 2402-2887
> 
> There are also suspicious lines with "device_not_available" and "ipipe_handle_exception", but they seem to be regularly appearing.

I will probably not have time to have a look at it before the end of the
week-end. I had a quick glance and did not find what I expected. We will
have to add some calls to ipipe_trace_special to see get the values of
the task state or info flags in the trace.

-- 
Gilles.

