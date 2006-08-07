Subject: Re: [Xenomai-help] Problems with rt_task_wait_period
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D74405.7000900@domain.hid>
References: <1903678222@domain.hid>  <44D74405.7000900@domain.hid>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 16:13:28 +0200
Message-Id: <1154960008.4322.8.camel@domain.hid>
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

On Mon, 2006-08-07 at 15:45 +0200, Jan Kiszka wrote:
> Steve Kreyer wrote:
> > Hi,
> > 
> > Iam new to xenomai. 
> > For warming up I try to run this little test program:
> > 
> > -----------------------------------------------------------------------
> > #include <native/task.h>
> > #include <stdio.h>
> > #include <sys/mman.h>
> > 
> > RT_TASK task1;
> > 
> > void rt_task1(void* user_data){
> >     int err = 0;
> >     printf("%d\n", rt_task_set_periodic(NULL, TM_NOW, 100));
> 
> You are running in one-shot mode, thus all time units are in
> *nanoseconds*. 100 ns cycles tend to pass quite quickly, thus the setup
> actually fails (but it doesn't report this - a corner case for
> considering this a bug).

The setup does not really fail, but the period is so short that the tick
occurs before the task has a chance to wait for the first release point
in the timeline, so rt_task_wait_period() notices that no timer is
outstanding, but incorrectly concludes that no timer was ever armed.

> 
> >     err = rt_task_wait_period(NULL);
> >     if(err){
> >         fprintf(stderr, "Cannot wait periodic: %d, %d\n", err, EWOULDBLOCK);
> > 
> >     }
> > }
> > 
> > int main(){
> >     char* task1_data = NULL;
> >     mlockall(MCL_CURRENT|MCL_FUTURE);
> >     rt_timer_set_mode(TM_ONESHOT);
> >     rt_task_spawn(&task1, "task1", 0, 99, 0, rt_task1, &task1_data);
> >     sleep(10);
> >     rt_task_delete(&task1);
> >     return 0;
> > }
> > -----------------------------------------------------------------------
> > 
> > But rt_task_wait_period gives me always the Error EWOULDBLOCK, which means that I did not set the task periodic
> > but which in fact I did... The call to rt_task_set_periodic is succesful.
> > Can anyone help me figure out why? If you need additional infos please let me know...
> > 
> > Thanks in advance!
> > 
> > Steve
> > 
> 
> Jan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



