Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: multipart/mixed; boundary=Apple-Mail-77--687511771
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <1287218938.1854.11.camel@domain.hid>
Date: Sat, 25 Dec 2010 09:56:24 -0800
Message-Id: <EF4812F9-55B3-46C7-B665-91E4E091B9D2@domain.hid>
References: <515034A5-8E42-4ACC-B08E-FC8A05DEB293@domain.hid>
	<1287218938.1854.11.camel@domain.hid>
Subject: Re: [Xenomai-core] hanging in Xenomai 2.5.5
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


--Apple-Mail-77--687511771
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Phiippe,

  thanks so much for your replay -- it took me a moment to get back to =
this problem. Here are some first observations:

1) the problem only occurs when I distribute the communicating processes =
over multiple cores -- in Xenomai 2.5.4, this has never been a problem.

2) The /proc/xenomai/stat looks like:

CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          2349229    0     00500080  100.0  ROOT/0
  1  0      0          20328410   0     00500080  100.0  ROOT/1
  2  0      0          1040321    0     00500080  100.0  ROOT/2
  3  0      0          445786     0     00500080  100.0  ROOT/3
  4  0      0          71162      0     00500080  100.0  ROOT/4
  5  0      0          0          0     00500080  100.0  ROOT/5
  6  0      0          0          0     00500080  100.0  ROOT/6
  7  0      0          0          0     00500080  100.0  ROOT/7
  1  3128   0          91261      0     00300182    0.0  sem1_task
  2  3166   0          90470      0     00300188    0.0  sem2_task
  3  3195   0          45237      0     00300182    0.0  sem3_task
  0  0      0          0          0     00000000    0.0  IRQ56: Analogy =
device
  1  0      0          0          0     00000000    0.0  IRQ56: Analogy =
device
  2  0      0          0          0     00000000    0.0  IRQ56: Analogy =
device
  3  0      0          0          0     00000000    0.0  IRQ56: Analogy =
device
  4  0      0          0          0     00000000    0.0  IRQ56: Analogy =
device
  5  0      0          0          0     00000000    0.0  IRQ56: Analogy =
device
  6  0      0          0          0     00000000    0.0  IRQ56: Analogy =
device
  7  0      0          0          0     00000000    0.0  IRQ56: Analogy =
device
  1  0      0          39326230   0     00000000    0.0  IRQ521: [timer]
  2  0      0          1641532    0     00000000    0.0  IRQ521: [timer]
  3  0      0          1258571    0     00000000    0.0  IRQ521: [timer]
  4  0      0          722843     0     00000000    0.0  IRQ521: [timer]
  5  0      0          780591     0     00000000    0.0  IRQ521: [timer]
  6  0      0          764817     0     00000000    0.0  IRQ521: [timer]
  7  0      0          385421     0     00000000    0.0  IRQ521: [timer]

The three communicating processes are sem1_task, sem2_task, sem3_task -- =
they are currently hanging with 0% CPU

3) the /proc/xenomai/sched look like:

CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
  0  0      idle    -1      -         master     R          ROOT/0
  1  0      idle    -1      -         master     R          ROOT/1
  2  0      idle    -1      -         master     R          ROOT/2
  3  0      idle    -1      -         master     R          ROOT/3
  4  0      idle    -1      -         master     R          ROOT/4
  5  0      idle    -1      -         master     R          ROOT/5
  6  0      idle    -1      -         master     R          ROOT/6
  7  0      idle    -1      -         master     R          ROOT/7
  1  3128   rt      50      -         master     W          sem1_task
  2  3166   rt      50      -         master     R          sem2_task
  3  3195   rt      50      -         master     W          sem3_task

Interestingly, despite sem2_task is supposed to be running, it doesn't.


4) When I try to terminate the three processes, sem2_task would hand and =
I cannot kill it. Interestingly, if I start another program that does a =
similar semaphore communication, sem2_task is finally released. Indeed, =
when I start this other program, the three processes (sem1_task, =
sem2_task, sem3_task) start running again, until they hang again.


5) I appended the little test program I used -- it is called =
xtest_xeno_sem.c

I compile with:

gcc -o xtest -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall =
-pipe -D__XENO__ -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt =
-lrtdk -lnative test_xeno_sem.c

To create three communicating processes on different cores, I execute:

terminal1>  xtest 1 1
terminal2>  xtest 2 1
terminal3>  xtest 3 1


To create three communicating processes on ONE core, I execute:

terminal1>  xtest 1 0
terminal2>  xtest 2 0
terminal3>  xtest 3 0


6) I haven't tested the other commits yet --  this comes next. But maybe =
the information above already tells you all you need to know.

Best wishes, and, as always, a thousand thanks for your kind help!

-Stefan

------------------------------------------- test_xeno_sem.c =
------------------------------------------------------------------------


--Apple-Mail-77--687511771
Content-Disposition: attachment;
	filename=test_xeno_sem.c
Content-Type: application/octet-stream;
	name="test_xeno_sem.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <sys/mman.h>
#include <native/timer.h>
#include <native/task.h>
#include <native/mutex.h>
#include <native/heap.h>
#include <native/sem.h>
#include <pthread.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <rtdk.h>


int
main(int argc, char**argv)

