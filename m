From: gohlx002@domain.hid
Date: 21 Jan 2010 09:59:43 -0600
Message-ID: <Gophermail.2.0.1001210959431.7980@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] using the RTAI skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello all,

I'm doing some investigation on migrating my application from RTAI to=20
Xenomai. From the description of a Xenomai skin, it seems like I might be=
=20
able to use the RTAI skin to run my application "as is". Along this line, I=
=20
put together a small test application in RTAI that would be very=20
illustrative if I can get it to run in Xenomai. The first step is of course=
=20
compiling it which I haven't been able to do because of missing references=
=20
to all the RTAI functions (e.g. rt_task_init_schmod). If someone feels like=
=20
helping out, we could work through this whole process (from an RTAI app to=
=20
running on Xenomai) and turn this into another example to add to the=20
examples folder for future reference. Here's the application I'm trying to=
=20
compile (the Makefile I just adapted from the native examples folder and=20
changed the application name):

<CODE SNIP>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

#include <rtai_lxrt.h>

int main(int argc, char *argv[])
{

=09RT_TASK *rttsk;
=09RTIME period;
=09int  hrt =3D 1;
=09int idx, end =3D 0;
=09
=09rt_allow_nonroot_hrt();

         if (!(rttsk =3D rt_task_init_schmod(nam2num("RTTSK"), 2, 0, 0,=20
SCHED_FIFO, 0xF))) {
=09=09printf("CANNOT INIT THE TASK\n");
=09=09exit(1);
=09}

=09/*****************************************************************/
=09/* start the scheduler */
=09
=09rt_set_oneshot_mode();
=09start_rt_timer(0);
=09
=09/*****************************************************************/
=09/***********************************************************/
=09/* run the task */
=09
=09mlockall(MCL_CURRENT | MCL_FUTURE);
=09
=09printf("\nSTARTING TASK\n\n");
=09if (hrt) rt_make_hard_real_time(); =20
=09
=09if (hrt) {
=09=09rt_printk("\nTASK RUNNING\n\n");
=09}else{
=09=09printf("\nTASK RUNNING\n\n");
=09}

=09period =3D nano2count(1e8);
=09
=09rt_task_make_periodic(rttsk, rt_get_time(), period);

=09for (idx =3D 0; idx < 10 && !end; idx++) {=09
=09=09if (hrt) {
=09=09=09rt_printk("Finished step %d\n", idx);
=09=09=09printf("Finished step %d\n", idx);
=09=09} else {
=09=09=09printf("Finished step %d\n", idx);
=09=09}
=09
=09=09/* pause */
=09=09rt_task_wait_period();
=09}
=09

=09rt_sleep(nano2count(1E8));=09
=09rt_make_soft_real_time();
=09
=09/***********************************************************/

=09stop_rt_timer();=09
=09rt_task_delete(rttsk);
=09printf("\nTASK STOPPED\n");
=09return 0;
}
</CODE SNIP>

