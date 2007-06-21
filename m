Date: Thu, 21 Jun 2007 05:59:38 -0700 (PDT)
From: poornima r <rpoornar@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1560203515-1182430778=:20668"
Content-Transfer-Encoding: 8bit
Message-ID: <190993.20668.qm@domain.hid>
Subject: [Adeos-main] Domain switching latencies
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: wg@domain.hid
Cc: adeos-main@gna.org

--0-1560203515-1182430778=:20668
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Srry the previous mail was sent with wrong subject



       
____________________________________________________________________________________
Boardwalk for $500? In 2007? Ha! Play Monopoly Here and Now (it's updated for today's economy) at Yahoo! Games.
http://get.games.yahoo.com/proddesc?gamekey=monopolyherenow  
--0-1560203515-1182430778=:20668
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

Received: from [61.95.197.134] by web57003.mail.re3.yahoo.com via HTTP; Thu, 21 Jun 2007 05:53:12 PDT
Date: Thu, 21 Jun 2007 05:53:11 -0700 (PDT)
From: poornima r <rpoornar@domain.hid>
Subject: adeos-main@gna.org
To: wg@domain.hid
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1421968784-1182430391=:75456"
Content-Transfer-Encoding: 8bit
Content-Length: 4733

--0-1421968784-1182430391=:75456
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hello Wolfgang,

We are very thankful to you for providing help and
guidance in running latency testsuites and other
assignments 
We are trying to measure context switching latencies
between primary and secondary domains with changes in
the
latency code as specified in the below link
http://www.mail-archive.com/xenomai@xenomai.org

The following changes are done in the latency code and
the applications are attached
-------------------------------------------------------
1:Measured using linux call printf
err = rt_task_wait_period(&ov);
before = rt_timer_tsc();
printf(" ");
after = rt_timer_tsc();
dt = (long)(after - before);
--------------------------------------------------------
2. Measure using Native API call
err = rt_task_wait_period(&ov);
before = rt_timer_tsc();
rt_task_set_mode (T_PRIMARY, NULL, NULL);
after = rt_timer_tsc();
dt = (long)(after - before);
---------------------------------------------------------
The worst case latencies was around 20 us using printf
call and around 60 us when rt_task_set_mode was called

The results are below
1:Measured using linux call printf
==Sampling period: 1000000 us
== Test mode: periodic user-mode task
== All results in microseconds
xnpod_thread_init Stacksize = 0x2000
xnthread_init, stack size = 0x0xnpod_thread_init
Stacksize = 0x2000
xnthread_init, stack size = 0x0warming up...
  RTT|  00:00:01  (periodic user-mode task, 1000000 us
period, priority 99)
RTH|-----lat min|-----lat avg|-----lat
max|-overrun|----lat best|---lat worst
RTD|      19.020|      19.020|      19.020|       0|  
   19.020|      19.020
RTD|      20.840|      20.840|      20.840|       0|  
   19.020|      20.840
RTD|      19.500|      19.500|      19.500|       0|  
   19.020|      20.840
RTD|      21.810|      21.810|      21.810|       0|  
   19.020|      21.810
RTD|      19.545|      19.545|      19.545|       0|  
   19.020|      21.810
RTD|      20.655|      20.655|      20.655|       0|  
   19.020|      21.810
RTD|      19.485|      19.485|      19.485|       0|  
   19.020|      21.810
RTD|      21.265|      21.265|      21.265|       0|  
   19.020|      21.810
RTD|      20.190|      20.190|      20.190|       0|  
   19.020|      21.810
RTD|      20.435|      20.435|      20.435|       0|  
   19.020|      21.810
RTD|      19.075|      19.075|      19.075|       0|  
   19.020|      21.810
RTD|      21.460|      21.460|      21.460|       0|  
   19.020|      21.810
RTD|      19.520|      19.520|      19.520|       0|  
   19.020|      21.810
RTD|      21.120|      21.120|      21.120|       0|  
   19.020|      21.810
RTD|      19.515|      19.515|      19.515|       0|  
   19.020|      21.810
RTD|      20.880|      20.880|      20.880|       0|  
   19.020|      21.810
RTD|      19.055|      19.055|      19.055|       0|  
   19.020|      21.810
RTD|      21.195|      21.195|      21.195|       0|  
   19.020|      21.810
RTD|      20.765|      20.765|      20.765|       0|  
   19.020|      21.810
