Date: Fri, 15 Dec 2006 06:59:29 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
Subject: Re: [Xenomai-help] user space interrupt
In-Reply-To: <45817C88.8070906@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1881580032-1166194769=:20532"
Content-Transfer-Encoding: 8bit
Message-ID: <162080.20532.qm@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0-1881580032-1166194769=:20532
Content-Type: multipart/alternative; boundary="0-673855506-1166194769=:20532"

--0-673855506-1166194769=:20532
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks a lot
The error with "iopl" is fixed after i have acquired the root right but now problem is that rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,I_NOAUTOENA);

returns -22 which i dont understand  what it means.my code is extremely simple  .i have attached the code also please guide me how can i solve this problem.thanks again.

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote: mani bhatti wrote:
> Hi Gilles and all
> Thanks for ur help.The error i get after replacing printf with
> perror("iopl") is "iopl: Operation not permitted".
> Please suggest me some solution for this.Thanks again.

"Operation not permitted" is the error message for the error code EPERM.
Now look for EPERM in iopl manual page.

-- 
                                                 Gilles Chanteperdrix


 __________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-673855506-1166194769=:20532
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks a lot<br>The error with "iopl" is fixed after i have acquired the root right but now problem is that rt_intr_create(&amp;intr_desc,"MyIrq",IRQ_NUMBER,I_NOAUTOENA);<br><br>returns -22 which i dont understand&nbsp; what it means.my code is extremely simple&nbsp; .i have attached the code also please guide me how can i solve this problem.thanks again.<br><br><b><i>Gilles Chanteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> mani bhatti wrote:<br>&gt; Hi Gilles and all<br>&gt; Thanks for ur help.The error i get after replacing printf with<br>&gt; perror("iopl") is "iopl: Operation not permitted".<br>&gt; Please suggest me some solution for this.Thanks again.<br><br>"Operation not permitted" is the error message for the error code EPERM.<br>Now look for EPERM in iopl manual page.<br><br>-- <br>                                                
 Gilles Chanteperdrix<br></blockquote><br><p>&#32;__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-673855506-1166194769=:20532--

--0-1881580032-1166194769=:20532
Content-Type: text/x-csrc; name="parinterrupt.c"
Content-Description: 18037014-parinterrupt.c
Content-Disposition: inline; filename="parinterrupt.c"


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
        rt_intr_delete(&intr_desc);	
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
	      perror("iopl"); 
          //	printf("iopl err\n");
		exit(1);
	}


         outb_p(0x10, BASEPORT + 2);
         mlockall(MCL_CURRENT | MCL_FUTURE);
         err = rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,I_NOAUTOENA);
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
   


	/* create zaehler2_task */
	err = rt_task_create(&zaehler2_task_ptr,"beta",STACK_SIZE,STD_PRIO2,0);

	/* start zaehler2_task */
	err = rt_task_start(&zaehler2_task_ptr,&zaehler2_task,NULL);

	// wait for signal & return of signal handler
	pause();
	fflush(NULL);
	return 0;
}

--0-1881580032-1166194769=:20532--

