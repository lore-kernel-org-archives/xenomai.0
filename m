MIME-Version: 1.0
From: Jackson Jones <jackson.jones@gmail.com>
Date: Tue, 3 Oct 2017 20:05:38 -0700
Message-ID: <CADXNiGXZ7sCz8ZZ0TUtPGuWzCvdyBueeAm0oqeBWs=WccZk-YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] rt_task_set_affinity causes hang
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Below is an example program that runs fine under xenomai-3.0.3. Under 3.0.5
it hangs when rt_task_set_affinity() is called.

Any ideas?

Thanks,

Jackson

------------------------------------------------------------------------------------------

#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <alchemy/task.h>
#include <alchemy/timer.h>

// periodically prints "hello world" and the task name
void demo(void *arg)
{
  RT_TASK *curtask;
  RT_TASK_INFO curtaskinfo;

  while (1)
  {
    // hello world
    rt_printf("Hello World! ");

    // inquire current task
    curtask=rt_task_self();
    rt_task_inquire(curtask,&curtaskinfo);

    // print task name
    rt_printf("Task name : %s \n", curtaskinfo.name);

    // put task to sleep
    rt_task_sleep(1000000000);
  }
}

int main(int argc, char* argv[])
{

    RT_TASK demo_task;
    cpu_set_t mask;

    // set CPU to affine to
    CPU_ZERO(&mask);    // clear all CPUs
    CPU_SET(3, &mask);    // select CPU 3


    // Lock memory : avoid memory swapping for this program
    //mlockall(MCL_CURRENT|MCL_FUTURE);

    rt_printf("start task\n");

    /*
    * Arguments: &task,
    *            name,
    *            stack size (0=default),
    *            priority,
    *            mode (FPU, start suspended, ...)
    */
    rt_task_create(&demo_task, "demo", 0, 50, 0);

    // set task cpu affinity
    rt_task_set_affinity(&demo_task, &mask);

    /*
    * Arguments: &task,
    *            task function,
    *            function argument
    */
    rt_task_start(&demo_task, &demo, 0);

    pause();

    return 0;
}
