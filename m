Message-ID: <517A9F2C.6060303@xenomai.org>
Date: Fri, 26 Apr 2013 17:37:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1366732845.34430.YahooMailNeo@web161405.mail.bf1.yahoo.com>
	<5176B0E3.3030009@xenomai.org>
	<1366738934.20080.YahooMailNeo@web161406.mail.bf1.yahoo.com>
	<517A53E7.2030304@xenomai.org>
	<1366989234.58956.YahooMailNeo@web161403.mail.bf1.yahoo.com>
In-Reply-To: <1366989234.58956.YahooMailNeo@web161403.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_wait_period returns -11 (-EAGAIN)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/26/2013 05:13 PM, Tom Z wrote:
> After a code review, I think I now know what is going on there. My
> program contains two parts, a user-space rt_task, and a kernel-space
> task. While the user-space task is waiting for its next release point
> (rt_task_wait_period), the kernel task calls rt_task_suspend and
> rt_task_resume to suspend and resume that user-space task occasionally,
> which should not be done.  I don't know whether rt_task_suspend or
> rt_task_resume causes the user-space rt_task_wait_period() to return
> prematurely, but it seems that where the cause is. And after I fixed
> this bug, the problem was gone.
>

Makes sense. The delayed and (forcibly) suspended conditions are 
cumulative in the Xenomai scheduler, and the per-thread periodic timer 
keeps running and eventually fires in the background even when the 
thread is suspended (by a previous call to rt_task_suspend()).

Because these states are cumulative, calling rt_task_resume() does not 
cause any early shot for a delay timer though. The thread keeps on 
sleeping until the timer fires, or rt_task_unblock() is called upon it, 
whichever comes first.

> Thanks a lot!
>
>
> ------------------------------------------------------------------------
> *From:* Philippe Gerum <rpm@xenomai.org>
> *To:* Tom Z <tomz30@yahoo.com>
> *Cc:* "xenomai@xenomai.org" <xenomai@xenomai.org>
> *Sent:* Friday, 26 April 2013 5:16 AM
> *Subject:* Re: [Xenomai] rt_task_wait_period returns -11 (-EAGAIN)
>
> On 04/23/2013 07:42 PM, Tom Z wrote:
>  > Hi Philippe,
>  >
>  > Thanks for answering my previous question. However, I encountered
>  > another one regarding rt_task_wait_period(). NowI fixed a problematic
>  > parameter in rt_task_set_periodic(), and add the checking of the return
>  > values of rt_task_wait_period() and rt_task_set_periodic(). I use
>  > rt_task_set_periodic()to set a period of 500 ms for a rt_task, and call
>  > rt_task_wait_period() later. It seems that sometimes
>  > rt_task_wait_period()works good, but sometimes it just returns 0
>  > immediately. Here is what my code looks like:
>  >
>  > unsigned long overrun;
>  > RTIME release_time;
>  >
>  > if (0 != rt_task_set_periodic(NULL, TM_NOW, 500000000){
>  >                rt_printf("Error\n");
>  > }
>  > ....
>  > while (1){
>  > release_time = rt_timer_read();
>  > //Store release_time in an array for offline analysis
>  > //Some computation taking about 100 ms
>  > if (0 != rt_task_wait_period(&overrun)){
>  >              rt_printf("Error\n");
>  >        }
>  > }
>  >
>  >
>  > I noticed that, during the program's execution, no "Error" was printed,
>  > but some consecutive values of release_time is about 100 ms which is the
>  > computation time and far less than the period 500 ms.
>  >
>  > This problem seems weird to me. Did I possibly overlook something?
>  >
>
> What does "some consecutive values" mean in this report, what about the
> other values? Also, how do you observe this behavior, by looking at the
> pace of rt_printf's output?
>
> If so, I would suggest to log all release times and wait_period() return
> codes in an array, performing the sampling loop silently. Then check the
> array for spurious samples, i.e. error returns or weird intervals
> between samples.
>
> --
> Philippe.
>
>


-- 
Philippe.

