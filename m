Date: Wed, 6 Dec 2006 07:04:07 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
In-Reply-To: <45463851.3030202@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-984976661-1165417447=:36703"
Content-Transfer-Encoding: 8bit
Message-ID: <995989.36703.qm@domain.hid>
Subject: [Xenomai-help] problem persists with rt_queue
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

--0-984976661-1165417447=:36703
Content-Type: multipart/alternative; boundary="0-1422083311-1165417447=:36703"

--0-1422083311-1165417447=:36703
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hi 
I had a problem of rt_queue overflow in xenomai 2.1.Then installed xenomai 2.2.5 but previous poblem with rt_queue is still there.I repeat the problem that when there is no listener on the queue the sender the sender displays the error message 

rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_send(queue_input) failed sent bytes: 0
rt_queue_alloc(queue_inout, 8) failed


 and then stops and if i try to start my program again following message 

start
rt_queue_alloc(queue_inout, 8) failed
Segmentation fault

is displayed and program doesnot work at all.I would be very thankful for the correcting me what wrong am i doing.the code for the sender is attached.


Jan Kiszka <jan.kiszka@domain.hid> wrote: mani bhatti wrote:
> Thanks Jan .
> I have executed # patch -p0 < native-queue-bcast-fix.patch in directory where xenomai is installed and in my case it is  /usr/xenomai directory but sender still goes out of memory  if no  listener  is  waiting on the queue and displays the message
> 
> rt_queue_alloc(queue_inout, 8) failed
> 
> After this message is displayed and i try to execute sender again then sender doesnot execute at all and simply displays above message so i need to restart my computer if i want to eecute sender again .Should i execute patch in some other directory or  is it some other problem?

Nope. Executing your original test case after applying my patch (AND
rebuilding Xenomai - did you check if the kernel you run got updated?)
clearly demonstrated on my box that the problem was fixed.

I would suggest to do a clean rebuild from latest SVN.

Jan



 
---------------------------------
Any questions?  Get answers on any topic at Yahoo! Answers. Try it now.
--0-1422083311-1165417447=:36703
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br>Hi <br>I had a problem of rt_queue overflow in xenomai 2.1.Then installed xenomai 2.2.5 but previous poblem with rt_queue is still there.I repeat the problem that when there is no listener on the queue the sender the sender displays the error message <br><br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_send(queue_input) failed sent bytes: 0<br>rt_queue_alloc(queue_inout, 8) failed<br><br><br>&nbsp;and then stops and if i try to start my program again following message <br><br>start<br>rt_queue_alloc(queue_inout, 8) failed<br>Segmentation fault<br><br>is displayed and program doesnot work at all.I would be very thankful for the correcting me what wrong am i doing.the code for the sender is attached.<br><br><br><b><i>Jan Kiszka &lt;jan.kiszka@domain.hid&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> mani bhatti wrote:<br>&gt;
 Thanks Jan .<br>&gt; I have executed # patch -p0 &lt; native-queue-bcast-fix.patch in directory where xenomai is installed and in my case it is  /usr/xenomai directory but sender still goes out of memory  if no  listener  is  waiting on the queue and displays the message<br>&gt; <br>&gt; rt_queue_alloc(queue_inout, 8) failed<br>&gt; <br>&gt; After this message is displayed and i try to execute sender again then sender doesnot execute at all and simply displays above message so i need to restart my computer if i want to eecute sender again .Should i execute patch in some other directory or  is it some other problem?<br><br>Nope. Executing your original test case after applying my patch (AND<br>rebuilding Xenomai - did you check if the kernel you run got updated?)<br>clearly demonstrated on my box that the problem was fixed.<br><br>I would suggest to do a clean rebuild from latest SVN.<br><br>Jan<br><br></blockquote><br><p>&#32;

<hr size=1>Any questions?  Get answers on any topic at <a href="http://answers.yahoo.com/;_ylc=X3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZQRzbGsDbWFpbF90YWcx">Yahoo! Answers</a>. Try it now.
--0-1422083311-1165417447=:36703--

--0-984976661-1165417447=:36703
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

int missedpackets=0;

RT_QUEUE queue_input;


//                      --s-ms-us-ns
RTIME task_period_ns1 =   10000000llu;
RTIME task_period_ns2 =  10000000000llu;

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
            
               rt_task_wait_period(NULL);


		void *msg = rt_queue_alloc(&queue_input, sizeof(TInputData));
		if(msg == NULL) {
			printf("rt_queue_alloc(queue_inout, %d) failed\n", sizeof(TInputData));
			
                     }
		memcpy(msg, &sendData, sizeof(TInputData));
		int bytesSent = rt_queue_send(&queue_input, msg,sizeof(TInputData), Q_BROADCAST);
		
                  if (bytesSent <= 0) {
		  	
                    printf("rt_queue_send(queue_input) failed sent bytes: %d\n", bytesSent);
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

	/* create zaehler1_task */
	err = rt_task_create(&zaehler1_task_ptr,"alpha",STACK_SIZE,STD_PRIO1,0);

	/* start zaehler1_task */
	err = rt_task_start(&zaehler1_task_ptr,&zaehler1_task,NULL);

	// wait for signal & return of signal handler
	pause();
	fflush(NULL);
	return 0;
}

--0-984976661-1165417447=:36703--

