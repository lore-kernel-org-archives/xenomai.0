Date: Tue, 27 Nov 2007 11:12:00 +0100
Message-Id: <1820393698@domain.hid>
MIME-Version: 1.0
From: Andreas Vogt <A_C_V@web.de>
Content-Type: multipart/mixed;
 boundary="=-------------11961583214259978106"
Subject: [Xenomai-help] interrupt programm hang up the computer
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

--=-------------11961583214259978106
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hello,

I try to implement an interrupt but I get always the error message -38. Wh=
at does this messages mean=3F
And when i delete in the section...

if (err > 0) {int=5Fcount++;}
	 else {
			printf("interrupt=5Ftask=5F2 error =3D %i\n", err);
		}
		rt=5Fintr=5Fenable (&intr=5Fdesc);=20
      =20
	   }

 ... the printf command the program hang up.

In my config the XENO=5FOPT=5FNATIVE=5FINTR is not set. Cause this any Problem=3F
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220


--=-------------11961583214259978106
Content-Type: text/x-csrc;
 name="timer.c"
Content-Disposition: attachment;
 filename="timer.c"
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
 
#define IRQ_NUMBER 7  /* Intercept interrupt #7 */
#define TASK_PRIO  99 /* Highest RT priority */
#define TASK_MODE  0  /* No flags */
#define TASK_STKSZ 0  /* Stack size (use default one) */
int end = 0;
RT_INTR intr_desc; 
RT_TASK server_desc;



void irq_server (void *cookie){
int err=0;
int int_count;		
    
while(!end){
        /* Wait for the next interrupt on channel #7. */
        err = rt_intr_wait(&intr_desc,TM_INFINITE);
	if (err > 0) {int_count++;printf("interrupt_task error = %i\n", int_count);}
	 else {
			printf("interrupt_task_2 error = %i\n", err);
		}
		rt_intr_enable (&intr_desc); 
       
	   }
 }

int main (int argc, char *argv[]){
int err = 0;
mlockall(MCL_CURRENT|MCL_FUTURE);


err = rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,0);

err = rt_task_create(&server_desc,"MyIrqServer",TASK_STKSZ,TASK_PRIO,TASK_MODE);
if (err) {
		printf("error rt_task_spawn\n");
		return 0;
	 }
else printf("start\n");
    
err = rt_task_start(&server_desc,&irq_server,NULL);
if (err) {
		printf("error rt_task_spawn\n");
		return 0;
	 }
else printf("start\n");
 }

 void cleanup (void)
 
 {
     end = 1;
     rt_intr_delete(&intr_desc);
     rt_task_delete(&server_desc);
 }

--=-------------11961583214259978106--

