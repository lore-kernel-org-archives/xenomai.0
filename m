From: "Meier, Hans" <Hans.Meier@zwick.de>
Date: Thu, 23 Apr 2015 18:42:43 +0000
Message-ID: <1b27d68cb89340489802b18862a2b2d7@zue-s-199.zue.zwick.de>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Corruption after phtread_mutex_destroy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi everybody,

First of all thanks a lot for your excellent work, we are using Xenomai 
for about 8 years now in quite a complex application together with ACE 
based on the POSIX skin and most of the time it just works fine.

But now we have a situation we think needs to be reported. 

Consider the following:
We have a thread H with high priority, a thread L with low priority and 
a mutex M (recursive, prio-inherit). L locks M and then H tries to lock M, 
L gets boosted until it unlocks M, then H succeeds in locking M, then H 
unlocks M. If H then immediately destroys and frees M, we get a corruption 
where M's pthread_mutex_t was stored (a byte gets decremented), as soon as 
L gets scheduled again.

According to man page PTHREAD_MUTEX_DESTROY(3P), section "Destroying 
Mutexes" - close to the end - "Implementations are required to allow an 
object to be destroyed and freed ... immediately after the object is 
unlocked". So that is what we do here, we destroy and free the mutex 
immediately after it is unlocked. Certainly in a simple scenario we could 
easily work around this problem by destroying and freeing M later, but 
what if this code is buried deep inside a framework lib (here ACE)? 

We upgraded to Xenomai 2.6.4 some months ago coming from 2.4.9.1 and as 
far as I remember all of the really weird crashes of our application 
happened after upgrading. So I guess it has something to do with the futex 
implementation. A heavily simplified example code showing the problem can 
be found below. There the pthread_mutex_t gets implicitly freed as it 
resides on the stack. This results in a nice, delayed stack corruption - 
just like It happens in our application. Our environment: x86 32bit on a 
P4 dual core, linux 3.10.32, config attached.

So could you please have a look into that? A note on timing: I am working 
on this project normally 2 days a week, so Monday and Thursday next week I 
will probably be here for emailing if you have further questions.

Thanks in advance,
Best regards

Hans 

---

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <sys/mman.h>

pthread_mutex_t* g_mutex = NULL;

void* worker(void*)
{
    // we only get here while the main thread that has a higher prio
    // sleeps, thus the mutex is ready to use now
    pthread_mutex_lock(g_mutex);
    timespec t; t.tv_sec = 2; t.tv_nsec = 0;
    nanosleep(&t,&t);
    pthread_mutex_unlock(g_mutex);
    return NULL;
}

void do_mutex_stuff()
{
    pthread_mutexattr_t mutex_attr;
    pthread_mutexattr_init(&mutex_attr);
    pthread_mutexattr_setprotocol(&mutex_attr, PTHREAD_PRIO_INHERIT);
    pthread_mutexattr_settype(&mutex_attr, PTHREAD_MUTEX_RECURSIVE);

    pthread_mutex_t mutex;
    pthread_mutex_init(&mutex, &mutex_attr);
    g_mutex = &mutex;
    //allow the low prio thread now to run.
    //sleep must be long enough that the worker can lock the mutex
    //and short enough that it doesn't reach unlock.
    timespec t; t.tv_sec = 1; t.tv_nsec =0;
    nanosleep(&t,&t);
    //this call will block until worker 
    //(which is sleeping longer than we did) unlocks
    pthread_mutex_lock(&mutex);
    pthread_mutex_unlock(&mutex);
    //remark: pthread_mutex_destroy returns EINVAL here!
    /*int rv = */pthread_mutex_destroy(&mutex);

    pthread_mutexattr_destroy(&mutex_attr);
}

void check_for_corruption()
{
    //set up a corruption target
    unsigned char Buffer[256];
    memset(Buffer, 0xaa, sizeof(Buffer));

    //let worker continue after unlock and corrupt whatever it likes
    timespec t; t.tv_sec = 1; t.tv_nsec = 0;
    nanosleep(&t,&t);

    //check what has happened with our corruption target
    for(size_t i = 0; i < sizeof(Buffer); i++)
    {
        if(Buffer[i] != 0xaa)
        {
            printf("Corruption at buffer offset %u: contents: 0x%02x "
                   "instead of 0xaa\n",
                   i, (unsigned)Buffer[i]);
            printf("The corruption occured at %p, pthread_mutex_t "
                   "formerly covered [%p..%p]\n",
                   &Buffer[i], g_mutex, 
                   ((unsigned char*)g_mutex)+sizeof(pthread_mutex_t)-1);
            printf("Thus the corruption occured at offset %d within "
                   "pthread_mutex_t.\n",
                   &Buffer[i] - ((unsigned char*)g_mutex));
        }
    }
}


int main (int, char**)
{
    mlockall(MCL_CURRENT | MCL_FUTURE);

    // make self be the high prio thread
    struct sched_param sched_param_main;
    sched_param_main.sched_priority = 20;
    pthread_setschedparam(pthread_self(), SCHED_FIFO, &sched_param_main);

    // create low prio worker thread
    pthread_attr_t thread_attr;
    pthread_attr_init(&thread_attr);
    pthread_attr_setschedpolicy(&thread_attr, SCHED_FIFO);
    struct sched_param sched_param_worker;
    sched_param_worker.sched_priority = 10;
    pthread_attr_setschedparam(&thread_attr, &sched_param_worker);
    pthread_attr_setinheritsched(&thread_attr, PTHREAD_EXPLICIT_SCHED);
    pthread_t worker_thread;
    pthread_create(&worker_thread, &thread_attr, worker, NULL);

    // create mutex, let worker run, lock, unlock and destroy mutex
    do_mutex_stuff();

    // wait for a stack corruption to occur ...
    check_for_corruption();

    // cleanup
    void* threadExitPtr;
    pthread_join(worker_thread, &threadExitPtr);
    pthread_attr_destroy(&thread_attr);

    return 0;
}
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/x-gzip
Size: 16689 bytes
Desc: config.gz
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150423/6fe8d3a6/attachment.bin>
