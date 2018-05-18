From: "Singh, Raman" <rasingh@mitre.org>
Date: Fri, 18 May 2018 16:24:47 +0000
Message-ID: <CY4PR0901MB2211C40E748F61C0C92D976DA1900@CY4PR0901MB2211.namprd09.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Xenomai 3 Multi-core Semaphore latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Environment: ARM Cortex-A53 quad-core processor (ARM 64-bit) on a
Zynq Ultrascale+ ZCU102 dev board, Xenomai 3 next branch from May=20
14, 2018 (SHA1: 410a4cc1109ba4e0d05b7ece7b4a5210287e1183 ),=20
Cobalt configuration with POSIX skin, Linux Kernel version 4.9.24

I've been having issues with semaphore latency when threads access=20
semaphores while executing on different cores. When both threads accessing=
=20
a semaphore execute on the same processor core, the latency between
one thread posting a semaphore and another waking up after waiting on it=20
is fairly small. However, as soon as one of the threads is moved to a=20
different core, the latency between a semaphore post from one thread to a=20
waiting thread waking up in response starts to become large enough to=20
affect real time performance.  The latencies I've been seeing are on the or=
der
of 100's of milliseconds.

The code below demonstrates the issue. It creates two threads. One thread
calls sem_post() and sleeps for a millisecond for each iteration of a loop=
=20
for 1000 iterations. The other thread performs a blocking wait on the=20
semaphore in a loop for the same amount of iterations. Both threads print=20
out their operation (either sem_post() or sem_wait()) along with a=20
timestamp and loop iteration count. The expectation is that the printouts=20
that result should alternate between posts and waits and this is in fact=20
what happens when both threads run on the same core. The timestamps show=20
that the latency between a post and the second thread waking up is pretty=20
low.

When the threads are moved to separate cores, the pattern of the printouts
changes. Instead of alternating posts followed by waits, there are
multiple posts in a row followed by an equal number of waits in a row. The=
=20
timestamps show significant latency between the first call to sem_post()=20
in a sequence and the corresponding first sem_wait() call that returns
after blocking.

I've also tried this test code using standard Linux primitives, and in=20
both cases, the printouts come out the same with alternating posts and=20
waits.  Additionally, this multi-core issue does not occur on an older ZC70=
6=20
platform with Xenomai 2.6.x.

With regard to the executable generated from the code below, with no=20
arguments provided it will run with both threads on the same core. If
any argument(s) are provided, it will run with the threads on separate
cores.

Any help with this issue would be appreciated.

Thanks,=20
Raman

#include <cstdlib>
#include <errno.h>
#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

static sem_t semaphore;

void* producer_thread(void* arg)
{
    int count =3D 0;

    struct timespec current_time;

    while(count < 1000)
    {
        sem_post(&semaphore);
        ++count;

        if(clock_gettime(CLOCK_REALTIME, &current_time) =3D=3D -1)
        {
            printf("Failed to get current time.\n");
            return 0;
        }

        printf("sem_post:%lld.%.9ld, count =3D %d\n",
               static_cast<long long>(current_time.tv_sec), current_time.tv=
_nsec, count);

        usleep(1000);
    }

    return 0;
}

void* consumer_thread(void* arg)
{
    int count =3D 0;

    struct timespec current_time;

    while(count < 1000)
    {
        sem_wait(&semaphore);
        ++count;

        if(clock_gettime(CLOCK_REALTIME, &current_time) =3D=3D -1)
        {
            printf("Failed to get current time.\n");
            return 0;
        }

        printf("sem_wait:%lld.%.9ld, count =3D %d\n",
               static_cast<long long>(current_time.tv_sec), current_time.tv=
_nsec, count);

    }

    return 0;
}

int main(int argc, char *argv[])
{
    bool same_core =3D true;
    if(argc > 1) same_core =3D false;

    if(sem_init(&semaphore, 0, 0) =3D=3D -1)
    {
        printf("Failed to initialize semaphore. Error: %s\n.", strerror(err=
no));
        return -1;
    }

    int producer_affinity =3D 0;
    int consumer_affinity =3D 0;
    if(!same_core) consumer_affinity =3D 1;

    int consumer_priority =3D 86;
    int producer_priority =3D 99;

    pthread_attr_t attr;

    if(pthread_attr_init(&attr))
    {
        printf("Failed to initialize attributes.\n");
        return -1;
    }

    if(pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED))
    {
        printf("Failed to disable scheduler inheritance.\n");
        return -1;
    }

    if(pthread_attr_setschedpolicy(&attr, SCHED_FIFO))
    {
        printf("Failed to set scheduler to SCHED_FIFO.\n");
        return -1;
    }

    sched_param param;
    if(!pthread_attr_getschedparam(&attr, &param))
    {
        param.sched_priority =3D consumer_priority;

        if(pthread_attr_setschedparam(&attr, &param))
        {
           printf("Unable to set thread priority.\n");
           return -1;
        }
    }
    else
    {
        printf("Unable to get params for setting priority.\n");
        return -1;
    }

    cpu_set_t cpu_set;
    CPU_ZERO(&cpu_set);
    CPU_SET(consumer_affinity, &cpu_set);
    if(pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpu_set))
    {
        printf("Unable to set CPU affinity.\n");
        return -1;
    }

    pthread_t consumer;
    if(pthread_create(&consumer, &attr, consumer_thread, NULL))
    {
        printf("Unable to create consumer thread.\n");
        return -1;
    }

    if(!pthread_attr_getschedparam(&attr, &param))
    {
        param.sched_priority =3D producer_priority;

        if(pthread_attr_setschedparam(&attr, &param))
        {
           printf("Unable to set thread priority.\n");
           return -1;
        }
    }
    else
    {
        printf("Unable to get params for setting priority.\n");
        return -1;
    }

    CPU_ZERO(&cpu_set);
    CPU_SET(producer_affinity, &cpu_set);
    if(pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpu_set))
    {
        printf("Unable to set CPU affinity.\n");
        return -1;
    }

    pthread_t producer;
    if(pthread_create(&producer, &attr, producer_thread, NULL))
    {
        printf("Unable to create producer thread.\n");
        return -1;
    }

    pthread_attr_destroy(&attr);

    pthread_join(producer, NULL);
    pthread_join(consumer, NULL);

    sem_destroy(&semaphore);

    return 0;
}

