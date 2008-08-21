Message-ID: <48ADC7C4.8040902@domain.hid>
Date: Thu, 21 Aug 2008 21:53:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48ADC134.7060605@domain.hid> <48ADC224.9030409@domain.hid>
	<48ADC3B0.4080204@domain.hid> <48ADC493.7000009@domain.hid>
In-Reply-To: <48ADC493.7000009@domain.hid>
Content-Type: multipart/mixed; boundary="------------040408000907030601020002"
Subject: Re: [Xenomai-core] Fast userspace locks for native skin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------040408000907030601020002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Hi Gilles,
>>>>
>>>> do you - or anyone else - happen to have some patches under preparation
>>>> to extend also the native skin with the newly added CONFIG_XENO_FASTSEM
>>>> support? Just to avoid duplicate work (we are about to work on this).
>>> Not yet. But the fastsem work is largely unfinished in other areas: for
>>> instance, semaphores are not implemented yet.
>> neither is x86_64 support, which is a shame...
>>
> 
> Uhh, that's bad. But I guess we are just lacking the required atomic ops
> here, aren't we?

Yes. And with a little luck, these will probably be a cut-n-past of the
x86_32. At the time I started doing this, I had no access to an x86_64,
and since I have an x86_64 at hand, I had no time to implement it.

> 
> What about pthread_cond_*?

Well, nothing can be gained for pthread_cond_wait since it will suspend,
so needs a call to kernel. pthread_cond_signal needs a scheduler
decision (we could store the first pending thread priority in a
user/kernel shared area, with the complication that we would need
updating this priority if it ever changes, but to get the priority of
the current thread, we also need a syscall, moreover switching to
secondary mode).

> 
> And do we have test cases for the support in the posix skin? Or did
> anyone look at the stuff LTP is doing for realtime testing? I guess that
> should be reusable (hmm, with some search&replace also for native...).

I have a small test, attached to this mail. It does not test XNROBBED.
About LTP, a long time ago, I started running the open posix testsuite
with Xenomai, the recurring problem I had was that this testsuite
assumes that the SCHED_OTHER policy means time sharing, so uses the CPU
in endless loops. Needless to say that it systematically caused lockups
with Xenomai (we had not SCHED_OTHER support in Xenomai at that time).

-- 
					    Gilles.

--------------040408000907030601020002
Content-Type: text/x-csrc;
 name="unit_mutex.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unit_mutex.c"

#include <pthread.h>
#include <unistd.h>
#include <string.h>
#include <native/timer.h>
#include <posix/syscall.h>

extern unsigned __pse51_muxid;

#ifdef __pse51_get_current_prio
unsigned get_current_prio(void)
{
	unsigned prio;
	XENOMAI_SKINCALL1(__pse51_muxid, __pse51_get_current_prio, &prio);
	return prio;
}
#endif

int check(const char *service, int status, int err)
{
        if (status >= 0)
                return 0;

        fprintf(stderr, "%s: %s\n", service, strerror(err));
        exit(EXIT_FAILURE);
}

#define check_pthread(service, status)                  \
        ({                                              \
                int _status = (status);                 \
                check((service), -_status, _status);    \
        })

#define check_unix(service, status) check((service), (status), errno)

void *waiter(void *cookie)
{
	pthread_mutex_t *mutex = (pthread_mutex_t *) cookie;
	unsigned long long start, diff;

	check_pthread("pthread_detach", pthread_detach(pthread_self()));
	
	start = rt_timer_tsc();
	check_pthread("waiter mutex_lock", pthread_mutex_lock(mutex));
	diff = rt_timer_tsc2ns(rt_timer_tsc() - start);
	
	if (diff < 10000000) {
		fprintf(stderr, "waiter, waited %Ld.%03u us\n",
			diff / 1000, (unsigned) (diff % 1000));
		exit(EXIT_FAILURE);
	}
	usleep(10000);
	check_pthread("waiter mutex_unlock", pthread_mutex_unlock(mutex));

	return cookie;
}

