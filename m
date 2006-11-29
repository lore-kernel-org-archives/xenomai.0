Message-ID: <456D5075.1060905@domain.hid>
Date: Wed, 29 Nov 2006 10:18:45 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010000080205000000060905"
Subject: [Xenomai-help] measuring context switch primary<->secondary mode
Reply-To: Markus.Franke@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010000080205000000060905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear Xenomai Users,

I want to measure the context switch times between primary and secondary
 execution modes. Therefore I made some small modifications to the
already present Latency-Test located in
$(XENOMAI_ROOT)/src/testsuite/latency

Basically I just changed few things in the latency-Task:

---snip---

err = rt_task_wait_period(&ov);
before_tsc = rt_timer_tsc();
printf("This is a teststring for entering in secondary mode!\n");
after_tsc = rt_timer_tsc();

dt = after_tsc - before_tsc;


if (dt > maxj)
    maxj = dt;
if (dt < minj)
    minj = dt;
sumj += dt;

---snap---

After that I configured a kernel with CONFIG_PREEMPT and one without. In
theory I should resolve much lower switch-times when I am running the
kernel with CONFIG_PREEMPT, right? However, I can't prove this theory.
The Switch-Times in the non-CONFIG_PREEMPT case are a bit lower than in
the CONFIG_PREEMPT - Case.

The complete Test-Code is attached.

My System is:

Linux Kernel 2.6.17
Adeos Patch: adeos-ipipe-2.6.17-i386-1.5-00.patch
Xenomai 2.2.4

Thanks for help,
Markus Franke

---



--------------010000080205000000060905
Content-Type: text/x-csrc;
 name="switch_primsek.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="switch_primsek.c"

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

RT_TASK switch_task, display_task;

RT_SEM display_sem;

#define ONE_BILLION  1000000000
#define TEN_MILLION    10000000

long minjitter, maxjitter, avgjitter;
long gminjitter = TEN_MILLION, gmaxjitter = -TEN_MILLION, goverrun = 0;
long long gavgjitter = 0;

long long period_ns = 0;
int test_duration = 0;		/* sec of testing, via -T <sec>, 0 is inf */
int data_lines = 21;		/* data lines per header line, -l <lines> to change */
int quiet = 0;			/* suppress printing of RTH, RTD lines when -T given */
int benchdev_no = 0;
int benchdev = -1;
int freeze_max = 0;
int priority = T_HIPRIO;

time_t test_start, test_end;	/* report test duration */
int test_loops = 0;		/* outer loop count */

#define MEASURE_PERIOD ONE_BILLION
#define SAMPLE_COUNT (MEASURE_PERIOD / period_ns)

/* Warmup time : in order to avoid spurious cache effects on low-end machines. */
#define WARMUP_TIME 1
#define HISTOGRAM_CELLS 100
int histogram_size = HISTOGRAM_CELLS;
long *histogram_avg = NULL, *histogram_max = NULL, *histogram_min = NULL;

int do_histogram = 0, do_stats = 0, finished = 0;
int bucketsize = 1000;		/* default = 1000ns, -B <size> to override */

static inline void add_histogram(long *histogram, long addval)
{
	/* bucketsize steps */
	long inabs =
	    rt_timer_tsc2ns(addval >= 0 ? addval : -addval) / bucketsize;
	histogram[inabs < histogram_size ? inabs : histogram_size - 1]++;
}

