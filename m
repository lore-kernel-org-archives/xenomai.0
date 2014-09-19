Message-ID: <541C16C3.9070101@xenomai.org>
Date: Fri, 19 Sep 2014 13:42:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALe7ZU0q+9ymAuFSJ=dCkh_+o=pzLrRe0qj31w+WVPjKUpP5Fw@mail.gmail.com>
In-Reply-To: <CALe7ZU0q+9ymAuFSJ=dCkh_+o=pzLrRe0qj31w+WVPjKUpP5Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] problem with rt_task_wait_period
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>, xenomai@xenomai.org

On 09/19/2014 01:33 PM, JAY KOTHARI wrote:
> Hi,
>     I am using rt_task_wait_period in calculating jitter for two of my
> task.But it works perfectly for one task while it shows error in
> second real time task.I am writing code.Please tell me where am I
> going wrong
> 
> #include<stdio.h>
> #include<signal.h>
> #include<unistd.h>
> #include<sys/mman.h>
> //#include <native/sem.h>
> 
> #include<native/task.h>
> #include<native/timer.h>
> #include<native/pipe.h>
> 
> #define TASK_MODE       (T_FPU|T_CPU(0))
> #define TASK_STKSZ      4096
> #define u_NSEC          1000000
> 
> #define SETUP_TICK_NSEC         1000000
> 
> #define PERIOD_1        (u_NSEC*1)
> #define PERIOD_2        (u_NSEC*2)
> 
> #define ONE_SHOT_MODE   1
> 
> void rt_task_1(void *cookie)
> {       unsigned long overrun1_t;
>         int ret;
>         int err;
>         RTIME systime1=0,systime2=0,expected=0;
>         systime2= rt_timer_read();
>         ret = rt_task_set_periodic(&task_desc1, TM_NOW, PERIOD_1);
>         if(ret<0)
>         {
>         printf("error1 in rt_task_set_periodic()  %d ...\n",ret); return ;
>         }
> 
>         expected= systime2 + PERIOD_2;

This looks wrong, you want systime2 + PERIOD_1 here.

>         err=rt_task_wait_period(&overrun1_t);
>       printf("overrun1=%lu\n",overrun1_t);
>         if(err<0)
>         {perror("task wait error\n");
>         }
>         systime1 = rt_timer_read();
>       printf("actual system time after first task1 wake-up....value
> %llu \n",systime1);
>       printf(" task1 time%lld \n", systime1-systime2);
> 
>       printf("jitter after task1.....%lld\n",systime1-expected);

The printf here will cause the task to switch to secondary mode, unless
you compile for the posix skin (in addition to the native skin), and
will cause jitter for the next release point.


-- 
                                                                Gilles.

