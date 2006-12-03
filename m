Message-ID: <20061203150211.80319.qmail@domain.hid>
Date: Sun, 3 Dec 2006 07:02:11 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-457789134-1165158131=:78409"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] porting to kernel 2.2 
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

--0-457789134-1165158131=:78409
Content-Type: multipart/alternative; boundary="0-1979956489-1165158131=:78409"

--0-1979956489-1165158131=:78409
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



Note: forwarded message attached.
 
---------------------------------
Everyone is raving about the all-new Yahoo! Mail beta.
--0-1979956489-1165158131=:78409
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<BR><BR>Note: forwarded message attached.<p>&#32;


<hr size=1>Everyone is raving about <a href="http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail beta.</a>
--0-1979956489-1165158131=:78409--

--0-457789134-1165158131=:78409
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

X-Apparently-To: imranbashirbhatti@domain.hid via 69.147.75.96;
	Thu, 30 Nov 2006 08:48:05 -0800
X-Originating-IP: [88.191.250.45]
Authentication-Results: mta279.mail.mud.yahoo.com  from=gna.org;
	domainkeys=fail (bad syntax)
Received: from 88.191.250.45  (EHLO gna.org) (88.191.250.45)
	by mta279.mail.mud.yahoo.com with SMTP; Thu, 30 Nov 2006 08:48:04 -0800
Received: from localhost ([127.0.0.1] helo=bart.gna.org)
	by gna.org with esmtp (Exim 4.50)
	id 1Gpp3A-0002l3-MT; Thu, 30 Nov 2006 17:46:16 +0100
Received: from Debian-exim by gna.org with spam-scanned (Exim 4.50)
	id 1Gpp32-0002kp-6Y
	for xenomai@xenomai.org; Thu, 30 Nov 2006 17:46:14 +0100
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-26) on mail.gna.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.3 tests=AWL,BAYES_00,HTML_MESSAGE,
	RCVD_IN_RFCI_ABUSE,RCVD_IN_RFCI_POSTMASTER autolearn=no version=3.1.4
Received: from web62509.mail.re1.yahoo.com ([69.147.75.101])
	by gna.org with smtp (Exim 4.50) id 1Gpp31-0002jF-Sj
	for xenomai@xenomai.org; Thu, 30 Nov 2006 17:46:08 +0100
Received: (qmail 70293 invoked by uid 60001); 30 Nov 2006 16:45:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=s1024; d=yahoo.com;
	h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=dyO7QKZiIXMggp6cRhmofhdTHHePWxWhDu3QFz5c4ilq4pF5+WRDUDzGdU6MrLof9rN7DSYyzf6BdRe/sdtsZeH40MpT5JGUhTRNIc7PnxeVG7vn1RWblTcoKcIaVQg92Xf3R0Ejeu3jvP30sKqfoVFhz9gcYA5aO91ZQtqmnnw=
	; 
Received: from [130.83.71.96] by web62509.mail.re1.yahoo.com via HTTP;
	Thu, 30 Nov 2006 08:45:32 PST
Date: Thu, 30 Nov 2006 08:45:32 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
To: xenomai-help <xenomai@xenomai.org>
In-Reply-To: <451A9C64.7040802@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-318679095-1164905132=:69610"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] porting to kernel 2.2 
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
Content-Length: 2301

--0-318679095-1164905132=:69610
Content-Type: multipart/alternative; boundary="0-1240062379-1164905132=:69610"

--0-1240062379-1164905132=:69610
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



Hi all 
Previously i was working with 2.1 version of xenomai kernel but now i have kernel  2.2 and my previous code flags me error about  rt_task_wait_period() which i have fixed to rt_task_wait_period(NULL) and also gives me warning rt_start_time is deprecated and i have removed this line because in 2.2 system timer automatically starts but still by 
rt_task_set_periodic gives error   "system timer not stared" and my program exits due to return statement showing that peridodic mode is not set.i am attaching my code.Please figure out the problem and help me about the bug in program.Thanks all.

 
---------------------------------
Cheap Talk? Check out Yahoo! Messenger's low PC-to-Phone call rates.
--0-1240062379-1164905132=:69610
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br><br><b><i></i></b>Hi all <br>Previously i was working with 2.1 version of xenomai kernel but now i have kernel&nbsp; 2.2 and my previous code flags me error about&nbsp; rt_task_wait_period() which i have fixed to rt_task_wait_period(NULL) and also gives me warning rt_start_time is deprecated and i have removed this line because in 2.2 system timer automatically starts but still by <br>rt_task_set_periodic gives error&nbsp;&nbsp; "system timer not stared" and my program exits due to return statement showing that peridodic mode is not set.i am attaching my code.Please figure out the problem and help me about the bug in program.Thanks all.<br><p>&#32;
<hr size=1>Cheap Talk? <a href="http://us.rd.yahoo.com/mail_us/taglines/postman8/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com">Check out</a> Yahoo! Messenger's low PC-to-Phone call rates.
--0-1240062379-1164905132=:69610--

