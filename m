Message-ID: <5277C86F.5070603@wanadoo.fr>
Date: Mon, 04 Nov 2013 17:16:47 +0100
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] big deviation on clock_nanosleep wait time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

My configuration is
xenomai-2.6.3 + ipipe-1.18-13, freescale kernel rel_imx_3.0.35_4.0.0, on
the IMX6Q.

I want to use CONFIG_HIGH_RES_TIMERS and CONFIG_HZ=100, which is the
default value for the IMX.

The described issue does not happen when CONFIG_IPIPE is not set.
This happens with a linux task, no other xenomai task is running.

The following linux program performs 1000 calls to clock_nanosleep and
calculates some stats at the end.

When sleeping for delays around 10 to 30 ms the results are pretty good,
the error is pretty much constant and around 0.1 %
but when waiting for 100 to 500 microseconds things get bad, with
sometimes, wake up that happen 40 ms after.

Average 247.354000, error 0.247354%
Deviation 44240.660581, average error 147.354000, max_err 40781.000000


Looking at the log shows that there are about 7 occurrences where the
sleep takes between 3 and 40 ms instead of 0.1 ms .

sample program:

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sched.h>
#include <math.h>

#define TIMESPEC2USEC(t1, t2) \
    ( (unsigned long)(t2.tv_sec * 1000000 + t2.tv_nsec / 1000) - \
      (unsigned long)(t1.tv_sec * 1000000 + t1.tv_nsec / 1000) )

#define NB 1000

int main(int argc, char * argv[]) {

	struct timespec res;
	struct timespec delay, time1, time2;

    	int default_priority;
	sigset_t mask;
	int ix;

	unsigned long total = 0;
	int sleep_time = 100 * 1000; // 0.1 ms

	unsigned long vals[NB];
	double  max_err = 0.0;


	struct sched_param p;

	default_priority = ( sched_get_priority_min(SCHED_FIFO) +
sched_get_priority_max(SCHED_FIFO) ) / 2;

	p.sched_priority = default_priority;

	if ( sched_setscheduler( 0, SCHED_FIFO, &p) != 0 )
	{
        	perror( "sched_setscheduler" );
	        exit(-1);
	}


	if (clock_getres (CLOCK_REALTIME, &res) == -1)
	        perror ("clock_getres: CLOCK_REALTIME");
	else
        	printf ("CLOCK_REALTIME: %ld s, %ld ns\n", res.tv_sec,
res.tv_nsec);

	if (clock_getres (CLOCK_MONOTONIC, &res) == -1)
		perror ("clock_getres: CLOCK_MONOTONIC");
	else
		printf ("CLOCK_MONOTONIC: %ld s, %ld ns\n", res.tv_sec, res.tv_nsec);

	if (clock_getres (CLOCK_PROCESS_CPUTIME_ID, &res) == -1)
	        perror ("clock_getres: CLOCK_PROCESS_CPUTIME_ID");
	else
		printf ("CLOCK_PROCESS_CPUTIME_ID: %ld s, %ld ns\n", res.tv_sec,
res.tv_nsec);

	if (clock_getres (CLOCK_THREAD_CPUTIME_ID, &res) == -1)
		perror ("clock_getres: CLOCK_THREAD_CPUTIME_ID");
	else
		printf ("CLOCK_THREAD_CPUTIME_ID: %ld s, %ld ns\n", res.tv_sec,
res.tv_nsec);

	clock_gettime(CLOCK_MONOTONIC, &time1);

	for (ix=0; ix < NB; ix++)
	{

		delay.tv_sec = 0;
		delay.tv_nsec = sleep_time; // 20 ms

		if (clock_nanosleep(CLOCK_MONOTONIC, /*TIMER_ABSTIME */ 0, &delay,
NULL) != 0)
		{
			perror("clock_nanosleep\n");
			exit(0);
		}

		if (clock_gettime(CLOCK_MONOTONIC, &time2) !=0)
		{
			perror("clock_gettime\n");
			exit(0);
		}

	
		vals[ix] = TIMESPEC2USEC(time1,time2);

		printf("Slept %ld usecs\n", vals[ix]);
		total += vals[ix];

		time1 = time2;
	}

	double average = ((double)total) / NB;

	printf("Average %f, error %f%%\n", average, 100*average/sleep_time);

	// calculates deviation

	double dev = 0.0;
	double err, av_err = 0.0;

	for (ix = 0 ; ix < NB; ix++)
	{
		double diff = vals[ix]-average;
		dev += (diff*diff);

		err = abs(vals[ix]-(sleep_time/1000.0));
		av_err+=err;

		if (max_err < err)
			max_err = err;
	}

	printf("Deviation %f, average error %f, max_err %f\n",
		sqrt(dev), av_err/NB, max_err);

	return 0;
}


Best regards
Thierry


