Message-ID: <463EE376.9030702@domain.hid>
Date: Mon, 07 May 2007 10:29:42 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<1178198991.29605.54.camel@domain.hid>
	<463AE79E.2090901@domain.hid>
	<1178281926.29093.93.camel@domain.hid> <463B2A69.7080704@domain.hid>
In-Reply-To: <463B2A69.7080704@domain.hid>
Content-Type: multipart/mixed; boundary="------------020505010207090701030603"
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

This is a multi-part message in MIME format.
--------------020505010207090701030603
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Jan, Philippe,

Attached is my test program, based on cyclictest. I removed all the 
unneeded parts, and set all the options to the right values, as used for 
my test. I use the PPC8540 internal highres timer, but this can be 
disabled by undef-ing the define at the top of the program.
I compiled the program using the same compiler-settings as used by the 
latency program.

The commands I use to run the test are:
/usr/xenomai/bin/latency -P 60
./cyclictest-Xenomai -q

The -q option gives shows the output at the end of the test run, instead 
of the running data, to examine all the recorded data add the -v option. 
The -h option enables the PPC8540 highres timer.

This are the results from a test run using the attached 
cyclictest-Xenomai and the standard latency test (both are run in 
separate terminals):

bash-3.00# ./cyclictest-Xenomai -q -h        
#T: 0 P:80 I:10000 O:  0 C:  100 Min:  -3.181 Avg:  -0.025 Max:    2.392
#T: 1 P:79 I:10000 O:  0 C:  100 Min:  -1.787 Avg:   1.377 Max:  139.257
#T: 2 P:78 I:10000 O:  0 C:  100 Min:  -1.836 Avg:   5.518 Max:  553.623
#T: 3 P:77 I:10000 O:  0 C:  100 Min:  -1.932 Avg:   3.153 Max:  317.275
#T: 4 P:76 I:10000 O:  0 C:  100 Min:  -1.740 Avg:   0.435 Max:   45.203
#T: 5 P:75 I:10000 O:  0 C:  100 Min:  -1.980 Avg:   0.047 Max:    5.443
#T: 6 P:74 I:10000 O:  0 C:  100 Min:  -2.148 Avg:   0.015 Max:    2.537
#T: 7 P:73 I:10000 O:  0 C:  100 Min:  -1.811 Avg:   0.020 Max:    2.440
#T: 8 P:72 I:10000 O:  0 C:  100 Min:  -1.667 Avg:   0.011 Max:    2.416
#T: 9 P:71 I:10000 O:  0 C:  100 Min:  -1.788 Avg:   0.051 Max:    5.347

bash-3.00# /usr/xenomai/bin/latency -P 60
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 60)
RTH|---lat min|---lat avg|---lat max|-overrun|--lat best|--lat worst
RTD|    -5.453|    -4.492|    -2.090|       0|    -5.453|     -2.090
RTD|    -5.381|    -4.492|     3.699|       0|    -5.453|      3.699
RTD|    -5.453|    -4.492|    -1.321|       0|    -5.453|      3.699
RTD|    -5.357|    -4.492|     1.201|       0|    -5.453|      3.699
RTD|    -5.477|    -4.468|     3.003|       0|    -5.477|      3.699
RTD|    -5.405|    -4.516|     1.417|       0|    -5.477|      3.699
RTD|    -5.429|    -4.420|     7.207|       0|    -5.477|      7.207
RTD|    -5.285|    -4.108|    28.588|       0|    -5.477|     28.588
RTD|    -5.429|    -4.324|   770.282|      10|    -5.477|    770.282
RTD|    -5.477|    -4.492|     2.210|      10|    -5.477|    770.282
RTD|    -5.405|    -4.468|    -0.504|      10|    -5.477|    770.282
RTD|    -5.309|    -4.468|    -0.312|      10|    -5.477|    770.282
---|----------|----------|----------|--------|----------------------
RTS|    -5.477|    -4.420|   770.282|      10|    00:00:13/00:00:13

Kind regards,
    Johan Borkhuis

--------------020505010207090701030603
Content-Type: text/x-csrc;
 name="cyclictest-Xenomai.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cyclictest-Xenomai.c"

/*
 * High resolution timer test software
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License Veriosn
 * 2 as published by the Free Software Foundation;
 *
 */

#define VERSION_STRING "V 0.11-Xenomai"

#define USE_PPC8540_TIMER

#include <getopt.h>
#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

#include <linux/unistd.h>

#include <sys/types.h>
#include <sys/mman.h>

#include <native/task.h>

#define USEC_PER_SEC        1000000
#define NSEC_PER_SEC        1000000000

/* Must be power of 2 ! */
#define VALBUF_SIZE     1024*1024

/* Struct to transfer parameters to the thread */
struct thread_param {
    int prio;
    unsigned long max_cycles;
    struct thread_stat *stats;
    int bufmsk;
    unsigned long interval;
};