--0-318679095-1164905132=:69610
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

RT_TASK zaehler1_task_ptr;
RT_TASK zaehler2_task_ptr;
int count1 = 0;
int count2 = 0;
int i;
int end = 0;

//                      --s-ms-us-ns
RTIME task_period_ns1 =   1000000000llu;
RTIME task_period_ns2 =  10000000000llu;


void zaehler1_task(void *cookie){
        int ret;
        
// ************************* Xenomai-Krempel ********************************************************************
        ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_ns1));
     switch(-ret){
      case EINVAL:   printf("Task is not a task descriptor\n");
                    break;
      case EIDRM:  printf( "Task is a deleted task descriptor\n");
                    rt_task_sleep(50000); // wait 50us
                    break;
      case ETIMEDOUT: printf("idate different from TM_INFINITE\n");
                    break;
      case EWOULDBLOCK: printf("system timer not stared\n");
                    break;
      case EPERM:    printf("task is null\n");
      break;
    }   
     
      if (ret) {
                printf("error while set periodic, code %d\n",ret);
                return;
        }
// ************************* Ende Xenomai-Krempel ****************************************************************


// ********************** Beginn des wiederholt ausgefuehrten Codes **********************************************
        while(!end){
    /*      
          ret = rt_task_set_mode(0, T_PRIMARY, NULL);
                if (ret) {
                        printf("error while rt_task_set_mode, code %d\n",ret);
                        return;
                }
      */          
             ret = rt_task_wait_period(NULL);
                printf("T1:Start\n");

                if (ret) {
                        printf("error while rt_task_wait_period, code %d\n",ret);
                        return;
                }
                count1++;

                printf("T1:Ende:%d\n", count1);

                fflush(NULL);
        }
// ********************** Ende des wiederholt ausgefuehrten Codes ***********************************************
}


void zaehler2_task(void *cookie){
	int ret;	
	long ii;
	long jj;
	double a;
        unsigned long overrun;
// ************************* Xenomai-Krempel ********************************************************************
	ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_ns2));
	if (ret) {
		printf("error while set periodic, code %d\n",ret);
		return;
	}
// ************************* Ende Xenomai-Krempel ****************************************************************


// ********************** Beginn des wiederholt ausgefuehrten Codes **********************************************
	while(!end){
	/*	ret = rt_task_set_mode(0, T_PRIMARY, NULL);
		if (ret) {
			printf("error while rt_task_set_mode, code %d\n",ret);
			return;
		}
	 */	
      ret = rt_task_wait_period(NULL);
		
		printf("\t\tT2:Start\n");

		if (ret) {
			printf("error while rt_task_wait_period, code %d\n",ret);
			return;
		}

                for(ii=0; ii<200; ii++) {
		 	for(jj=0; jj<1000000; jj++) {
				a = (double)ii * (double)jj;
			}
		}              

                count2++;
                printf("\t\tT2:Ende:%d\n", count2++);

		fflush(NULL);
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
	printf("start\n");
	// install signal handler
	signal(SIGTERM, clean_exit);	
	signal(SIGINT, clean_exit);	
	// start timer
	//ret = rt_timer_start(TM_ONESHOT);
/*	switch (ret) {
		case 0:       printf("Mit dem Fahrrad nich inn ersten Wagen\n\n");
		              break;
		case -EBUSY:  printf("timer is running\n");
		              break;
		case -ENOSYS: printf("can't start timer\n");
		              return ret;
	}

*/

	/* create zaehler1_task */
	err = rt_task_create(&zaehler1_task_ptr,"alpha",STACK_SIZE,STD_PRIO1,0);
	/* create zaehler2_task */
	err = rt_task_create(&zaehler2_task_ptr,"beta",STACK_SIZE,STD_PRIO2,0);

	/* start zaehler1_task */
	err = rt_task_start(&zaehler1_task_ptr,&zaehler1_task,NULL);

	/* start zaehler2_task */
	err = rt_task_start(&zaehler2_task_ptr,&zaehler2_task,NULL);

	// wait for signal & return of signal handler
	pause();
	fflush(NULL);
	return 0;
}

--0-318679095-1164905132=:69610
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

--0-318679095-1164905132=:69610--


--0-457789134-1165158131=:78409--

