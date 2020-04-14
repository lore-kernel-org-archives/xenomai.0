Subject: Re: rt_task_unblock() POSIX alternative
References: <20200407154117.5D7D71C2@centrum.cz>
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
 <20200407171816.E0B3979D@centrum.cz>
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>
 <20200408114406.6119E0D9@centrum.cz>
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>
 <20200409170009.5B0DAA77@centrum.cz>
 <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>
 <20200409201057.74CB5ED0@centrum.cz>
 <CAFLxGvxuZw57FvaAQEAxseamoPhHdKX7wfZoaZxKskgeXa4V9g@mail.gmail.com>
 <20200414101600.F9AA555D@centrum.cz>
 <CAFLxGvz7ewnVv57QiEfCG76tjGcJ5v9KSg0QNHwtMa0Hihp_dQ@mail.gmail.com>
 <20200414111059.39716137@centrum.cz>
 <CAFLxGvx4qs8ONbaiU37rFNqXy=n8Hat_p-V7fLAAxgskbuU_GA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6b8c89d1-bae0-90f5-4935-925fb0af2137@siemens.com>
Date: Tue, 14 Apr 2020 12:07:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvx4qs8ONbaiU37rFNqXy=n8Hat_p-V7fLAAxgskbuU_GA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, =?UTF-8?Q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
Cc: Xenomai <xenomai@xenomai.org>

On 14.04.20 11:46, Richard Weinberger wrote:
> On Tue, Apr 14, 2020 at 11:11 AM Petr Červenka <grugh@centrum.cz> wrote:
>>
>>> I fear there seems to be a confusion between POSIX tasks and POSIX skin.
>>> Is your goal programming Xenomai realtime threads using POSIX alike APIs?
>>> Or are you looking for a pedant of rt_task_unblock() to unblock a
>>> POSIX task, without Xenomai realtime threads?
>>>
>>> The solution I provided is for the latter case.
>>
>>
>>
>> My original goal was to port a very complex realtime application from Xenomai 2.6.5 Native skin to Xenomai 3.1 POSIX skin. So I made series of examples, where I tried to verify porting of several designs used in the orig. application. And rt_task_unblock() for reconfiguration of the waiting threads in the orig app was one of them.
>>
>> Now I'm very curious, why the (my explicit) signals in Xenomai POSIX skin are not working for me as I would expect.
>>
>>
>>
>> Here is my compile command:
>>
>> g++ -fasynchronous-unwind-tables   -c -g -D_DEBUG -D_GNU_SOURCE -D_REENTRANT -D__COBALT_WRAP__ -D__COBALT__ -I/usr/xenomai/include/cobalt -I/usr/xenomai/include -MMD -MP -MF "build/Debug/GNU-Linux/main.o.d" -o build/Debug/GNU-Linux/main.o main.cpp
>>
>>
>>
>> Here is my link command:
>>
>> g++ -fasynchronous-unwind-tables    -o dist/Debug/GNU-Linux/countertestapp_4 build/Debug/GNU-Linux/main.o -L/usr/xenomai/lib -Wl,-rpath,'/usr/xenomai/lib' -Wl,--no-as-needed -Wl,@/usr/xenomai/lib/cobalt.wrappers -Wl,@/usr/xenomai/lib/modechk.wrappers /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -lcobalt -lmodechk -lpthread -lrt
>>
>>
>>
>> I'm using Netbeans IDE for my attemps, but the I tried to integrate xeno-config --posix --cflags or --ldflags result into the project settings as much as possible.
> 
> Okay. Now things get clearer.
> pthread_kill() will be wrapped to Xenomai, but you installed a signal
> handler for a Linux process.
> 
> What you basically need is a function in the Xenomai POSIX skin which
> calls threadobj_unblock().
> 

Below the working version for unblocking the RT task with non-RT signal.

Jan

---


#include <math.h>
#include <pthread.h>
#include <stdint.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/timerfd.h>
#include <unistd.h>

#define AUTO_KILL

#define SECOND  1000000000l     // ns
#define PERIOD  (5 * SECOND)    // ns
#define SLEEP   (1 * SECOND)    // ns

using namespace std;

