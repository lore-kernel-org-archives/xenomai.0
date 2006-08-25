Subject: Re: [Xenomai-core] [bug] broken PI-chain
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44EF2BA6.9040601@domain.hid>
References: <44EF2BA6.9040601@domain.hid>
Content-Type: multipart/mixed; boundary="=-j1SbdNOr7r3mvsHHPIUH"
Date: Fri, 25 Aug 2006 20:33:54 +0200
Message-Id: <1156530834.4338.42.camel@domain.hid>
Mime-Version: 1.0
Reply-To: rpm@xenomai.org
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


--=-j1SbdNOr7r3mvsHHPIUH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-08-25 at 18:56 +0200, Jan Kiszka wrote:
> Hi,
> 
> the following (academic?) scenario is not handled as expected by the
> nucleus:
> 
>  Prio	^
> 	|                  -- T2
> 	|                 /
> 	|  T0 <----- T1 <- M1
> 	| (M0)  M0  (M1)
> 	+------------------------
> 
> That means: Task T0 at, e.g., prio 1 holds mutex M0. T1, also at prio 1,
> happens to interrupt T0 (round-robin?). T1 already holds M1 and now
> tries to acquire M0. As both are at the same prio level, no boosting
> takes place, all fine. Then T2 comes in play. It's at prio 2 and tries
> to gain access to M1. T1 gets therefore boosted to prio 2 as well, but
> T0 will stay at prio 1 under Xenomai.
> 

Ok, confirmed. The way the PI chain is handled is very academically
broken.

> I hacked this scenario in the attached demo. Set MAX to 2 to let it
> work, leave it 3 and it breaks.

Ouch. It does indeed...

> 
> The problem looks on first sight like this test [1]: the claiming
> relation is only establish if there is a priority delta on entry, but
> that breaks when the claiming thread's prio changes later. Can we simply
> remove this test?

It seems that there is even more than this, and I'm wondering now if
something fishy is not happening with the CLAIMED bit handling too, when
an attempt is made to clear the priority boost.
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/synch.c?v=SVN-trunk#L265

I've slightly adapted your test code so that my friend the simulator
helps us, and a segfault is raised upon exit of task_func(), which goes
south, likely trying to flush the pend queue of some synch object it
should not still be waiting for.

FWIW, I've attached the code and the Makefile adapted to the simulator.

-- 
Philippe.


--=-j1SbdNOr7r3mvsHHPIUH
Content-Disposition: attachment; filename=Makefile
Content-Type: text/x-makefile; name=Makefile; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# Allow overriding xeno-config on make command line
XENO_CONFIG=xeno-config
prefix := $(shell $(XENO_CONFIG) --prefix)

ifeq ($(prefix),)
$(error Please add <xenomai-install-path>/bin to your PATH variable)
endif

GCIC := $(prefix)/bin/gcic
SIM_CFLAGS  := -g
SIM_LDFLAGS := -lnative_sim
SIM_TARGETS := pip-chain

sim: $(SIM_TARGETS)

all: sim

$(SIM_TARGETS): $(SIM_TARGETS:%=%.o)
	$(GCIC) -o $@ $^ $(SIM_LDFLAGS)

%.o: %.c
	$(GCIC) -o $@ -c $< $(SIM_CFLAGS)

clean:
	$(RM) -f *.o *_s.o $(SIM_TARGETS)

--=-j1SbdNOr7r3mvsHHPIUH
Content-Disposition: attachment; filename=pip-chain.c
Content-Type: text/x-csrc; name=pip-chain.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/mutex.h>

#define MAX	3

RT_MUTEX mutex[3];

RT_TASK task[3], main_tcb;

void task_func(void *arg)
{
	int index = (int)arg;

	rt_mutex_lock(&mutex[index], TM_INFINITE);
	rt_mutex_lock(&mutex[index-1], TM_INFINITE);
	rt_mutex_unlock(&mutex[index]);
}

void task_init(void *arg)
{
	RT_TASK_INFO info;
	int i;

	for (i = 0; i < 3; i++)
		rt_mutex_create(&mutex[i], NULL);

	rt_mutex_lock(&mutex[0], TM_INFINITE);

	for (i = 1; i < MAX; i++)
		rt_task_spawn(&task[i], NULL, 0, (i == MAX-1) ? 2 : 1, 0, task_func, (void *)i);

	rt_task_inquire(NULL, &info);
	printf("MAX=%d, prio=%d\n", MAX, info.cprio);

	rt_mutex_unlock(&mutex[0]);

	for (i = 0; i < 3; i++)
		rt_mutex_delete(&mutex[i]);
}

int root_thread_init(void)
{
    return rt_task_spawn(&main_tcb, "task_init", 0, 1, T_JOINABLE, task_init, 0);
}

void root_thread_exit(void)
{
}

--=-j1SbdNOr7r3mvsHHPIUH--


