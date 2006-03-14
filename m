Message-ID: <44169F39.2060904@domain.hid>
Date: Tue, 14 Mar 2006 11:47:21 +0100
From: marcellin <marcellin.fotze@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] another question
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

Sorry, but with this tiny program i have the same error : Operation not 
permitted. What is wrong ?

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


RT_INTR intr_desc;

RT_COND cond;

RT_MUTEX mutextest;

int err;

void mytask(void * cookie)
{
  sleep(1);
  err = rt_cond_signal(&cond);
  if(err != 0){
    printf("\nrt_cond_signal : %s",strerror(-err));
  }
         

}

int main (int argc, char **argv)
{

  mlockall(MCL_CURRENT | MCL_FUTURE);
   
  rt_timer_set_mode(TM_ONESHOT);

  err = rt_cond_create(&cond,"condition");
  if(err != 0){
    printf("\nrt_cond_create : %s",strerror(-err));
  }
  err = rt_mutex_create(&mutextest,"mut");
  if(err != 0){
    printf("\nrt_mutex_create : %s",strerror(-err));
  }
 
  err = rt_task_create(&task,"SecondTask",0,99,0);
  if(err != 0){
    printf("\nrt_task_create : %s",strerror(-err));
  }
  err = rt_task_start(&task,&mytask,NULL);
  if(err != 0){
    printf("\nrt_task_start : %s",strerror(-err));
  }
 
 
  err = rt_cond_wait(&cond,&mutextest,TM_INFINITE);
  if(err != 0){
    printf("\nrt_cond_wait : %s",strerror(-err));
  }
  printf("\nend \n");
 
  retrurn(0);

}

regards

Marcell1