void simple_wait(void)
{
	unsigned long long start, diff;
	pthread_mutex_t mutex;
	pthread_t waiter_tid;

	fprintf(stderr, "simple_wait\n");
	
	check_pthread("simple mutex_init", pthread_mutex_init(&mutex, NULL));
	check_pthread("simple mutex_lock 1", pthread_mutex_lock(&mutex));

	check_pthread("simple thread_create",
		      pthread_create(&waiter_tid, NULL, waiter, &mutex));
	usleep(10000);
	check_pthread("simple mutex_unlock 1", pthread_mutex_unlock(&mutex));
	sched_yield();

	start = rt_timer_tsc();
	check_pthread("simple mutex_lock 2", pthread_mutex_lock(&mutex));
	diff = rt_timer_tsc2ns(rt_timer_tsc() - start);
	if (diff < 10000000) {
		fprintf(stderr, "main, waited %Ld.%03u us\n",
			diff / 1000, (unsigned) (diff % 1000));
		exit(EXIT_FAILURE);
	}
	check_pthread("simple mutex_unlock 2", pthread_mutex_unlock(&mutex));

	check_pthread("simple mutex_destroy", pthread_mutex_destroy(&mutex));
}

void recursive_wait(void)
{
	unsigned long long start, diff;
	pthread_mutexattr_t mattr;
	pthread_mutex_t mutex;
	pthread_t waiter_tid;

	fprintf(stderr, "recursive_wait\n");

	check_pthread("rec mutexattr_init", pthread_mutexattr_init(&mattr));
	check_pthread("rec mutexattr_settype",
		      pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE));
	check_pthread("rec mutex_init", pthread_mutex_init(&mutex, &mattr));
	check_pthread("rec mutexattr_destroy", pthread_mutexattr_destroy(&mattr));
	check_pthread("rec mutex_lock 1", pthread_mutex_lock(&mutex));
	check_pthread("rec mutex_lock 2", pthread_mutex_lock(&mutex));

	check_pthread("rec thread_create",
		      pthread_create(&waiter_tid, NULL, waiter, &mutex));
	check_pthread("rec mutex_unlock 2", pthread_mutex_unlock(&mutex));
	usleep(10000);
	check_pthread("rec mutex_unlock 1", pthread_mutex_unlock(&mutex));
	sched_yield();

	start = rt_timer_tsc();
	check_pthread("rec mutex_lock 3", pthread_mutex_lock(&mutex));
	diff = rt_timer_tsc2ns(rt_timer_tsc() - start);

	if (diff < 10000000) {
		fprintf(stderr, "main, waited %Ld.%03u us\n",
			diff / 1000, (unsigned) (diff % 1000));
		exit(EXIT_FAILURE);
	}
	check_pthread("rec mutex_unlock 3", pthread_mutex_unlock(&mutex));

	check_pthread("rec mutex_destroy", pthread_mutex_destroy(&mutex));
}

void errorcheck_wait(void)
{
	unsigned long long start, diff;
	pthread_mutexattr_t mattr;
	pthread_mutex_t mutex;
	pthread_t waiter_tid;
	int err;

	fprintf(stderr, "errorcheck_wait\n");

	check_pthread("errorcheck mutexattr_init",
		      pthread_mutexattr_init(&mattr));
	check_pthread("errorcheck mutexattr_settype",
		      pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_ERRORCHECK));
	check_pthread("errorcheck mutex_init", pthread_mutex_init(&mutex, &mattr));
	check_pthread("errorcheck mutexattr_destroy", pthread_mutexattr_destroy(&mattr));
	check_pthread("errorcheck mutex_lock 1", pthread_mutex_lock(&mutex));

	err = pthread_mutex_lock(&mutex);
	if (err != EDEADLK) {
		fprintf(stderr, "errorcheck mutex_lock 2: %s\n", strerror(err));
		exit(EXIT_FAILURE);
	}

	check_pthread("errorcheck thread_create",
		      pthread_create(&waiter_tid, NULL, waiter, &mutex));
	usleep(10000);
	check_pthread("errorcheck mutex_unlock 1", pthread_mutex_unlock(&mutex));
	sched_yield();
	err = pthread_mutex_unlock(&mutex);
	if (err != EPERM) {
		fprintf(stderr, "errorcheck mutex_unlock 2: %s\n",
			strerror(err));
		exit(EXIT_FAILURE);
	}

	start = rt_timer_tsc();
	check_pthread("errorcheck mutex_lock 3", pthread_mutex_lock(&mutex));
	diff = rt_timer_tsc2ns(rt_timer_tsc() - start);
	if (diff < 10000000) {
		fprintf(stderr, "main, waited %Ld.%03u us\n",
			diff / 1000, (unsigned) (diff % 1000));
		exit(EXIT_FAILURE);
	}
	check_pthread("errorcheck mutex_unlock 3", pthread_mutex_unlock(&mutex));

	check_pthread("errorcheck mutex_destroy", pthread_mutex_destroy(&mutex));
}

