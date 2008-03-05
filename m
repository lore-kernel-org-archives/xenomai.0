Message-ID: <47CE7FD5.7080602@domain.hid>
Date: Wed, 05 Mar 2008 12:11:17 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_task_delete of an active task kills main program
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

With the following program:

#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>



static void child(void *arg)
{
  int n = (int)arg;

  printf("start %d, ", n); fflush(stdout);
  rt_task_sleep(100000000L);
  printf("exit %d, ", n); fflush(stdout);
}

int main(int argc, char *argv[])
{
  int i;
  RT_TASK task_main;
  RT_TASK task;

  mlockall(MCL_CURRENT|MCL_FUTURE);
  rt_task_shadow(&task_main, NULL, 1, T_FPU);

  for  (i = 20 ; i > 0 ; i--) {
    if (rt_task_create(&task, NULL, 0, 1, 0)) {
      fprintf(stderr, "Failed to create  task\n");
      exit(1);
    }
    if (rt_task_start(&task, &child, (void*)i)) {
      fprintf(stderr, "Failed to start task\n");
      exit(1);
    }
    rt_task_sleep(1000000 + 10000000L * i);
    printf("delete %d\n", i);
    rt_task_delete(&task);
  }
  exit(0);
}

I get this output:

start 20, exit 20, delete 20
start 19, exit 19, delete 19
start 18, exit 18, delete 18
start 17, exit 17, delete 17
start 16, exit 16, delete 16
start 15, exit 15, delete 15
start 14, exit 14, delete 14
start 13, exit 13, delete 13
start 12, exit 12, delete 12
start 11, exit 11, delete 11
start 10, exit 10, delete 10
start 9, delete 9
Killed

i.e. rt_task_delete of a [still] running task kills the main program. Is this
the expected behaviour? Versions are still:

# uname -r ; cat /proc/xenomai/version
2.6.24.3-ipipe
2.4.2

(The symptoms are the same both with and without Gilles patch to my previous
rt_task_delete problem).

Regards

Anders Blomdell

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

