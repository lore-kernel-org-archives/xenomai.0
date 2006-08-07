Subject: Re: [Xenomai-help] Problems with rt_task_wait_period
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D74B8E.5050309@domain.hid>
References: <1903678222@domain.hid>  <44D74405.7000900@domain.hid>
	<1154960008.4322.8.camel@domain.hid>  <44D74B8E.5050309@domain.hid>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 16:35:56 +0200
Message-Id: <1154961356.4322.16.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-08-07 at 16:17 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Mon, 2006-08-07 at 15:45 +0200, Jan Kiszka wrote:
> >> Steve Kreyer wrote:
> >>> Hi,
> >>>
> >>> Iam new to xenomai. 
> >>> For warming up I try to run this little test program:
> >>>
> >>> -----------------------------------------------------------------------
> >>> #include <native/task.h>
> >>> #include <stdio.h>
> >>> #include <sys/mman.h>
> >>>
> >>> RT_TASK task1;
> >>>
> >>> void rt_task1(void* user_data){
> >>>     int err = 0;
> >>>     printf("%d\n", rt_task_set_periodic(NULL, TM_NOW, 100));
> >> You are running in one-shot mode, thus all time units are in
> >> *nanoseconds*. 100 ns cycles tend to pass quite quickly, thus the setup
> >> actually fails (but it doesn't report this - a corner case for
> >> considering this a bug).
> > 
> > The setup does not really fail, but the period is so short that the tick
> > occurs before the task has a chance to wait for the first release point
> > in the timeline, so rt_task_wait_period() notices that no timer is
> > outstanding, but incorrectly concludes that no timer was ever armed.
> 
> Mmh, wouldn't the box simply lock up if the setup succeeded? It's a
> periodic timer... :->

No it would not, because of the first test in xnpod_wait_thread_period()
that checks if the timer is still enqueued, and because the application
properly tests the return value. Actually, using an additional flag to
state that a timer has indeed been started would be better than
recycling the enqueuing bit for the purpose of testing the timer
validity. An elapsed timer is still a valid one.

> 
> Jan
> 
-- 
Philippe.