void pi_wait(void)
{
	unsigned long long start, diff;
	pthread_attr_t waiter_attr;
	struct sched_param sparam;
	pthread_mutexattr_t mattr;
	pthread_mutex_t mutex;
	pthread_t waiter_tid;

	fprintf(stderr, "pi_wait\n");

	check_pthread("pi mutexattr_init",
		      pthread_mutexattr_init(&mattr));
	check_pthread("pi mutexattr_settype",
		      pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT));
	check_pthread("pi mutex_init", pthread_mutex_init(&mutex, &mattr));
	check_pthread("pi mutexattr_destroy", pthread_mutexattr_destroy(&mattr));
	check_pthread("pi mutex_lock 1", pthread_mutex_lock(&mutex));

	check_pthread("pi pthread_attr_init", pthread_attr_init(&waiter_attr));
	check_pthread("pi pthread_setinheritsched",
		      pthread_attr_setinheritsched(&waiter_attr,
						   PTHREAD_EXPLICIT_SCHED));
	check_pthread("pi pthread_attr_setschedpolicy",
		      pthread_attr_setschedpolicy(&waiter_attr, SCHED_FIFO));
	sparam.sched_priority = 45;
	check_pthread("pi pthread_attr_setschedparam",
		      pthread_attr_setschedparam(&waiter_attr, &sparam));
#ifdef __pse51_get_current_prio
	if (get_current_prio() != 0) {
		fprintf(stderr, "pi: non null prio %d\n", get_current_prio());
		exit(EXIT_FAILURE);
	}
#endif
	check_pthread("pi thread_create",
		      pthread_create(&waiter_tid, &waiter_attr, waiter, &mutex));
	usleep(10000);
#ifdef __pse51_get_current_prio
	if (get_current_prio() != 45) {
		fprintf(stderr, "pi: prio %d != 45\n", get_current_prio());
		exit(EXIT_FAILURE);
	}
#endif
	check_pthread("pi mutex_unlock 1", pthread_mutex_unlock(&mutex));
	sched_yield();
#ifdef __pse51_get_current_prio
	if (get_current_prio() != 0) {
		fprintf(stderr, "pi: non null prio %d\n", get_current_prio());
		exit(EXIT_FAILURE);
	}
#endif

	start = rt_timer_tsc();
	check_pthread("pi mutex_lock 2", pthread_mutex_lock(&mutex));
	diff = rt_timer_tsc2ns(rt_timer_tsc() - start);
	if (diff < 10000000) {
		fprintf(stderr, "main, waited %Ld.%03u us\n",
			diff / 1000, (unsigned) (diff % 1000));
		exit(EXIT_FAILURE);
	}
	check_pthread("pi mutex_unlock 2", pthread_mutex_unlock(&mutex));

	check_pthread("pi mutex_destroy", pthread_mutex_destroy(&mutex));
}

struct cond_mutex {
	pthread_mutex_t *mutex;
	pthread_cond_t *cond;
};

void *cond_signaler(void *cookie)
{
	struct cond_mutex *cm = (struct cond_mutex *) cookie;
	unsigned long long start, diff;

	check_pthread("pthread_detach", pthread_detach(pthread_self()));
	
	start = rt_timer_tsc();
	check_pthread("cond_signaler mutex_lock 1",
		      pthread_mutex_lock(cm->mutex));
	diff = rt_timer_tsc2ns(rt_timer_tsc() - start);
	
	if (diff < 10000000) {
		fprintf(stderr, "cond_signaler, mutex_lock waited %Ld.%03u us\n",
			diff / 1000, (unsigned) (diff % 1000));
		exit(EXIT_FAILURE);
	}
	usleep(10000);
	check_pthread("cond_signaler cond_signal",
		      pthread_cond_signal(cm->cond));
	check_pthread("cond_signaler mutex_unlock 2",
		      pthread_mutex_unlock(cm->mutex));
	sched_yield();
	start = rt_timer_tsc();
	check_pthread("cond_signaler mutex_lock 2",
		      pthread_mutex_lock(cm->mutex));
	diff = rt_timer_tsc2ns(rt_timer_tsc() - start);
	if (diff < 10000000) {
		fprintf(stderr,
			"cond_signaler, mutex_lock 2 waited %Ld.%03u us\n",
			diff / 1000, (unsigned) (diff % 1000));
		exit(EXIT_FAILURE);
	}
	check_pthread("cond_signaler mutex_unlock 2",
		      pthread_mutex_unlock(cm->mutex));

	return cookie;
}