static pid_t mainTask_pid;
static pthread_t task;
static int timer_fd;
static volatile bool end = false;

void signalHandler(int signal, siginfo_t *info, void *ctx) {
    end = true;
}

void timediff (struct timespec *result, const struct timespec *t1, const struct timespec *t2) {
    result->tv_sec = t2->tv_sec - t1->tv_sec;
    result->tv_nsec = t2->tv_nsec - t1->tv_nsec;
    if (result->tv_nsec >= SECOND) {
        result->tv_nsec -= SECOND;
        result->tv_sec++;
    }
    if (result->tv_nsec < 0) {
        result->tv_nsec += SECOND;
        result->tv_sec--;
    }
}

static void *taskHandler(void *cookie) {
    struct sigaction sa = {0};
    int err;

    printf("Task started\n");

    sa.sa_flags = 0;
    sigemptyset(&sa.sa_mask);
    sa.sa_sigaction = signalHandler;
    sigaction(SIGUSR1, &sa, NULL);

    // Get current time
    struct timespec start;
    clock_gettime(CLOCK_MONOTONIC, &start);

    // Set task period
    timer_fd = timerfd_create(CLOCK_MONOTONIC, 0);
    struct itimerspec timer_conf;
    timer_conf.it_value.tv_sec      = start.tv_sec;
    timer_conf.it_value.tv_nsec     = start.tv_nsec;
    timer_conf.it_interval.tv_sec   = PERIOD / SECOND;
    timer_conf.it_interval.tv_nsec  = PERIOD % SECOND;
    printf("Set period: %.3gs\n", timer_conf.it_interval.tv_sec + (double) timer_conf.it_interval.tv_nsec / SECOND);
    err = timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &timer_conf, NULL);
    if (err != 0) {
        printf("timerfd_settime failed: %d (%s)\n", err, strerror(-err));
        return NULL;
    }

    // Main cycle
    while (!end) {
        // Wait next period
        uint64_t ticks;
        ::read(timer_fd, &ticks, sizeof (ticks));

        // Get current time
        struct timespec now, result;
        clock_gettime(CLOCK_MONOTONIC, &now);

        // Printf wait time
        timediff(&result, &start, &now);
        printf("Task livind: %.3gs\n", result.tv_sec + (double) result.tv_nsec / SECOND);
        start = now;
    }

    ::close(timer_fd);
    printf("Task ended\n");
}

/*
 * 
 */
int main(int argc, char** argv) {
    unsigned long overruns;
    int err;

    mlockall(MCL_CURRENT | MCL_FUTURE);

    // Get current process ID
    mainTask_pid = getpid();

    // Make main task real-time (prio 1)
    sched_param param;
    memset(&param, 0, sizeof(param));
    param.sched_priority = 1;
    err = sched_setscheduler(mainTask_pid, SCHED_FIFO, &param);
    if (err != 0) {
        printf("sched_setscheduler failed: %d (%s)\n", err, strerror(-err));
        goto sched_setscheduler_err;
    }

    // Create new task (prio 2)
    pthread_attr_t tattr;
    pthread_attr_init(&tattr);
    pthread_attr_setinheritsched(&tattr, PTHREAD_EXPLICIT_SCHED);
    pthread_attr_setschedpolicy(&tattr, SCHED_FIFO);
    memset(&param, 0, sizeof (param));
    param.sched_priority = 2;
    pthread_attr_setschedparam(&tattr, &param);
    err = pthread_create(&task, &tattr, taskHandler, NULL);
    if (err != 0) {
        printf("pthread_create failed: %d (%s)\n", err, strerror(-err));
        goto pthread_create_err;
    }

#ifndef AUTO_KILL
    printf("Press ^C to stop!\n");
    do {
        pause();
    } while(!end);
#else
    usleep(SLEEP / 1000);

    err = __STD(pthread_kill)(task, SIGUSR1);
    if (err != 0) {
        printf("pthread_kill failed: %d (%s)\n", err, strerror(-err));
    }
#endif

    printf("Waiting for join\n");
    //pthread_cancel(task);
    pthread_join(task, NULL);
pthread_create_err:
sched_setaffinity_err:
sched_setscheduler_err:
    return 0;
}

