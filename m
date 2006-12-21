Date: Thu, 21 Dec 2006 07:17:49 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-90690271-1166714269=:54449"
Content-Transfer-Encoding: 8bit
Message-ID: <16509.54449.qm@domain.hid>
Subject: [Xenomai-help] please i need help for rt_intr_create() fails
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

--0-90690271-1166714269=:54449
Content-Type: multipart/alternative; boundary="0-722307226-1166714269=:54449"

--0-722307226-1166714269=:54449
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



Note: forwarded message attached.
 __________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-722307226-1166714269=:54449
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br><br>Note: forwarded message attached.<p>&#32;__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-722307226-1166714269=:54449--

--0-90690271-1166714269=:54449
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

X-Apparently-To: imranbashirbhatti@domain.hid via 69.147.75.103;
	Wed, 20 Dec 2006 07:31:28 -0800
X-Originating-IP: [88.191.250.45]
Authentication-Results: mta378.mail.mud.yahoo.com  from=gna.org;
	domainkeys=fail (bad syntax)
Received: from 88.191.250.45  (EHLO gna.org) (88.191.250.45)
	by mta378.mail.mud.yahoo.com with SMTP; Wed, 20 Dec 2006 07:31:27 -0800
Received: from localhost ([127.0.0.1] helo=bart.gna.org)
	by gna.org with esmtp (Exim 4.50)
	id 1Gx3OX-0001VZ-9D; Wed, 20 Dec 2006 16:30:13 +0100
Received: from Debian-exim by gna.org with spam-scanned (Exim 4.50)
	id 1Gx3OL-0001TZ-Q8
	for xenomai@xenomai.org; Wed, 20 Dec 2006 16:30:10 +0100
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-26) on mail.gna.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.3 tests=AWL,BAYES_20,HTML_00_10,
	HTML_MESSAGE,RCVD_IN_RFCI_ABUSE,RCVD_IN_RFCI_POSTMASTER autolearn=no 
	version=3.1.4
Received: from web62508.mail.re1.yahoo.com ([69.147.75.100])
	by gna.org with smtp (Exim 4.50) id 1Gx3OL-0001Sz-Cc
	for xenomai@xenomai.org; Wed, 20 Dec 2006 16:30:01 +0100
Received: (qmail 38274 invoked by uid 60001); 20 Dec 2006 15:29:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=s1024; d=yahoo.com;
	h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
	b=AecSXWpHSNuFCnsUyZJv9R8CgpPa4QMwG+sXB+n9dIf2n5DuZWfSa45mnQrr2XKoC2J0tgYIdrpX1DoKiIgElhasMmDxdVQ7WmEHGQfsAcwKKL6mpm4bZRkq7SCDo8SrAn3V+294l/Xbjdb8dj8AKbZdl23kZdIDSNFlYyBGB2Y=;
X-YMail-OSG: vv8kT2oVM1nB62A30s9lfRW_3lXp.2f3Hl_v66Go
Received: from [130.83.71.96] by web62508.mail.re1.yahoo.com via HTTP;
	Wed, 20 Dec 2006 07:29:26 PST
Date: Wed, 20 Dec 2006 07:29:26 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
To: xenomai@xenomai.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-742605428-1166628566=:38100"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] rt_intr_create() fails
X-BeenThere: xenomai@xenomai.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Sender: xenomai-help-bounces@domain.hid
Errors-To: xenomai-help-bounces@domain.hid
Content-Length: 1738

--0-742605428-1166628566=:38100
Content-Type: multipart/alternative; boundary="0-1523260492-1166628566=:38100"

--0-1523260492-1166628566=:38100
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all
i am trying to create a user space parallel port interrupt but the problem is that   err=rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,I_NOAUTOENA);


returns -22 instead of zero which means success.i dont have idea what this error code  -22 means.please help me in this regard.i am attaching the sample code.If some one can send me some basic working user space xenomai  code i would be  very thankful.Thanks,

 __________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1523260492-1166628566=:38100
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all<br>i am trying to create a user space parallel port interrupt but the problem is that &nbsp; err=rt_intr_create(&amp;intr_desc,"MyIrq",IRQ_NUMBER,I_NOAUTOENA);<br><br><br>returns -22 instead of zero which means success.i dont have idea what this error code&nbsp; -22 means.please help me in this regard.i am attaching the sample code.If some one can send me some basic working user space xenomai&nbsp; code i would be&nbsp; very thankful.Thanks,<br><p>&#32;__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1523260492-1166628566=:38100--

--0-742605428-1166628566=:38100
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

--0-742605428-1166628566=:38100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

--0-742605428-1166628566=:38100--


--0-90690271-1166714269=:54449--

