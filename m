Message-ID: <463EEA4A.1070405@domain.hid>
Date: Mon, 07 May 2007 10:58:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<1178198991.29605.54.camel@domain.hid>
	<463AE79E.2090901@domain.hid>
	<1178281926.29093.93.camel@domain.hid> <463B2A69.7080704@domain.hid>
	<463EE376.9030702@domain.hid>
In-Reply-To: <463EE376.9030702@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6DE06A450B02C956B7BD4020"
Sender: jan.kiszka@domain.hid
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
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DE06A450B02C956B7BD4020
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johan Borkhuis wrote:
> Jan, Philippe,
>=20
> Attached is my test program, based on cyclictest. I removed all the
> unneeded parts, and set all the options to the right values, as used fo=
r
> my test. I use the PPC8540 internal highres timer, but this can be
> disabled by undef-ing the define at the top of the program.
> I compiled the program using the same compiler-settings as used by the
> latency program.
>=20
> The commands I use to run the test are:
> /usr/xenomai/bin/latency -P 60
> ./cyclictest-Xenomai -q
>=20
> The -q option gives shows the output at the end of the test run, instea=
d
> of the running data, to examine all the recorded data add the -v option=
=2E
> The -h option enables the PPC8540 highres timer.
>=20
> This are the results from a test run using the attached
> cyclictest-Xenomai and the standard latency test (both are run in
> separate terminals):
>=20
> bash-3.00# ./cyclictest-Xenomai -q -h        #T: 0 P:80 I:10000 O:  0
> C:  100 Min:  -3.181 Avg:  -0.025 Max:    2.392
> #T: 1 P:79 I:10000 O:  0 C:  100 Min:  -1.787 Avg:   1.377 Max:  139.25=
7
> #T: 2 P:78 I:10000 O:  0 C:  100 Min:  -1.836 Avg:   5.518 Max:  553.62=
3
> #T: 3 P:77 I:10000 O:  0 C:  100 Min:  -1.932 Avg:   3.153 Max:  317.27=
5
> #T: 4 P:76 I:10000 O:  0 C:  100 Min:  -1.740 Avg:   0.435 Max:   45.20=
3
> #T: 5 P:75 I:10000 O:  0 C:  100 Min:  -1.980 Avg:   0.047 Max:    5.44=
3
> #T: 6 P:74 I:10000 O:  0 C:  100 Min:  -2.148 Avg:   0.015 Max:    2.53=
7
> #T: 7 P:73 I:10000 O:  0 C:  100 Min:  -1.811 Avg:   0.020 Max:    2.44=
0
> #T: 8 P:72 I:10000 O:  0 C:  100 Min:  -1.667 Avg:   0.011 Max:    2.41=
6
> #T: 9 P:71 I:10000 O:  0 C:  100 Min:  -1.788 Avg:   0.051 Max:    5.34=
7
>=20
> bash-3.00# /usr/xenomai/bin/latency -P 60
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 60)
> RTH|---lat min|---lat avg|---lat max|-overrun|--lat best|--lat worst
> RTD|    -5.453|    -4.492|    -2.090|       0|    -5.453|     -2.090
> RTD|    -5.381|    -4.492|     3.699|       0|    -5.453|      3.699
> RTD|    -5.453|    -4.492|    -1.321|       0|    -5.453|      3.699
> RTD|    -5.357|    -4.492|     1.201|       0|    -5.453|      3.699
> RTD|    -5.477|    -4.468|     3.003|       0|    -5.477|      3.699
> RTD|    -5.405|    -4.516|     1.417|       0|    -5.477|      3.699
> RTD|    -5.429|    -4.420|     7.207|       0|    -5.477|      7.207
> RTD|    -5.285|    -4.108|    28.588|       0|    -5.477|     28.588
> RTD|    -5.429|    -4.324|   770.282|      10|    -5.477|    770.282
> RTD|    -5.477|    -4.492|     2.210|      10|    -5.477|    770.282
> RTD|    -5.405|    -4.468|    -0.504|      10|    -5.477|    770.282
> RTD|    -5.309|    -4.468|    -0.312|      10|    -5.477|    770.282
> ---|----------|----------|----------|--------|----------------------
> RTS|    -5.477|    -4.420|   770.282|      10|    00:00:13/00:00:13
>=20
> Kind regards,
>    Johan Borkhuis
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> /*
>  * High resolution timer test software
>  *
>  * This program is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public License Veriosn
>  * 2 as published by the Free Software Foundation;
>  *
>  */
>=20
> #define VERSION_STRING "V 0.11-Xenomai"
>=20
> #define USE_PPC8540_TIMER
>=20
> #include <getopt.h>
> #include <signal.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <time.h>
> #include <unistd.h>
>=20
> #include <linux/unistd.h>
>=20
> #include <sys/types.h>
> #include <sys/mman.h>
>=20
> #include <native/task.h>
>=20
> #define USEC_PER_SEC        1000000
> #define NSEC_PER_SEC        1000000000
>=20
> /* Must be power of 2 ! */
> #define VALBUF_SIZE     1024*1024
>=20
> /* Struct to transfer parameters to the thread */
> struct thread_param {
>     int prio;
>     unsigned long max_cycles;
>     struct thread_stat *stats;
>     int bufmsk;
>     unsigned long interval;
> };
>=20
> /* Struct for statistics */
> struct thread_stat {
>     unsigned long cycles;
>     unsigned long cyclesread;
>     double min;
>     double max;
>     double act;
>     double avg;
>     double *values;
>     pthread_t thread;
>     int threadstarted;
>     RT_TASK task;
>     unsigned long overruns;
> };
>=20
> static int shutdown     =3D 0;
> static int hwtimer      =3D 0;
> static int priority     =3D 80;
> static int num_threads  =3D 10;
> static int max_cycles   =3D 100;
> static int verbose      =3D 0;
> static int quiet        =3D 0;
> static int interval     =3D 10000;
>=20
> /*=20
>  * High res timer for PPC 8540
>  * Timebase is running at CCB/8.  CCB is running at 333MHz, so TB is ru=
nning
>  * at 41.6667 MHz, which results in 24 nsec/tick
>  */
> #ifdef USE_PPC8540_TIMER
>=20
> /* Correction needed: clock is 0.1% off */
> #define TB_TICKS_NSEC   ((24.0)*1.001)
>=20
> __inline__ unsigned long get_tbl(void) {
>     unsigned long tbl;
>     asm volatile("mftb %0" : "=3Dr" (tbl));
>     return tbl;
> }
>=20
> __inline__ unsigned long get_tbu(void) {
>     unsigned long tbl;
>     asm volatile("mftbu %0" : "=3Dr" (tbl));
>     return tbl;
> }
>=20
> void timeStampGet(clockid_t which_clock, struct timespec *curtime)
> {
>     unsigned long lo, hi, hi2;
>     unsigned long long tr;
>     long double tmpVal;
>=20
>     if(hwtimer =3D=3D 0)
>     {
>         clock_gettime(which_clock, curtime);
>         return;
>     }
>=20
>     do {
>         hi =3D get_tbu();
>         lo =3D get_tbl();
>         hi2 =3D get_tbu();
>     } while (hi2 !=3D hi);
>=20
>     tr =3D ((unsigned long long) hi << 32) | lo;
>     tmpVal =3D (((long double)tr)*TB_TICKS_NSEC)/1000000000.0;
>     curtime->tv_sec =3D (int)tmpVal;
>     curtime->tv_nsec =3D (int)((tmpVal - (int)tmpVal) * 1000000000);
> }
> #else
> void timeStampGet(clockid_t which_clock, struct timespec *curtime)
> {
>     clock_gettime(which_clock, curtime);
>     return;
> }
> #endif
>=20
> static inline void tsnorm(struct timespec *ts)
> {
>     while (ts->tv_nsec >=3D NSEC_PER_SEC) {
>         ts->tv_nsec -=3D NSEC_PER_SEC;
>         ts->tv_sec++;
>     }
> }
>=20
> static double calcdiff(struct timespec t1, struct timespec t2)
> {
>     double diff;
>     diff =3D USEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
>     diff +=3D ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000.0;
>     return diff;
> }
>=20
> /*
>  * timer thread
>  *
>  */
> void timerthread(void *param)
> {
>     struct thread_param *par =3D param;
>     struct timespec now, next, interval;
>     struct thread_stat *stat =3D par->stats;
>     int n =3D 1;
>     RTIME start_ticks;
>     RT_TIMER_INFO timer_info;
>     int err;
>=20
>     interval.tv_sec =3D par->interval / USEC_PER_SEC;
>     interval.tv_nsec =3D (par->interval % USEC_PER_SEC) * 1000;
>=20
>     err =3D rt_timer_inquire(&timer_info);
>     if (err) {
>         fprintf(stderr, "latency: rt_timer_inquire, code %d\n", err);
>         return;
>     }
>=20
>     start_ticks =3D timer_info.date + rt_timer_ns2ticks(1000000);
>     err =3D rt_task_set_periodic(NULL, start_ticks,
>             rt_timer_ns2ticks(par->interval * 1000));
>     if (err) {
>         fprintf(stderr, "latency: failed to set periodic, code %d\n", e=
rr);
>         return;
>     }
>=20
>     /* Get current time */
>     timeStampGet(CLOCK_MONOTONIC, &now);
>     next =3D now;
>     next.tv_sec++;
>=20
>     stat->threadstarted++;
>=20
>     while (!shutdown) {
>         double diff;
>         unsigned long ov;
>=20
>         if (rt_task_wait_period(&ov))
>             break;
>         stat->overruns +=3D ov;
>=20
>         timeStampGet(CLOCK_MONOTONIC, &now);
>         if (n) { n=3D 0; } /* Ignore first period */
>         else {
>             diff =3D calcdiff(now, next);
>             if (diff < stat->min)
>                 stat->min =3D diff;
>             if (diff > stat->max)
>                 stat->max =3D diff;
>             stat->avg +=3D diff;
>=20
>             stat->act =3D diff;
>=20
>             stat->cycles++;
>=20
>             if (par->bufmsk)
>                 stat->values[stat->cycles & par->bufmsk] =3D diff;
>         }
>=20
>         next.tv_sec =3D now.tv_sec + interval.tv_sec;
>         next.tv_nsec =3D now.tv_nsec + interval.tv_nsec;
>         tsnorm(&next);
>=20
>         if (par->max_cycles && par->max_cycles =3D=3D stat->cycles)
>             break;
>     }
>=20
>     stat->threadstarted =3D -1;
>     return;
> }
>=20
> /* Print usage information */
> static void display_help(void)
> {
>     printf("cyclictest_xenomai %s\n", VERSION_STRING);
>     printf("Usage:\n"
>            "cyclictest <options>\n\n"
>            "-h       --hwtimer         use hardware timer\n"
>            "-i INTV  --interval=3DINTV   base interval of thread in us =
default=3D1000\n"
>            "-l LOOPS --loops=3DLOOPS     number of loops: default=3D100=
\n"
>            "-p PRIO  --prio=3DPRIO       priority of highest prio threa=
d: default=3D80\n"
>            "-q       --quiet           print only a summary on exit\n"
>            "-t NUM   --threads=3DNUM     number of threads: default=3D1=
0\n"
>            "-v       --verbose         output values on stdout for stat=
istics\n"
>            "                           format: n:c:v n=3Dtasknum c=3Dco=
unt v=3Dvalue in us\n"
>            );
>     exit(0);
> }
>=20
> /* Process commandline options */
> static void process_options (int argc, char *argv[])
> {
>     int error =3D 0;
>     for (;;) {
>         int option_index =3D 0;
>         /** Options for getopt */
>         static struct option long_options[] =3D {
>             {"hwtimer", no_argument, NULL, 'h'},
>             {"interval", required_argument, NULL, 'i'},
>             {"loops", required_argument, NULL, 'l'},
>             {"priority", required_argument, NULL, 'p'},
>             {"quiet", no_argument, NULL, 'q'},
>             {"threads", required_argument, NULL, 't'},
>             {"verbose", no_argument, NULL, 'v'},
>             {"help", no_argument, NULL, '?'},
>             {NULL, 0, NULL, 0}
>         };
>         int c =3D getopt_long (argc, argv, "hi:l:p:qt:vx",
>             long_options, &option_index);
>         if (c =3D=3D -1)
>             break;
>         switch (c) {
>         case 'h': hwtimer =3D 1; break;
>         case 'i': interval =3D atoi(optarg); break;
>         case 'l': max_cycles =3D atoi(optarg); break;
>         case 'p': priority =3D atoi(optarg); break;
>         case 'q': quiet =3D 1; break;
>         case 't': num_threads =3D atoi(optarg); break;
>         case 'v': verbose =3D 1; break;
>         case '?': error =3D 1; break;
>         }
>     }
>=20
>     if (priority < 0 || priority > 99 || num_threads < 1)
>         error =3D 1;
>=20
>     if (error)
>         display_help ();
> }
>=20
> static void sighand(int sig)
> {
>     shutdown =3D 1;
> }
>=20
> static void print_stat(struct thread_param *par, int index, int verbose=
)
> {
>     struct thread_stat *stat =3D par->stats;
>=20
>     if (!verbose) {
>         if (quiet !=3D 1) {
>             printf("%cT:%2d P:%2d I:%ld O:%4ld C:%7lu "
>                    "Min:%10.3lf Avg:%10.3lf Max:%10.3lf         \n",
>                    quiet =3D=3D 2 ? '#' : ' ',
>                    index, par->prio, par->interval,
>                    stat->overruns, stat->cycles, stat->min,=20
>                    stat->cycles ?
>                    stat->avg/stat->cycles : 0, stat->max);
>         }
>     }=20
> }
>=20
> int main(int argc, char **argv)
> {
>     struct thread_param *par;
>     struct thread_stat *stat;
>     int i, ret =3D -1;
>     char task_name[16];
>=20
>     if (geteuid()) {
>         printf("need to run as root!\n");
>         exit(-1);
>     }
>=20
>     process_options(argc, argv);
>=20
>     /* Lock all pages from being swapped out */
>     if (mlockall(MCL_CURRENT|MCL_FUTURE) !=3D 0) {
>         perror("mlockall");
>         exit(1);
>     }
>=20
>     signal(SIGINT, sighand);
>     signal(SIGTERM, sighand);
>=20
>     par =3D calloc(num_threads, sizeof(struct thread_param));
>     if (!par)
>         goto out;
>     stat =3D calloc(num_threads, sizeof(struct thread_stat));
>     if (!stat)
>         goto outpar;
>=20
>     for (i =3D 0; i < num_threads; i++) {
>         if (verbose) {
>             stat[i].values =3D calloc(VALBUF_SIZE, sizeof(double));
>             if (!stat[i].values)
>                 goto outall;
>             par[i].bufmsk =3D VALBUF_SIZE - 1;
>         }
>=20
>         par[i].prio =3D priority;
>         if (priority)
>             priority--;
>         par[i].interval =3D interval;
>         par[i].max_cycles =3D max_cycles;
>         par[i].stats =3D &stat[i];
>         stat[i].min =3D 1000000.0;
>         stat[i].max =3D -1000000.0;
>         stat[i].avg =3D 0.0;
>         snprintf(task_name, sizeof(task_name), "TimerTest-%d", i+1);
>         if((rt_task_create(&stat[i].task, task_name, 0, priority, T_FPU=
)) ||
>            (rt_task_start(&stat[i].task, &timerthread, &par[i])))
>             goto outall;
>         stat[i].threadstarted =3D 1;
>     }
>=20
>     while (!shutdown) {
>         int allstopped =3D 0;
>=20
>         for (i =3D 0; i < num_threads; i++) {
>             print_stat(&par[i], i, verbose);
>             if(max_cycles && stat[i].cycles >=3D max_cycles)
>                 allstopped++;
>         }
>         usleep(10000);
>         if (shutdown || allstopped)
>             break;
>         if (!verbose && !quiet)
>             printf("\033[%dA", num_threads);
>     }
>     ret =3D 0;
>=20
>  outall:
>     shutdown =3D 1;
>     usleep(50000);
>=20
>     if (verbose) {
>         for (i =3D 0; i < num_threads; i++) {
>             unsigned int j;
>             if(par[i].stats->cycles > VALBUF_SIZE)
>                 par[i].stats->cycles =3D VALBUF_SIZE;
>             j =3D 0;
>    =20
>             while (par[i].stats->cycles !=3D j) {
>                 double diff =3D par[i].stats->values[j];
>                 printf("%8d:%8u:%10.3lf\n", i, j++, diff);
>             }
>         }
>     }
>=20
>     if (quiet)
>         quiet =3D 2;
>=20
>     for (i =3D 0; i < num_threads; i++) {
>         if (stat[i].threadstarted > 0) {
>             rt_task_delete(&stat[i].task);
>         }
>         if (stat[i].threadstarted) {
>             if (quiet)
>                 print_stat(&par[i], i, 0);
>         }
>         if (stat[i].values)
>             free(stat[i].values);
>     }
>     free(stat);
>  outpar:
>     free(par);
>  out:
>     exit(ret);
> }

I don't see anything suspicious right now, so please consider capturing
a trace with the latency as I suggested. That should give a full picture
of what is happening when latency detects that huge delay.

Jan


--------------enig6DE06A450B02C956B7BD4020
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGPupTniDOoMHTA+kRApKoAJ9V+HR/ksoQDqNyfVM9RMi7lrxpwgCfVcDC
Wf0TNr0mk+01Rw/v4j+yMyA=
=WCWL
-----END PGP SIGNATURE-----

--------------enig6DE06A450B02C956B7BD4020--

