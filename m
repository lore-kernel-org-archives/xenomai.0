Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <OFBAF613A3.27D3BC8A-ONC1257CE7.003515C1-C1257CE7.0042F1F4@selex-es.com>
Date: Thu, 29 May 2014 17:16:30 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <D776F8A3-D546-4745-8838-1822C2B10C70@mah.priv.at>
References: <OFBAF613A3.27D3BC8A-ONC1257CE7.003515C1-C1257CE7.0042F1F4@selex-es.com>
Subject: Re: [Xenomai] User Space Interrupt not working
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: matteo.semmoloni@selex-es.com
Cc: xenomai@xenomai.org


Am 29.05.2014 um 14:11 schrieb matteo.semmoloni@selex-es.com:

>=20
>=20
> Hi all,
>=20
> I've pached (succefullly...I hope so) linux kernel 3.8 with Xenomai =
2.6.3.
>=20
> I've two issue about interrupt handled in userspace: the first one is
> related to asynchronous notifications from kernelspace to userspace, =
the
> second one related to creation of interrupt in userspace.
>=20
> 1) I've have an application that must be triggered by an IRQ; if I =
create
> interrupt in kernel space it works properly and interrupt service =
routine
> is fired. In this case, if I create a task at userspace, bind it to =
kernal
> space interrupt and waiting for it, it doesn't work; userspace task is
> always blocked at rt_intr_wait() function. An unexpected behaviour =
occurs
> during debugging: when task switches to secondary mode adding a =
breakpoint,
> task is released with error ENOSYS( -38) returned by rt_intr_wait().


For inspiration on an RTDM driver example for ARM (raspberry, but not =
that far off) you might have a look at

=
http://www.blaess.fr/christophe/2013/02/15/raspberry-pi-interruptions-gpio=
-avec-rtdm/

- Michael


>=20
> In this case, reading /proc/xenomai/stat I see CSW counter of kernel
> interrupt increment but CSW counter of userspace task not.
>=20
>=20
> 2) If I create interrupt in userspace, task is always blocked at
> rt_intr_wait().
> In this case, reading /proc/xenomai/stat I see both task and interrupt =
CSW
> counter not increment.
>=20
>=20
> Hereinafter the code used, the same of xenomai example:
>=20
>=20
> #include <stdio.h>
> #include <signal.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <native/task.h>
> #include <native/intr.h>
> #include <rtdk.h>
>=20
> #define IRQ_NUMBER 91  /* Intercept interrupt */
> #define TASK_PRIO  99 /* Highest RT priority */
> #define TASK_MODE  0  /* No flags */
> #define TASK_STKSZ 0  /* Stack size (use default one) */
>=20
>=20
> RT_INTR Hirq;
> RT_INTR Hirq_bind;
>=20
>=20
> RT_TASK Htask_irq;
> RT_TASK Htask_irq_bind;
>=20
> int irq_count =3D 0;
>=20
>=20
> /* Task in pending on userspace interrupt */
> void irq_user (void *cookie)
> {
> 	int err;
>=20
> 	rt_task_set_periodic(NULL, TM_NOW, 500000000);
>=20
> 	while(1)
> 	{
>=20
> 	   err =3D rt_intr_wait(&Hirq, TM_INFINITE);
>=20
> 	   if (!err)
> 	   {
> 		   irq_count++;
> 	   }
>=20
> 	   rt_task_wait_period(NULL);
> 	}
> }
>=20
>=20
>=20
> /* Task in pending on kernelspace interrupt */
> void irq_user_bind (void *cookie)
> {
> 	int err, exit;
>=20
> 	err =3D rt_intr_bind(&Hirq_bind, "timerInterruptKernel", =
TM_INFINITE);
> 	//at this point bind is correct, task is blocked until interupt =
is
> created in kernel space
>=20
> 	if (!err)
> 	{
> 		exit =3D 0;
> 		while (exit=3D=3D0) {
>=20
> 		err =3D rt_intr_wait(&Hirq_bind, TM_INFINITE);
>=20
> 		if (!err)
> 		{
> 			irq_count++;
> 		}
> 		else
> 		{
> 			// object destroyed
> 			err =3D rt_intr_unbind(&Hirq_bind);
> 			exit =3D 1;
> 		}
> 	}
> }
>=20
>=20
> int main (int argc, char *argv[])
> {
> 	int err, exit =3D 0;
> 	int bind =3D 0;
> 	mlockall(MCL_CURRENT|MCL_FUTURE);
>=20
> 	if (bind =3D=3D 0)
> 	{
> 		/* During this test kernel module is not loaded */
> 		err =3D rt_intr_create(&Hirq, "timerInterruptUser", =
IRQ_NUMBER,
> 0);
> 		if (err) {printf("Error creating Hirq =
(err=3D%d)",err);return
> -1;}
>=20
> 		err =3D rt_intr_enable(&Hirq);
> 		if (err) {printf("Error enabling Hirq =
(err=3D%d)",err);return
> -1;}
>=20
> 		err =3D rt_task_spawn(&Htask_irq,      "TskIrq", 	 =
  TASK_STKSZ,
> 99, TASK_MODE, &irq_user,		NULL);
> 		if (err) {printf("Error creating Htask_irq
> (err=3D%d)",err);return -1;}
> 	}
> 	else
> 	{
> 		/* During this test kernel load is loaded */
> 		err =3D rt_task_spawn(&Htask_irq_bind, "TskIrqBind", =
TASK_STKSZ,
> 99, TASK_MODE, &irq_user_bind,	NULL);
> 		if (err) {printf("Error creating Htask_irq_bind
> (err=3D%d)",err);return -1;}
> 	}
>=20
> 	pause();
>=20
> 	if (bind =3D=3D 0)
> 	{
> 		err =3D rt_intr_disable(&Hirq);
> 		err =3D rt_intr_delete(&Hirq);
> 		rt_task_delete(&Htask_irq);
> 	}
> 	else
> 	{
> 		rt_task_delete(&Htask_irq_bind);
> 	}
> 	return 0;
> }
>=20
>=20
>=20
> Reading the troubleshooting web guide,  I've checked dmesg and both =
ipipe
> and xenomai are loaded correctly, versions files exist and =
CONFIG_XENO_
> SKIN_NATIVE  and CONFIG_XENO_OPT_PERVASIVE configs are enabled.
>=20
> Do you have any idea?
> I don't have any idea how to debugging it, any suggestions?
>=20
> Many thanks in advance.
>=20
> Matteo
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


