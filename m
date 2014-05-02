Message-ID: <53639F52.2070108@gmail.com>
Date: Fri, 02 May 2014 19:06:18 +0530
From: Arun Kumar Gupta <arungupta143@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Is everything inside a function(task wchi made as a
 RT_task) is comes under Realtime ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello, I am new here,

I want to know if i make a function(task) to real time,

Is everything inside that function is in realtime scheduler or not ?
For Ex.


/*#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/timer.h>

#include  <rtdk.h>
*/
#include "../../include/Controller/statcom.h"

RT_TASK demo_task;

void demo(void *arg){
   RT_TASK *curtask;
   RT_TASK_INFO curtaskinfo;

   // hello world
   rt_printf("Hello World!\n");
     printf("Something");
     printf("Something");
printf("Something");


   // inquire current task
   curtask=rt_task_self();
   rt_task_inquire(curtask,&curtaskinfo);

   // print task name
   rt_printf("Task name : %s \n", curtaskinfo.name);
}

int main(void)
{
   char  str[10] ;

   // Perform auto-init of rt_print buffers if the task doesn't do so
   rt_print_auto_init(1);

   // Lock memory : avoid memory swapping for this program
   mlockall(MCL_CURRENT|MCL_FUTURE);

   rt_printf("start task\n");

   /*
    * Arguments: &task,
    *            name,
    *            stack size (0=default),
    *            priority,
    *            mode (FPU, start suspended, ...)
    */
   sprintf(str,"hello");
   rt_task_create(&demo_task, str, 0, 50, 0);

   /*
    * Arguments: &task,
    *            task function,
    *            function argument
    */
   rt_task_start(&demo_task, &demo, 0);
   return 0;
}


Here i am trying to print "Something" using "printf" will it's priority 
will be as high as "rt_printf"

Here task "demo" is in realtime mode.

it's important to know.

