Message-ID: <445C2D1700022E97@domain.hid> (added by
	postmaster@domain.hid)
From: "Prashanti Bedapudi" <pbedapudi@domain.hid>
Date: Sun, 7 May 2006 15:33:47 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C671EB.A5F025B0"
In-Reply-To: <mailman.271.1146850846.2786.xenomai@xenomai.org>
Subject: [Xenomai-help] help on alarms..
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C671EB.A5F025B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Attached is a piece of code using alarms, but I am seeing some unexpected
behavior.  Any help will be appreciated.

in function main() the program behaves two different ways depending on where
I have the last printf()

1. It works fine and terminates as expected if I have it like this
	while(!quit_now)
	   printf("quit_now = %d\n", quit_now);

2. It does not terminate if I have it this way. I know quit_now is set to 1,
since the last statement printed is 'quit_now is set to 1'.

	while(!quit_now);
	printf("quit_now = %d\n", quit_now);

thanks,
Shanti


------=_NextPart_000_0005_01C671EB.A5F025B0
Content-Type: text/plain;
	name="alarmtest.cpp"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="alarmtest.cpp"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <native/types.h>
#include <native/alarm.h>
#include <native/task.h>


#define ALARM_NAME  "dl_alarm2"
#define ALARM_TASK_NAME	"dl_alarm_task"
#define ALARM_TIME 500000
#define ALARM_INTERVAL 250000
#define ALARM_TASK_PRIO  20

RT_ALARM dl_alarm;
RT_TASK alarm_task;
bool quit_now =3D 0;


void catch_signal(int sig)
{
	rt_alarm_stop(&dl_alarm);
	rt_alarm_delete(&dl_alarm);
	rt_task_delete(&alarm_task);
	exit(0);
}



static void alarm_handler(void *cookie)
{
	int i =3D0;

	printf("Inside alarm handler\n ");
	for(i =3D 0; i<100; i++){
		rt_alarm_wait(&dl_alarm);
		printf("i =3D %d\n",i);
	}

	quit_now =3D 1;
	printf("quit_now is set to %d\n",quit_now);
	return;
=09
}

int main()
{
	int ret =3D 0;

	signal(SIGTERM, catch_signal);=0A=
    signal(SIGINT, catch_signal);

	ret =3D rt_alarm_create(&dl_alarm, ALARM_NAME) ;
	if (ret)
		printf("\ncannot create alarm %d\n", ret);
=09
	ret =3D  rt_task_spawn(&alarm_task, ALARM_TASK_NAME, 0, =
ALARM_TASK_PRIO, 0, &alarm_handler, NULL);
	if(ret)
		exit(0);

	rt_alarm_start(&dl_alarm, ALARM_TIME, ALARM_INTERVAL);
=09

	while(!quit_now);
		printf("quit_now =3D %d\n",quit_now);


	rt_alarm_stop(&dl_alarm);
	rt_alarm_delete(&dl_alarm);
	rt_task_delete(&alarm_task);

	return 0;
}

------=_NextPart_000_0005_01C671EB.A5F025B0--



