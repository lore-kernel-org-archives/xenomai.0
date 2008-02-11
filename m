Message-Id: <47B06F8C0200000100192434@domain.hid>
Date: Mon, 11 Feb 2008 15:53:48 -0500
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
References: <47B0371E0200000100192400@domain.hid>
	<47B093D8.2050605@domain.hid>
In-Reply-To: <47B093D8.2050605@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] =?iso-8859-15?q?R=E9p=2E_=3A_Re=3A__T=5FRRB?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

There is something I don't understand.

Does Xenomai really implement RRB?

Here is my code:

//****************************************************
#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>
#include <native/sem.h>

#define NBTASK 2
#define NSEC 	1
#define USEC 	1000
#define MSEC 	1000000
#define SEC 	1000000000

RT_TASK tasks[NBTASK];
RT_SEM sem;

void my_sleep(int nSec)
{
	struct timeval tv_start, tv_current;
=09
	gettimeofday(&tv_start, 0);
=09
	do
	{
//		rt_task_wait_period(NULL);
		struct timeval;
		gettimeofday(&tv_current, 0);
	} while (tv_current.tv_sec - tv_start.tv_sec <=3D nSec);
}


void task(void *arg)
{
	int taskID =3D *((int *)arg);
	struct timeval tv_start, tv_end;
=09
	rt_task_set_mode(0, T_RRB, 0);=20
	rt_task_slice(NULL, rt_timer_ns2ticks(10 * MSEC));=20

	rt_sem_p(&sem, TM_INFINITE);=20
   	printf("task %d start...\n", taskID);
	gettimeofday(&tv_start, 0);

//	sleep(1);
	my_sleep(1);

	gettimeofday(&tv_end, 0);
	printf("task %d end (%d sec)\n", taskID, tv_end.tv_sec - tv_start.t=
v_sec);
}

int main(void)
{
	int rc;
	int i;
	struct timeval tv1, tv2;

	mlockall(MCL_CURRENT | MCL_FUTURE);
=09
	rc =3D rt_timer_set_mode(1 * MSEC);
	if (rc !=3D 0)
	{
		printf("failed to rt_timer_set_mode: %d\n", rc);
		return rc;
	}

	rt_sem_create(&sem, "sem", 0, S_FIFO);
=09
	for (i =3D 0; i < NBTASK; i++)
	{
		char szTaskID[20];
		sprintf(szTaskID, "Task%02d", i);
		rt_task_create(&tasks[i],
				szTaskID,
				4096,
				99,
				T_JOINABLE);
	}

	gettimeofday(&tv1, 0);

	for (i =3D 0; i < NBTASK; i++)
	{
	   	RT_TASK_INFO info;
=09
		rt_task_start(&tasks[i], &task, (void *)&i);
	}=09
=09
	rt_sem_broadcast(&sem);

	for (i =3D 0; i < NBTASK; i++)
	{
    		rt_task_join(&tasks[i]);
    	}

	gettimeofday(&tv2, 0);
	printf("****** total time: %d (sec)\n\n", tv2.tv_sec - tv1.tv_sec);=


	rt_sem_delete(&sem);

	return 0;
}
 =20
//****************************************************

CASE 1
---------
In the task function, if I use my_sleep() the output is:

	task 0 start...
	task 0 end (2 sec)
	task 1 start...
	task 1 end (2 sec)
	****** total time: 4 (sec)

...not really RRB.

CASE 2
---------
If I use sleep() the output is:

	task 0 start...
	task 1 start...
	task 0 end (1 sec)
	task 1 end (1 sec)
	****** total time: 1 (sec)

...ok, RRB but why?

CASE 3
---------
In my_sleep(), if I uncomment=20

	// rt_task_wait_period(NULL);

The output is

	task 0 start...
	task 1 start...
	task 0 end (2 sec)
	task 1 end (2 sec)
	****** total time: 2 (sec)

It seems for me the the latter does not need RRB.


Sould output from CASE 1 be like CASE 2 (or at least like CASE 3) ?

Am I missing something?

Thanks in advance

Hubert



>>> Philippe Gerum <rpm@xenomai.org> 2008-02-11 13:28 >>>
Hubert Talbot wrote:
> Hi,
>=20
> I'm new to Xenomai.
>=20
> I am studying xenomai and I would like to kwow how to apply round-robin.
>=20
> Specifically, what to do with (do I have to?):
>=20
> 	- the kernel configuration
>=20
> 		Real-time sub-system/Timing/Enable periodic timing ?
>

Yes. Round-robin scheduling is only available with tick-based timing.

> 	- the timer configuration=20
>=20
> 		rt_timer_set_mode(rt_timer_ns2ticks(???))  ?
>=20

rt_timer_set_mode(ns), to switch the default oneshot mode for the native
API to tick-based.

> 	- the task configuration
>=20
> 		rt_task_set_periodic(???)  ?

Not this one; it controls whether your task follows a periodic timeline
using the rt_task_wait_period() service. It's not related to RRB.

> 		rt_task_set_mode(0, T_RRB, 0)    ?

Yes, this one is needed to switch on RRB for the calling task.

> 		rt_task_slice(???)  ?
>=20

And this one allows to set the time quantum alloted to the task (in =
ticks).

> Thanks in advanced.
>=20
> Hubert
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help=20
>=20


--=20
Philippe.


