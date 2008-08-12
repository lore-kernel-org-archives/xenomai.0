Message-ID: <48A126E5.7070708@domain.hid>
Date: Tue, 12 Aug 2008 02:00:05 -0400
From: Josh Bowman <jbowman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Early timeouts from rt_mutex_acquire() ?
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

In the documentation for rt_mutex_acquire, it says that it should return
-ETIMEDOUT "if the mutex cannot be made available to the calling task
within the specified amount of time."

I'm not sure if this is really a bug, but I've run into a case where the
it returns the -ETIMEDOUT well before the specified amount of time has
passed.  It took me a little while to track down what's happening, and
in the process I've created a small test program.  Basically what's
happening in the test is that a higher priority task is holding the
mutex, releases it, and (without blocking) re-acquires the mutex.  Then
the higher priority task sleeps, and the lower priority task (which
should be blocked waiting for quite some time yet) wakes up with -ETIMEDOUT.

Can anyone say whether this behavior is correct?

Thanks,
Josh


Running xenomai 2.4.4 on i686, with kernel 2.6.20.21.  Output from test
program is:

at 561946, waiter_task attempting to get mutex
at 100675462, waiter_task: Error -110 from rt_mutex_acquire, with
maxWait=2000000000
at 3008820189, mutex_test is done.

----
#include <stdio.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/mutex.h>
#include <native/timer.h>

RT_TASK task, waiter;
RTIME start;

RT_MUTEX mutex;

void waiter_task( void *cookie ) {
    RTIME maxWait = 2 * 1000 * 1000 * 1000LL;
    printf("at %lld, waiter_task attempting to get mutex\n",
rt_timer_read()-start);
    int ret = rt_mutex_acquire( &mutex, maxWait );
    if ( ret == 0 )
        printf("at %lld, waiter_task got mutex\n", rt_timer_read()-start);
    else {
        printf( "at %lld, waiter_task: Error %d from rt_mutex_acquire,
with maxWait=%lld\n",
            rt_timer_read()-start, ret, maxWait );
    }
}

int main( int argc, char *argv[] ) {

    mlockall(MCL_CURRENT|MCL_FUTURE);

    int err = rt_task_shadow( &task, "mutex_test", 15, 0  );
    if ( err != 0 ) {
        printf( "Error %d calling rt_task_shadow()\n", err );
        return 1;
    }
   
    start = rt_timer_read();
   
    int ret = rt_mutex_create( &mutex, 0 );

    if (ret != 0) {
        printf( "Error %d from rt_create_mutex\n", ret );
        return 1;
    }

    ret = rt_mutex_acquire( &mutex, TM_INFINITE );
    if (ret != 0) {
        printf( "Error %d from rt_mutex_acquire\n", ret );
        return 1;
    }
   
    ret = rt_task_spawn( &waiter, "mutex_waiter", 0, 2, 0, waiter_task, 0 );
    if (ret != 0) {
        printf( "Error %d from rt_task_spawn\n", ret );
        return 1;
    }

    for ( int i = 0; i < 300; i++ ) {
        ret = rt_task_sleep( 10 * 1000 * 1000LL );
        if (ret != 0) {
            printf( "at %lld, Error %d from rt_task_sleep\n",
rt_timer_read()-start, ret );
            return 1;
        }
        if ( (i % 10) == 9 ) {
            ret = rt_mutex_release( &mutex );
            if ( ret != 0 )
                printf( "at %lld: Error %d from rt_mutex_release, i =
%d\n", rt_timer_read()-start, ret, i );
           
            rt_timer_spin( 100 * 1000LL );

            ret = rt_mutex_acquire( &mutex, TM_INFINITE );
            if ( ret != 0 )
                printf( "at %lld: Error %d from rt_mutex_acquire, i =
%d\n", rt_timer_read()-start, ret, i );
        }
    }
    printf( "at %lld, mutex_test is done.\n", rt_timer_read()-start );
   
    return 0;
}

