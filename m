Date: Fri, 8 Dec 2006 06:01:00 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1124567486-1165586460=:29791"
Content-Transfer-Encoding: 8bit
Message-ID: <279913.29791.qm@domain.hid>
Subject: [Xenomai-help] user space interrupt
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

--0-1124567486-1165586460=:29791
Content-Type: multipart/alternative; boundary="0-477837361-1165586460=:29791"

--0-477837361-1165586460=:29791
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all 
i am trying to access parallel port form a user space task.i have copied code from an example which runs parallel port in interrupt mode but the problem is that when i run program i get following message 

"iopl err"

due to this piece of  code 
        
// ask for permission to access the parallel port from user-space
        if (iopl(3)) {
                printf("iopl err\n");
                exit(1);
        }


i am working with interrupts for the first time and have no idea why this is happening .i am attaching the code also.Thanks all for the great help.

 
---------------------------------
Everyone is raving about the all-new Yahoo! Mail beta.
--0-477837361-1165586460=:29791
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all <br>i am trying to access parallel port form a user space task.i have copied code from an example which runs parallel port in interrupt mode but the problem is that when i run program i get following message <br><br>"iopl err"<br><br>due to this piece of&nbsp; code <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>// ask for permission to access the parallel port from user-space<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (iopl(3)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("iopl err\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br><br>i am working with interrupts for the first time and have no idea why this is happening .i am attaching the code also.Thanks all for the great help.<br><p>&#32;


<hr size=1>Everyone is raving about <a href="http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail beta.</a>
--0-477837361-1165586460=:29791--

--0-1124567486-1165586460=:29791
Content-Type: text/x-csrc; name="doppel_task.c"
Content-Description: 4248410318-doppel_task.c
Content-Disposition: inline; filename="doppel_task.c"


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
#define IRQ_NUMBER 7 
#define BASEPORT 0x378
#define PARPORTINT 7


RT_TASK zaehler1_task_ptr;
RT_TASK zaehler2_task_ptr;
RT_INTR intr_desc;

int count1 = 0;
int count2 = 0;
int i;
int end = 0;

//                      --s-ms-us-ns
RTIME task_period_ns1 =   1000000000llu;
RTIME task_period_ns2 =  10000000000llu;




void zaehler2_task(void *cookie){
	int ret;	
	long ii;
	long jj;
	double a;
        unsigned long overrun;
        int err;



// ********************** Beginn des wiederholt ausgefuehrten Codes **********************************************
	while(!end){
	
         err = rt_intr_wait(&intr_desc,TM_INFINITE);
         printf("Error is %d\n",err);

                printf("\nInterrupt occured");

		fflush(NULL);
        }
// ********************** Ende des wiederholt ausgefuehrten Codes ***********************************************
}
       


// signal-handler, to ensure clean exit on Ctrl-C
void clean_exit(int dummy) {
	printf("cleanup\n");
	end = 1;

	rt_task_delete(&zaehler2_task_ptr);
	printf("end\n");
}

int main(int argc, char *argv[]) {
	int err, ret;
	printf("start\n");
	// install signal handler
	signal(SIGTERM, clean_exit);	
	signal(SIGINT, clean_exit);	
	
        // ask for permission to access the parallel port from user-space
	if (iopl(3)) {  
		printf("iopl err\n");
		exit(1);
	}


         outb_p(0x10, BASEPORT + 2);
         err = rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,NULL);
         printf("rt_intr_create=%i\n", err);

         switch(-err)

          {
             case ENOMEM  :
             printf("fail to allocate dynamic memory");
             break;

             case EBUSY:
             printf("Busy");
             break;
             }

        rt_intr_enable (&intr_desc);


   


          mlockall(MCL_CURRENT|MCL_FUTURE);
  
       
                   


	/* create zaehler2_task */
//	err = rt_task_create(&zaehler2_task_ptr,"beta",STACK_SIZE,STD_PRIO2,0);


	/* start zaehler2_task */
//	err = rt_task_start(&zaehler2_task_ptr,&zaehler2_task,NULL);

	// wait for signal & return of signal handler
	pause();
	fflush(NULL);
	return 0;
}

--0-1124567486-1165586460=:29791--

