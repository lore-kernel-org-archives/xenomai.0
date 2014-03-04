From: Alexander Herzog <aherzog@tuebingen.mpg.de>
Message-Id: <C2E8B18D-18DA-4EB6-9E92-7CD39319979E@tuebingen.mpg.de>
Date: Tue, 4 Mar 2014 11:55:46 -0800
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai]  real-time guarantee issues on xenomai 2.6.2.1
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

We have some real-time issues with our xenomai machine running Ubuntu =
12.04 with kernel version 3.5.7 patched with Xenomai 2.6.2.1 . We run a =
simple program (see end of this email), where we shadow the main thread, =
then switch it into periodic mode and obtain the timestamp each time the =
process is released. One would expect that the time between two cycles =
should remain constant. This is roughly true, if we run the program. =
However, if we run the program and in parallel execute 'watch -n .1 cat =
/proc/xeno/stat' we see pretty high spikes. The same code runs on an =
older kernel+xenomai version (kernel 2.6.35.9 with xenomai 2.5.6 on =
Ubuntu 10.04) without spikes. I attached 3 plots. All of them show the =
duration between two consecutive cycles in blue. After the process is =
woken up it sleeps for a while and records the time it spent sleeping. =
This duration is plotted in green. You will also see spikes in sleep =
duration. The 3 plots are:

2_5_with_watch.png shows the execution on an older xenomai system while =
we ran 'watch -n .1 cat /proc/xeno/stat'=20
min cycle duration 989184.0 ns
max cycle duration 1010688.0 ns

2_6_with_watch.png shows the execution on our xenomai system while we =
ran 'watch -n .1 cat /proc/xeno/stat'=20
min cycle duration 400640.0 ns
max cycle duration 1911552.0 ns

2_6_no_watch.png shows the execution on our xenomai without running the =
watch command in parallel.=20
min cycle duration 989696.0 ns
max cycle duration 1010432.0 ns

We appreciate any hint on what might be the cause for this or how we =
could further diagnose the problem.

Thanks in advance,
Alex

PS: Here is the test program:

#include <native/task.h>
#include <native/timer.h>
#include <sys/mman.h>
#include <cstdio>

#define LOG_SIZE 100000

int main(int argc, char* argv[])
{
        long system_time[LOG_SIZE];
        long work_duration[LOG_SIZE];
        unsigned long overruns[LOG_SIZE];

        mlockall(MCL_CURRENT | MCL_FUTURE);

        rt_task_shadow(NULL, "periodic_thread", 50, 0);
        if(0 !=3D rt_task_set_periodic(NULL, TM_NOW, 0.001 * 1e9))
        {
                printf ("Could not make task periodic\n");
            return -1;
        }
        rt_task_wait_period(NULL);

        for(int it=3D0; it<LOG_SIZE; ++it)
        {
          rt_task_wait_period(&(overruns[it]));
          system_time[it] =3D long(rt_timer_ticks2ns(rt_timer_read()));

          // do something
          long work_start =3D long(rt_timer_ticks2ns(rt_timer_read()));
          rt_task_sleep(400000);
          work_duration[it] =3D long(rt_timer_ticks2ns(rt_timer_read())) =
- work_start;
        }

        printf("writing log...\n");
        FILE *slog_file =3D fopen("periodic_task.log","w");
        for(int i=3D0; i<LOG_SIZE; ++i)
        {
          printf("writing log %d\n", i);
          fprintf(slog_file, "%ld ", system_time[i]);
          fprintf(slog_file, "%ld\n", work_duration[i]);
          fprintf(slog_file, "%lu\n", overruns[i]);
        }
        fclose(slog_file);

        return 0;
}




