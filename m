Message-Id: <1143612388.32703.257789950@domain.hid>
From: "Saul" <xeno@domain.hid>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Date: Wed, 29 Mar 2006 16:06:28 +1000
Subject: [Xenomai-help] Non-deterministic behaviour in primary mode
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

Hi,

I'm trying to run a short test program, just to get into the swing
of this shiny new real-time system. I'm running Xenomai 2.1.0 on
kernel 2.6.15.6

The following program runs a busy delay in primary mode (verified by
enabling the primary mode switch warning) and calculates the time taken.
Another task is resumed and prints the time.

I get output something like this:
  1:  40.017 ms
  2:  40.017 ms
  3:  53.357 ms
  4:  53.356 ms
  5:  40.017 ms
  6:  40.020 ms
  7:  53.355 ms
  8:  40.020 ms
  9:  40.017 ms
 10:  53.356 ms
 11:  40.020 ms
 12:  40.019 ms
 13:  106.710 ms
 14:  40.017 ms
 15:  40.018 ms ...

I assume I've done something silly but I can't find anything wrong. My
computer is a 3GHz P4. Xenomai is built-in statically, and at boot says
"Xenomai: SMI-enabled Intel chipset found, enabling SMI workaround."

Anyway, the erratic execution times come and go with the smallest
changes in the program e.g. moving the delay into it's own function or
creating functions for timing the delay loop, so I wouldn't be too
surprised if the problem can't be reproduced.

Also, I found that using rt_timer_spin() instead of a real busy loop
does not have the same problem, which indicates that the simple busy
loop is in fact being interrupted during execution.

Is it a problem that I'm not explicitly destroying the tasks? They don't
linger in /proc/xenomai/sched once the program is killed. How much
is automatically cleaned up upon process exit?

#include <stdio.h>
#include <stdlib.h> // exit
#include <unistd.h> // pause
#include <sys/mman.h> // mlockall
#include <signal.h>
#include <xenomai/native/task.h>
#include <xenomai/native/timer.h>

#define MS 1000000

RT_TASK timed_task;
RT_TASK display_task;
int timed_count = 0;
double timed_delay = 0;

void my_processing(void)
{
        int i;
//      rt_timer_spin(40*MS);
        for (i=80000000; --i; );
}

void timed_task_handler(void *cookie)
{
        RTIME start_tsc = rt_timer_tsc();
        rt_task_set_mode(0, T_WARNSW, NULL);
        for (timed_count=0;;) {
                rt_task_sleep(40*MS); /* allow linux to run */

                RTIME prev_tsc = rt_timer_tsc();
                my_processing();
                RTIME tsc = rt_timer_tsc();
                timed_delay = rt_timer_tsc2ns(tsc-prev_tsc)*1e-9;

                timed_count++;
                rt_task_resume(&display_task);
                if (timed_count >= 100)
                        break;
        }
        rt_task_set_mode(T_WARNSW, 0, NULL);
        printf("total time: %.3f\n",
                rt_timer_tsc2ns(rt_timer_tsc()-start_tsc)*1e-6);
        exit(0);
}

void display_task_handler(void *cookie)
{
        for (;;) {
                rt_task_suspend(NULL);
                printf("%3d:  %.3f ms\n",
                        timed_count, timed_delay * 1e3);
        }
        exit(0);
}

void context_switch_warn_handler(int sig)
{
        printf("WARNING: detected switch to secondary mode\n");
}

int main(int argc, char *argv[])
{
        int err;
        mlockall(MCL_CURRENT|MCL_FUTURE);
        signal(SIGXCPU, context_switch_warn_handler);
        rt_timer_set_mode(TM_ONESHOT);
        rt_task_spawn(&timed_task, "timed-task",
                                0, 99, 0, timed_task_handler, 0);
        rt_task_spawn(&display_task, "display-task",
                                0, 98, 0, display_task_handler, 0);
        pause();
        return 0;
}

Any clues?
Thanks in advance,
Saul.

