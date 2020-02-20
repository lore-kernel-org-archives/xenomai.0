From: LOCHE Daniel <dloche@laas.fr>
Subject: rt_task_bind blocking: inter-process ?
Message-ID: <4392cb58-f99f-f1d6-b4c7-58c75040cf01@laas.fr>
Date: Thu, 20 Feb 2020 14:29:27 +0100
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone,

I a currently factoring my application to go from a multi-thread one to 
a multi-process one (C++11).
I am using Xenomai 3.0.5 on Linux Mint 18.04 (on a Intel 8250U 
computer), 90% alchemy library (10% posix).
(either processes or tasks, let's call all of those "tasks" here after 
for easier understanding)

*Context : *Basically, during the setup phase of the execution, 
previously I was reading a list of "task" parameters from a file
and launched consequently the correct amount of rt_task_create() / 
launch() from my main process.
All my RT_TASK links to the threads were stored in the main thread to 
manage them.

Now, I have to go through a fork() for every task, followed by a 
rt_task_shadow(). OK.
But to get in my main process the link to the RT_TASK of every xenomai 
process created, I have to use rt_task_bind().
Issue is here : whatever arguments I give to rt_task_bind(), it blocks 
as long as the searched task name exists... don't know why.

Here is a sample code bellow ... what is wrong exactly ? Is it possible 
to use rt_task_bind with inter-process tasks..? Why the "TM_NONBLOCK" 
does nothing..? Thanks for your help.

Daniel

#include <alchemy/task.h>
#include <alchemy/timer.h>
#include <sys/types.h>
#include <unistd.h>

int main ()

{
     const char* taskNames[3] = {"task0", "task1", "task2"};
     for (int i = 0, i < 3, ++i)
     {
             pid_t pid = fork()
             if (pid) //
             {
                 sleep(1); // wait a little before going through another 
fork.

         } else { // child process
             RT_TASK _t;
             rt_task_shadow(&_t, taskNames[i], 50, 0);
             rt_printf("Success creating task %s", taskNames[i]);
             sleep(15);        /* placeholder, should do real-time stuff
    here, then end process. */
             exit(EXIT_SUCCESS);
         }

    }

     // Only "main" process goes here.

     RT_TASK _t;
     for (int i = 0, i < 3, ++i)
     {
         int ret = rt_task_bind(&t, taskNames[i], TM_NONBLOCK); // <== 
HERE. TM_NONBLOCK, TM_INFINITE or a time value, changes    nothing.... 
never goes here.
         if (ret) printf("Error : could not bind task. Error #%d", ret);
         else printf("Bind to task %s done.", taskNames[i]);
     }
     /* Do stuff here on the binded tasks */
     exit(EXIT_SUCCESS);

}