RTD|      20.945|      20.945|      20.945|       0|  
   19.020|      21.810
RTD|      19.960|      19.960|      19.960|       0|  
   19.020|      21.810

2. Measure using Native API call
==Sampling period: 1000000 us
==Test mode: periodic user-mode task
== All results in microseconds
xnpod_thread_init Stacksize = 0x2000
xnthread_init, stack size = 0x0xnpod_thread_init
Stacksize = 0x2000
xnthread_init, stack size = 0x0warming up...
RTT|  00:00:01  (periodic user-mode task, 1000000 us
period, priority 99)
RTH|-----lat min|-----lat avg|-----lat
max|-overrun|----lat best|---lat worst
RTD|      61.155|      61.155|      61.155|       0|  
   61.155|      61.155
RTD|      59.260|      59.260|      59.260|       0|  
   59.260|      61.155
RTD|      66.310|      66.310|      66.310|       0|  
   59.260|      66.310
RTD|      59.555|      59.555|      59.555|       0|  
   59.260|      66.310
RTD|      66.355|      66.355|      66.355|       0|  
   59.260|      66.355
RTD|      59.565|      59.565|      59.565|       0|  
   59.260|      66.355
RTD|      61.230|      61.230|      61.230|       0|  
   59.260|      66.355
RTD|      61.595|      61.595|      61.595|       0|  
   59.260|      66.355
RTD|      61.835|      61.835|      61.835|       0|  
   59.260|      66.355
RTD|      59.365|      59.365|      59.365|       0|  
   59.260|      66.355
RTD|      65.225|      65.225|      65.225|       0|  
   59.260|      66.355
RTD|      59.805|      59.805|      59.805|       0|  
   59.260|      66.355
RTD|      65.260|      65.260|      65.260|       0|  
   59.260|      66.355
RTD|      59.850|      59.850|      59.850|       0|  
   59.260|      66.355
RTD|      60.120|      60.120|      60.120|       0|  
   59.260|      66.355
RTD|      59.875|      59.875|      59.875|       0|  
   59.260|      66.355
RTD|      59.770|      59.770|      59.770|       0|  
   59.260|      66.355
RTD|      61.760|      61.760|      61.760|       0|  
   59.260|      66.355
RTD|      59.940|      59.940|      59.940|       0|  
   59.260|      66.355
RTD|      61.620|      61.620|      61.620|       0|  
   59.260|      66.355
RTD|      60.665|      60.665|      60.665|       0|  
   59.260|      66.355
RTT|  00:00:22  (periodic user-mode task, 1000000 us
period, priority 99)

My doubts are
1. Are the methods followed to measure domain
switching latencies are correct?
2. Are there any other methods to measure context
switching latencies between domains?
3. Why is the difference of around 40 usec in the
above 
methods?
My assumption was rt_task_set_mode() should take less
time when compared to printf (). Because
rt_task_set_mode() involves only switching whereas
during printf() there is switching + printf() function
execution

Thanks and Regards,
Poornima



 
____________________________________________________________________________________
Need Mail bonding?
Go to the Yahoo! Mail Q&A for great tips from Yahoo! Answers users.
http://answers.yahoo.com/dir/?link=list&sid=396546091
--0-1421968784-1182430391=:75456
Content-Type: text/x-csrc; name="latency2.c"
Content-Description: 276044871-latency2.c
Content-Disposition: inline; filename="latency2.c"

#include <sys/mman.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <getopt.h>
#include <time.h>
#include <native/task.h>
#include <native/timer.h>
#include <native/sem.h>
#include <rtdm/rttesting.h>
#include <time.h>
RT_TASK latency_task, display_task;

RT_SEM display_sem;

#define ONE_BILLION  1000000000
#define TEN_MILLION    10000000

long minjitter, maxjitter, avgjitter;
long gminjitter = TEN_MILLION, gmaxjitter = -TEN_MILLION, goverrun = 0;
long long gavgjitter = 0;

long long period_ns =1000000000;
int test_duration = 0;		/* sec of testing, via -T <sec>, 0 is inf */
int data_lines = 21;		/* data lines per header line, -l <lines> to change */
int quiet = 0;			/* suppress printing of RTH, RTD lines when -T given */
int freeze_max = 0;
int priority = T_HIPRIO;
//struct timespec tv1;

#define USER_TASK       0

int test_mode = USER_TASK;
const char *test_mode_names[] = {
	"periodic user-mode task",
	"in-kernel periodic task",
	"in-kernel timer handler"
};

