MIME-Version: 1.0
Date: Fri, 19 Sep 2014 17:03:46 +0530
Message-ID: <CALe7ZU0q+9ymAuFSJ=dCkh_+o=pzLrRe0qj31w+WVPjKUpP5Fw@mail.gmail.com>
From: JAY KOTHARI <jaikothari10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] problem with rt_task_wait_period
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
    I am using rt_task_wait_period in calculating jitter for two of my
task.But it works perfectly for one task while it shows error in
second real time task.I am writing code.Please tell me where am I
going wrong

#include<stdio.h>
#include<signal.h>
#include<unistd.h>
#include<sys/mman.h>
//#include <native/sem.h>

#include<native/task.h>
#include<native/timer.h>
#include<native/pipe.h>

#define TASK_MODE       (T_FPU|T_CPU(0))
#define TASK_STKSZ      4096
#define u_NSEC          1000000

#define SETUP_TICK_NSEC         1000000

#define PERIOD_1        (u_NSEC*1)
#define PERIOD_2        (u_NSEC*2)

#define ONE_SHOT_MODE   1

void rt_task_1(void *cookie)
{       unsigned long overrun1_t;
        int ret;
        int err;
        RTIME systime1=0,systime2=0,expected=0;
        systime2= rt_timer_read();
        ret = rt_task_set_periodic(&task_desc1, TM_NOW, PERIOD_1);
        if(ret<0)
        {
        printf("error1 in rt_task_set_periodic()  %d ...\n",ret); return ;
        }

        expected= systime2 + PERIOD_2;
        err=rt_task_wait_period(&overrun1_t);
      printf("overrun1=%lu\n",overrun1_t);
        if(err<0)
        {perror("task wait error\n");
        }
        systime1 = rt_timer_read();
      printf("actual system time after first task1 wake-up....value
%llu \n",systime1);
      printf(" task1 time%lld \n", systime1-systime2);

      printf("jitter after task1.....%lld\n",systime1-expected);
        expected=systime1;
}

void rt_task_2(void *cookie)
{
int overrun2_t;
int ret,ret1;
        printf("\t task 2 started  \t\n");
        int err,i;
        RTIME systime1=0,systime2=0,expected=0;
        systime2= rt_timer_read();
        ret1 = rt_task_set_periodic(&task_desc1, TM_NOW, PERIOD_2);
        if(ret<0)
        {
        printf("error2 in rt_task_set_periodic()  %d ...\n",ret); return ;
        }
                expected= systime2 +PERIOD_2;
                err=rt_task_wait_period(&overrun2_t);
if(err<0)
{perror("task 2 wait error\n");
 }

        systime1 = rt_timer_read();
printf("jitter after task2.....%lld\n",systime1-expected);

//      printf("\ttask 2 ended\t\n");
//        rt_sem_v(&sem_desc);

}
void catch_signal(int sig)
{printf("task is completed\n");
}
int main(int argc,char* argv[])
{
        int ret;
        signal(SIGTERM,catch_signal);
        signal(SIGINT,catch_signal);

        mlockall(MCL_CURRENT | MCL_FUTURE);

#if ONE_SHOT_MODE == 1
                ret = rt_timer_set_mode(TM_ONESHOT);//sets timer MODE
                printf("timer base in one-shot mode  ***********");
#else
                ret = rt_timer_set_mode(SETUP_TICK_NSEC);
                printf("timer base in periodic mode  *********");
#endif

      ret=rt_task_create(&task_desc1,"rt_task_1",TASK_STKSZ,5,TASK_MODE);
        rt_task_start(&task_desc1,&rt_task_1,NULL);
   pause();
          ret = rt_task_delete(&task_desc1);
    ret=rt_task_create(&task_desc2,"rt_task_2",TASK_STKSZ,4,TASK_MODE);
        rt_task_start(&task_desc2,&rt_task_2,NULL);
    pause();
        ret = rt_task_delete(&task_desc2);

}

