From: Hemal C.Bavishi <Hemal.Bavishi@domain.hid>
Date: Mon, 16 Aug 2010 20:12:32 +0530
Message-ID: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065792@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Task execution order
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I have written small test program to test the execution order of task as pe=
r activation but it's executing not as per order defined in the program. Fo=
r your reference, I have mentioned the output of the program

 Task 1 is created
 Task 2 is created
 Task 3 is created
 Tasks are not executed yet =


 Task 3 is entered
 end of task 3
 Task 1 is entered
 end of task 1
 Task 2 is entered
 end of task 2
 Execution complete - success


Logic:

On entry to main, I am increasing the priority of main thread to 99 and the=
n activating all the task with the same priority one by one. After that, I =
am changing the main thread priority to 1 to check the execution order. Is =
there any way to run the tasks as per the activation order?

For your reference, I have attached the test program,


#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/timer.h>

RT_TASK demo_task1;
RT_TASK demo_task2;
RT_TASK demo_task3;

volatile unsigned int dummy =3D 0;
int main_policy;
struct sched_param main_param;
/* NOTE: error handling omitted. */



void task3(void *arg)
{
        printf("\n Task 3 is entered");
        printf("\n end of task 3");
        rt_task_delete(&demo_task3);   =

}


void task2(void *arg)
{
        printf("\n Task 2 is entered");
        /*
         * Arguments: &task,
         *            name,
         *            stack size (0=3Ddefault),
         *            priority,
         *            mode (FPU, start suspended, ...)
         */
 =


        /*
         * Arguments: &task,
         *            task function,
         *            function argument
         */
        //rt_task_start(&demo_task3, &task3, NULL);
       =

        printf("\n end of task 2");
        rt_task_delete(&demo_task2);   =

}


void task1(void *arg)
{
        printf("\n Task 1 is entered");
        /*
         * Arguments: &task,
         *            name,
         *            stack size (0=3Ddefault),
         *            priority,
         *            mode (FPU, start suspended, ...)
         */


 =


        /*
         * Arguments: &task,
         *            task function,
         *            function argument
         */
        //rt_task_start(&demo_task2, &task2, NULL);
        dummy =3D 1;
        printf("\n end of task 1");
        rt_task_delete(&demo_task1);   =


}
int main(int argc, char* argv[])
{
        /* Avoids memory swapping for this program */
        mlockall(MCL_CURRENT|MCL_FUTURE);
        main_policy =3D SCHED_FIFO;
        main_param.sched_priority =3D 99;
        pthread_setschedparam(pthread_self(), main_policy, &main_param);

        /*
         * Arguments: &task,
         *            name,
         *            stack size (0=3Ddefault),
         *            priority,
         *            mode (FPU, start suspended, ...)
         */
        printf("\n Task 1 is created");
        rt_task_create(&demo_task1, "mytask1", 0, 2, 0);
        printf("\n Task 2 is created");
        rt_task_create(&demo_task2, "mytask2", 0, 2, 0);
        printf("\n Task 3 is created");
        rt_task_create(&demo_task3, "mytask3", 0, 2, 0);

        /*
         * Arguments: &task,
         *            task function,
         *            function argument
         */
        rt_task_start(&demo_task1, &task1, NULL);
        rt_task_start(&demo_task2, &task2, NULL);
        rt_task_start(&demo_task3, &task3, NULL);
        printf("\n Tasks are not executed yet \n");
        main_policy =3D SCHED_FIFO;
        main_param.sched_priority =3D 1;
        pthread_setschedparam(pthread_self(), main_policy, &main_param);
        printf("\n Execution complete - success \n");
        return(0);
}



