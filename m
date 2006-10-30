Message-ID: <20061030170740.63056.qmail@domain.hid>
Date: Mon, 30 Oct 2006 09:07:40 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1949248512-1162228060=:61117"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] rt_queue fails to allocate
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, xenomai@xenomai.org

--0-1949248512-1162228060=:61117
Content-Type: multipart/alternative; boundary="0-1889830561-1162228060=:61117"

--0-1889830561-1162228060=:61117
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi
I am working with rt_queues.I have a producer which sends data to a conusmer through rt_queue.The problem is when there is no consumer listening to the queue or waiting on the queue the producer displays the following Error (down ) even i am freeing the rt_queue when there is no consumer waiting on queue.I have attached the code for sender.

rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_alloc(queue_inout, 8) failed
Segmentation fault



 
---------------------------------
We have the perfect Group for you. Check out the handy changes to Yahoo! Groups.
--0-1889830561-1162228060=:61117
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi<br>I am working with rt_queues.I have a producer which sends data to a conusmer through rt_queue.The problem is when there is no consumer listening to the queue or waiting on the queue the producer displays the following Error (down ) even i am freeing the rt_queue when there is no consumer waiting on queue.I have attached the code for sender.<br><br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes:
 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_alloc(queue_inout, 8) failed<br>Segmentation fault<br><br><br><p>&#32;

<hr size=1>We have the perfect Group for you. Check out the <a href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=41144/*http://groups.yahoo.com/local/newemail.html">handy changes to Yahoo! Groups.</a>

--0-1889830561-1162228060=:61117--

--0-1949248512-1162228060=:61117
Content-Type: text/x-csrc; name="queue_sender.c"
Content-Description: 3236561751-queue_sender.c
Content-Disposition: inline; filename="queue_sender.c"

#include <math.h>
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


#define STACK_SIZE 8192
#define STD_PRIO1 2
#define STD_PRIO2 1
#define QUEUE_INPUT_LEN		1024
#define USE_READ_WRITE
RT_TASK zaehler1_task_ptr;
RT_TASK zaehler2_task_ptr;
int count1 = 0;
int count2 = 0;
int i;
int end = 0;
typedef struct  {
	int counter;
	int data;
}TInputData;



RT_QUEUE queue_input;


//                      --s-ms-us-ns
RTIME task_period_ns1 =     10000000llu;
RTIME task_period_ns2 =     10000000llu;


void zaehler1_task(void *cookie){
        
  int ret;
  TInputData sendData;
   memset(&sendData, 0, sizeof(TInputData));



// ************************* Xenomai-Krempel ********************************************************************
        ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_ns1));
        if (ret) {
                printf("error while set periodic, code %d\n",ret);
                return;
        }
// ************************* Ende Xenomai-Krempel ****************************************************************


// ********************** Beginn des wiederholt ausgefuehrten Codes **********************************************
        while(!end){
            
               rt_task_wait_period();


		void *msg = rt_queue_alloc(&queue_input, sizeof(TInputData));
		if(msg == NULL) {
			printf("rt_queue_alloc(queue_inout, %d) failed\n", sizeof(TInputData));
			
                     }
		memcpy(msg, &sendData, sizeof(TInputData));
		int bytesSent = rt_queue_send(&queue_input, msg,sizeof(TInputData), Q_BROADCAST);
		if (bytesSent <= 0) {
			printf("rt_queue_send(queue_input) failed: %d\n", bytesSent);
			rt_queue_free(&queue_input, msg);
			
		}

		sendData.counter++;  







        }
// ********************** Ende des wiederholt ausgefuehrten Codes ***********************************************
}



       


// signal-handler, to ensure clean exit on Ctrl-C
void clean_exit(int dummy) {
	printf("cleanup\n");
	end = 1;
	rt_task_delete(&zaehler1_task_ptr);
	rt_task_delete(&zaehler2_task_ptr);
	printf("end\n");
}

int main(int argc, char *argv[]) {
	int err, ret;
	
       int res;
	res = mlockall(MCL_CURRENT | MCL_FUTURE);
	if (res < 0) {
		printf("mlockall failed: %d\n", res);
		
	}
        // INPUT_QUEUE
	res = rt_queue_create(&queue_input, "queue_input", sizeof(TInputData) * QUEUE_INPUT_LEN,
		QUEUE_INPUT_LEN, Q_FIFO | Q_SHARED);
	if (res == -EEXIST)  {
		res = rt_queue_bind(&queue_input, "queue_input", 1000);
		//rt_queue_clear(&queue_input);
	}
	if (res < 0) {
		printf("rt_queue_create(queue_input) failed: %d\n", res);
		
	}

	

 
       printf("start\n");
	// install signal handler
	signal(SIGTERM, clean_exit);	
	signal(SIGINT, clean_exit);	
	// start timer
	ret = rt_timer_start(TM_ONESHOT);
	switch (ret) {
		case 0:       printf("Mit dem Fahrrad nich inn ersten Wagen\n\n");
		              break;
		case -EBUSY:  printf("timer is running\n");
		              break;
		case -ENOSYS: printf("can't start timer\n");
		              return ret;
	}

	/* create zaehler1_task */
	err = rt_task_create(&zaehler1_task_ptr,"alpha",STACK_SIZE,STD_PRIO1,0);
	
	/* start zaehler1_task */
	err = rt_task_start(&zaehler1_task_ptr,&zaehler1_task,NULL);

	

	// wait for signal & return of signal handler
	pause();
	fflush(NULL);
	return 0;
}

--0-1949248512-1162228060=:61117--

