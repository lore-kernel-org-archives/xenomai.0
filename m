Message-Id: <47B2D60A0200000100192509@domain.hid>
Date: Wed, 13 Feb 2008 11:35:37 -0500
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] T_RRB - OK
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

It's ok now.

Linux Kernel Configuration / Real-time sub-system / Debug support / =
Watchdog support
was enabled (Watchdog timeout =3D 4).

Disabling it fixed the problem.

It's great!

Thank you very much.

Hubert


>>> Philippe Gerum <rpm@xenomai.org> 13/02/08 9:31 >>>
Hubert Talbot wrote:
> Thanks for explanations. It's clearer now.
>=20
> But...
>=20
> In the following code (almost the same), there is one task that dies =
prematurely.
>

Use GDB to know why.

>=20
> //***********************************************************************=
*******
> #include <stdio.h>
>=20
> #include <sys/mman.h>
>=20
> #include <native/task.h>
>=20
> #include <native/timer.h>
>=20
> #include <native/sem.h>
>=20
>=20
> #define NBTASK 1
>=20
> #define NSEC 	1
>=20
> #define USEC 	1000
>=20
> #define MSEC 	1000000
>=20
> #define SEC 	1000000000LL
>=20
> #define PERIOD  (10 * MSEC)
>=20
> RT_TASK tasks[NBTASK];
>=20
> RT_SEM sem;
>=20
> unsigned long counts[NBTASK];
>=20
>=20
>=20
> static inline unsigned tick_delta(RTIME t0, RTIME t1)
>=20
> {
> //	return ((unsigned)(t1 - t0) * PERIOD) / SEC;
>=20
> 	return rt_timer_ticks2ns(t1 - t0) / SEC;
>=20
> }
>=20
>=20
>=20
> void my_sleep(int nSec, int taskID)
>=20
> {
>=20
> 	RTIME start_ticks, wait_ticks;
>=20
> =09
> //	wait_ticks =3D (nSec * SEC) / PERIOD;
>=20
> 	wait_ticks =3D nSec * rt_timer_ns2ticks(SEC);
>=20
> 	start_ticks =3D rt_timer_read();
> =09
> 	while (rt_timer_read() - start_ticks <=3D wait_ticks)
> 	{
> 		counts[taskID]++;
> 	}
>=20
> }
>=20
>=20
>=20
> void task(void *arg)
>=20
> {
>=20
> 	int taskID =3D (int)(long)arg;
>=20
> 	RTIME start_date, end_date;
>=20
> 	RTIME start_ticks, wait_ticks;
>=20
> =09
>=20
> 	rt_task_slice(NULL, rt_timer_ns2ticks(PERIOD));
>=20
> 	rt_task_set_mode(0, T_RRB, 0);
> =09
>    	printf("task %d start...\n", taskID);
>=20
> 	rt_sem_p(&sem, TM_INFINITE);
>=20
>=20
>=20
> 	start_date =3D rt_timer_read();
> 	my_sleep(5, taskID);
> 	end_date =3D rt_timer_read();
>=20
>=20
>=20
> 	printf("task %d end (%u sec) --> %u\n", taskID, tick_delta(start_da=
te, end_date), counts[taskID]);
>=20
> }
>=20
>=20
>=20
> int main(void)
>=20
> {
>=20
> 	int rc;
>=20
> 	int i;
>=20
> 	RTIME tv1, tv2;
>=20
>=20
> 	mlockall(MCL_CURRENT | MCL_FUTURE);
> =09
> 	memset(counts, 0, NBTASK * sizeof(unsigned long));
>=20
>=20
> 	rc =3D rt_timer_set_mode(1 * MSEC);
>=20
> 	if (rc !=3D 0)
>=20
> 	{
>=20
> 		printf("failed to rt_timer_set_mode: %d\n", rc);
>=20
> 		return rc;
>=20
> 	}
> =09
> 	rt_sem_create(&sem, "sem", 0, S_FIFO);
>=20
> =09
>=20
> 	for (i =3D 0; i < NBTASK; i++)
>=20
> 	{
>=20
> 		char szTaskID[20];
>=20
> 		sprintf(szTaskID, "Task%02d", i);
>=20
> 		rt_task_create(&tasks[i],
>=20
> 				szTaskID,
>=20
> 				4096,
>=20
> 				99,
>=20
> 				T_JOINABLE);
>=20
> 	}
>=20
>=20
>=20
> 	tv1 =3D rt_timer_read();
>=20
>=20
> 	for (i =3D 0; i < NBTASK; i++)
>=20
> 	{
>=20
> 	   	RT_TASK_INFO info;
>=20
> =09
>=20
> 		rt_task_start(&tasks[i], &task, (void *)(long)i);
>=20
> 	}=09
>=20
> =09
> 	rt_sem_broadcast(&sem);
>=20
>=20
>=20
> 	for (i =3D 0; i < NBTASK; i++)
>=20
> 	{
>=20
>    		rt_task_join(&tasks[i]);
>=20
> 		printf("task %d count =3D %u\n", i, counts[i]);
>=20
>    	}
>=20
> 	tv2 =3D rt_timer_read();
>=20
> 	printf("****** total time: %u (sec)\n\n", tick_delta(tv1, tv2));
>=20
>=20
> 	rt_sem_delete(&sem);
> =09
> /*
> 	tv1 =3D rt_timer_read();
>=20
>=20
> 	my_sleep(10, 9);
>=20
> 	tv2 =3D rt_timer_read();
>=20
> 	printf("****** total time: %u (sec)\n\n", tick_delta(tv1, tv2));
>=20
> */
>=20
> 	return 0;
>=20
> }
>=20
> //***********************************************************************=
*******
>=20
>=20
> With...
>=20
> #define NBTASK 5
> ------------------------
>=20
>=20
> output is (task 2 died prematurely):
>=20
> task 0 start...
> task 1 start...
> task 2 start...
> task 3 start...
> task 4 start...
> task 0 end (5 sec) --> 4452399
> task 1 end (5 sec) --> 4456435
> task 3 end (5 sec) --> 4497016
> task 4 end (5 sec) --> 4513423
> task 0 count =3D 4452399
> task 1 count =3D 4456435
> task 2 count =3D 2687455
> task 3 count =3D 4497016
> task 4 count =3D 4513423
> ****** total time: 5 (sec)
>=20
> #define NBTASK 3
> ------------------------
>=20
>=20
> output is (task 2 died prematurely):
>=20
> task 0 start...
> task 1 start...
> task 2 start...
> task 0 end (5 sec) --> 8130524
> task 1 end (5 sec) --> 8140688
> task 0 count =3D 8130524
> task 1 count =3D 8140688
> task 2 count =3D 4211880
> ****** total time: 5 (sec)
>=20
> #define NBTASK 1
> ------------------------
>=20
>=20
> output is (task 0 died prematurely):
>=20
> task 0 start...
> task 0 count =3D 14200778
> ****** total time: 3 (sec)
>=20
>=20
> I think it's abnormal. Isn't it?
>=20
>=20
> Thanks
>=20
> Hubert
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20
Philippe.


