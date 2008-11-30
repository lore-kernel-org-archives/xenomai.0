Message-ID: <493306F5.2080605@domain.hid>
Date: Sun, 30 Nov 2008 22:34:45 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010804080604090804090907"
Subject: [Xenomai-help] pthread cancelation and scheduling magics
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

This is a multi-part message in MIME format.
--------------010804080604090804090907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I have written the attached test program to cancel Xenomai POSIX
threads. The "calc_task" does some busy work, which the higher priority
task "ctrl_task" interrupts and aborts after some time. The program does
not behave like I expect and it also behaves differently on my PowerPC
and ARM test system. The "calc_task" continues after calling
pthread_cancel() in "ctrl_task". On ARM, the behaviour is even more
wired. Is there anything wrong in my test program or anything else I
should care of?

Thanks.

Wolfgang.

--------------010804080604090804090907
Content-Type: text/x-csrc;
 name="cancel-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cancel-test.c"

/*
 * Test program for thread cancelation
 */

#include <execinfo.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <sys/mman.h>

#ifndef __XENO__
#define rt_printf printf
#else
#include <rtdk.h>
#endif

#define USE_SIGXCPU
//#define USE_EXPLICIT_SCHED
#define CTRL_PRIO 39
#define CALC_PRIO 38

static pthread_t calc_thread;
static pthread_t ctrl_thread;

volatile unsigned long count = 0;
static int load_ms = 2500;

void check_err(char *string, int err)
{
	if (err) {
		printf("Failed with %d at %s", err, string);
		exit(1);
	}
}

static void create_load_100ms(void)
{
	struct timespec now, stop;

	clock_gettime(CLOCK_MONOTONIC, &stop);
	stop.tv_nsec += 100000000;
	if (stop.tv_nsec >= 1000000000) {
		stop.tv_nsec -= 1000000000;
		stop.tv_sec++;
	}

	while (1) {
		clock_gettime(CLOCK_MONOTONIC, &now);
		if (now.tv_sec > stop.tv_sec)
			break;
		else if (now.tv_sec == stop.tv_sec &&
			 now.tv_nsec >= stop.tv_nsec)
			break;
	}
}

void *ctrl_func(void *parm)
{
	struct timespec ts;
#ifndef USE_EXPLICIT_SCHED
	struct sched_param param;

	memset(&param, 0 , sizeof(param));
	param.sched_priority = CTRL_PRIO;
	pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
#endif
#ifdef __XENO__
	pthread_set_name_np(pthread_self(), __func__);
#ifdef USE_SIGXCPU
	pthread_set_mode_np(0, PTHREAD_WARNSW);
#endif
#endif
	rt_printf("%s: started at count %d\n", __func__, count);

	ts.tv_sec = load_ms / 1000;
	ts.tv_nsec = (load_ms % 1000) * 1000000;
	rt_printf("%s: sleeping for %dsec %dns\n", __func__,
		  ts.tv_sec, ts.tv_nsec);
	nanosleep(&ts, NULL);
	rt_printf("%s: cancel at count %ld\n", __func__, count);
	pthread_cancel(calc_thread);
	rt_printf("%s: stopped at count %ld\n", __func__, count);

	return NULL;
}
void *calc_func(void *parm)
{
	int rc , count_max;
#ifndef USE_EXPLICIT_SCHED
	struct sched_param param;
#endif

#ifndef USE_EXPLICIT_SCHED
	memset(&param, 0 , sizeof(param));
	param.sched_priority = CALC_PRIO;
	pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
#endif
#ifdef __XENO__
	pthread_set_name_np(pthread_self(), __func__);
#ifdef USE_SIGXCPU
	pthread_set_mode_np(0, PTHREAD_WARNSW);
#endif
#endif
	rc = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
	check_err("pthread_setcanceltype()\n", rc);
	rc = pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
	check_err("pthread_setcanceltype()\n", rc);

	count_max = 2 * load_ms / 100;
	rt_printf("%s: counting till %d\n", __func__, count_max);
	while (count < count_max) {
		create_load_100ms();
		rt_printf("%s: at count %ld\n", __func__, count);
		count++;
	}

	rt_printf("%s: stopped at count %ld\n", __func__, count);

	return NULL;
}

#ifdef USE_SIGXCPU
void mode_switch_handler(int sig)
{
        void *bt[32];
        int nentries;

        /* Dump a backtrace of the frame which caused the switch to
           secondary mode: */
        nentries = backtrace(bt,sizeof(bt) / sizeof(bt[0]));
        backtrace_symbols_fd(bt, nentries, fileno(stdout));
}
#endif

int main(int argc, char **argv)
{
	int rc = 0;
	void *status;
#ifdef USE_EXPLICIT_SCHED
	pthread_attr_t calc_attr, ctrl_attr;
	struct sched_param calc_param, ctrl_param;
#endif

	if (argc == 2)
		load_ms = atoi(argv[1]);

	/* Lock process memory */
	mlockall(MCL_CURRENT | MCL_FUTURE);

#ifdef USE_SIGXCPU
	signal(SIGXCPU, mode_switch_handler);
#endif
#ifdef __XENO__
	/* We use rt_printf() for debugging real-time code */
	rt_print_auto_init(1);
	rt_printf("Real-Time debugging started\n");
#endif

#ifdef USE_EXPLICIT_SCHED
	memset(&ctrl_param, 0 , sizeof(ctrl_param));
	pthread_attr_init(&ctrl_attr);
	pthread_attr_setschedpolicy(&ctrl_attr, SCHED_FIFO);
 	ctrl_param.sched_priority = CTRL_PRIO;
	pthread_attr_setschedparam(&ctrl_attr, &ctrl_param);
	pthread_attr_setinheritsched(&ctrl_attr, PTHREAD_EXPLICIT_SCHED);
	rc = pthread_create(&ctrl_thread, &ctrl_attr, ctrl_func, NULL);
#else
	rc = pthread_create(&ctrl_thread, NULL, ctrl_func, NULL);
#endif
	check_err("pthread_create()\n", rc);

#ifdef USE_EXPLICIT_SCHED
	memset(&calc_param, 0 , sizeof(calc_param));
	pthread_attr_init(&calc_attr);
	pthread_attr_setschedpolicy(&calc_attr, SCHED_FIFO);
	calc_param.sched_priority = CALC_PRIO;
	pthread_attr_setschedparam(&calc_attr, &calc_param);
	pthread_attr_setinheritsched(&calc_attr, PTHREAD_EXPLICIT_SCHED);
	rc = pthread_create(&calc_thread, &calc_attr, calc_func, NULL);
#else
	rc = pthread_create(&calc_thread, NULL, calc_func, NULL);
#endif
	check_err("pthread_create()\n", rc);

	rc = pthread_join(calc_thread, &status);
	check_err("pthread_join()\n", rc);

	if (status != PTHREAD_CANCELED)
		printf("Unexpected thread status\n");

	printf("main terminating in 3 seconds...\n");
	sleep(3);
	return 0;
}

--------------010804080604090804090907--

