Message-ID: <53765654.8010509@ruggedcom.com>
Date: Fri, 16 May 2014 14:17:56 -0400
From: Makarand Pradhan <makarandpradhan@ruggedcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RT_HEAP physical address
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi All,

I am running on MPC8360(powerpc) linux 3.0, xenomai 2.6.3.

I am trying to get the physical address of a heap using rt_heap_inquire. 
All the same, I'm getting a null pointer. Can you pl point out if I'm 
doing something wrong?

Code:

#include <rtdk.h>
#include <stdio.h>
#include <sys/mman.h>
#include <native/heap.h>
#include <native/task.h>

void task1_func(void *arg)
{
         RT_HEAP heap;
         RT_HEAP_INFO info;

         rt_printf("Running\n");

         int rc = rt_heap_create(&heap, "TEST", 1024, H_DMA);

         rt_printf("Heap allocated: heap: %p, rc: %i\n", heap.mapbase, rc);

         if (rt_heap_inquire(&heap, &info) == 0)
         {
                 rt_printf("task1: heap: %p, phy: %x\n", heap.mapbase, 
info.phys_addr);
         }
         else
         {
                 rt_printf("Could not inquire\n");
         }

}

int main(int argc, char **argv)
{
         RT_TASK task1;

         mlockall(MCL_CURRENT|MCL_FUTURE);

         /* Perform auto-init of rt_print buffers if the task doesn't do 
so */
         rt_print_auto_init(1);

         /* Initialise the rt_print buffer for this task explicitly */
         rt_print_init(4096, "Task 1");

         rt_task_spawn(&task1, "T1", 0, 11, 0, task1_func, NULL);

         return 0;
}

O/P:
root@ruggedcom:~# ./a.out
Running
Heap allocated: heap: 0x48073000, rc: 0
task1: heap: 0x48073000, phy: 0
root@ruggedcom:~#

Thanks and Rgds,
Makarand.