{
  int        rc;
  RT_SEM     sem1;
  RT_SEM     sem2;
  RT_SEM     sem3;
  RT_SEM    *sem_give,*sem_wait;
  char       sem1_name[]="sem1";
  char       sem2_name[]="sem2";
  char       sem3_name[]="sem3";
  long       del;
  int        multicore = 0;

  if (argc < 2) {
    printf("too few arguments\n");
    return 0;
  }
    
  if (argc > 2) {
    sscanf(argv[2],"%d",&multicore);
  }
    
  // lock all of the pages currently and pages that become
  // mapped into the address space of the process
  mlockall(MCL_CURRENT | MCL_FUTURE);

  // establish semaphores
  rc = rt_sem_bind(&sem1,sem1_name,TM_NONBLOCK);
  if (rc) {
    rc = rt_sem_create(&sem1,sem1_name,0,S_FIFO);	
    if (rc) {
      printf("Error: rt_sem_create returned %d\n",rc);
      return 0;
    }
  }

  rc = rt_sem_bind(&sem2,sem2_name,TM_NONBLOCK);
  if (rc) {
    rc = rt_sem_create(&sem2,sem2_name,0,S_FIFO);	
    if (rc) {
      printf("Error: rt_sem_create returned %d\n",rc);
      return 0;
    }
  }

  rc = rt_sem_bind(&sem3,sem3_name,TM_NONBLOCK);
  if (rc) {
    rc = rt_sem_create(&sem3,sem3_name,0,S_FIFO);	
    if (rc) {
      printf("Error: rt_sem_create returned %d\n",rc);
      return 0;
    }
  }

  // create a simple back-and-forth communication
  if (argv[1][0] == '1') {
    printf("wait for 1, give 2\n");
    sem_wait = &sem1;
    sem_give = &sem2;
    del = 1000000;
    rc=rt_task_shadow(NULL,"sem1_task",50,T_FPU|T_CPU(1*multicore));
    if (rc != 0) {
      printf("rc = %d\n",rc);
      return 0;
    }
  } else if (argv[1][0] == '2') {
    printf("wait for 2, give 3\n");
    sem_wait = &sem2;
    sem_give = &sem3;
    del = 2000000;
    rc=rt_task_shadow(NULL,"sem2_task",50,T_FPU|T_CPU(2*multicore));
    if (rc != 0) {
      printf("rc = %d\n",rc);
      return 0;
    }
  } else {
    printf("wait for 3, give 1\n");
    sem_wait = &sem3;
    sem_give = &sem1;
    del = 3000000;
    rc=rt_task_shadow(NULL,"sem3_task",50,T_FPU|T_CPU(3*multicore));
    if (rc != 0) {
      printf("rc = %d\n",rc);
      return 0;
    }
  }

  rt_sem_v(sem_give);

  while (1) {

    rc = rt_sem_p(sem_wait,TM_INFINITE);
    if (rc != 0) {
      printf("rc = %d\n",rc);
      return 0;
    }

    rt_task_sleep((RTIME) del);    

    rt_sem_v(sem_give);

  }


  rt_sem_delete(&sem1);
  rt_sem_delete(&sem2);

  return 0;

}

--Apple-Mail-77--687511771
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii




=
--------------------------------------------------------------------------=
------------------------------------------------------------------

On Oct 16, 2010, at 1:48, Philippe Gerum wrote:

> On Fri, 2010-10-15 at 22:43 -0700, Stefan Schaal wrote:
>> Hi everybody,
>>=20
>>  here is a quick first report on an issue that appeared with Xenomai =
2.5.5 --- NOTE: 2.5.4 (and earlier) DOES NOT have this issue.
>>=20
>> We run multiple real-time processes, synchronized by semaphores and =
interprocess communication using shared memory. All is cleanly =
implemented using the xenomai real-time functions, no mode switches. The =
different processes are distributed on different processors of our =
multi-core machine using rt_task_spawn() with the T_CPU directive.=20
>>=20
>> Up to version 2.5.4, this worked fine.
>>=20
>> With version 2.5.5 (and 2.5.5.1), the processes hang after a few =
seconds of running (CPU consumption goes to zero), and usually one of =
them hangs so badly that it cannot be killed anymore with kill -9 -- =
thus reboot is required.
>>=20
>> The problems happens on BOTH our i386 machine (Dell 8-core, ubuntu =
9.04, kernel 2.6.29.5) AND x86_64 machine (Dell 8 core, ubuntu 9.10, =
kernel 2.6.31.4). Thus, this seems to be specific to the xenomai release =
2.5.5 and higher.
>>=20
>> No "dmesg" print-outs when this error occurs.
>>=20
>> We will try to create a simple test program to illustrate the =
problem, but maybe the issue is already obvious to some of the experts =
on this list.
>>=20
>=20
> $ cat /proc/xenomai/stat
> $ cat /proc/xenomai/sched
>=20
> when the threads hang would help.
>=20
> Additionally, please clone the -stable repo from there:
> git://git.xenomai.org/xenomai-2.5.git
>=20
> then branch+build and test from these commits:
>=20
> - 6a020f5 first; if the bug does not show up anymore, check the next =
one
> - 5e7cfa5; if the bug is still there, try disabling
> CONFIG_XENO_OPT_PRIOCPL to test the basic system and re-check.
>=20
>> Best wishes,
>>=20
>> -Stefan
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
>=20
> --=20
> Philippe.
>=20
>=20


--Apple-Mail-77--687511771--

