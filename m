MIME-Version: 1.0
Date: Wed, 23 Jan 2013 17:40:01 +0100
Message-ID: <CANzShzdBHfYGQEzpvnHGhbuwb1KNcdFT-7M8LOV=VoyGa+MZ9Q@mail.gmail.com>
From: Moustapha Bikienga <mbikienga@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Native_skin_Alarm_reprogramming
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi.

Writing a periodic alarm tested program, I noticed that after 10 shot, the
alarm wasn't reprogramming (or some thing else!).
Is there any reason for this ?

Best regards

Configuration :
xenomai : 2.6.0
Linux kernel : 2.6.38
---------------------
My program
#include <sys/mman.h>
#include <native/task.h>
#include <native/alarm.h>
#include <native/timer.h>

RT_ALARM alarm_desc;
RT_TASK server_desc;

void alarm_server(void *cookie){
int i;
i=0;
while(1){
rt_alarm_wait(&alarm_desc);
printf("SHOTED %d \n",i);
i++;
}
}
int main(int argc, char *argv[]){
int err;
mlockall(MCL_CURRENT|MCL_FUTURE);
err=rt_alarm_create(&alarm_desc,"MyAlarm");
err=rt_alarm_start(&alarm_desc,100000000,10000000);
err=rt_task_create(&server_desc,"myAlarmServer",0,5,0);
if(!err) rt_task_start(&server_desc,&alarm_server,NULL);
return 0;
}
-----------------------