/* Struct for statistics */
struct thread_stat {
    unsigned long cycles;
    unsigned long cyclesread;
    double min;
    double max;
    double act;
    double avg;
    double *values;
    pthread_t thread;
    int threadstarted;
    RT_TASK task;
    unsigned long overruns;
};

static int shutdown     = 0;
static int hwtimer      = 0;
static int priority     = 80;
static int num_threads  = 10;
static int max_cycles   = 100;
static int verbose      = 0;
static int quiet        = 0;
static int interval     = 10000;

/* 
 * High res timer for PPC 8540
 * Timebase is running at CCB/8.  CCB is running at 333MHz, so TB is running
 * at 41.6667 MHz, which results in 24 nsec/tick
 */
#ifdef USE_PPC8540_TIMER

/* Correction needed: clock is 0.1% off */
#define TB_TICKS_NSEC   ((24.0)*1.001)

__inline__ unsigned long get_tbl(void) {
    unsigned long tbl;
    asm volatile("mftb %0" : "=r" (tbl));
    return tbl;
}

__inline__ unsigned long get_tbu(void) {
    unsigned long tbl;
    asm volatile("mftbu %0" : "=r" (tbl));
    return tbl;
}

void timeStampGet(clockid_t which_clock, struct timespec *curtime)
{
    unsigned long lo, hi, hi2;
    unsigned long long tr;
    long double tmpVal;

    if(hwtimer == 0)
    {
        clock_gettime(which_clock, curtime);
        return;
    }

    do {
        hi = get_tbu();
        lo = get_tbl();
        hi2 = get_tbu();
    } while (hi2 != hi);

    tr = ((unsigned long long) hi << 32) | lo;
    tmpVal = (((long double)tr)*TB_TICKS_NSEC)/1000000000.0;
    curtime->tv_sec = (int)tmpVal;
    curtime->tv_nsec = (int)((tmpVal - (int)tmpVal) * 1000000000);
}
#else
void timeStampGet(clockid_t which_clock, struct timespec *curtime)
{
    clock_gettime(which_clock, curtime);
    return;
}
#endif

static inline void tsnorm(struct timespec *ts)
{
    while (ts->tv_nsec >= NSEC_PER_SEC) {
        ts->tv_nsec -= NSEC_PER_SEC;
        ts->tv_sec++;
    }
}

static double calcdiff(struct timespec t1, struct timespec t2)
{
    double diff;
    diff = USEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
    diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000.0;
    return diff;
}

/*
 * timer thread
 *
 */
void timerthread(void *param)
{
    struct thread_param *par = param;
    struct timespec now, next, interval;
    struct thread_stat *stat = par->stats;
    int n = 1;
    RTIME start_ticks;
    RT_TIMER_INFO timer_info;
    int err;

    interval.tv_sec = par->interval / USEC_PER_SEC;
    interval.tv_nsec = (par->interval % USEC_PER_SEC) * 1000;

    err = rt_timer_inquire(&timer_info);
    if (err) {
        fprintf(stderr, "latency: rt_timer_inquire, code %d\n", err);
        return;
    }

    start_ticks = timer_info.date + rt_timer_ns2ticks(1000000);
    err = rt_task_set_periodic(NULL, start_ticks,
            rt_timer_ns2ticks(par->interval * 1000));
    if (err) {
        fprintf(stderr, "latency: failed to set periodic, code %d\n", err);
        return;
    }

    /* Get current time */
    timeStampGet(CLOCK_MONOTONIC, &now);
    next = now;
    next.tv_sec++;

    stat->threadstarted++;

    while (!shutdown) {
        double diff;
        unsigned long ov;

        if (rt_task_wait_period(&ov))
            break;
        stat->overruns += ov;

        timeStampGet(CLOCK_MONOTONIC, &now);
        if (n) { n= 0; } /* Ignore first period */
        else {
            diff = calcdiff(now, next);
            if (diff < stat->min)
                stat->min = diff;
            if (diff > stat->max)
                stat->max = diff;
            stat->avg += diff;

            stat->act = diff;

            stat->cycles++;

            if (par->bufmsk)
                stat->values[stat->cycles & par->bufmsk] = diff;
        }

        next.tv_sec = now.tv_sec + interval.tv_sec;
        next.tv_nsec = now.tv_nsec + interval.tv_nsec;
        tsnorm(&next);

        if (par->max_cycles && par->max_cycles == stat->cycles)
            break;
    }

    stat->threadstarted = -1;
    return;
}

/* Print usage information */
static void display_help(void)
{
    printf("cyclictest_xenomai %s\n", VERSION_STRING);
    printf("Usage:\n"
           "cyclictest <options>\n\n"
           "-h       --hwtimer         use hardware timer\n"
           "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
           "-l LOOPS --loops=LOOPS     number of loops: default=100\n"
           "-p PRIO  --prio=PRIO       priority of highest prio thread: default=80\n"
           "-q       --quiet           print only a summary on exit\n"
           "-t NUM   --threads=NUM     number of threads: default=10\n"
           "-v       --verbose         output values on stdout for statistics\n"
           "                           format: n:c:v n=tasknum c=count v=value in us\n"
           );
    exit(0);
}