time_t test_start, test_end;	/* report test duration */
int test_loops = 0;		/* outer loop count */


#define MEASURE_PERIOD ONE_BILLION
#define SAMPLE_COUNT (MEASURE_PERIOD / period_ns)

/* Warmup time : in order to avoid spurious cache effects on low-end machines. */
#define WARMUP_TIME 1
int finished = 0;


void latency(void *cookie)
{
	int err, count, nsamples, warmup = 1;
	//tv1.tv_nsec = 10;
	RTIME expected_tsc, period_tsc, start_ticks,before_tsc, after_tsc;
	RT_TIMER_INFO timer_info;

	err = rt_timer_inquire(&timer_info);

	if (err) {
		fprintf(stderr, "latency: rt_timer_inquire, code %d\n", err);
		return;
	}

	nsamples = ONE_BILLION / period_ns;
	period_tsc = rt_timer_ns2tsc(period_ns);
	/* start time: one millisecond from now. */
	start_ticks = timer_info.date + rt_timer_ns2ticks(1000000);
	expected_tsc = timer_info.tsc + rt_timer_ns2tsc(1000000);

	err =
	    rt_task_set_periodic(NULL, start_ticks,
				 rt_timer_ns2ticks(period_ns));

	if (err) {
		fprintf(stderr, "latency: failed to set periodic, code %d\n",
			err);
		return;
	}

	for (;;) {
		long minj = TEN_MILLION, maxj = -TEN_MILLION;
		long long  dt, before, after;
		long overrun = 0;
		long long sumj;
		test_loops++;

		for (count = sumj = 0; count < nsamples; count++) {
			unsigned long ov;

			expected_tsc += period_tsc;
			err = rt_task_wait_period(&ov);
			before = rt_timer_tsc();
			//usleep (10000);
			//nanosleep (&tv1, NULL);
			printf (" ");
			
			after = rt_timer_tsc();
			dt = (long)(after - before);
			if (dt > maxj)
				maxj = dt;
			if (dt < minj)
				minj = dt;
			sumj += dt;

			if (err) {
				if (err != -ETIMEDOUT) {
					fprintf(stderr,
						"latency: wait period failed, code %d\n",
						err);
					rt_task_delete(NULL);	/* Timer stopped. */
				}

				overrun += ov;
				expected_tsc += period_tsc * ov;
			}

			if (freeze_max && (dt > gmaxjitter)
			    && !(finished || warmup)) {
				xntrace_user_freeze(rt_timer_tsc2ns(dt), 0);
				gmaxjitter = dt;
			}
		}

		if (!warmup) {
			minjitter = minj;
			if (minj < gminjitter)
				gminjitter = minj;

			maxjitter = maxj;
			if (maxj > gmaxjitter)
				gmaxjitter = maxj;

			avgjitter = sumj / nsamples;
			gavgjitter += avgjitter;
			goverrun += overrun;
			err = rt_sem_v(&display_sem);
			if (err)
				printf ("Error while releasing the semaphore\n");
		}

		if (warmup && test_loops == WARMUP_TIME) {
			test_loops = 0;
			warmup = 0;
		}
	}
}

void display(void *cookie)
{
	int err, n = 0;
	time_t start;
	char sem_name[16];

	snprintf(sem_name, sizeof(sem_name), "dispsem-%d", getpid());
	err = rt_sem_create(&display_sem, sem_name, 0, S_FIFO);

	if (err) {
		fprintf(stderr,
			"latency: cannot create semaphore: %s\n",
			strerror(-err));
		return;
	}

	time(&start);
	
	if (WARMUP_TIME)
		printf("warming up...\n");

	if (quiet)
		fprintf(stderr, "running quietly for %d seconds\n",
			test_duration);
	for (;;) { 
		long minj, gminj, maxj, gmaxj, avgj;
		err = rt_sem_p(&display_sem, TM_INFINITE);
		if (err) {
			if (err != -EIDRM)
				fprintf(stderr,
					"latency: failed to pend on semaphore, code %d\n",
					err);
			return;
		}

		/* convert jitters to nanoseconds. */
		minj = rt_timer_tsc2ns(minjitter);
		gminj = rt_timer_tsc2ns(gminjitter);
		avgj = rt_timer_tsc2ns(avgjitter);
		maxj = rt_timer_tsc2ns(maxjitter);
		gmaxj = rt_timer_tsc2ns(gmaxjitter);

		if (!quiet) {
			if (data_lines && (n++ % data_lines) == 0) {
				time_t now, dt;
				time(&now);
				dt = now - start - WARMUP_TIME;
				printf
				    ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
				     "priority %d)\n", dt / 3600,
				     (dt / 60) % 60, dt % 60,
				     test_mode_names[test_mode],
				     period_ns / 1000, priority);
				printf("RTH|%12s|%12s|%12s|%8s|%12s|%12s\n",
				       "-----lat min", "-----lat avg",
				       "-----lat max", "-overrun",
				       "----lat best", "---lat worst");
			}
			printf("RTD|%12.3f|%12.3f|%12.3f|%8ld|%12.3f|%12.3f\n",
			       (double)minj / 2000,
			       (double)avgj / 2000,
			       (double)maxj / 2000,
			       goverrun,
			       (double)gminj / 2000, (double)gmaxj / 2000);
		}
	}
}

