Message-ID: <47CBD35A.6030305@domain.hid>
Date: Mon, 03 Mar 2008 11:30:50 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <47C838A9.8040200@domain.hid>
	<2ff1a98a0802290958k3457d577j8e2ad01079612320@domain.hid>
In-Reply-To: <2ff1a98a0802290958k3457d577j8e2ad01079612320@domain.hid>
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
> On Fri, Feb 29, 2008 at 5:54 PM, Anders Blomdell
> <anders.blomdell@domain.hid> wrote:
>> Hi,
>>
>>  with xenomai 2.4.1 my call to:
>>
>>   rt_cond_wait(&cond, &mutex, 1000);
>>
>>  doesn't timeout (signalling works OK). Kernel version is 2.6.23.12, can it be
>>  due to CONFIG_NO_HZ=y, or have I misunderstood something?
> 
> What is your system timer setting ? Are you running in periodic or
> aperiodic mode ? If aperiodic, 1000 ticks means 1000 ns, that is 1us,
> so rt_cond_wait should return instantaneously.
OK, here comes a simplified program that just outputs A, and then hangs.

#include <sys/mman.h>
#include <native/cond.h>
#include <native/mutex.h>
#include <native/task.h>
#include <native/timer.h>

int main(int argc, char *argv[])
{
  RT_MUTEX mutex;
  RT_COND cond;
  RT_TASK task_main;

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

  rt_mutex_acquire(&mutex, TM_INFINITE);
  printf("A\n");
  rt_cond_wait(&cond, &mutex, 1000);
  printf("B\n");
  rt_mutex_release(&mutex);
  exit(0);
}

Probaly something extremely simple I have overlooked (SIGH).

Regards

Anders


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

