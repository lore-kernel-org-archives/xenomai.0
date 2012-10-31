Message-ID: <50918734.3090605@ruggedcom.com>
Date: Wed, 31 Oct 2012 16:16:52 -0400
From: Makarand Pradhan <makarandpradhan@ruggedcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Improper closure of rt pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi All,

While working with rt pipes I noticed that:

 > When a process that is writing to the real time pipe is killed, I am 
not able to write to the pipe again after restarting the process.
 > When the pipe is closed properly with an fclose, then everything works.
 > The only way to recover the rt pipe was to reboot the system.

Would highly appreciate if you can comment on this behaviour.
Is it the expected behaviour?
Is there a way to recover the rt pipe without rebooting? Anything that 
can be done, on the other side of the pipe after detecting closure? I 
have tried deleting and recreating the pipe with no luck. I am running 
in user space so cannot flush the pipe.

Am attaching code that can be used to reproduce this issue.

I am running linux 3.0.0 on MPC8360.

Thanks and Rgds,
Makarand.


Real time task creating the pipe and reading the pipe:

rt_pipe.c
#include <xenomai/asm-generic/bits/current.h>
#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/mutex.h>
#include <native/timer.h>
#include <native/pipe.h>
#include <rtdk.h>
#include <stdlib.h>
#include <unistd.h>

RT_PIPE rt_pipe_1;
#define PIPE_NAME "pn"
#define PIPE_MINOR_NO 4

void task1_func(void *arg)
{

     while(true)
     {
         int bytes_read = 0;
         char buff[1024];

         bytes_read = rt_pipe_read(&rt_pipe_1, buff, 1024, TM_INFINITE);
         rt_printf("Read: %i\n", bytes_read);

         if (0 == bytes_read)
         {
             int rc = 0;
             // Delete and recreate.
             rc = rt_pipe_delete(&rt_pipe_1);
             rt_printf("Pipe delete: %i\n", rc);
             rc = rt_pipe_create(&rt_pipe_1, PIPE_NAME, PIPE_MINOR_NO, 0);
             rt_printf("Pipe creation: %i\n", rc);
         }
         rt_task_sleep(33333333LL);
     }
}

int main(int argc, char **argv)
{
     RT_TASK task0, task1;
     int rc = 0;

     mlockall(MCL_CURRENT|MCL_FUTURE);

     /* Perform auto-init of rt_print buffers if the task doesn't do so */
     rt_print_auto_init(1);

     rt_task_shadow(&task0, "Task 0", 10, 0);

     rc = rt_pipe_create(&rt_pipe_1, PIPE_NAME, PIPE_MINOR_NO, 0);
     rt_printf("Pipe creation: %i\n", rc);

     printf("Spawning: task1\n");
     rt_task_spawn(&task1, "TASK1", 10, 0, 0, task1_func, NULL);

     while (1) {
         rt_task_sleep(5000000LL);
     }
}



Linux thread that can be killed to cause the problem:

cat pipe_client.c
#include <xenomai/asm-generic/bits/current.h>
#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/mutex.h>
#include <native/timer.h>
#include <native/pipe.h>
#include <rtdk.h>
#include <stdlib.h>
#include <unistd.h>

#define PIPE_NAME "/proc/xenomai/registry/native/pipes/pn"
#define PIPE_MINOR_NO 4

int main(int argc, char **argv)
{

     FILE *fp;

     fp = fopen(PIPE_NAME, "r+");

     while (1==1)
     {

         printf("fp: %p\n", fp);

         fwrite("Test", 1, 4, fp);

         sleep(5);

     }

     fclose(fp);

     return 0;

}

-- 
___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged information.  If you are
not the intended recipient, please notify the sender immediately by return e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a person other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  


