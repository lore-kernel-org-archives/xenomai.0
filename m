From: <matteo.semmoloni@selex-es.com>
Message-ID: <OFBAF613A3.27D3BC8A-ONC1257CE7.003515C1-C1257CE7.0042F1F4@selex-es.com>
Date: Thu, 29 May 2014 14:11:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] User Space Interrupt not working
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



Hi all,

I've pached (succefullly...I hope so) linux kernel 3.8 with Xenomai 2.6=
.3.

I've two issue about interrupt handled in userspace: the first one is
related to asynchronous notifications from kernelspace to userspace, th=
e
second one related to creation of interrupt in userspace.

1) I've have an application that must be triggered by an IRQ; if I crea=
te
interrupt in kernel space it works properly and interrupt service routi=
ne
is fired. In this case, if I create a task at userspace, bind it to ker=
nal
space interrupt and waiting for it, it doesn't work; userspace task is
always blocked at rt_intr_wait() function. An unexpected behaviour occu=
rs
during debugging: when task switches to secondary mode adding a breakpo=
int,
task is released with error ENOSYS( -38) returned by rt_intr_wait().

In this case, reading /proc/xenomai/stat I see CSW counter of kernel
interrupt increment but CSW counter of userspace task not.


2) If I create interrupt in userspace, task is always blocked at
rt_intr_wait().
In this case, reading /proc/xenomai/stat I see both task and interrupt =
CSW
counter not increment.


Hereinafter the code used, the same of xenomai example:


#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/intr.h>
#include <rtdk.h>

#define IRQ_NUMBER 91  /* Intercept interrupt */
#define TASK_PRIO  99 /* Highest RT priority */
#define TASK_MODE  0  /* No flags */
#define TASK_STKSZ 0  /* Stack size (use default one) */


RT_INTR Hirq;
RT_INTR Hirq_bind;


RT_TASK Htask_irq;
RT_TASK Htask_irq_bind;

int irq_count =3D 0;


/* Task in pending on userspace interrupt */
void irq_user (void *cookie)
{
	int err;

	rt_task_set_periodic(NULL, TM_NOW, 500000000);

	while(1)
	{

	   err =3D rt_intr_wait(&Hirq, TM_INFINITE);

	   if (!err)
	   {
		   irq_count++;
	   }

	   rt_task_wait_period(NULL);
	}
}



/* Task in pending on kernelspace interrupt */
void irq_user_bind (void *cookie)
{
	int err, exit;

	err =3D rt_intr_bind(&Hirq_bind, "timerInterruptKernel", TM_INFINITE);=

	//at this point bind is correct, task is blocked until interupt is
created in kernel space

	if (!err)
	{
		exit =3D 0;
		while (exit=3D=3D0) {

		err =3D rt_intr_wait(&Hirq_bind, TM_INFINITE);

		if (!err)
		{
			irq_count++;
		}
		else
		{
			// object destroyed
			err =3D rt_intr_unbind(&Hirq_bind);
			exit =3D 1;
		}
	}
}


int main (int argc, char *argv[])
{
	int err, exit =3D 0;
	int bind =3D 0;
	mlockall(MCL_CURRENT|MCL_FUTURE);

	if (bind =3D=3D 0)
	{
		/* During this test kernel module is not loaded */
		err =3D rt_intr_create(&Hirq, "timerInterruptUser", IRQ_NUMBER,
0);
		if (err) {printf("Error creating Hirq (err=3D%d)",err);return
-1;}

		err =3D rt_intr_enable(&Hirq);
		if (err) {printf("Error enabling Hirq (err=3D%d)",err);return
-1;}

		err =3D rt_task_spawn(&Htask_irq,      "TskIrq", 	   TASK_STKSZ,
99, TASK_MODE, &irq_user,		NULL);
		if (err) {printf("Error creating Htask_irq
(err=3D%d)",err);return -1;}
	}
	else
	{
		/* During this test kernel load is loaded */
		err =3D rt_task_spawn(&Htask_irq_bind, "TskIrqBind", TASK_STKSZ,
99, TASK_MODE, &irq_user_bind,	NULL);
		if (err) {printf("Error creating Htask_irq_bind
(err=3D%d)",err);return -1;}
	}

	pause();

	if (bind =3D=3D 0)
	{
		err =3D rt_intr_disable(&Hirq);
		err =3D rt_intr_delete(&Hirq);
		rt_task_delete(&Htask_irq);
	}
	else
	{
		rt_task_delete(&Htask_irq_bind);
	}
	return 0;
}



Reading the troubleshooting web guide,  I've checked dmesg and both ipi=
pe
and xenomai are loaded correctly, versions files exist and CONFIG_XENO_=

SKIN_NATIVE  and CONFIG_XENO_OPT_PERVASIVE configs are enabled.

Do you have any idea?
I don't have any idea how to debugging it, any suggestions?

Many thanks in advance.

Matteo=
