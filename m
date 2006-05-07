Message-ID: <445E740C.1010308@domain.hid>
Date: Mon, 08 May 2006 00:26:20 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] help on alarms..
References: <445C2D1700022E97@domain.hid> (added
	by	postmaster@domain.hid)
In-Reply-To: <445C2D1700022E97@domain.hid> (added
	by	postmaster@domain.hid)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Prashanti Bedapudi <pbedapudi@domain.hid>
Cc: xenomai@xenomai.org

Prashanti Bedapudi wrote:
> Attached is a piece of code using alarms, but I am seeing some unexpected
> behavior.  Any help will be appreciated.
> 

- bool quit_now = 0;
+ volatile bool quit_now = 0;

> in function main() the program behaves two different ways depending on where
> I have the last printf()
> 
> 1. It works fine and terminates as expected if I have it like this
> 	while(!quit_now)
> 	   printf("quit_now = %d\n", quit_now);
> 
> 2. It does not terminate if I have it this way. I know quit_now is set to 1,
> since the last statement printed is 'quit_now is set to 1'.
> 
> 	while(!quit_now);
> 	printf("quit_now = %d\n", quit_now);
> 
> thanks,
> Shanti
> 
> 
> 
> ------------------------------------------------------------------------
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <errno.h>
> #include <string.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <signal.h>
> #include <native/types.h>
> #include <native/alarm.h>
> #include <native/task.h>
> 
> 
> #define ALARM_NAME  "dl_alarm2"
> #define ALARM_TASK_NAME	"dl_alarm_task"
> #define ALARM_TIME 500000
> #define ALARM_INTERVAL 250000
> #define ALARM_TASK_PRIO  20
> 
> RT_ALARM dl_alarm;
> RT_TASK alarm_task;
> bool quit_now = 0;
> 
> 
> void catch_signal(int sig)
> {
> 	rt_alarm_stop(&dl_alarm);
> 	rt_alarm_delete(&dl_alarm);
> 	rt_task_delete(&alarm_task);
> 	exit(0);
> }
> 
> 
> 
> static void alarm_handler(void *cookie)
> {
> 	int i =0;
> 
> 	printf("Inside alarm handler\n ");
> 	for(i = 0; i<100; i++){
> 		rt_alarm_wait(&dl_alarm);
> 		printf("i = %d\n",i);
> 	}
> 
> 	quit_now = 1;
> 	printf("quit_now is set to %d\n",quit_now);
> 	return;
> 	
> }
> 
> int main()
> {
> 	int ret = 0;
> 
> 	signal(SIGTERM, catch_signal);
>     signal(SIGINT, catch_signal);
> 
> 	ret = rt_alarm_create(&dl_alarm, ALARM_NAME) ;
> 	if (ret)
> 		printf("\ncannot create alarm %d\n", ret);
> 	
> 	ret =  rt_task_spawn(&alarm_task, ALARM_TASK_NAME, 0, ALARM_TASK_PRIO, 0, &alarm_handler, NULL);
> 	if(ret)
> 		exit(0);
> 
> 	rt_alarm_start(&dl_alarm, ALARM_TIME, ALARM_INTERVAL);
> 	
> 
> 	while(!quit_now);
> 		printf("quit_now = %d\n",quit_now);
> 
> 
> 	rt_alarm_stop(&dl_alarm);
> 	rt_alarm_delete(&dl_alarm);
> 	rt_task_delete(&alarm_task);
> 
> 	return 0;
> }
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