void cleanup(void)
{
	time_t actual_duration;
	long gmaxj, gminj, gavgj;

	rt_sem_delete(&display_sem);

	gavgjitter /= (test_loops > 1 ? test_loops : 2) - 1;

	gminj = rt_timer_tsc2ns(gminjitter);
	gmaxj = rt_timer_tsc2ns(gmaxjitter);
	gavgj = rt_timer_tsc2ns(gavgjitter);
	time(&test_end);
	actual_duration = test_end - test_start - WARMUP_TIME;
	if (!test_duration)
		test_duration = actual_duration;

	printf
	    ("---|------------|------------|------------|--------|-------------------------\n"
	     "RTS|%12.3f|%12.3f|%12.3f|%8ld|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
	     (double)gminj / 1000, (double)gavgj / 1000, (double)gmaxj / 1000,
	     goverrun, actual_duration / 3600, (actual_duration / 60) % 60,
	     actual_duration % 60, test_duration / 3600,
	     (test_duration / 60) % 60, test_duration % 60);

	exit(0);
}

void sighand(int sig __attribute__ ((unused)))
{
	finished = 1;
}

int main(int argc, char **argv)
{
	int c, err;
	char task_name[16];
	int cpu = 0;

	time(&test_start);
	
	signal(SIGINT, sighand);
	signal(SIGTERM, sighand);
	signal(SIGHUP, sighand);
	signal(SIGALRM, sighand);

	setlinebuf(stdout);

	printf("== Sampling period: %Ld us\n"
	       "== Test mode: %s\n"
	       "== All results in microseconds\n",
	       period_ns / 1000, test_mode_names[test_mode]);

	mlockall(MCL_CURRENT | MCL_FUTURE);
	
	rt_timer_set_mode(TM_ONESHOT);	/* Force aperiodic timing. */
	snprintf(task_name, sizeof(task_name), "display-%d", getpid());
	err = rt_task_create(&display_task, task_name, 0, 0, T_FPU);

	if (err) {
		fprintf(stderr,
			"latency: failed to create display task, code %d\n",
			err);
		return 0;
	}

	err = rt_task_start(&display_task, &display, NULL);

	if (err) {
		fprintf(stderr,
			"latency: failed to start display task, code %d\n",
			err);
		return 0;
	}

	snprintf(task_name, sizeof(task_name), "sampling-%d", getpid());
	err =
	rt_task_create(&latency_task, task_name, 0, priority,
				   T_FPU | cpu);

	if (err) {
		fprintf(stderr,
			"latency: failed to create latency task, code %d\n",
			err);
		return 0;
	}

	err = rt_task_start(&latency_task, &latency, NULL);

	if (err) {
		fprintf(stderr,
			"latency: failed to start latency task, code %d\n",
			err);
		return 0;
	}

	while (!finished)
		pause();

	cleanup();

	return 0;
}

--0-1421968784-1182430391=:75456
Content-Type: text/x-csrc; name="latency1.c"
Content-Description: 336783122-latency1.c
Content-Disposition: inline; filename="latency1.c"

#include <sys/mman.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <getopt.h>
#include <time.h>
#include <native/task.h>
#include <native/timer.h>
#include <native/sem.h>
#include <rtdm/rttesting.h>

RT_TASK latency_task, display_task;

RT_SEM display_sem;

#define ONE_BILLION  1000000000
#define TEN_MILLION    10000000

long minjitter, maxjitter, avgjitter;
long gminjitter = TEN_MILLION, gmaxjitter = -TEN_MILLION, goverrun = 0;
long long gavgjitter = 0;