void simple_condwait(void)
{
	unsigned long long start, diff;
	pthread_mutex_t mutex;
	pthread_cond_t cond;
	struct cond_mutex cm = {
		.mutex = &mutex,
		.cond = &cond,
	};
	pthread_t cond_signaler_tid;

	fprintf(stderr, "simple_condwait\n");
	
	check_pthread("simple_condwait mutex_init",
		      pthread_mutex_init(&mutex, NULL));
	check_pthread("simple_condwait cond_init",
		      pthread_cond_init(&cond, NULL));
	check_pthread("simple_condwait mutex_lock 1",
		      pthread_mutex_lock(&mutex));

	check_pthread("simple_condwait thread_create",
		      pthread_create(&cond_signaler_tid, NULL, cond_signaler, &cm));
	usleep(10000);
	start = rt_timer_tsc();
	check_pthread("simple_condwait cond_wait 1",
		      pthread_cond_wait(&cond, &mutex));
	diff = rt_timer_tsc2ns(rt_timer_tsc() - start);
	if (diff < 10000000) {
		fprintf(stderr, "main, waited %Ld.%03u us\n",
			diff / 1000, (unsigned) (diff % 1000));
		exit(EXIT_FAILURE);
	}
	usleep(10000);
	check_pthread("simple_condwait mutex_unlock 1",
		      pthread_mutex_unlock(&mutex));
	sched_yield();

	check_pthread("simple_condwait mutex_destroy",
		      pthread_mutex_destroy(&mutex));
	check_pthread("simple_condwait cond_destroy",
		      pthread_cond_destroy(&cond));
}

void recursive_condwait(void)
{
	unsigned long long start, diff;
	pthread_mutexattr_t mattr;
	pthread_mutex_t mutex;
	pthread_cond_t cond;
	struct cond_mutex cm = {
		.mutex = &mutex,
		.cond = &cond,
	};
	pthread_t cond_signaler_tid;

	fprintf(stderr, "recursive_condwait\n");
	
	check_pthread("rec_condwait mutexattr_init",
		      pthread_mutexattr_init(&mattr));
	check_pthread("rec_condwait mutexattr_settype",
		      pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE));
	check_pthread("rec_condwait mutex_init",
		      pthread_mutex_init(&mutex, &mattr));
	check_pthread("rec_condwait mutexattr_destroy",
		      pthread_mutexattr_destroy(&mattr));

	check_pthread("rec_condwait cond_init",
		      pthread_cond_init(&cond, NULL));
	check_pthread("rec_condwait mutex_lock 1",
		      pthread_mutex_lock(&mutex));
	check_pthread("rec_condwait mutex_lock 2",
		      pthread_mutex_lock(&mutex));

	check_pthread("rec_condwait thread_create",
		      pthread_create(&cond_signaler_tid, NULL, cond_signaler, &cm));
	usleep(10000);
	start = rt_timer_tsc();
	check_pthread("rec_condwait cond_wait 1",
		      pthread_cond_wait(&cond, &mutex));
	diff = rt_timer_tsc2ns(rt_timer_tsc() - start);
	if (diff < 10000000) {
		fprintf(stderr, "main, waited %Ld.%03u us\n",
			diff / 1000, (unsigned) (diff % 1000));
		exit(EXIT_FAILURE);
	}
	check_pthread("rec_condwait mutex_unlock 1",
		      pthread_mutex_unlock(&mutex));
	usleep(10000);
	check_pthread("rec_condwait mutex_unlock 2",
		      pthread_mutex_unlock(&mutex));

	sched_yield();
	check_pthread("rec_condwait mutex_destroy",
		      pthread_mutex_destroy(&mutex));
	check_pthread("simple_condwait cond_destroy",
		      pthread_cond_destroy(&cond));
}

int main(void)
{
	check_unix("mlockall", mlockall(MCL_CURRENT | MCL_FUTURE));
	simple_wait();
	recursive_wait();
	errorcheck_wait();
	pi_wait();
	simple_condwait();
	recursive_condwait();
	fprintf(stderr, "Test OK\n");
	return 0;
}

--------------040408000907030601020002--

