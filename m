Date: Tue, 22 Apr 2008 16:25:41 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
In-Reply-To: <480DECDA.3070204@domain.hid>
Message-ID: <Pine.LNX.4.64.0804221559300.31165@domain.hid>
References: <Pine.LNX.4.64.0804111759280.5433@domain.hid>
	<4800B4FA.1050309@domain.hid>
	<50879.62.235.129.158.1208014366.squirrel@domain.hid>
	<18432.56533.343662.272421@domain.hid>
	<Pine.LNX.4.64.0804171657380.18446@domain.hid>
	<2ff1a98a0804170830v3b2fc392lf320f05a8c7f4e8d@domain.hid>
	<2ff1a98a0804170846p2dddbea5k3b69dbbc57fb6761@domain.hid>
	<480775C4.2060302@domain.hid>
	<Pine.LNX.4.64.0804211731160.26198@domain.hid>
	<480DECDA.3070204@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] rt_task_sleep_until question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Tue, 22 Apr 2008, Philippe Gerum wrote:
> Klaas Gadeyne wrote:

[snipping lots of context]
>>>>>>  I noticed that xnpod_suspend_thread offers the possibility to
>>>>> suspend
>>>>>>  a thread "indefinitely" (until unblocked) via the (in the 2.4.x API,
>>>>>>  that is)
>>>>>>
>>>>>>  xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL)
>>>>>>
>>>>>>  call.
>>>>>>  However, since TM_INFINITE (and XN_INFINITE) are both defined as
>>>>> being
>>>>>>  zero, calls to rt_task_sleep(TM_INFINITE), are intercepted in the
>>>>>>  implementation of rt_task_sleep [1].  So in the latter case (which I
>>>>>>  would naively---i.e. without looking at API docs--- read as
>>>>> "sleep for
>>>>>>  an infinite amount of time), rt_task_sleep() returns *immediately*.
>>>
>>> This behaviour is explicitly stated in the doc, though. So people
>>> should not be
>>> surprised.
>>
>> That why I added the stuff between the long dashes above :-)  However, if
>> there's even one thing even better than well documented API's, it's
>> well documented _and_ intuitive APIs.
>>
>>>>>>  Would it make sense to change the current behaviour of
>>>>>>  rt_task_sleep(TM_INFINITE) and call
>>>>>>  xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL)
>>>>>>  instead of returning 0?
>>>>>>
>>>>>>  One could either do that by
>>>>>>  - altering rt_task_sleep()'s behaviour (not returning zero if
>>>>> delay is
>>>>>> zero)
>>>>>>  - redefining TM_INFINITE
>>>
>>> No way. You don't want to change "magic" values that lightly. This is
>>> why they
>>> are magic in the first place.
>>
>> I know none of them were ideal solutions.  However (AFAIS, that is), *
>> from a user point of view, I would find it convenient to be able to
>>   sleep indefinitely until somebody wakes me up using rt_task_unblock(),
>>   and this is currently not possible.
>> * the nucleus _does_ offer this functionality via the
>>   xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL)
>>   call, but I cannot access that functionality in the native skin.
>>
>> So I was wondering if nothing (else) could be done to solve that
>> problem, the concrete use case being a thread which is woken up every
>> time a job has to be done, but which can safely sleep "forever" (until
>> unblocked) if nothing has to be done.
>>
>
> What's wrong with rt_task_suspend() ?

The current loop code is something like

void timerloop_task_proc(void *arg)
{
         int ret;
         int errors = 0;
         do{
                 do{
                         last_occured_alarm = last_alarm_set;
                         EnterMutex();
                         TimeDispatch();
                         LeaveMutex();
                 }while ((ret = rt_task_sleep_until(last_alarm)) == 0);
                 if (ret == -ETIMEDOUT){
                   printf("[TIMERLOOP] Total errors = %d, return code = %d\n",++errors,ret);
                 }
         }while (!(stop_timer && ret == -EINTR));
         printf("End of TimerLoop, code %d, Total errors = %d\n",ret,errors);
}

I could modify that code and put something like
if (last_alarm == TIMEVAL_MAX) // Nothing else to do, sleep forever
   rt_task_suspend()
else
   rt_task_sleep_until(last_alarm)

However, the one who wants to wake up this thread (e.g. for asking
this thread to stop) doesn't know in what state the timerthread is.
It seems clumsy to me if that the one who wants to wake up the thread
has to try _unblock() first, and the _resume()?

thx,

Klaas

ps.  Note that the original problem I sketched in this thread was due
to an overflow situation, and that this suggestion to allow to make a
thread *sleep* forever instead of suspending only tackles _my_
concrete problem, and doesn't solve the overflow issue.




