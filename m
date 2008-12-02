Message-ID: <49355B5D.8070802@domain.hid>
Date: Tue, 02 Dec 2008 16:59:25 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid>
	<49330CD3.4090700@domain.hid>	<4933BAE2.3000502@domain.hid>
	<4933F1A4.8060209@domain.hid>
	<4933F18F.7080103@domain.hid> <4933FE5A.5060501@domain.hid>
In-Reply-To: <4933FE5A.5060501@domain.hid>
Content-Type: multipart/mixed; boundary="------------000802000506040207070102"
Subject: Re: [Xenomai-help] pthread cancelation and scheduling magics
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

This is a multi-part message in MIME format.
--------------000802000506040207070102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Gilles,

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>>>> Now, the question is, do you realistically plan to write an application
>>>> which makes no syscall in its real-time loop?
>>> Unlikely, but it may happen in case of programming errors. Anyhow, the
>>> pthreads will run legacy code and it would be a pain to add
>>> pthread_testcancel where necessary. But maybe there is a more elegant
>>> and simple solution to do a defined exit/abort.
>> In case of programming error, enable the xenomai watchdog, it will
>> forcibly kill the problematic thread.
> 
> To give you a more complete answer: most blocking functions are
> cancellation points in the PTHREAD_CANCEL_DEFERRED case, so, you
> probably do not need to add pthread_testcancel at all. The only
> exception is pthread_mutex_lock: this way, cancellation happens for well
> defined mutex states, and you may install cleanup handlers with
> pthread_cleanup_push/pthread_cleanup_pop if ever a thread may be
> destroyed while holding a mutex. With PTHREAD_CANCEL_ASYNCHRONOUS, the
> situation is not that clean.

Well, there seems something wrong with it, also PTHREAD_CANCEL_DEFERRED
with pthread_testcancel does not work reliably and consistently and it
still behaves different on my ARM and PowerPC systems. I have attached
my revised test program allowing to enable/disable various method of
thread creation, setup and cancellation. They all work fine with the
Linux POSIX libraries. With Xenomai, only a few work as expected on my
ARM and PowerPC test systems. It would be nice if somebody could test it
on a X86 system. Maybe there is still something wrong with my test program.
I'm also puzzled why pthread_setschedparam() does make a mode switch to
secondary mode (sometimes).

Wolfgang.




--------------000802000506040207070102
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

//#define USE_SIGXCPU
//#define USE_EXPLICIT_SCHED
#define CANCEL_TYPE PTHREAD_CANCEL_DEFERRED
//#define CANCEL_TYPE PTHREAD_CANCEL_ASYNCHRONOUS
#define USE_TEST_CANCEL

#define CTRL_PRIO 39
#define CALC_PRIO 38

static pthread_t calc_thread;
static pthread_t ctrl_thread;

volatile unsigned long count = 0;
static int load_ms = 2500;
static int calc_exit;

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
#ifdef USE_TEST_CANCEL
		pthread_testcancel();
#endif
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
#endif
	int rc;

#ifdef __XENO__
	pthread_set_name_np(pthread_self(), __func__);
#ifdef USE_SIGXCPU
	pthread_set_mode_np(0, PTHREAD_WARNSW);
#endif
#endif
#ifndef USE_EXPLICIT_SCHED
	memset(&param, 0 , sizeof(param));
	param.sched_priority = CTRL_PRIO;
	rc = pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
	check_err("pthread_setschedparam()\n", rc);
#endif
	rt_printf("%s: started at count %ld\n", __func__, count);

	ts.tv_sec = load_ms / 1000;
	ts.tv_nsec = (load_ms % 1000) * 1000000;
	rt_printf("%s: sleeping for %ldsec %ldns\n", __func__,
		  (long)ts.tv_sec, (long)ts.tv_nsec);
	nanosleep(&ts, NULL);
	if (!calc_exit) {
		rt_printf("%s: cancel at count %ld\n", __func__, count);
		pthread_cancel(calc_thread);
	}
	rt_printf("%s: stopped at count %ld\n", __func__, count);

	return NULL;
}
void *calc_func(void *parm)
{
	int rc , count_max;
#ifndef USE_EXPLICIT_SCHED
	struct sched_param param;

	memset(&param, 0 , sizeof(param));
	param.sched_priority = CALC_PRIO;
	rc = pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
	check_err("pthread_setschedparam()\n", rc);
#endif
#ifdef __XENO__
	pthread_set_name_np(pthread_self(), __func__);
#ifdef USE_SIGXCPU
	pthread_set_mode_np(0, PTHREAD_WARNSW);
#endif
#endif
#ifdef CANCEL_TYPE
	rc = pthread_setcanceltype(CANCEL_TYPE, NULL);
	check_err("pthread_setcanceltype()\n", rc);
#endif

	count_max = 2 * load_ms / 100;
	rt_printf("%s: counting till %d\n", __func__, count_max);
	while (count < count_max) {
		create_load_100ms();
		rt_printf("%s: at count %ld\n", __func__, count);
		count++;
	}

	rt_printf("%s: stopped at count %ld\n", __func__, count);

	calc_exit = 1;

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

	printf("main terminating in 2 seconds...\n");
	sleep(3);
	return 0;
}

--------------000802000506040207070102
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

APP := cancel-test

CFLAGS = -Wall -O0 -g

ifeq ($(XENO),)

CC = gcc
LDFLAGS = -lpthread -lrt

else

XENOCONFIG = \
$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config 2>/dev/null)

CC = $(shell $(XENOCONFIG) --cc)
LD = $(patsubst %-gcc,%-ld,$(CC))
CFLAGS += $(shell $(XENOCONFIG) --posix-cflags)
LDFLAGS = $(shell $(XENOCONFIG) --posix-ldflags) -lrtdk
LDFLAGS += -Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)

endif

all: $(APP)

$(APP): % : %.c
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)

clean:
	$(RM) $(APP)

--------------000802000506040207070102--

