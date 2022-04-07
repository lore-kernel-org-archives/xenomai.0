Message-ID: <53b70915-2040-d2aa-3077-698fa8be01af@siemens.com>
Date: Thu, 7 Apr 2022 11:47:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] cobalt/events: add auto-clear feature
Content-Language: en-US
References: <20220406155648.1592472-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220406155648.1592472-1-rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 06.04.22 17:56, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> The current implementation does not atomically consume+clear the event
> set to be received by the waiter(s), which makes it useless for
> anything but a plain one-time latch due to the race window this opens
> with a consume[A]->signal[B]->clear[A] sequence.
> 
> To address this issue, let's provide the auto-clear feature with
> __cobalt_event_wait().
> 
> This change affects the ABI by adding the auto-clear mode as an opt-in
> feature, enabled by passing COBALT_EVENT_AUTOCLEAR to
> cobalt_event_init().
> 

Makes sense, but shouldn't autoclear be rather the default then? Which
users are affected? None in-tree so far?

Jan

> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  configure.ac                        |   1 +
>  include/cobalt/uapi/event.h         |   7 +-
>  kernel/cobalt/posix/event.c         |  17 +++-
>  testsuite/smokey/Makefile.am        |   2 +
>  testsuite/smokey/events/Makefile.am |   8 ++
>  testsuite/smokey/events/events.c    | 123 ++++++++++++++++++++++++++++
>  6 files changed, 152 insertions(+), 6 deletions(-)
>  create mode 100644 testsuite/smokey/events/Makefile.am
>  create mode 100644 testsuite/smokey/events/events.c
> 
> diff --git a/configure.ac b/configure.ac
> index 5611b5b8db..15d3e46e9a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1002,6 +1002,7 @@ AC_CONFIG_FILES([ \
>  	testsuite/smokey/gdb/Makefile \
>  	testsuite/smokey/y2038/Makefile \
>  	testsuite/smokey/can/Makefile
> +	testsuite/smokey/events/Makefile \
>  	testsuite/clocktest/Makefile \
>  	testsuite/xeno-test/Makefile \
>  	utils/Makefile \
> diff --git a/include/cobalt/uapi/event.h b/include/cobalt/uapi/event.h
> index 8710e8e25f..14ddbcf567 100644
> --- a/include/cobalt/uapi/event.h
> +++ b/include/cobalt/uapi/event.h
> @@ -30,9 +30,10 @@ struct cobalt_event_state {
>  struct cobalt_event;
>  
>  /* Creation flags. */
> -#define COBALT_EVENT_FIFO    0x0
> -#define COBALT_EVENT_PRIO    0x1
> -#define COBALT_EVENT_SHARED  0x2
> +#define COBALT_EVENT_FIFO       0x0
> +#define COBALT_EVENT_PRIO       0x1
> +#define COBALT_EVENT_SHARED     0x2
> +#define COBALT_EVENT_AUTOCLEAR  0x4
>  
>  /* Wait mode. */
>  #define COBALT_EVENT_ALL  0x0
> diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
> index 052c686050..0a1236ad73 100644
> --- a/kernel/cobalt/posix/event.c
> +++ b/kernel/cobalt/posix/event.c
> @@ -146,7 +146,7 @@ int __cobalt_event_wait(struct cobalt_event_shadow __user *u_event,
>  	if (bits == 0) {
>  		/*
>  		 * Special case: we don't wait for any event, we only
> -		 * return the current flag group value.
> +		 * return the pending ones without consuming them.
>  		 */
>  		rbits = state->value;
>  		goto out;
> @@ -155,8 +155,11 @@ int __cobalt_event_wait(struct cobalt_event_shadow __user *u_event,
>  	state->flags |= COBALT_EVENT_PENDED;
>  	rbits = state->value & bits;
>  	testval = mode & COBALT_EVENT_ANY ? rbits : bits;
> -	if (rbits && rbits == testval)
> +	if (rbits && rbits == testval) {
> +		if (event->flags & COBALT_EVENT_AUTOCLEAR)
> +			state->value &= ~rbits;
>  		goto done;
> +	}
>  
>  	if (timeout == XN_NONBLOCK) {
>  		ret = -EWOULDBLOCK;
> @@ -239,7 +242,7 @@ COBALT_SYSCALL(event_wait64, primary,
>  COBALT_SYSCALL(event_sync, current,
>  	       (struct cobalt_event_shadow __user *u_event))
>  {
> -	unsigned int bits, waitval, testval;
> +	unsigned int bits, waitval, testval, consumed = 0;
>  	struct xnthread_wait_context *wc;
>  	struct cobalt_event_state *state;
>  	struct event_wait_context *ewc;
> @@ -275,10 +278,18 @@ COBALT_SYSCALL(event_sync, current,
>  		if (waitval && waitval == testval) {
>  			state->nwaiters--;
>  			ewc->value = waitval;
> +			consumed |= waitval;
>  			xnsynch_wakeup_this_sleeper(&event->synch, p);
>  		}
>  	}
>  
> +	/*
> +	 * If some flags were consumed and auto-clear is enabled,
> +	 * clear the former.
> +	 */
> +	if (consumed && (event->flags & COBALT_EVENT_AUTOCLEAR))
> +		state->value &= ~consumed;
> +
>  	xnsched_run();
>  out:
>  	xnlock_put_irqrestore(&nklock, s);
> diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
> index 4a9773f586..3f0521282b 100644
> --- a/testsuite/smokey/Makefile.am
> +++ b/testsuite/smokey/Makefile.am
> @@ -14,6 +14,7 @@ COBALT_SUBDIRS = 	\
>  	bufp		\
>  	can		\
>  	cpu-affinity	\
> +	events		\
>  	fpu-stress	\
>  	gdb		\
>  	iddp		\
> @@ -53,6 +54,7 @@ DIST_SUBDIRS = 		\
>  	can		\
>  	cpu-affinity	\
>  	dlopen		\
> +	events		\
>  	fpu-stress	\
>  	gdb		\
>  	iddp		\
> diff --git a/testsuite/smokey/events/Makefile.am b/testsuite/smokey/events/Makefile.am
> new file mode 100644
> index 0000000000..37b9f92d7f
> --- /dev/null
> +++ b/testsuite/smokey/events/Makefile.am
> @@ -0,0 +1,8 @@
> +
> +noinst_LIBRARIES = libevents.a
> +
> +libevents_a_SOURCES = events.c
> +
> +libevents_a_CPPFLAGS = 		\
> +	@XENO_USER_CFLAGS@	\
> +	-I$(top_srcdir)/include
> diff --git a/testsuite/smokey/events/events.c b/testsuite/smokey/events/events.c
> new file mode 100644
> index 0000000000..79711795ac
> --- /dev/null
> +++ b/testsuite/smokey/events/events.c
> @@ -0,0 +1,123 @@
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <smokey/smokey.h>
> +#include <cobalt/time.h>
> +#include <cobalt/semaphore.h>
> +#include <cobalt/pthread.h>
> +#include <cobalt/sys/cobalt.h>
> +#include <boilerplate/time.h>
> +
> +smokey_test_plugin(events,
> +		   SMOKEY_NOARGS,
> +		   "Check event event"
> +);
> +
> +#define LOW_PRIO	1
> +#define HIGH_PRIO	2
> +
> +struct test_context {
> +	cobalt_event_t event;
> +	sem_t start;
> +	sem_t sem;
> +};
> +
> +static void *event_receiver(void *arg)
> +{
> +	struct test_context *p = arg;
> +	struct timespec now, timeout;
> +	unsigned int bits;
> +	int ret;
> +
> +	sem_wait(&p->start);
> +	clock_gettime(CLOCK_MONOTONIC, &now);
> +	timespec_adds(&timeout, &now, 400000000); /* 400ms */
> +
> +	/* Sender is quiet: expect timeout. */
> +	if (!__F(ret, cobalt_event_wait(&p->event, -1U, &bits,
> +				COBALT_EVENT_ANY, &timeout)) ||
> +		!__Tassert(ret == -ETIMEDOUT))
> +		goto fail;
> +
> +	sem_post(&p->sem);
> +
> +	/* Sender should have sent 0x12121212. */
> +	clock_gettime(CLOCK_MONOTONIC, &now);
> +	timespec_adds(&timeout, &now, 400000000); /* 400ms */
> +	if (!__T(ret, cobalt_event_wait(&p->event, -1U, &bits,
> +				COBALT_EVENT_ANY, &timeout)))
> +		goto fail;
> +
> +	if (!__Tassert(bits == 0x12121212))
> +		goto fail;
> +
> +	sem_post(&p->sem);
> +
> +	/* Sender should send 0x41414141 in a moment. */
> +	if (!__T(ret, cobalt_event_wait(&p->event, 0x41414141, &bits,
> +				COBALT_EVENT_ALL, NULL)))
> +		goto fail;
> +
> +	if (!__Tassert(bits == 0x41414141))
> +		goto fail;
> +
> +	sem_post(&p->sem);
> +
> +	return NULL;
> +fail:
> +	exit(-ret);
> +}
> +
> +static int run_events(struct smokey_test *t, int argc, char *const argv[])
> +{
> +	struct sched_param param;
> +	struct test_context c;
> +	pthread_attr_t attr;
> +	void *status = NULL;
> +	pthread_t receiver;
> +	int ret;
> +
> +	param.sched_priority = HIGH_PRIO;
> +	if (!__Tassert(pthread_setschedparam(pthread_self(),
> +			SCHED_FIFO, &param) == 0))
> +		return -EPERM;
> +
> +	sem_init(&c.sem, 0, 0);
> +	sem_init(&c.start, 0, 0);
> +
> +	if (!__T(ret, cobalt_event_init(&c.event, 0,
> +		COBALT_EVENT_FIFO|COBALT_EVENT_AUTOCLEAR)))
> +		return ret;
> +
> +	param.sched_priority = LOW_PRIO;
> +	pthread_attr_init(&attr);
> +	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
> +	pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
> +	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
> +	pthread_attr_setschedparam(&attr, &param);
> +
> +	if (!__T(ret, pthread_create(&receiver, &attr, event_receiver, &c)))
> +		return ret;
> +
> +	sem_post(&c.start);
> +	sem_wait(&c.sem);
> +
> +	if (!__T(ret, cobalt_event_post(&c.event, 0x12121212)))
> +		return ret;
> +
> +	sem_wait(&c.sem);
> +	usleep(1000);
> +
> +	if (!__T(ret, cobalt_event_post(&c.event, 0x41414141)))
> +		return ret;
> +
> +	sem_wait(&c.sem);
> +
> +	pthread_join(receiver, &status);
> +	if (!__Tassert(status == NULL))
> +		return -EPROTO;
> +
> +	if (!__T(ret, cobalt_event_destroy(&c.event)))
> +		return ret;
> +
> +	return 0;
> +}

-- 
Siemens AG, Technology
Competence Center Embedded Linux

