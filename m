Message-ID: <47CC2107.8030803@domain.hid>
Date: Mon, 03 Mar 2008 17:02:15 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <47C838A9.8040200@domain.hid>	
	<2ff1a98a0802290958k3457d577j8e2ad01079612320@domain.hid>	
	<47CBD35A.6030305@domain.hid> <47CBDA5B.70603@domain.hid>	
	<47CBDC28.1020907@domain.hid> <47CBDF7E.9050704@domain.hid>	
	<47CBE07D.6010307@domain.hid> <47CBF3B3.30606@domain.hid>
	<2ff1a98a0803030527j19166af8pfd5c6c7c1a9c49bf@domain.hid>
In-Reply-To: <2ff1a98a0803030527j19166af8pfd5c6c7c1a9c49bf@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_cond_wait doesn't timeout (xenomai 2.4.1)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On Mon, Mar 3, 2008 at 1:48 PM, Philippe Gerum <philippe.gerum@domain.hid> wrote:
>> Anders Blomdell wrote:
>>  > Philippe Gerum wrote:
>>  >> Anders Blomdell wrote:
>>  >>> Philippe Gerum wrote:
>>  >>>> Anders Blomdell wrote:
>>  >>>>> Gilles Chanteperdrix wrote:
>>  >>>>>> On Fri, Feb 29, 2008 at 5:54 PM, Anders Blomdell
>>  >>>>>> <anders.blomdell@domain.hid> wrote:
>>  >>>>>>> Hi,
>>  >>>>>>>
>>  >>>>>>>  with xenomai 2.4.1 my call to:
>>  >>>>>>>
>>  >>>>>>>   rt_cond_wait(&cond, &mutex, 1000);
>>  >>>>>>>
>>  >>>>>>>  doesn't timeout (signalling works OK). Kernel version is 2.6.23.12, can it be
>>  >>>>>>>  due to CONFIG_NO_HZ=y, or have I misunderstood something?
>>  >>>>>> What is your system timer setting ? Are you running in periodic or
>>  >>>>>> aperiodic mode ? If aperiodic, 1000 ticks means 1000 ns, that is 1us,
>>  >>>>>> so rt_cond_wait should return instantaneously.
>>  >>>>> OK, here comes a simplified program that just outputs A, and then hangs.
>>  >>>>>
>>  >>>> I can't reproduce this issue with your test code here, but this might be
>>  >>>> the sign of some timer race depending on how fast is the hw.
>>  >>>>
>>  >>>> By hanging, I assume the box is still ok, right?
>>  >>>> If so, could you please send the output of /proc/xenomai/stat,
>>  >>>> /proc/xenomai/sched, /proc/xenomai/timer and /proc/xenomai/timerstat/master?
>>  >>>>
>>  >>>> TIA,
>>  >>>>
>>  >>>> cat /proc/xenomai/stat
>>  >>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>  >>>   0  0      0          108606586  0     00500080  100.0  ROOT/0
>>  >>>   0  0      0          54113426   0     00000082    0.0  rtnet-stack
>>  >>>   0  0      0          1          0     00000082    0.0  rtnet-rtpc
>>  >>>   0  22291  2          3          0     00300186    0.0  main
>>  >>>   0  0      0          107816863  0     00000000    0.0  IRQ22: rt_eepro100
>>  >>>   0  0      0          617309219  0     00000000    0.0  IRQ233: [timer]
>>  >>>
>>  >>>> cat /proc/xenomai/sched
>>  >>> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
>>  >>>   0  0       -1      0          0          master    R          ROOT/0
>>  >>>   0  0       98      0          0          master    W          rtnet-stack
>>  >>>   0  0        0      0          0          master    W          rtnet-rtpc
>>  >>>   0  22291    1      0          0          master    w          main
>>  >>>
>>  >>>> cat /proc/xenomai/timer
>>  >>> status=on+watchdog:setup=0:clock=8061167744254256:timerdev=lapic:clockdev=tsc
>>  >>>
>>  >>>> cat /proc/xenomai/timerstat/master
>>  >>> CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
>>  >>> 0    1049107334  506070537   324149     -          NULL         [host-timer/0]
>>  >>> 0    3358790     3358789     662553305  1000000000  xnpod_watch  [watchdog]
>>  >>> 0    1           1           -          -          xnthread_ti  main
>>  >>>
>>  >>>
>>  >> Thanks. It looks like the timer did tick but the wakeup event was
>>  >> missed. The thread is still waiting for it (stat xxxxxxx6 means
>>  >> delayed+pending, which is the mode rt_cond_wait() sets for the thread).
>>  >> We do have a problem, it seems.
>>  >>
>>  > OK, what can I do to be of assistance?
>>  >
>>
>>  Are you running the application over GDB?
> 
> Cannot this be that the constant (3) used in rthal_timer_program_shot
> is a bit too small ?
Some more info:

The problem is somewhat repeatable, running the following program sometimes
brings back the problem. I'm beginning to think that the problem is that
'rt_task_delete(NULL);' doesn't release all thread resources (i.e. memory usage
grows continually [(i = 4999) => VmSize:   342504 kB). What have I misunderstood
about task deletion?

#include <sys/mman.h>
#include <native/cond.h>
#include <native/mutex.h>
#include <native/task.h>
#include <native/timer.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>


static void suicide(void *arg)
{
  printf("Suicide\n");
  rt_task_delete(NULL);
}

int main(int argc, char *argv[])
{
  RT_MUTEX mutex;
  RT_TASK task_main;
  RT_TASK task;
  RT_COND cond;
  int i;

  mlockall(MCL_CURRENT|MCL_FUTURE);

  rt_task_shadow(&task_main, "main", 1, T_FPU);
  if (rt_mutex_create(&mutex, NULL)) {
    fprintf(stderr, "Failed to create mutex\n");
    exit(1);
  }
  if (rt_cond_create (&cond, NULL)) {
    fprintf(stderr, "Failed to create condition\n");
    exit(1);
  }

  if (rt_timer_set_mode(TM_ONESHOT)) {
    fprintf(stderr, "Failed to set timer mode\n");
    exit(1);
  }

  for  (i = 0 ; i < 5000 ; i++) {
    if (i % 100 == 99) {
      int fd, N;

      char buf[1000];
      fd = open("/proc/self/status", O_RDONLY);
      while ((N = read(fd, buf, 1000)) > 0) {
        write(1, buf, N);
      }
      close(fd);
    }

    if (rt_task_create(&task, NULL, 0, 1, 0)) {
      fprintf(stderr, "Failed to create  task\n");
      exit(1);
    }
    if (rt_task_start(&task, &suicide, NULL)) {
      fprintf(stderr, "Failed to start task\n");
      exit(1);
    }
    rt_mutex_acquire(&mutex, TM_INFINITE);
    printf("i = %d\n", i);
    rt_cond_wait(&cond, &mutex, 5000000);
    printf("wait done\n");
    rt_mutex_release(&mutex);
  }
  exit(0);
}


Regards

/Anders


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

