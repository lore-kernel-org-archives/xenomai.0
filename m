From: Gmail <jiahanchina@gmail.com>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF1EB560-EB26-42CF-896F-A98D1329DFC8@gmail.com>
Date: Sat, 23 Jan 2016 08:44:08 +0800
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: [Xenomai] xenomai 3 rt_pipe_write() returns -ENOMEM (cannot
	allocate memory)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Good day gentleman. I recently switched to xenomai 3 and found a problem =
when I use rt_pipe_write() function.=20

A pipe can be created successfully by rt_pipe_create() but when it comes =
to rt_pipe_write(), the function returns ENOMEM. I used strerror to =
print out the problem and I got the message =A1=B0cannot allocate =
memory=A1=B1.=20

I don=A1=AFt know if it=A1=AFs the problem of the buffer size parameter =
in rt_pipe_create(), rt_pipe_write() or rt_task_create() ?
Or it=A1=AFs the problem of the parameter in config file setting when I =
compile the xenomai kernel?

Here is (some parts of) my code on /* Kernel-side */:

 =
/*************************************************************************=
****************************/
#include <alchemy/task.h>
#include <alchemy/pipe.h>
#include  <trank/rtdk.h>

#define TASK_PRIO    50        =20
#define TASK_MODE  0             =20
#define TASK_STKSZ 10000           /* Stack size (in bytes) */

RT_TASK task_desc;
RT_PIPE pipe_desc;

void task_body(void *arg)
{
  while (1) {   =20
      fprintf(stderr, "Failed: %s\n", =
strerror(-rt_pipe_write(&pipe_desc, "Hello", sizeof("Hello"), =
P_NORMAL)));         =20
     =20
      // Then wait for the reply string "World":=20
      rt_printf("******waiting******\n");

      char buf[200];
      rt_pipe_read(&pipe_desc, buf, 200, TM_INFINITE);
      rt_printf("received msg> %s\n", buf);
                      =20
      sleep(1);               =20
  }
}

=20
int main(int argc, char* argv[])
{
    mlockall(MCL_CURRENT|MCL_FUTURE);
=20
    rt_print_auto_init(1);

    rt_pipe_create(&pipe_desc, "my_pipe", P_MINOR_AUTO, 32);

    rt_task_create(&task_desc, "MyTaskName", TASK_STKSZ, TASK_PRIO, =
TASK_MODE);

    rt_task_start(&task_desc, &task_body, NULL);
}
 =
/*************************************************************************=
****************************/


Here is the setting of the pipe in my config file:
 =
/*************************************************************************=
****************************/
(32)Number of pipe devices
(4096)Number of registry slots
(2048)Size of system heap(Kb)
(64)Size of private heap(Kb)
(64)Size of shared heap(Kb)
(128)Maximum number of POSIX timers per process
 =
/*************************************************************************=
****************************/

Any help could be appreciated.


Thank you in advance.

Han=

