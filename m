Message-ID: <d6c8ef150804230553i4b9a5952pa78dcd543b1c1111@domain.hid>
Date: Wed, 23 Apr 2008 14:53:07 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <480F1F91.7040502@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0804111759280.5433@domain.hid>
	<2ff1a98a0804170830v3b2fc392lf320f05a8c7f4e8d@domain.hid>
	<2ff1a98a0804170846p2dddbea5k3b69dbbc57fb6761@domain.hid>
	<480775C4.2060302@domain.hid>
	<Pine.LNX.4.64.0804211731160.26198@domain.hid>
	<480DECDA.3070204@domain.hid>
	<Pine.LNX.4.64.0804221559300.31165@domain.hid>
	<480E5107.1060906@domain.hid>
	<Pine.LNX.4.64.0804231320210.28489@domain.hid>
	<480F1F91.7040502@domain.hid>
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
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Are there any differences (in performance point of view) between using
rt_task_sleep_until (TM_INFINITE) + rt_task_unblock() and
rt_task_suspend() + rt_task_resume() ? I'm writting some kind of task
manager and I'm using suspend + resume combination.

On Wed, Apr 23, 2008 at 1:37 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>
> Klaas Gadeyne wrote:
>  > On Tue, 22 Apr 2008, Philippe Gerum wrote:
>  >
>  > [snipping even more context]
>  >
>  >>>> What's wrong with rt_task_suspend() ?
>  >>>
>  >>> The current loop code is something like
>  >>>
>  >>> void timerloop_task_proc(void *arg)
>  >>> {
>  >>>         int ret;
>  >>>         int errors = 0;
>  >>>         do{
>  >>>                 do{
>  >>>                         last_occured_alarm = last_alarm_set;
>  >>>                         EnterMutex();
>  >>>                         TimeDispatch();
>  >>>                         LeaveMutex();
>  >>>                 }while ((ret = rt_task_sleep_until(last_alarm)) == 0);
>  >>>                 if (ret == -ETIMEDOUT){
>  >>>                   printf("[TIMERLOOP] Total errors = %d, return code =
>  >>> %d\n",++errors,ret);
>  >>>                 }
>  >>>         }while (!(stop_timer && ret == -EINTR));
>  >>>         printf("End of TimerLoop, code %d, Total errors =
>  >>> %d\n",ret,errors);
>  >>> }
>  >>>
>  >>> I could modify that code and put something like
>  >>> if (last_alarm == TIMEVAL_MAX) // Nothing else to do, sleep forever
>  >>>   rt_task_suspend()
>  >>> else
>  >>>   rt_task_sleep_until(last_alarm)
>  >>>
>  >>> However, the one who wants to wake up this thread (e.g. for asking
>  >>> this thread to stop) doesn't know in what state the timerthread is.
>  >>> It seems clumsy to me if that the one who wants to wake up the thread
>  >>> has to try _unblock() first, and the _resume()?
>  >>>
>  >>
>  >> There has been a fair amount of misunderstanding. Past mails were
>  >> apparently
>  >> aiming at rt_task_sleep's behaviour (e.g. returning 0 on NULL delay
>  >> etc.), but
>  >> you actually care for rt_task_sleep_until, which is a totally
>  >> different story
>  >> (the subject line was right though).
>  >
>  > Sorry about that, during the debugging I ended up playing around with
>  > rt_task_sleep() to check if the overflow issues did occur there too.
>  >
>  >> Handling the special TM_INFINITE value as a valid timeout value for
>  >> rt_task_sleep_until would not introduce the flaws I was concerned about
>  >> regarding rt_task_sleep. We would just change the behaviour when
>  >> receiving what
>  >> used to be an utterly bugous date spec in the current implementation,
>  >> and make
>  >> it valid, which is ok -- i.e. I'm not particularly concerned by
>  >> maintaining
>  >> backward compatible behaviours when receiving utterly insane data
>  >> specs like "0"
>  >> for an absolute date.
>  >>
>  >> If your loop was truly periodic, you could probably use
>  >> rt_task_wait_period(),
>  >> but I suspect last_alarm may not try to enforce a strictly periodic
>  >> timeline, right?
>  >>
>  >> The fact that we don't have any other blocking calls with absolute
>  >> date specs is
>  >> bothering me actually, and 2.5 will probably see some extensions like
>  >> rt_sem_p_until(), in order to address patterns of this kind.
>  >>
>  >> But well, back to rt_task_sleep_until, I see no reason not to handle
>  >> the corner
>  >> case you described a bit more gracefully. So let's try the Klaas
>  >> Amendment to
>  >> the native API.
>  >
>  > I *really* like the way that sounds ;-)
>  >
>  >> Does the following work for you?
>  >
>  > [snipped patch]
>  >
>  > It does!  Tested on today's 2.4-branch on a 2.6.20.21-ipipe-1.12-03 kernel.
>  > Any chance this could still be merged in the 2.4 series?
>  >
>
>  Since this does not change the behaviour of documented and valid use cases, I
>  will merge that patch into 2.4.4.
>
>  > Thx for your patience!
>  >
>
>  You are welcome.
>
>  > Klaas
>  >
>  >
>
>
>  --
>  Philippe.
>
>
>
>  _______________________________________________
>  Xenomai-help mailing list
>  Xenomai-help@domain.hid
>  https://mail.gna.org/listinfo/xenomai-help
>

