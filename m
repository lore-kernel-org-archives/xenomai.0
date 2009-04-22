Message-ID: <49EEE65E.6060308@domain.hid>
Date: Wed, 22 Apr 2009 11:41:50 +0200
From: Roman Pisl <rpisl@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040209090207020208040704"
Subject: [Xenomai-help] Problem with mutexes in daemon
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
--------------040209090207020208040704
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I'm experiencing weird behavior with mutexes in a daemon application. 
After daemon() is called, unnamed mutexes fail on call 
rt_mutex_release() with -EPERM. Everything is ok for named mutexes.

Is there something special with daemon and unnamed mutexes - should all 
have name? Or is it a bug? I'm using kernel 2.6.28 and Xenomai 2.4.6.1.

Example showing this problem is attached.

Thank you for help,

Roman

--------------040209090207020208040704
Content-Type: text/plain;
 name="daemon.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="daemon.c"

#include <stdio.h>
#include <stdbool.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/cond.h>
#include <native/mutex.h>
#include <native/timer.h>

RT_TASK demo_task;
RT_TASK main_task;
RT_MUTEX mutex;
RT_MUTEX shut_mutex;
RT_COND shut_cond;

#define TRUE 1
#define FALSE 0

bool terminated = FALSE;
bool terminated2 = FALSE;

void demo(void *arg)
{
    int ret;
    RTIME now, previous;

    rt_task_set_periodic(NULL, TM_NOW, 1000000000);
    previous = rt_timer_read();

    while (!terminated2) {
        rt_task_wait_period(NULL);
        now = rt_timer_read();

        printf("DT: Time since last turn: %ld.%06ld ms\n",
               (long)(now - previous) / 1000000,
               (long)(now - previous) % 1000000);
               previous = now;

        if (ret = rt_mutex_acquire(&mutex, TM_INFINITE))
            printf("DT: rt_mutex_acquire() failed %i\n", ret);
        rt_task_sleep(1000000);
        if (ret = rt_mutex_release(&mutex))
            printf("DT: rt_mutex_release() failed %i\n", ret);
    }
    if (ret = rt_mutex_acquire(&shut_mutex, TM_INFINITE))
        printf("DT: rt_mutex_acquire() before cond failed %i\n", ret);
    if (ret = rt_cond_signal(&shut_cond))
        printf("DT: rt_cond_signal() failed %i\n", ret);
    if (ret = rt_mutex_release(&shut_mutex))
        printf("DT: rt_mutex_release() after cond failed %i\n", ret);
}

void catch_signal(int sig)
{
    terminated = TRUE;
}

int main(int argc, char* argv[])
{
    int ret;
    //when daemon - problems with unnamed mutexes
    //without daemon everything ok
    daemon(1, 1);

    if (ret = rt_mutex_create(&mutex, NULL))
    {
        printf("Error creating mutex %i\n", ret);
        return 0;
    }

    if (ret = rt_mutex_create(&shut_mutex, NULL))
    {
        printf("Error creating shut_mutex %i\n", ret);
        return 0;
    }

    if (ret = rt_cond_create(&shut_cond, NULL))
    {
        printf("Error creating cond%i\n", ret);
        return 0;
    }

    signal(SIGTERM, catch_signal);
    signal(SIGINT, catch_signal);

    mlockall(MCL_CURRENT|MCL_FUTURE);

    if (ret = rt_task_shadow(&main_task, "main", 90, 0))
        printf("rt_task_shadow() failed %i\n", ret);
    if (ret = rt_task_create(&demo_task, "trivial", 0, 99, 0))
        printf("rt_task_create() failed %i\n", ret);

    rt_task_start(&demo_task, &demo, NULL);

    while (!terminated)
    {
        if (ret = rt_mutex_acquire(&mutex, TM_INFINITE))
            printf("MT: rt_mutex_acquire() failed, %i\n", ret);
        rt_task_sleep(1000000);
        printf("sleep\n");
        if (ret = rt_mutex_release(&mutex))
            printf("MT: rt_mutex_release() failed %i\n", ret);
        rt_task_sleep(1000000000);
    }
    printf("Finished...\n");

    if (ret = rt_mutex_acquire(&shut_mutex, TM_INFINITE))
        printf("MT: rt_mutex_acquire() before cond failed %i\n", ret);
    terminated2 = TRUE;
    if (ret = rt_cond_wait(&shut_cond, &shut_mutex, TM_INFINITE))
        printf("MT: rt_cond_signal() failed %i\n", ret);
    if (ret = rt_mutex_release(&shut_mutex))
        printf("MT: rt_mutex_release() after cond failed %i\n", ret);

    rt_task_delete(&demo_task);
    rt_mutex_delete(&mutex);
    rt_mutex_delete(&shut_mutex);
    rt_cond_delete(&shut_cond);
}

--------------040209090207020208040704--