long long period_ns =1000000000;
int test_duration = 0;		/* sec of testing, via -T <sec>, 0 is inf */
int data_lines = 21;		/* data lines per header line, -l <lines> to change */
int quiet = 0;			/* suppress printing of RTH, RTD lines when -T given */
int freeze_max = 0;
int priority = T_HIPRIO;

#define USER_TASK       0

int test_mode = USER_TASK;
const char *test_mode_names[] = {
	"periodic user-mode task",
	"in-kernel periodic task",
	"in-kernel timer handler"
};

time_t test_start, test_end;	/* report test duration */
int test_loops = 0;		/* outer loop count */

#define MEASURE_PERIOD ONE_BILLION
#define SAMPLE_COUNT (MEASURE_PERIOD / period_ns)

/* Warmup time : in order to avoid spurious cache effects on low-end machines. */
#define WARMUP_TIME 1
int finished = 0;

void latency(void *cookie)
{
	int err, count, nsamples, warmup = 1;
	RTIME expected_tsc, period_tsc, start_ticks,before_tsc, after_tsc;
	RT_TIMER_INFO timer_info;

	err = rt_timer_inquire(&timer_info);

	if (err) {
		fprintf(stderr, "latency: rt_timer_inquire, code %d\n", err);
		return;
	}

	nsamples = ONE_BILLION / period_ns;
	period_tsc = rt_timer_ns2tsc(period_ns);
	/* start time: one millisecond from now. */
	start_ticks = timer_info.date + rt_timer_ns2ticks(1000000);
	expected_tsc = timer_info.tsc + rt_timer_ns2tsc(1000000);

	err =
	    rt_task_set_periodic(NULL, start_ticks,
				 rt_timer_ns2ticks(period_ns));

	if (err) {
		fprintf(stderr, "latency: failed to set periodic, code %d\n",
			err);
		return;
	}

	for (;;) {
		long minj = TEN_MILLION, maxj = -TEN_MILLION, dt, before, after;
		long overrun = 0;
		long long sumj;
		test_loops++;

		for (count = sumj = 0; count < nsamples; count++) {
			unsigned long ov;

			expected_tsc += period_tsc;
			err = rt_task_wait_period(&ov);
			before = rt_timer_tsc();
			rt_task_set_mode (T_PRIMARY, NULL, NULL);
			after = rt_timer_tsc();
			//dt = (long)(rt_timer_tsc() - expected_tsc);
			dt = (long)(after - before);
			if (dt > maxj)
				maxj = dt;
			if (dt < minj)
				minj = dt;
			sumj += dt;

			if (err) {
				if (err != -ETIMEDOUT) {
					fprintf(stderr,
						"latency: wait period failed, code %d\n",
						err);
					rt_task_delete(NULL);	/* Timer stopped. */
				}

				overrun += ov;
				expected_tsc += period_tsc * ov;
			}

			if (freeze_max && (dt > gmaxjitter)
			    && !(finished || warmup)) {
				xntrace_user_freeze(rt_timer_tsc2ns(dt), 0);
				gmaxjitter = dt;
			}
		}

		if (!warmup) {
			minjitter = minj;
			if (minj < gminjitter)
				gminjitter = minj;

			maxjitter = maxj;
			if (maxj > gmaxjitter)
				gmaxjitter = maxj;

			avgjitter = sumj / nsamples;
			gavgjitter += avgjitter;
			goverrun += overrun;
			err = rt_sem_v(&display_sem);
			if (err)
				printf ("Error while releasing the semaphore\n");
		}

		if (warmup && test_loops == WARMUP_TIME) {
			test_loops = 0;
			warmup = 0;
		}
	}
}

