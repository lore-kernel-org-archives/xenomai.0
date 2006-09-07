Message-ID: <44FFF19B.8080104@domain.hid>
Date: Thu, 07 Sep 2006 12:16:59 +0200
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Strange segmentation fault
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

I'm experiencing an strange segmentation fault problem. I've boiled down 
the code to the simplest possible program that causes the segfault:

1- Set the timer in oneshot mode.
2- Create a task.
3- Start the task.

At the task function:

1- Make the task periodic (1s).
2- Issue a fprintf.

That's all. The code segfaults. If I remove the fprintf, it won't 
segfault. If I change it for a printf, it won't segfault.

If I use fprintf but print just "TICK" instead of "TICK %u", it won't 
segfault while the task is running, but it will when the program is 
interrupted (not shown here, but I tried this with a signal handler in 
place that properly deleted the task, though I think this is not 
absolutely necessary).

I'm totally confused.

I know I can use fprintf as long as I assume that the RT task will go 
into "secondary" mode at this point because it'll be using linux 
services, and that it will go back to "primary" RT mode on the next call 
to rt_task_wait_period.

Also, I know that it would be best to use periodic instead of oneshot 
mode, but my program is obviously more complex than this boiled down 
example and really needs oneshot mode.

Any ideas about what could be the problem?

Thanks.

P.S: This is the same problem I described earlier inthe list as caused 
by inb. I though that inb was the cause because removing it avoided the 
segfault, however, it turns out that removing the inb was causing 
another piece of code containing the fprintf not to execute.

//===========================================================================

#include <sys/types.h>
#include <sys/mman.h>
#include <sys/io.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

#include <native/task.h>

#include "main.h"



static RT_TASK    _io_task;

static void _io_proc (void *arg) {

    u_long overrun;

    rt_task_set_periodic(&_io_task, TM_NOW, 
rt_timer_ns2ticks(1000000000LL));

    for (;;) {

        rt_task_wait_period(&overrun);

        fprintf(stderr, "TICK %u\n", 1);
    }
}



static void _cleanup (void) {
    rt_task_delete(&_io_task);
}



static int _init (void) {

    int r;

    r = rt_timer_set_mode(TM_ONESHOT);
    if (r < 0) {
        fprintf(stderr, "ERROR %i initializing RT\n", r);
        _cleanup(); return r;
    }

    r = rt_task_create(&_io_task, "rtcore_io_task", 0x1000, 10, T_FPU);
    if (r < 0) {
        fprintf(stderr, "ERROR %i creating task\n", r);
        _cleanup(); return r;
    }

    r = rt_task_start(&_io_task, &_io_proc, NULL);
    if (r < 0) {
        fprintf(stderr, "ERROR %i starting task\n", r);
        _cleanup(); return r;
    }

    return 0;
}



int main (int argc, char **argv) {

    iopl(3);
    mlockall(MCL_CURRENT | MCL_FUTURE);

    if ( _init() < 0) return 1;

    for (;;) sleep(1);

    _cleanup();

    return 0;
}