void switch_primsek(void *cookie)
{
	int err, count, nsamples, warmup = 1;
	RTIME expected_tsc, period_tsc, start_ticks;
	RT_TIMER_INFO timer_info;

	err = rt_timer_inquire(&timer_info);

	if (err) {
		fprintf(stderr, "switch_primsek: rt_timer_inquire, code %d\n", err);
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
		fprintf(stderr, "switch_primsek: failed to set periodic, code %d\n",
			err);
		return;
	}

	for (;;) {
		long minj = TEN_MILLION, maxj = -TEN_MILLION, dt;
		long overrun = 0;
		long long sumj;
		test_loops++;
		long before_tsc;
		long after_tsc;

		for (count = sumj = 0; count < nsamples; count++) {
			unsigned long ov;

			expected_tsc += period_tsc;
			err = rt_task_wait_period(&ov);

			before_tsc = rt_timer_tsc();
			printf("This is a teststring for entering in secondary mode!\n");
			after_tsc = rt_timer_tsc();
			dt = after_tsc - before_tsc;

			
			if (dt > maxj)
				maxj = dt;
			if (dt < minj)
				minj = dt;
			sumj += dt;

			if (err) {
				if (err != -ETIMEDOUT) {
					fprintf(stderr,
						"switch_primsek: wait period failed, code %d\n",
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

			if (!(finished || warmup) && (do_histogram || do_stats))
				add_histogram(histogram_avg, dt);
		}

		if (!warmup) {
			if (!finished && (do_histogram || do_stats)) {
				add_histogram(histogram_max, maxj);
				add_histogram(histogram_min, minj);
			}

			minjitter = minj;
			if (minj < gminjitter)
				gminjitter = minj;

			maxjitter = maxj;
			if (maxj > gmaxjitter)
				gmaxjitter = maxj;

			avgjitter = sumj / nsamples;
			gavgjitter += avgjitter;
			goverrun += overrun;

			rt_sem_v(&display_sem);
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
			"switch_primsek: cannot create semaphore: %s\n",
			strerror(-err));
		return;

	} 

	time(&start);

	if (WARMUP_TIME)
		printf("warming up...\n");

	if (quiet)
		printf("running quietly for %d seconds\n",
			test_duration);

	for (;;) {
		long minj, gminj, maxj, gmaxj, avgj;

		err = rt_sem_p(&display_sem, TM_INFINITE);
		if (err) {
			if (err != -EIDRM)
				fprintf(stderr,
					"switch_primsek: failed to pend on semaphore, code %d\n",
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
				     "User Mode",
				     period_ns / 1000, priority);
				printf("RTH|%12s|%12s|%12s|%8s|%12s|%12s\n",
				       "-----lat min", "-----lat avg",
				       "-----lat max", "-overrun",
				       "----lat best", "---lat worst");
			}

			printf("RTD|%12.3f|%12.3f|%12.3f|%8ld|%12.3f|%12.3f\n",
			       (double)minj / 1000,
			       (double)avgj / 1000,
			       (double)maxj / 1000,
			       goverrun,
			       (double)gminj / 1000, (double)gmaxj / 1000);
		}
	}
}

double dump_histogram(long *histogram, char *kind)
{
	int n, total_hits = 0;
	double avg = 0;		/* used to sum hits 1st */

	if (do_histogram)
		printf("---|--param|----range-|--samples\n");

	for (n = 0; n < histogram_size; n++) {
		long hits = histogram[n];

		if (hits) {
			total_hits += hits;
			avg += n * hits;
			if (do_histogram)
				printf("HSD|    %s| %3d -%3d | %8ld\n",
				       kind, n, n + 1, hits);
		}
	}

	avg /= total_hits;	/* compute avg, reuse variable */

	return avg;
}

void dump_stats(long *histogram, char *kind, double avg)
{
	int n, total_hits = 0;
	double variance = 0;

	for (n = 0; n < histogram_size; n++) {
		long hits = histogram[n];

		if (hits) {
			total_hits += hits;
			variance += hits * (n - avg) * (n - avg);
		}
	}

	/* compute std-deviation (unbiased form) */
	variance /= total_hits - 1;
	variance = sqrt(variance);

	printf("HSS|    %s| %9d| %10.3f| %10.3f\n",
	       kind, total_hits, avg, variance);
}

void dump_hist_stats(void)
{
	double minavg, maxavg, avgavg;

	/* max is last, where its visible w/o scrolling */
	minavg = dump_histogram(histogram_min, "min");
	avgavg = dump_histogram(histogram_avg, "avg");
	maxavg = dump_histogram(histogram_max, "max");

	printf("HSH|--param|--samples-|--average--|---stddev--\n");

	dump_stats(histogram_min, "min", minavg);
	dump_stats(histogram_avg, "avg", avgavg);
	dump_stats(histogram_max, "max", maxavg);
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

	if (do_histogram || do_stats)
		dump_hist_stats();

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

	if (histogram_avg)
		free(histogram_avg);
	if (histogram_max)
		free(histogram_max);
	if (histogram_min)
		free(histogram_min);

	exit(0);
}

void sighand(int sig __attribute__ ((unused)))
{
        if (sig == SIGXCPU)
                printf("---!! uh oh, switched to secondary mode !!--\n");
	else
		finished = 1;
}

int main(int argc, char **argv)
{
	int c, err;
	char task_name[16];
	int cpu = 0;
	
	while ((c = getopt(argc, argv, "hp:l:T:qH:B:sD:t:fc:P:")) != EOF)
		switch (c) {
		case 'h':

			do_histogram = 1;
			break;

		case 's':

			do_stats = 1;
			break;

		case 'H':

			histogram_size = atoi(optarg);
			break;

		case 'B':

			bucketsize = atoi(optarg);
			break;

		case 'p':

			period_ns = atoi(optarg) * 1000LL;
			break;

		case 'l':

			data_lines = atoi(optarg);
			break;

		case 'T':

			test_duration = atoi(optarg);
			alarm(test_duration + WARMUP_TIME);
			break;

		case 'q':

			quiet = 1;
			break;

		case 'D':

			benchdev_no = atoi(optarg);
			break;

		case 't':

			break;

		case 'f':

			freeze_max = 1;
			break;

		case 'c':
			cpu = T_CPU(atoi(optarg));
			break;

		case 'P':
			priority = atoi(optarg);
			break;

		default:

			fprintf(stderr, "usage: switch_primsek [options]\n"
				"  [-h]                         # print histograms of min, avg, max latencies\n"
				"  [-s]                         # print statistics of min, avg, max latencies\n"
				"  [-H <histogram-size>]        # default = 200, increase if your last bucket is full\n"
				"  [-B <bucket-size>]           # default = 1000ns, decrease for more resolution\n"
				"  [-p <period_us>]             # sampling period\n"
				"  [-l <data-lines per header>] # default=21, 0 to supress headers\n"
				"  [-T <test_duration_seconds>] # default=0, so ^C to end\n"
				"  [-q]                         # supresses RTD, RTH lines if -T is used\n"
				"  [-D <testing_device_no>]     # number of testing device, default=0\n"
				"  [-t <test_mode>]             # 0=user task (default), 1=kernel task, 2=timer IRQ\n"
				"  [-f]                         # freeze trace for each new max latency\n"
				"  [-c <cpu>]                   # pin measuring task down to given CPU\n"
				"  [-P <priority>]              # task priority (test mode 0 and 1 only)\n");
			exit(2);
		}

	time(&test_start);

	histogram_avg = calloc(histogram_size, sizeof(long));
	histogram_max = calloc(histogram_size, sizeof(long));
	histogram_min = calloc(histogram_size, sizeof(long));

	if (!(histogram_avg && histogram_max && histogram_min))
		cleanup();

	if (period_ns == 0)
		//period_ns = 1000000000LL;	/* ns */
		period_ns = 1000000LL;	/* ns */

	if (priority <= T_LOPRIO)
		priority = T_LOPRIO + 1;
	else if (priority > T_HIPRIO)
		priority = T_HIPRIO;

	signal(SIGINT, sighand);
	signal(SIGTERM, sighand);
	signal(SIGHUP, sighand);
	signal(SIGALRM, sighand);

	setlinebuf(stdout);

	printf("== Sampling period: %Ld us\n"
	       "== All results in microseconds\n",
	       period_ns / 1000);

	mlockall(MCL_CURRENT | MCL_FUTURE);

	err = rt_timer_set_mode(TM_ONESHOT);	/* Force aperiodic timing. */
	
	if (err) {
		fprintf(stderr,
			"switch_primsek: failed to start timer, code %d\n",
			err);
		return 0;
	}
	
	snprintf(task_name, sizeof(task_name), "display-%d", getpid());
	err = rt_task_create(&display_task, task_name, 0, 0, T_FPU);

	if (err) {
		fprintf(stderr,
			"switch_primsek: failed to create display task, code %d\n",
			err);
		return 0;
	}

	err = rt_task_start(&display_task, &display, NULL);

	if (err) {
		fprintf(stderr,
			"switch_primsek: failed to start display task, code %d\n",
			err);
		return 0;
	}

	snprintf(task_name, sizeof(task_name), "sampling-%d", getpid());
	err =
	    rt_task_create(&switch_task, task_name, 0, priority,
		   T_FPU | cpu);

	if (err) {
		fprintf(stderr,
			"switch_primsek: failed to create switch_primsek task, code %d\n",
			err);
		return 0;
	}

	err = rt_task_start(&switch_task, &switch_primsek, NULL);

	if (err) {
		fprintf(stderr,
			"switch_primsek: failed to start switch_primsek task, code %d\n",
			err);
		return 0;
	}

	while (!finished)
		pause();

	cleanup();

	return 0;
}


--------------010000080205000000060905
Content-Type: text/x-vcard; charset=utf-8;
 name="Markus.Franke.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Markus.Franke.vcf"

begin:vcard
fn:Markus Franke
n:Franke;Markus
adr;quoted-printable:;;Vettersstra=C3=9Fe 64/722;Chemnitz;Saxony;09126;Germany
email;internet:Markus.Franke@domain.hid
x-mozilla-html:FALSE
url:http://www.tu-chemnitz.de/~franm
version:2.1
end:vcard


--------------010000080205000000060905--

