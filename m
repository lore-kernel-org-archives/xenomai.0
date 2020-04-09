Subject: =?utf-8?q?Re=3A_rt=5Ftask=5Funblock=28=29_POSIX_alternative?=
Date: Thu, 09 Apr 2020 17:00:09 +0200
From: =?utf-8?q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
References: <20200407154117.5D7D71C2@centrum.cz>,
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>,
 <20200407171816.E0B3979D@centrum.cz>,
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>,
 <20200408114406.6119E0D9@centrum.cz>
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>
In-Reply-To: <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <20200409170009.5B0DAA77@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Richard_Weinberger?= <richard.weinberger@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

> BTW:
> Why do you think nothing can interrupt a read() from a timerfd?
> If read() blocks on a timerfd the calling thread will be put into
> interruptable sleep.
=C2=A0
"I" was not able to send a signal to the task and interrupt it.
Here is an example. Please let me know, how to improve it to interrupt the =
read() before its timeout:
=C2=A0
#include <math.h>
#include <pthread.h>
#include <stdint.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/timerfd.h>
#include <unistd.h>

#define AUTO_KILL

#define SECOND=C2=A0 1000000000l=C2=A0=C2=A0=C2=A0=C2=A0 // ns
#define PERIOD=C2=A0 (5 * SECOND)=C2=A0=C2=A0=C2=A0 // ns
#define SLEEP=C2=A0=C2=A0 (1 * SECOND)=C2=A0=C2=A0=C2=A0 // ns

using namespace std;

static pid_t mainTask_pid;
static pthread_t task;
static int timer_fd;
static bool end =3D false;

void signalHandler(int signal) {
=C2=A0=C2=A0=C2=A0 int err;
=C2=A0=C2=A0=C2=A0 printf("Signal handler: %d\n", signal);
=C2=A0=C2=A0=C2=A0 end =3D true;
=C2=A0=C2=A0=C2=A0 err =3D pthread_kill(task, SIGINT);
=C2=A0=C2=A0=C2=A0 if (err !=3D 0) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("pthread_kill failed: %d =
(%s)\n", err, strerror(-err));
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 printf("Signal handler end\n");
}

void timediff (struct timespec *result, const struct timespec *t1, const st=
ruct timespec *t2) {
=C2=A0=C2=A0=C2=A0 result->tv_sec =3D t2->tv_sec - t1->tv_sec;
=C2=A0=C2=A0=C2=A0 result->tv_nsec =3D t2->tv_nsec - t1->tv_nsec;
=C2=A0=C2=A0=C2=A0 if (result->tv_nsec >=3D SECOND) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result->tv_nsec -=3D SECOND;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result->tv_sec++;
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 if (result->tv_nsec < 0) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result->tv_nsec +=3D SECOND;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result->tv_sec--;
=C2=A0=C2=A0=C2=A0 }
}

static void *taskHandler(void *cookie) {
=C2=A0=C2=A0=C2=A0 int err;

=C2=A0=C2=A0=C2=A0 printf("Task started\n");

=C2=A0=C2=A0=C2=A0 signal(SIGINT, signalHandler);
=C2=A0=C2=A0=C2=A0 signal(SIGTERM, signalHandler);

=C2=A0=C2=A0=C2=A0 // Get current time
=C2=A0=C2=A0=C2=A0 struct timespec start;
=C2=A0=C2=A0=C2=A0 clock_gettime(CLOCK_MONOTONIC, &start);

=C2=A0=C2=A0=C2=A0 // Set task period
=C2=A0=C2=A0=C2=A0 timer_fd =3D timerfd_create(CLOCK_MONOTONIC, 0);
=C2=A0=C2=A0=C2=A0 struct itimerspec timer_conf;
=C2=A0=C2=A0=C2=A0 timer_conf.it_value.tv_sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D start.tv_sec;
=C2=A0=C2=A0=C2=A0 timer_conf.it_value.tv_nsec=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
start.tv_nsec;
=C2=A0=C2=A0=C2=A0 timer_conf.it_interval.tv_sec=C2=A0=C2=A0 =3D PERIOD / S=
ECOND;
=C2=A0=C2=A0=C2=A0 timer_conf.it_interval.tv_nsec=C2=A0 =3D PERIOD % SECOND=
;
=C2=A0=C2=A0=C2=A0 printf("Set period: %.3gs\n", timer_conf.it_interval.tv_=
sec + (double) timer_conf.it_interval.tv_nsec / SECOND);
=C2=A0=C2=A0=C2=A0 err =3D timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ti=
mer_conf, NULL);
=C2=A0=C2=A0=C2=A0 if (err !=3D 0) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("timerfd_settime failed: =
%d (%s)\n", err, strerror(-err));
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 // Main cycle
=C2=A0=C2=A0=C2=A0 while (!end) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Wait next period
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t ticks;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ::read(timer_fd, &ticks, sizeof =
(ticks));

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Get current time
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct timespec now, result;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock_gettime(CLOCK_MONOTONIC, &=
now);

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Printf wait time
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timediff(&result, &start, &now);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Task livind: %.3gs\n", r=
esult.tv_sec + (double) result.tv_nsec / SECOND);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start =3D now;
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 ::close(timer_fd);
=C2=A0=C2=A0=C2=A0 printf("Task ended\n");
}

