Message-ID: <20061025143438.30247.qmail@domain.hid>
Date: Wed, 25 Oct 2006 07:34:38 -0700 (PDT)
From: mani bhatti <imranbashirbhatti@domain.hid>
Subject: Re: [Xenomai-help] Problem with rt_queue
In-Reply-To: <1161014295.5131.13.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2101647737-1161786878=:27211"
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

--0-2101647737-1161786878=:27211
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi Phillipe and Jan 
Thanks a lot for your help.I am sending the compilable
source code so that you have an idea what wrong am i
doing.I am sending the listeners which are listening
to the same queue at the same time.But i dont know why
at one time only one listener receives data from
sender queue inspite of that i am using broadcast
mode.Thanks a lot.I have attached files for sender and
listener.

--- Philippe Gerum <rpm@xenomai.org> wrote:

> On Mon, 2006-10-16 at 08:39 -0700, mani bhatti
> wrote:
> > Hi all
> > I am trying to broadcast a message to a queue 
> from a producer by
> > using function 
> > 
> > rt_queue_send(&queue_input,
> msg,sizeof(TInputData), Q_BROADCAST);
> > 
> > I have two consumers waiting for the data from
> producer but the
> > problem is producer is not broadcasting actually
> to all consumers and
> > at one time if i run both consumers than only one
> of the consumer
> > receives the data from producer the other consumer
> receives nothing
> > and remains blank (the consumer which receives
> data from queue  is not
> > fixed it is arbitrary).If some one has encountered
> the problem before
> > please advice me in this regard-Thanks all.The
> producer code is given
> > below
> 
> Excerpt from the documentation:
> 
>  * - Q_BROADCAST causes the message to be sent to
> all tasks currently
>  * waiting for messages. [...]
> 
> Are both consumers actually aslept on the queue,
> waiting for a message?
> If so, then please send a compilable testcase that
> reproduces the issue,
> with the consumer part, too.
>  
> > 
> >  while(!end){
> >                rt_task_wait_period();
> >                void *msg =
> rt_queue_alloc(&queue_input,
> > sizeof(TInputData));
> >                 if(msg == NULL) {
> >                        
> printf("rt_queue_alloc(queue_inout, %d) failed
> > \n",sizeof(TInputData));
> >                      }
> >                 memcpy(msg, &sendData,
> sizeof(TInputData));
> >                 int bytesSent =
> > rt_queue_send(&queue_input,msg,sizeof(TInputData),
> Q_BROADCAST);
> >                 if (bytesSent <= 0) {
> >                        
> printf("rt_queue_send(queue_input) failed: %d
> > \n", bytesSent);
> >                        
> rt_queue_free(&queue_input, msg);
> >                 }
> >                 sendData.counter++;
> >         }
> > 
> > 
> > 
> > 
> > 
> >
>
______________________________________________________________________
> > Do you Yahoo!?
> > Get on board. You're invited to try the new Yahoo!
> Mail.
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> -- 
> Philippe.
> 
> 
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-2101647737-1161786878=:27211
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

--0-2101647737-1161786878=:27211
Content-Type: text/x-csrc; name="queuelistener1_task.c"
Content-Description: 2025157140-queuelistener1_task.c
Content-Disposition: inline; filename="queuelistener1_task.c"

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
RTIME task_period_ns1 =   1000000000llu;
RTIME task_period_ns2 =   1000000000llu;

void zaehler2_task(void *cookie){
	int ret;	
	long ii;
	long jj;
	double a;


        TInputData receiveData;
	receiveData.counter = -1;

// ************************* Xenomai-Krempel ********************************************************************
	ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_ns2));
	if (ret) {
		printf("error while set periodic, code %d\n",ret);
		return;
	}
// ************************* Ende Xenomai-Krempel ****************************************************************


// ********************** Beginn des wiederholt ausgefuehrten Codes **********************************************
	while(!end){
		
              int counter = receiveData.counter;
               
               void *msg;
		int bytesRead = rt_queue_recv(&queue_input, &msg, TM_INFINITE);
		if (bytesRead > 0) {
			memcpy(&receiveData, msg, sizeof(TInputData));
			rt_queue_free(&queue_input, msg);
		}
		if (bytesRead <=0) {
			printf("rt_queue_receive(queue_input) failed: %d\n", bytesRead);
			
		}

		else if (receiveData.counter != counter + 1) {
			printf("counter error: %d\t->\t%d\n", counter + 1, receiveData.counter);
		} else {
			printf("Data received from main is %d\n", receiveData.counter);
		}
      



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
     
      
		res = rt_queue_bind(&queue_input, "queue_input", 1000);
		//rt_queue_clear(&queue_input);
	
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

	/* create zaehler2_task */
	err = rt_task_create(&zaehler2_task_ptr,"beta",STACK_SIZE,STD_PRIO2,0);
	/* start zaehler2_task */
	err = rt_task_start(&zaehler2_task_ptr,&zaehler2_task,NULL);

	// wait for signal & return of signal handler
	pause();
	fflush(NULL);
	return 0;
}

--0-2101647737-1161786878=:27211
Content-Type: text/x-csrc; name="queuelistener2_task.c"
Content-Description: 3467232582-queuelistener2_task.c
Content-Disposition: inline; filename="queuelistener2_task.c"

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
RTIME task_period_ns1 =   1000000000llu;
RTIME task_period_ns2 =   1000000000llu;
void zaehler2_task(void *cookie){
	int ret;	
	long ii;
	long jj;
	double a;


        TInputData receiveData;
	receiveData.counter = -1;

// ************************* Xenomai-Krempel ********************************************************************
	ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_ns2));
	if (ret) {
		printf("error while set periodic, code %d\n",ret);
		return;
	}
