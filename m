Message-ID: <4EBA5585.8050807@domain.hid>
Date: Wed, 09 Nov 2011 11:27:17 +0100
From: Olivier Reynet <olivier.reynet@domain.hid>
MIME-Version: 1.0
References: <51962.81.220.196.189.1320786408.squirrel@domain.hid>
	<4EB9C562.9040107@domain.hid>
In-Reply-To: <4EB9C562.9040107@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai 2.5.6 and Round Robin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

OK, I understand that it is rt_task_slice that must be used.
The problem is that i dont see any RR effect during execution.
The code is simple and inspired by this no more suitable but useful code=20
: http://www.cs.ru.nl/lab/xenomai/exercises/ex06/ex06a.c .

4 non periodic tasks are set. They are calling rt_timer_spin(SPINTIME)=20
to do nothing during EXECTIME.
1. They are set with priority 60.
2. Then the RR quantum is set to 3*SPINTIME.
I would like to see the task 0 preempted but it is not.  It looks like=20
FIFO scheduling without RR.

Here below is the code and the output follows :

#include<stdio.h>
#include<signal.h>
#include<unistd.h>
#include<sys/mman.h>
#include<native/task.h>
#include<native/timer.h>
#include<native/sem.h>
#include<rtdk.h>
#include<sys/io.h>

#define NTASKS 4
RT_TASK demo_task[NTASKS];
RT_SEM mysync;

#define EXECTIME   2e7   // execution time in ns =3D=3D>  20 ms
#define SPINTIME   1e6   // spin time in ns =3D=3D>  1 ms

void demo(void *arg)
{
     RTIME runtime;
     runtime =3D 0;
     rt_sem_p(&mysync,TM_INFINITE);
     // inquire current task
     RT_TASK *curtask;
     RT_TASK_INFO curtaskinfo;
     curtask=3DNULL;
     rt_task_inquire(curtask,&curtaskinfo);
     while(curtaskinfo.exectime<  EXECTIME) {
       rt_timer_spin(SPINTIME);  // spin cpu doing nothing
       rt_task_inquire(curtask,&curtaskinfo);
       rt_printf("Running %s priority[%d]  at : %d ms\n",curtaskinfo.name=
,curtaskinfo.cprio,curtaskinfo.exectime/1000000);
     }
     rt_printf("End of %s\n",curtaskinfo.name);
}

//startup code
void startup()
{
   int i;
   char  str[10] ;
   RT_TASK_INFO ataskinfo;
   // semaphore to sync task startup on
   rt_sem_create(&mysync,"MySemaphore",0,S_FIFO);
   // starting tasks
   for(i=3D0;i<NTASKS;i++) {
     sprintf(str,"Task%d",i);
     int priority=3D60;
     rt_task_create(&demo_task[i], str, 0, priority, 0);
     rt_task_start(&demo_task[i],&demo, NULL);
     rt_task_inquire(&demo_task[i],&ataskinfo);
     rt_printf("Starting task  : %s with priority %d\n",ataskinfo.name,at=
askinfo.cprio);
   }
   // set RR
   for(i=3D0;i<NTASKS;i++) {
     RTIME quantum=3Drt_timer_ns2tsc(3*SPINTIME);
     int err=3Drt_task_slice(&demo_task[i],quantum);
     rt_printf("error set  quantum ? %d\n",err);
     rt_task_inquire(&demo_task[i],&ataskinfo);
     rt_printf("Setting round robin policy to %s with quantum %i\n",atask=
info.name,quantum);
   }
   rt_printf("wake up all tasks\n");
   rt_sem_broadcast(&mysync);
}

void init_xenomai() {
   /* Avoids memory swapping for this program */
   mlockall(MCL_CURRENT|MCL_FUTURE);
   /* Perform auto-init of rt_print buffers if the task doesn't do so */
   rt_print_auto_init(1);
}

int main(int argc, char* argv[])
{
   printf("\nType CTRL-C to end this program\n\n" );
   // code to set things to run xenomai
   init_xenomai();
   //startup code
   startup();
   pause();
   int i;
   for (i=3D0;i<NTASKS;i++)
     rt_task_join(&demo_task[i]);
   return 0;
}

And the ouput :

# ./xeno_sched

Type CTRL-C to end this program

