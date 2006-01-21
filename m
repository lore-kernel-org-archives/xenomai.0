Message-ID: <43D265A8.1020407@domain.hid>
Date: Sat, 21 Jan 2006 17:47:36 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid>
In-Reply-To: <43D21144.8040005@domain.hid>
Content-Type: multipart/mixed; boundary="------------030709070708030501080508"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030709070708030501080508
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
[...]
> PS: Out of curiosity I also checked RTAI's migration mechanism in this
> regard. It's similar except for the fact that it does the gatekeeper's
> work in the Linux scheduler's tail (i.e. after the next context switch).
> And RTAI seems it suffers from the very same race. So this is either a
> fundamental issue - or I'm fundamentally wrong.


Well, most of the stuff you guys talk about in this thread is still
beyond my level, but out of curiosity I ported the SEM example to
RTAI (see attached sem.c)
I couldn't come up with something similar to rt_sem_inquire and
rt_task_inquire in RTAI (in "void output(char c)")...
Anyway, unless I haven't missed something else important while
porting, the example runs flawlessly on RTAI 3.3test3 (kernel 2.6.15).

Best regards,
Hannes.

--------------030709070708030501080508
Content-Type: text/x-csrc;
 name="sem.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sem.c"

/* TEST_SEM.C ported to RTAI3.3*/

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <math.h>
#include <values.h>

#include <sys/mman.h>

#include <rtai.h>
#include <rtai_sched.h>
#include <rtai_sem.h>

int fd, err;
int t0end = 1;
int t1end = 1;

SEM *s, *m;
float tmax = 1.0e9;

#define CHECK(arg) check(arg, __LINE__)

int check(int r, int n)
{
    if (r != 0)
        fprintf(stderr, "L%d: %s.\n", n, strerror(-r));
    return(r);
}

void output(char c) {
    static int cnt = 0;
    int n;
    char buf[2];
    buf[0] = c;
    if (cnt == 80) {
        buf[1] = '\n';
        n = 2;
        cnt = 0;
    }
    else {
        n = 1;
        cnt++;
    }
/*   
    CHECK(rt_sem_inquire(&m, &seminfo));
    if (seminfo.count != 0) {
        RT_TASK_INFO taskinfo;
        CHECK(rt_task_inquire(NULL, &taskinfo));
        fprintf(stderr, "ALERT: No lock! (count=%ld) Offending task: %s\n",
                seminfo.count, taskinfo.name);
    }
*/  
    if (write(fd, buf, n) != n) {
        fprintf(stderr, "File write error.\n");
        CHECK( rt_sem_signal(s) );
    }
   
}

static void *task0(void *args) {
   RT_TASK *handler;

   if (!(handler = rt_task_init_schmod(nam2num("T0HDLR"), 0, 0, 0, SCHED_FIFO, 0xF))) {
      printf("CANNOT INIT HANDLER TASK > T0HDLR <\n");
      exit(1);
   }
   rt_allow_nonroot_hrt();
   mlockall(MCL_CURRENT | MCL_FUTURE);
   rt_make_hard_real_time();
   t0end = 0;
   rt_task_use_fpu(handler, TASK_USE_FPU );
   while ( !t0end ) {
       rt_sleep((float)rand()*tmax/(float)RAND_MAX);
       rt_sem_wait(m);
       output('0');
       CHECK( rt_sem_signal(m) );
   }
   rt_make_soft_real_time();
   rt_task_delete(handler);
   return 0;
}

static void *task1(void *args) {
   RT_TASK *handler;
   if (!(handler = rt_task_init_schmod(nam2num("T1HDLR"), 0, 0, 0, SCHED_FIFO, 0xF))) {
      printf("CANNOT INIT HANDLER TASK > T1HDLR <\n");
      exit(1);
   }
   rt_allow_nonroot_hrt();
   mlockall(MCL_CURRENT | MCL_FUTURE);
   rt_make_hard_real_time();
   t1end = 0;
   rt_task_use_fpu(handler, TASK_USE_FPU );
   while ( !t1end ) {
       rt_sleep((float)rand()*tmax/(float)RAND_MAX);
       rt_sem_wait(m);
       output('1');
       CHECK( rt_sem_signal(m) );
   }
   rt_make_soft_real_time();
   rt_task_delete(handler);
   return 0;
}


void sighandler(int arg)
{
    CHECK(rt_sem_signal(s));
}

int main(int argc, char *argv[])
{
   RT_TASK *maint; //, *squaretask;
   int t0, t1;
      
   if ((fd = open("dump.txt", O_CREAT | O_TRUNC | O_WRONLY)) < 0)
        fprintf(stderr, "File open error.\n");
   else {
      if (argc == 2) {
         tmax = atof(argv[1]);
         if (tmax == 0.0)
            tmax = 1.0e7;
      }
      rt_set_oneshot_mode();
      start_rt_timer(0);
      m = rt_sem_init(nam2num("MSEM"), 1);
      s = rt_sem_init(nam2num("SSEM"), 0);
      signal(SIGINT, sighandler);
      if (!(maint = rt_task_init(nam2num("MAIN"), 1, 0, 0))) {
         printf("CANNOT INIT MAIN TASK > MAIN <\n");
         exit(1);
      }
      t0 = rt_thread_create(task0, NULL, 10000);  // create thread
      while (t0end) {   // wait until thread went to hard real time
         usleep(100000);
      }
      t1 = rt_thread_create(task1, NULL, 10000);  // create thread
      while (t1end) {   // wait until thread went to hard real time
         usleep(100000);
      }   
      printf("Running for %.2f seconds.\n", (float)MAXLONG/1.0e9);
   
      rt_sem_wait(s);
   
      signal(SIGINT, SIG_IGN);
      t0end = 1;
      t1end = 1;
      printf("TEST ENDS\n");
      CHECK( rt_thread_join(t0) );
      CHECK( rt_thread_join(t1) );
      CHECK(rt_sem_delete(s));
      CHECK(rt_sem_delete(m));
      CHECK( rt_task_delete(maint) );
       close(fd);
   }
   return 0;
}



--------------030709070708030501080508--