/* Process commandline options */
static void process_options (int argc, char *argv[])
{
    int error = 0;
    for (;;) {
        int option_index = 0;
        /** Options for getopt */
        static struct option long_options[] = {
            {"hwtimer", no_argument, NULL, 'h'},
            {"interval", required_argument, NULL, 'i'},
            {"loops", required_argument, NULL, 'l'},
            {"priority", required_argument, NULL, 'p'},
            {"quiet", no_argument, NULL, 'q'},
            {"threads", required_argument, NULL, 't'},
            {"verbose", no_argument, NULL, 'v'},
            {"help", no_argument, NULL, '?'},
            {NULL, 0, NULL, 0}
        };
        int c = getopt_long (argc, argv, "hi:l:p:qt:vx",
            long_options, &option_index);
        if (c == -1)
            break;
        switch (c) {
        case 'h': hwtimer = 1; break;
        case 'i': interval = atoi(optarg); break;
        case 'l': max_cycles = atoi(optarg); break;
        case 'p': priority = atoi(optarg); break;
        case 'q': quiet = 1; break;
        case 't': num_threads = atoi(optarg); break;
        case 'v': verbose = 1; break;
        case '?': error = 1; break;
        }
    }

    if (priority < 0 || priority > 99 || num_threads < 1)
        error = 1;

    if (error)
        display_help ();
}

static void sighand(int sig)
{
    shutdown = 1;
}

static void print_stat(struct thread_param *par, int index, int verbose)
{
    struct thread_stat *stat = par->stats;

    if (!verbose) {
        if (quiet != 1) {
            printf("%cT:%2d P:%2d I:%ld O:%4ld C:%7lu "
                   "Min:%10.3lf Avg:%10.3lf Max:%10.3lf         \n",
                   quiet == 2 ? '#' : ' ',
                   index, par->prio, par->interval,
                   stat->overruns, stat->cycles, stat->min, 
                   stat->cycles ?
                   stat->avg/stat->cycles : 0, stat->max);
        }
    } 
}

int main(int argc, char **argv)
{
    struct thread_param *par;
    struct thread_stat *stat;
    int i, ret = -1;
    char task_name[16];

    if (geteuid()) {
        printf("need to run as root!\n");
        exit(-1);
    }

    process_options(argc, argv);

    /* Lock all pages from being swapped out */
    if (mlockall(MCL_CURRENT|MCL_FUTURE) != 0) {
        perror("mlockall");
        exit(1);
    }

    signal(SIGINT, sighand);
    signal(SIGTERM, sighand);

    par = calloc(num_threads, sizeof(struct thread_param));
    if (!par)
        goto out;
    stat = calloc(num_threads, sizeof(struct thread_stat));
    if (!stat)
        goto outpar;

    for (i = 0; i < num_threads; i++) {
        if (verbose) {
            stat[i].values = calloc(VALBUF_SIZE, sizeof(double));
            if (!stat[i].values)
                goto outall;
            par[i].bufmsk = VALBUF_SIZE - 1;
        }

        par[i].prio = priority;
        if (priority)
            priority--;
        par[i].interval = interval;
        par[i].max_cycles = max_cycles;
        par[i].stats = &stat[i];
        stat[i].min = 1000000.0;
        stat[i].max = -1000000.0;
        stat[i].avg = 0.0;
        snprintf(task_name, sizeof(task_name), "TimerTest-%d", i+1);
        if((rt_task_create(&stat[i].task, task_name, 0, priority, T_FPU)) ||
           (rt_task_start(&stat[i].task, &timerthread, &par[i])))
            goto outall;
        stat[i].threadstarted = 1;
    }

    while (!shutdown) {
        int allstopped = 0;

        for (i = 0; i < num_threads; i++) {
            print_stat(&par[i], i, verbose);
            if(max_cycles && stat[i].cycles >= max_cycles)
                allstopped++;
        }
        usleep(10000);
        if (shutdown || allstopped)
            break;
        if (!verbose && !quiet)
            printf("\033[%dA", num_threads);
    }
    ret = 0;

 outall:
    shutdown = 1;
    usleep(50000);

    if (verbose) {
        for (i = 0; i < num_threads; i++) {
            unsigned int j;
            if(par[i].stats->cycles > VALBUF_SIZE)
                par[i].stats->cycles = VALBUF_SIZE;
            j = 0;
    
            while (par[i].stats->cycles != j) {
                double diff = par[i].stats->values[j];
                printf("%8d:%8u:%10.3lf\n", i, j++, diff);
            }
        }
    }

    if (quiet)
        quiet = 2;

    for (i = 0; i < num_threads; i++) {
        if (stat[i].threadstarted > 0) {
            rt_task_delete(&stat[i].task);
        }
        if (stat[i].threadstarted) {
            if (quiet)
                print_stat(&par[i], i, 0);
        }
        if (stat[i].values)
            free(stat[i].values);
    }
    free(stat);
 outpar:
    free(par);
 out:
    exit(ret);
}

--------------020505010207090701030603--

