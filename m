Message-ID: <1ce16a2c0709131003t673986c5v417ddce15dd29de6@domain.hid>
Date: Thu, 13 Sep 2007 19:03:42 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] seperate native write task
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

Hi,

I've tried to write a native 'writefuction' which is seperated from main()

The output from my code are the value of counter, and string "hej"
both printed in the terminal. The ascii string should been printed to
serial device rtser0.

I don't understand why I got this behavior. Maybe because I'm tired..
but I assume most of what I've done should be correct.

The output looks like:
sandbox:/home/bkw/code/driver_v4# ./simpledriver_v4
hej
0
hej
1
hej
2
hej
3
hej
4
hej
5
etc..

And the source:
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <native/task.h>
#include <native/timer.h>
#include <rtdm/rtserial.h>
#define MAIN_PREFIX "main : "
#define WTASK_PREFIX "write_task: "
#define STATE_FILE_OPENED         1
#define STATE_TASK_CREATED        2
#define TASK_PRIO  10
#define TASK_MODE  0  /* No flags */
#define TASK_STKSZ 0  /* Stack size (use default one) */
#define WRITE_FILE  "rtser0"
int fd = -1;
RT_TASK task_desc;
RT_TASK write_task;
/*                           --s-ms-us-ns */
RTIME write_task_period_ns =    10000000llu;

static const struct rtser_config write_config = {
	.config_mask       = RTSER_SET_BAUD | RTSER_SET_TIMESTAMP_HISTORY,
	.baud_rate         = 115200,
	.timestamp_history = RTSER_DEF_TIMESTAMP_HISTORY,
};

void myWriteTask(void *arg){
	char* myString = "hej\n";
	int fd,err,counter;
	counter=0;
	RTIME write_time;
	ssize_t sz = sizeof(RTIME);
	ssize_t written = 0;
	//create rt device
	fd = rt_dev_open(WRITE_FILE, 0);
	if (fd < 0) {
		perror("open(WRITE_FILE)");
		exit(EXIT_FAILURE);
	}	
	
	//setup config
	err = rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &write_config);
	if (err) {
		printf(MAIN_PREFIX "error while RTSER_RTIOC_SET_CONFIG, %s\n",
strerror(-err));
	}
	rt_task_shadow(&write_task, NULL, 50, 0);
	err = rt_task_set_periodic(NULL,
TM_NOW,rt_timer_ns2ticks(write_task_period_ns));
	if (err) {
	printf(WTASK_PREFIX "error on set periodic, %s\n", strerror(-err));
		}
while(counter<100){
	err=write(fd, myString, strlen(myString));
	if (err < 0) {
		perror("write(WRITE_FILE)");
		exit(EXIT_FAILURE);
	}
	printf("%d\n",counter);
	counter++;	
	usleep(150000);
	}
}
		

int main(int argc){
	int err;
	/* no memory-swapping for this programm */
	mlockall(MCL_CURRENT | MCL_FUTURE);

	//create write task
	err = rt_task_create(&write_task, "write_task", 0, 50, 0);
	if (err) {
		printf(MAIN_PREFIX "failed to create write_task, %s\n",
		strerror(-err));
	}
	//start rt task
	err = rt_task_start(&write_task, &myWriteTask, NULL);	
	if (err) {
		printf(MAIN_PREFIX "failed to start write_task, %s\n",
		strerror(-err));
		}
	pause();
	rt_task_delete(&write_task);
}

