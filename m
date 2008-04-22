Message-ID: <480E5107.1060906@domain.hid>
Date: Tue, 22 Apr 2008 22:56:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
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
	<Pine.LNX.4.64.0804221559300.31165@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0804221559300.31165@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_task_sleep_until question
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
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Klaas Gadeyne wrote:
> On Tue, 22 Apr 2008, Philippe Gerum wrote:
>> Klaas Gadeyne wrote:
> 
> [snipping lots of context]
>>>>>>>  I noticed that xnpod_suspend_thread offers the possibility to
>>>>>> suspend
>>>>>>>  a thread "indefinitely" (until unblocked) via the (in the 2.4.x
>>>>>>> API,
>>>>>>>  that is)
>>>>>>>
>>>>>>>  xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL)
>>>>>>>
>>>>>>>  call.
>>>>>>>  However, since TM_INFINITE (and XN_INFINITE) are both defined as
>>>>>> being
>>>>>>>  zero, calls to rt_task_sleep(TM_INFINITE), are intercepted in the
>>>>>>>  implementation of rt_task_sleep [1].  So in the latter case
>>>>>>> (which I
>>>>>>>  would naively---i.e. without looking at API docs--- read as
>>>>>> "sleep for
>>>>>>>  an infinite amount of time), rt_task_sleep() returns *immediately*.
>>>>
>>>> This behaviour is explicitly stated in the doc, though. So people
>>>> should not be
>>>> surprised.
>>>
>>> That why I added the stuff between the long dashes above :-) 
>>> However, if
>>> there's even one thing even better than well documented API's, it's
>>> well documented _and_ intuitive APIs.
>>>
>>>>>>>  Would it make sense to change the current behaviour of
>>>>>>>  rt_task_sleep(TM_INFINITE) and call
>>>>>>>  xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL)
>>>>>>>  instead of returning 0?
>>>>>>>
>>>>>>>  One could either do that by
>>>>>>>  - altering rt_task_sleep()'s behaviour (not returning zero if
>>>>>> delay is
>>>>>>> zero)
>>>>>>>  - redefining TM_INFINITE
>>>>
>>>> No way. You don't want to change "magic" values that lightly. This is
>>>> why they
>>>> are magic in the first place.
>>>
>>> I know none of them were ideal solutions.  However (AFAIS, that is), *
>>> from a user point of view, I would find it convenient to be able to
>>>   sleep indefinitely until somebody wakes me up using rt_task_unblock(),
>>>   and this is currently not possible.
>>> * the nucleus _does_ offer this functionality via the
>>>   xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL)
>>>   call, but I cannot access that functionality in the native skin.
>>>
>>> So I was wondering if nothing (else) could be done to solve that
>>> problem, the concrete use case being a thread which is woken up every
>>> time a job has to be done, but which can safely sleep "forever" (until
>>> unblocked) if nothing has to be done.
>>>
>>
>> What's wrong with rt_task_suspend() ?
> 
> The current loop code is something like
> 
> void timerloop_task_proc(void *arg)
> {
>         int ret;
>         int errors = 0;
>         do{
>                 do{
>                         last_occured_alarm = last_alarm_set;
>                         EnterMutex();
>                         TimeDispatch();
>                         LeaveMutex();
>                 }while ((ret = rt_task_sleep_until(last_alarm)) == 0);
>                 if (ret == -ETIMEDOUT){
>                   printf("[TIMERLOOP] Total errors = %d, return code =
> %d\n",++errors,ret);
>                 }
>         }while (!(stop_timer && ret == -EINTR));
>         printf("End of TimerLoop, code %d, Total errors =
> %d\n",ret,errors);
> }
> 
> I could modify that code and put something like
> if (last_alarm == TIMEVAL_MAX) // Nothing else to do, sleep forever
>   rt_task_suspend()
> else
>   rt_task_sleep_until(last_alarm)
> 
> However, the one who wants to wake up this thread (e.g. for asking
> this thread to stop) doesn't know in what state the timerthread is.
> It seems clumsy to me if that the one who wants to wake up the thread
> has to try _unblock() first, and the _resume()?
> 

There has been a fair amount of misunderstanding. Past mails were apparently
aiming at rt_task_sleep's behaviour (e.g. returning 0 on NULL delay etc.), but
you actually care for rt_task_sleep_until, which is a totally different story
(the subject line was right though).

Handling the special TM_INFINITE value as a valid timeout value for
rt_task_sleep_until would not introduce the flaws I was concerned about
regarding rt_task_sleep. We would just change the behaviour when receiving what
used to be an utterly bugous date spec in the current implementation, and make
it valid, which is ok -- i.e. I'm not particularly concerned by maintaining
backward compatible behaviours when receiving utterly insane data specs like "0"
for an absolute date.

If your loop was truly periodic, you could probably use rt_task_wait_period(),
but I suspect last_alarm may not try to enforce a strictly periodic timeline, right?

The fact that we don't have any other blocking calls with absolute date specs is
bothering me actually, and 2.5 will probably see some extensions like
rt_sem_p_until(), in order to address patterns of this kind.

But well, back to rt_task_sleep_until, I see no reason not to handle the corner
case you described a bit more gracefully. So let's try the Klaas Amendment to
the native API. Does the following work for you?

--- ksrc/skins/native/task.c	(revision 3713)
+++ ksrc/skins/native/task.c	(working copy)
@@ -958,8 +958,10 @@
  * reached.
  *
  * @param date The absolute date in clock ticks to wait before
- * resuming the task (see note). Passing an already elapsed date
- * causes the task to return immediately with no delay.
+ * resuming the task (see note). As a special case, TM_INFINITE is an
+ * acceptable value that makes the caller block indefinitely, until
+ * rt_task_unblock() is called against it. Otherwise, any wake up date
+ * in the past causes the task to return immediately with no delay.
  *
  * @return 0 is returned upon success. Otherwise:
  *
@@ -968,7 +970,8 @@
  *
  * - -ETIMEDOUT is returned if @a date has already elapsed.
  *
- * - -EWOULDBLOCK is returned if the system timer is inactive.
+ * - -EWOULDBLOCK is returned if the system timer is inactive, and
+ *    @date is valid but different from TM_INFINITE.
  *
  * - -EPERM is returned if this service was called from a context
  * which cannot sleep (e.g. interrupt, non-realtime or scheduler
@@ -990,8 +993,8 @@

 int rt_task_sleep_until(RTIME date)
 {
+	int err = 0, mode = XN_REALTIME;
 	xnthread_t *self;
-	int err = 0;
 	spl_t s;

 	if (xnpod_unblockable_p())
@@ -999,22 +1002,30 @@

 	self = xnpod_current_thread();

-	if (!xnthread_timed_p(self))
-		return -EWOULDBLOCK;
-
 	xnlock_get_irqsave(&nklock, s);

-	/* Calling the suspension service on behalf of the current task
-	   implicitely calls the rescheduling procedure. */
+	if (date == TM_INFINITE)
+		/* i.e. will resume only upon rt_task_unblock(). */
+		mode = XN_RELATIVE;
+	else if (date <= xntbase_get_time(__native_tbase)) {
+		err = -ETIMEDOUT;
+		goto unlock_and_exit;
+	} else if (!xnthread_timed_p(self)) {
+		err = -EWOULDBLOCK;
+		goto unlock_and_exit;
+	}

-	if (date > xntbase_get_time(__native_tbase)) {
-		xnpod_suspend_thread(self, XNDELAY, date, XN_REALTIME, NULL);
+	/*
+	 * Calling the suspension service on behalf of the current
+	 * task implicitely calls the rescheduling procedure.
+	 */
+	xnpod_suspend_thread(self, XNDELAY, date, mode, NULL);

-		if (xnthread_test_info(self, XNBREAK))
-			err = -EINTR;
-	} else
-		err = -ETIMEDOUT;
+	if (xnthread_test_info(self, XNBREAK))
+		err = -EINTR;

+ unlock_and_exit:
+
 	xnlock_put_irqrestore(&nklock, s);

 	return err;

-- 
Philippe.

