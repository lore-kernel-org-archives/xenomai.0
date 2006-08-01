MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pKcnn4geoO"
Content-Transfer-Encoding: 7bit
Message-ID: <17615.48165.184151.82875@domain.hid>
Date: Tue, 1 Aug 2006 22:40:05 +0200
Subject: RE: [Xenomai-help] mq_send /mq_receive problem
In-Reply-To: <02AA386EB831044F8537A696BA785C78A668D5@domain.hid>
References: <17615.28311.703965.598653@domain.hid>
	<02AA386EB831044F8537A696BA785C78A668D5@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org


--pKcnn4geoO
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Landau, Bracha wrote:
 > The queue is opened with O_CREAT | O_RDWR.
 > Please note that I sent an updated version of the code that causes the crash - the queue in both the mq_send and mq_receive is "link_rq_mq".

Merging your sample with the code of the satch example, I arrived to the
attached test that work as expected as long as:
- the task priorities are correctly set
- there is no printf call between the mq_send and mq_receive in the
  "producer" function. It looks like such a printf suspends the
  GetLinkState thread out of mq_receive, so that when the LinkThread
  send a message, it is able to immediately receive it.

This state of affair is a bit fragile, in order to do something more
robust, you should probably use one message queue for each direction.

-- 


					    Gilles Chanteperdrix.

--pKcnn4geoO
Content-Type: text/plain
Content-Disposition: inline;
	filename="tmq.c"
Content-Transfer-Encoding: 7bit

#ifdef __KERNEL__
#include <linux/module.h>
#elif !defined(__XENO_SIM__)
#include <stdio.h>
#define printk printf
#else
#endif

#ifndef __XENO_SIM__
#include <errno.h>
#include <pthread.h>
#include <mqueue.h>
#include <sys/mman.h>
#else
#include <posix/posix.h>
#endif

#define CONSUMER_TASK_PRI    1
#define CONSUMER_STACK_SIZE  8192

#define PRODUCER_TASK_PRI    2
#define PRODUCER_STACK_SIZE  8192

#define MQ_NAME "/mymq"

static pthread_t consumer_task, producer_task;
static mqd_t mqd = (mqd_t) -1;
static pthread_mutex_t mutex;

void *consumer(void *cookie)
{
	int status;
	unsigned linkr;

	if ((status=mq_receive (mqd, (char *)&linkr, sizeof (linkr), 0)) > 0)
		status = mq_send (mqd, (char *)&linkr, sizeof (linkr), 0);
	else {
		printk ("linkthread:mq_receive returned %08x, errno=%08x\n", status, errno);
		return cookie;
	}

	status=mq_receive (mqd, (char *)&linkr, sizeof (linkr), 0);

	printk("test failed!\n");
	
	return 0;
}

void *producer(void *cookie)
{
	unsigned linkr = (unsigned) cookie;
	int status;
	status = mq_send (mqd, (char *)&linkr, sizeof (linkr), 0);
	mq_receive (mqd, (char *)&linkr, sizeof (linkr), 0);
	printk("test passed\n");
	return (void *) linkr;
}

void __xeno_user_exit(void)
{
    if (consumer_task)
        {
        pthread_cancel(consumer_task);
        pthread_join(consumer_task, NULL);
        }
    if (mqd != (mqd_t) -1)
        mq_close(mqd);
    if (producer_task)
        {
        pthread_cancel(producer_task);
        pthread_join(producer_task, NULL);
        }
    mq_unlink(MQ_NAME);
}

int __xeno_user_init (void)

{
    struct sched_param parm;
    pthread_attr_t attr;
    int rc = 0;
    struct mq_attr mattr;

    pthread_mutex_init(&mutex, NULL);

    mattr.mq_maxmsg = 30;
    mattr.mq_msgsize = sizeof(unsigned);
    mqd = mq_open(MQ_NAME, O_CREAT| O_EXCL| O_RDWR, 0, &mattr);
    if (mqd == (mqd_t) -1)
        {
	if (errno == EEXIST)
	    {
	    printk("Mqtest: consumer module is already running, please "
		     "only launch one consumer instance.\n");
	    goto out;
	    }

        printk("mq_open(mqd): %d\n", errno);
        goto out;
        }
   
    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, CONSUMER_STACK_SIZE);
    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
    parm.sched_priority = CONSUMER_TASK_PRI;
    pthread_attr_setschedparam(&attr, &parm);
    rc = pthread_create(&consumer_task, &attr, &consumer, NULL);

    if (rc)
        {
        printk("pthread_create(consumer_task): %d\n", rc);
        goto out;
        }

    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, PRODUCER_STACK_SIZE);
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
    parm.sched_priority = PRODUCER_TASK_PRI;
    pthread_attr_setschedparam(&attr, &parm);
    rc = pthread_create(&producer_task, &attr, &producer, (void *) 42);

    if (rc)
        {
        printk("pthread_create(producer_task): %d\n", rc);
        goto out;
        }

    return 0;

  out:
    rc = -rc ?: -errno;
    __xeno_user_exit();
    return rc;
}

#ifdef __KERNEL__
MODULE_AUTHOR("gilles.chanteperdrix@xenomai.org");
MODULE_LICENSE("GPL");
module_init(__xeno_user_init);
module_exit(__xeno_user_exit);

#elif !defined(__XENO_SIM__)
int main (int ac, char *av[])

{
    sigset_t mask;
    int rc, sig;

    sigemptyset(&mask);
    sigaddset(&mask,SIGINT);
    sigaddset(&mask,SIGTERM);
    sigaddset(&mask,SIGHUP);
    sigaddset(&mask,SIGALRM);

    pthread_sigmask(SIG_BLOCK, &mask, NULL);

    mlockall(MCL_CURRENT|MCL_FUTURE);

    rc = __xeno_user_init();

    if (rc)
        {
        printk("__xeno_user_init: %d\n", -rc);
        return -rc;
        }

    sigwait(&mask, &sig);
    __xeno_user_exit();

    return 0;
}
#endif /* !__XENO_SIM__ && !__KERNEL__ */

--pKcnn4geoO--