// ************************* Ende Xenomai-Krempel ****************************************************************


// ********************** Beginn des wiederholt ausgefuehrten Codes **********************************************
	while(!end){
		
              int counter = receiveData.counter;
               
               void *msg;
		int bytesRead = rt_queue_recv(&queue_input, &msg, TM_INFINITE);
		if (bytesRead > 0) {
			memcpy(&receiveData, msg, sizeof(TInputData));
			rt_queue_free(&queue_input, msg);
		}
		if (bytesRead <=0) {
			printf("rt_queue_receive(queue_input) failed: %d\n", bytesRead);
			
		}

		else if (receiveData.counter != counter + 1) {
			printf("counter error: %d\t->\t%d\n", counter + 1, receiveData.counter);
		} else {
			printf("Data received from main is %d\n", receiveData.counter);
		}
      



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
//	res = rt_queue_create(&queue_input, "queue_input", sizeof(TInputData) * QUEUE_INPUT_LEN,
//		QUEUE_INPUT_LEN, Q_FIFO | Q_SHARED);
//	if (res == -EEXIST)  
      {
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


	/* create zaehler2_task */
	err = rt_task_create(&zaehler2_task_ptr,"beta",STACK_SIZE,STD_PRIO2,0);

	/* start zaehler2_task */
	err = rt_task_start(&zaehler2_task_ptr,&zaehler2_task,NULL);

	// wait for signal & return of signal handler
	pause();
	fflush(NULL);
	return 0;
}

--0-2101647737-1161786878=:27211
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: base64
Content-Description: 402397780-Makefile
Content-Disposition: attachment; filename=Makefile

cHJlZml4IDo9ICQoc2hlbGwgeGVuby1jb25maWcgLS1wcmVmaXgpCgppZmVx
ICgkKHByZWZpeCksKQokKGVycm9yIFBsZWFzZSBhZGQgPHhlbm8taW5zdGFs
bD4vYmluIHRvIHlvdXIgUEFUSCB2YXJpYWJsZSkKZW5kaWYKCkNDID0gJChz
aGVsbCB4ZW5vLWNvbmZpZyAtLWNjKQpMWFJUX0NGTEFHUyA9ICQoc2hlbGwg
eGVuby1jb25maWcgLS14ZW5vLWNmbGFncykKTFhSVF9MREZMQUdTID0gJChz
aGVsbCB4ZW5vLWNvbmZpZyAtLXhlbm8tbGRmbGFncykKCgpxdWV1ZV9zZW5k
ZXIgOiAgcXVldWVfc2VuZGVyLm8KCSQoQ0MpICQoTFhSVF9DRkxBR1MpICQo
TFhSVF9MREZMQUdTKSAtbG0gLWxuYXRpdmUgLWcgLW8gJEAgJCsgICAKCnF1
ZXVlX3NlbmRlci5vIDogIHF1ZXVlX3NlbmRlci5jIAoJJChDQykgJChMWFJU
X0NGTEFHUykgJChMWFJUX0xERkxBR1MpIC1nICAtYyBxdWV1ZV9zZW5kZXIu
YyAKCmNsZWFuOgoJcm0gcXVldWVfc2VuZGVyLm8KCi5QSE9OWTogY2xlYW4K
Cg==

--0-2101647737-1161786878=:27211--