void display(void *cookie)
{
	int err, n = 0;
	time_t start;
	char sem_name[16];

	snprintf(sem_name, sizeof(sem_name), "dispsem-%d", getpid());
	err = rt_sem_create(&display_sem, sem_name, 0, S_FIFO);

	if (err) {
		fprintf(stderr,
			"latency: cannot create semaphore: %s\n",
			strerror(-err));
		return;
	}

	time(&start);
	
	if (WARMUP_TIME)
		printf("warming up...\n");

	if (quiet)
		fprintf(stderr, "running quietly for %d seconds\n",
			test_duration);
	for (;;) { 
		long minj, gminj, maxj, gmaxj, avgj;
		err = rt_sem_p(&display_sem, TM_INFINITE);
		if (err) {
			if (err != -EIDRM)
				fprintf(stderr,
					"latency: failed to pend on semaphore, code %d\n",
					err);
			return;
		}

		/* convert jitters to nanoseconds. */
		minj = rt_timer_tsc2ns(minjitter);
		gminj = rt_timer_tsc2ns(gminjitter);
		avgj = rt_timer_tsc2ns(avgjitter);
		maxj = rt_timer_tsc2ns(maxjitter);
		gmaxj = rt_timer_tsc2ns(gmaxjitter);

		if (!quiet) {
			if (data_lines && (n++ % data_lines) == 0) {
				time_t now, dt;
				time(&now);
				dt = now - start - WARMUP_TIME;
				printf
				    ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
				     "priority %d)\n", dt / 3600,
				     (dt / 60) % 60, dt % 60,
				     test_mode_names[test_mode],
				     period_ns / 1000, priority);
				printf("RTH|%12s|%12s|%12s|%8s|%12s|%12s\n",
				       "-----lat min", "-----lat avg",
				       "-----lat max", "-overrun",
				       "----lat best", "---lat worst");
			}
			printf("RTD|%12.3f|%12.3f|%12.3f|%8ld|%12.3f|%12.3f\n",
			       (double)minj / 2000,
			       (double)avgj / 2000,
			       (double)maxj / 2000,
			       goverrun,
			       (double)gminj / 2000, (double)gmaxj / 2000);
		}
	}
}

void cleanup(void)
{
	time_t actual_duration;
	long gmaxj, gminj, gavgj;

	rt_sem_delete(&display_sem);

	gavgjitter /= (test_loops > 1 ? test_loops : 2) - 1;

	gminj = rt_timer_tsc2ns(gminjitter);
	gmaxj = rt_timer_tsc2ns(gmaxjitter);
	gavgj = rt_timer_tsc2ns(gavgjitter);
	time(&test_end);
	actual_duration = test_end - test_start - WARMUP_TIME;
	if (!test_duration)
		test_duration = actual_duration;

	printf
	    ("---|------------|------------|------------|--------|-------------------------\n"
	     "RTS|%12.3f|%12.3f|%12.3f|%8ld|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
	     (double)gminj / 1000, (double)gavgj / 1000, (double)gmaxj / 1000,
	     goverrun, actual_duration / 3600, (actual_duration / 60) % 60,
	     actual_duration % 60, test_duration / 3600,
	     (test_duration / 60) % 60, test_duration % 60);

	exit(0);
}

void sighand(int sig __attribute__ ((unused)))
{
	finished = 1;
}

int main(int argc, char **argv)
{
	int c, err;
	char task_name[16];
	int cpu = 0;

	time(&test_start);
	
	signal(SIGINT, sighand);
	signal(SIGTERM, sighand);
	signal(SIGHUP, sighand);
	signal(SIGALRM, sighand);

	setlinebuf(stdout);

	printf("== Sampling period: %Ld us\n"
	       "== Test mode: %s\n"
	       "== All results in microseconds\n",
	       period_ns / 1000, test_mode_names[test_mode]);

	mlockall(MCL_CURRENT | MCL_FUTURE);
	
	rt_timer_set_mode(TM_ONESHOT);	/* Force aperiodic timing. */
	snprintf(task_name, sizeof(task_name), "display-%d", getpid());
	err = rt_task_create(&display_task, task_name, 0, 0, T_FPU);

	if (err) {
		fprintf(stderr,
			"latency: failed to create display task, code %d\n",
			err);
		return 0;
	}

	err = rt_task_start(&display_task, &display, NULL);

	if (err) {
		fprintf(stderr,
			"latency: failed to start display task, code %d\n",
			err);
		return 0;
	}

	snprintf(task_name, sizeof(task_name), "sampling-%d", getpid());
	err =
	rt_task_create(&latency_task, task_name, 0, priority,
				   T_FPU | cpu);

	if (err) {
		fprintf(stderr,
			"latency: failed to create latency task, code %d\n",
			err);
		return 0;
	}

	err = rt_task_start(&latency_task, &latency, NULL);

	if (err) {
		fprintf(stderr,
			"latency: failed to start latency task, code %d\n",
			err);
		return 0;
	}

	while (!finished)
		pause();

	cleanup();

	return 0;
}

--0-1421968784-1182430391=:75456--

--0-1560203515-1182430778=:20668--

