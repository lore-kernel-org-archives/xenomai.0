Date: Fri, 30 Nov 2007 11:52:48 +0100
Message-Id: <1829866571@domain.hid>
MIME-Version: 1.0
From: Andreas Vogt <A_C_V@web.de>
Content-Type: multipart/mixed;
 boundary="=-------------11964199698687424589"
Subject: [Xenomai-help] error while rt_task_wait_period, code -110
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

--=-------------11964199698687424589
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hallo,

I get an error in a simple program with a period time of 1 ms.My latency test program works with a period of 100us.The worst latenz time is about 23us
Any suggestions?

Andreas
_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066


--=-------------11964199698687424589
Content-Type: text/x-csrc;
 name="speaker.c"
Content-Disposition: attachment;
 filename="speaker.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/io.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/queue.h>
#include <native/intr.h>
#include <native/sem.h>


#define STACK_SIZE 0
#define PRIO_TIMER 3


RT_TASK test_task;

int int_count = 0;
int end = 0;

//                     --s-ms-us-ns
RTIME task_period_ns =    001000000llu;

void test_task_fct(){
	
	int count = 0;
	int ret;
	int err =0;
	unsigned long overrun;
	unsigned char sound_byte;
  	unsigned char toggle = 0;


	ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_ns));
	if (ret) {
		printf("error while set periodic, code %d\n",ret);
		return;
	}

	while(!end){

		ret = rt_task_set_mode(0, T_PRIMARY, NULL);
		if (ret) {
					
		printf("error while rt_task_set_mode, code %d\n",ret);
			return;
		}

		ret = rt_task_wait_period(&overrun);
		if (ret) {
			switch (ret) {
				case -EWOULDBLOCK:  printf("1\n");
					      break;
				case -EINTR: printf("2\n");
					      break;
				case -ETIMEDOUT: printf("3\n");
					      break;
				case -EPERM: printf("4\n");
					      break;
			}	
			printf("error while rt_task_wait_period, code %d\n",ret);
			return;
		}

		unsigned char bell = 7;
		printf("%c",bell);


		fflush(NULL);
	}
}


// signal-handler, to ensure clean exit on Ctrl-C
void clean_exit(int dummy) {
	printf("[MAIN] try clean exit\n");
	end = 1;
  	rt_task_delete(&test_task);
	printf("[MAIN] bye bye\n");

}


int main(int argc, char *argv[]) {

	int err, ret = 0;
	printf("[MAIN] start system\n");


	// install signal handler
	signal(SIGTERM, clean_exit);	
	signal(SIGINT, clean_exit);	
	mlockall(MCL_CURRENT | MCL_FUTURE);


	err = rt_task_spawn(&test_task, "Timer", STACK_SIZE, PRIO_TIMER, 0, &test_task_fct, NULL);
	if (err) {
		printf("error rt_task_spawn\n");
		return 0;
	}
	printf("[MAIN] test_task created\n");
	

printf("[MAIN] \n");
	pause();
	fflush(NULL);
	return 0;


}




































--=-------------11964199698687424589--

