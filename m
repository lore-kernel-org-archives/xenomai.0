Message-ID: <4416CC6A.8030605@domain.hid>
Date: Tue, 14 Mar 2006 15:00:10 +0100
From: marcellin <marcellin.fotze@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] the same error
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

well, I've made some little modifications, now i use the 
"rt_task_shadow()  function", but  from  the  "rt_intr_wait() function"  
the  numerical  error is  "-1".  To answer to Gilles, i use the RTC irq 
because i work on a (slow) acquisition system wich works continuously, 
and don't allow time drifts. The use of xenomai is to have tiny latencies.

the modified test program :

#include <sys/mman.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <getopt.h>
#include <time.h>
#include <native/task.h>
#include <native/mutex.h>
#include <native/timer.h>
#include <native/sem.h>
#include <native/intr.h>
#include <native/cond.h>
#include <rtdm/rtbenchmark.h>
#include <linux/rtc.h>
#include <sys/ioctl.h>
//#include <sys/time.h>
//#include <sys/types.h>
#include <fcntl.h>
#include <errno.h>


RT_TASK task;

RT_TASK main_task;


RT_INTR intr_desc;

RT_COND cond;

RT_MUTEX mutextest;

int err,fd,retval,i,irqcount = 0;
unsigned long data;
char err_message[80];
const int TIMER_IRQ = 8;

void mytask(void * cookie)
{
  sleep(1);
  err = rt_cond_signal(&cond);
  if(err != 0){
    printf("\nrt_cond_signal : %i\n",err);
  }
         

}

int main (int argc, char **argv)
{

  mlockall(MCL_CURRENT | MCL_FUTURE);
   
  rt_timer_set_mode(TM_ONESHOT);
 
  err = rt_task_shadow(&main_task,"main_task",11,0); 
  if(err != 0){                                                         
           
    printf("\nrt_task_shadow : %i",err);
  }

  err = rt_cond_create(&cond,"condition");
  if(err != 0){
    printf("\nrt_cond_create : %i",err);
  }
  err = rt_mutex_create(&mutextest,"mut");
  if(err != 0){
    printf("\nrt_mutex_create : %i",err);
  }
 
  err = rt_task_create(&task,"SecondTask",0,99,0);
  if(err != 0){
    printf("\nrt_task_create : %i",err);
  }
  err = rt_task_start(&task,&mytask,NULL);
  if(err != 0){
    printf("\nrt_task_start : %i",err);
  }
 
  err = rt_cond_wait(&cond,&mutextest,20000000);
  if(err != 0){
    printf("\nrt_cond_wait : %i",err);
  }
  printf("\nend \n");
 
  rt_mutex_delete(&mutextest);
  rt_cond_delete(&cond);
  rt_task_delete(&main_task);
  rt_task_delete(&task);

return(0);

}


regards

Marcell1