Starting task  : Task0 with priority 60
Starting task  : Task1 with priority 60
Starting task  : Task2 with priority 60
Starting task  : Task3 with priority 60
error set  quantum ? 0
Setting round robin policy to Task0 with quantum 9875004
error set  quantum ? 0
Setting round robin policy to Task1 with quantum 9875004
error set  quantum ? 0
Setting round robin policy to Task2 with quantum 9875004
error set  quantum ? 0
Setting round robin policy to Task3 with quantum 9875004
wake up all tasks
Running Task0 priority[60]  at : 1 ms
Running Task0 priority[60]  at : 2 ms
Running Task0 priority[60]  at : 3 ms
Running Task0 priority[60]  at : 4 ms
Running Task0 priority[60]  at : 5 ms
Running Task0 priority[60]  at : 6 ms
Running Task0 priority[60]  at : 7 ms
Running Task0 priority[60]  at : 8 ms
Running Task0 priority[60]  at : 9 ms
Running Task0 priority[60]  at : 10 ms
Running Task0 priority[60]  at : 11 ms
Running Task0 priority[60]  at : 12 ms
Running Task0 priority[60]  at : 13 ms
Running Task0 priority[60]  at : 14 ms
Running Task0 priority[60]  at : 15 ms
Running Task0 priority[60]  at : 16 ms
Running Task0 priority[60]  at : 17 ms
Running Task0 priority[60]  at : 18 ms
Running Task0 priority[60]  at : 19 ms
Running Task0 priority[60]  at : 20 ms
End of Task0
Running Task1 priority[60]  at : 1 ms
Running Task1 priority[60]  at : 2 ms
Running Task1 priority[60]  at : 3 ms
Running Task1 priority[60]  at : 4 ms
Running Task1 priority[60]  at : 5 ms
Running Task1 priority[60]  at : 6 ms
Running Task1 priority[60]  at : 7 ms
Running Task1 priority[60]  at : 8 ms
Running Task1 priority[60]  at : 9 ms
Running Task1 priority[60]  at : 10 ms
Running Task1 priority[60]  at : 11 ms
Running Task1 priority[60]  at : 12 ms
Running Task1 priority[60]  at : 13 ms
Running Task1 priority[60]  at : 14 ms
Running Task1 priority[60]  at : 15 ms
Running Task1 priority[60]  at : 16 ms
Running Task1 priority[60]  at : 17 ms
Running Task1 priority[60]  at : 18 ms
Running Task1 priority[60]  at : 19 ms
Running Task1 priority[60]  at : 20 ms
End of Task1
Running Task2 priority[60]  at : 1 ms
Running Task2 priority[60]  at : 2 ms
Running Task2 priority[60]  at : 3 ms
Running Task2 priority[60]  at : 4 ms
Running Task2 priority[60]  at : 5 ms
Running Task2 priority[60]  at : 6 ms
Running Task2 priority[60]  at : 7 ms
Running Task2 priority[60]  at : 8 ms
Running Task2 priority[60]  at : 9 ms
Running Task2 priority[60]  at : 10 ms
Running Task2 priority[60]  at : 11 ms
Running Task2 priority[60]  at : 12 ms
Running Task2 priority[60]  at : 13 ms
Running Task2 priority[60]  at : 14 ms
Running Task2 priority[60]  at : 15 ms
Running Task2 priority[60]  at : 16 ms
Running Task2 priority[60]  at : 17 ms
Running Task2 priority[60]  at : 18 ms
Running Task2 priority[60]  at : 19 ms
Running Task2 priority[60]  at : 20 ms
End of Task2
Running Task3 priority[60]  at : 1 ms
Running Task3 priority[60]  at : 2 ms
Running Task3 priority[60]  at : 3 ms
Running Task3 priority[60]  at : 4 ms
Running Task3 priority[60]  at : 5 ms
Running Task3 priority[60]  at : 6 ms
Running Task3 priority[60]  at : 7 ms
Running Task3 priority[60]  at : 8 ms
Running Task3 priority[60]  at : 9 ms
Running Task3 priority[60]  at : 10 ms
Running Task3 priority[60]  at : 11 ms
Running Task3 priority[60]  at : 12 ms
Running Task3 priority[60]  at : 13 ms
Running Task3 priority[60]  at : 14 ms
Running Task3 priority[60]  at : 15 ms
Running Task3 priority[60]  at : 16 ms
Running Task3 priority[60]  at : 17 ms
Running Task3 priority[60]  at : 18 ms
Running Task3 priority[60]  at : 19 ms
Running Task3 priority[60]  at : 20 ms
End of Task3






Le 09/11/2011 01:12, Gilles Chanteperdrix a =C3=A9crit :
> See also ksrc/skins/native/API.CHANGES in xeny omai sources.