/*
=C2=A0*=20
=C2=A0*/
int main(int argc, char** argv) {
=C2=A0=C2=A0=C2=A0 unsigned long overruns;
=C2=A0=C2=A0=C2=A0 int err;

=C2=A0=C2=A0=C2=A0 mlockall(MCL_CURRENT | MCL_FUTURE);

=C2=A0=C2=A0=C2=A0 // Setup signal handler
=C2=A0=C2=A0=C2=A0 signal(SIGINT, signalHandler);
=C2=A0=C2=A0=C2=A0 signal(SIGTERM, signalHandler);

=C2=A0=C2=A0=C2=A0 // Get current process ID
=C2=A0=C2=A0=C2=A0 mainTask_pid =3D getpid();

=C2=A0=C2=A0=C2=A0 // Make main task real-time (prio 1)
=C2=A0=C2=A0=C2=A0 sched_param param;
=C2=A0=C2=A0=C2=A0 memset(&param, 0, sizeof(param));
=C2=A0=C2=A0=C2=A0 param.sched_priority =3D 1;
=C2=A0=C2=A0=C2=A0 err =3D sched_setscheduler(mainTask_pid, SCHED_FIFO, &pa=
ram);
=C2=A0=C2=A0=C2=A0 if (err !=3D 0) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("sched_setscheduler faile=
d: %d (%s)\n", err, strerror(-err));
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto sched_setscheduler_err;
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 // Create new task (prio 2)
=C2=A0=C2=A0=C2=A0 pthread_attr_t tattr;
=C2=A0=C2=A0=C2=A0 pthread_attr_init(&tattr);
=C2=A0=C2=A0=C2=A0 pthread_attr_setinheritsched(&tattr, PTHREAD_EXPLICIT_SC=
HED);
=C2=A0=C2=A0=C2=A0 pthread_attr_setschedpolicy(&tattr, SCHED_FIFO);
=C2=A0=C2=A0=C2=A0 memset(&param, 0, sizeof (param));
=C2=A0=C2=A0=C2=A0 param.sched_priority =3D 2;
=C2=A0=C2=A0=C2=A0 pthread_attr_setschedparam(&tattr, &param);
=C2=A0=C2=A0=C2=A0 err =3D pthread_create(&task, &tattr, taskHandler, NULL)=
;
=C2=A0=C2=A0=C2=A0 if (err !=3D 0) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("pthread_create failed: %=
d (%s)\n", err, strerror(-err));
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto pthread_create_err;
=C2=A0=C2=A0=C2=A0 }

#ifndef AUTO_KILL
=C2=A0=C2=A0=C2=A0 printf("Press ^C to stop!\n");
=C2=A0=C2=A0=C2=A0 do {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pause();
=C2=A0=C2=A0=C2=A0 } while(!end);
#else
=C2=A0=C2=A0=C2=A0 usleep(SLEEP / 1000);

=C2=A0=C2=A0=C2=A0 // Call of signal handler
=C2=A0=C2=A0=C2=A0 err =3D kill(0, SIGINT);=C2=A0 // THE ONLY ONE WHICH WOR=
KS !!!
=C2=A0=C2=A0=C2=A0 //err =3D kill(getpid(), SIGINT);
=C2=A0=C2=A0=C2=A0 //err =3D kill(mainTask_pid, SIGINT);
=C2=A0=C2=A0=C2=A0 //err =3D pthread_kill(pthread_self(), SIGINT);
=C2=A0=C2=A0=C2=A0 //err =3D pthread_kill(task, SIGINT);
=C2=A0=C2=A0=C2=A0 if (err !=3D 0) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("pthread_kill failed: %d =
(%s)\n", err, strerror(-err));
=C2=A0=C2=A0=C2=A0 }
#endif

=C2=A0=C2=A0=C2=A0 printf("Waiting for join\n");
=C2=A0=C2=A0=C2=A0 //pthread_cancel(task);
=C2=A0=C2=A0=C2=A0 pthread_join(task, NULL);
pthread_create_err:
sched_setaffinity_err:
sched_setscheduler_err:
=C2=A0=C2=A0=C2=A0 return 0;
}

