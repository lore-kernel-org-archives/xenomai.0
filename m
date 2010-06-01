Date: Tue, 1 Jun 2010 17:54:04 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100601155403.GA8240@domain.hid>
References: <20100601135005.GA5483@domain.hid>
	<1275402757.27918.151.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <1275402757.27918.151.camel@domain.hid>
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Handling Linux Signals in primary domain context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2010 at 04:32:37PM +0200, Philippe Gerum wrote:
> Not in the absence of syscall. We thought about this once already, when
> considering how a watchdog preempting a runaway task in primary mode
> could force a secondary mode switch: there is no sane and easy solution
> to this unfortunately.

This is exactly Sigmatek's problem: Our customers develop code
within our debugging/development environment. We want to catch
this situation (the developer implements a while(1)) with a
watchdog throwing SIGTRAP so that our debugger gets active
and can locate the problem according to the stack frame...

Find attached a separated test case (using SIGTERM which
should terminate the application). When pressing space
the system freezes (work_l() is in the while() loop with
pending signal and work_h() does not rt_task_suspend()
anymore (returning EINTR).

Then, we implement a workaround sending a rt-signal
when rt_task_suspend() returns EINTR. In the rt-signal
handler we explicitely migrate the task to secondary
domain, where linux signal handling is triggered...

Thanks,

	Olli

--=20
Tschaeche IT-Services       Tel.:  +49/9134/9089850
Dr.-Ing. Oliver Tsch=E4che    Mobil: +49/176/20435601
Welluckenweg 4              Email: services@domain.hid
91077 Neunkirchen

--9amGYk9869ThD9tj
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="signal2xenomai.c"

/* compile with gcc -Wall -D_GNU_SOURCE -lpthread -o thisfile thisfile.c */
/*
 * Simple test app to show pthread api mutex behaviour.
 *
 * This is compared against the Xenomai native api behaviour.
 * See mutex_xeno_native.c
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/mman.h>		/* Needed for mlockall() */
#include <limits.h>
#include <pthread.h>

#include "native/task.h"

#define MY_STACK_SIZE (100*1024)      /* 100 kB is enough for now. */

static pthread_t ph, pl;
static RT_TASK xh, xl;
static volatile int state = 0;

void *
work_h(void *cookie)
{
	if (rt_task_shadow(&xh, "high", 50, 0)) {
		printf("failed to shadow high\n");
		return NULL;
	}
	if (rt_task_set_periodic(&xh, TM_NOW, 1000000)) {
		printf("failed to set high periodic\n");
		return NULL;
	}
	while (1) {
		if (rt_task_wait_period(NULL)) {
			printf("wait_period failed\n");
			break;
		}

		switch (state) {
			case -1:
				if (rt_task_suspend(&xl)) {
					/* work around??? */
				}
				state = 1;
				break;
			case 1:
				rt_task_resume(&xl);
				state = -1;
				break;
			default:
				break;
		}
	}
	return NULL;
}

void *
work_l(void *cookie)
{
	if (rt_task_shadow(&xl, "low", 25, 0)) {
		printf("failed to shadow low\n");
		return NULL;
	}
	if (rt_task_set_mode(0, T_PRIMARY, NULL)) {
		printf("failed to migrate low\n");
		return NULL;
	}
	state = -1;
	while (1)
		;
	return NULL;
}

int main(void)
{
	pthread_attr_t threadattr;
	mlockall(MCL_CURRENT | MCL_FUTURE);

	pthread_attr_init(&threadattr);
	pthread_attr_setstacksize(&threadattr, MY_STACK_SIZE);

	pthread_create(&ph, &threadattr, work_h, NULL);
	printf("high prio watchdog started\n");
	pthread_create(&pl, &threadattr, work_l, NULL);
	printf("low prio work started\n");

	printf("Press <ENTER> to send a signal\n");
	getc(stdin);

	pthread_kill(pl, SIGTERM);

	/* you will not get here, because work_l() eats up your CPU */
	printf("Press <ENTER> to finish\n");
	getc(stdin);

	printf("main finished\n");
	return 0;
}

--9amGYk9869ThD9tj--

