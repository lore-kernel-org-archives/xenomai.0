Date: Wed, 26 Oct 2005 16:23:30 +0200 (MEST)
From: "j.p.schulz" <j.p.schulz@domain.hid>
MIME-Version: 1.0
References: <435F8A90.8050809@domain.hid>
Subject: Re: [Xenomai-help] Spawn Task from a Task -vxworks-skin
Message-ID: <11384.1130336610@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

> --- Urspr=FCngliche Nachricht ---
> Von: Philippe Gerum <rpm@xenomai.org>
> An: "j.p.schulz" <j.p.schulz@domain.hid>
> Kopie: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Spawn Task from a Task -vxworks-skin
> Datum: Wed, 26 Oct 2005 15:54:24 +0200
>=20
> j.p.schulz wrote:
> >>--- Urspr=FCngliche Nachricht ---
> >>Von: Philippe Gerum <rpm@xenomai.org>
> >>An: "j.p.schulz" <j.p.schulz@domain.hid>
> >>Kopie: xenomai@xenomai.org
> >>Betreff: Re: [Xenomai-help] Spawn Task from a Task -vxworks-skin
> >>Datum: Wed, 26 Oct 2005 10:09:19 +0200
> >>
> >>j.p.schulz wrote:
> >>
> >>>Hello
> >>>I have Problems spawning a Task from a Task under the vxworks skin!
> >>>If I spawn my Tasks from a Funktion - it works!
> >>>If I spawn my Tasks from a Task     - system crashes!
> >>
> >>Make sure to use an Adeos patch >=3D 1.0-07. v0.9.1 ships with 1.0-02, =
so
> >>you=20
> >>likely want to upgrade and try again. Recent Adeos patches for x86 can
> be
> >>found=20
> >>here: http://download.gna.org/adeos/patches/v2.6/adeos/i386/
> >>
> >=20
> >=20
> > I installed the latest Fusion 9.1 patch - no changes
>=20
> Which _Adeos_ patch version, exactely?
>=20
> > Do I make a mistake when I am spawning the tasks?
> >=20
> > Second Problem ist that the uvm module has to be started twice. The
> first
> > attempt returns: -1 Function not implemented=20
> > The second attempt works!=20
> >=20
>=20
> Does dmesg say something after the first attempt?
>=20
> >=20
> >>>Here the programm:
> >>>
> >>>#include <stdlib.h>
> >>>#include <stdio.h>
> >>>#include <string.h>
> >>>#include <signal.h>
> >>>#include <ctype.h>
> >>>#include <fcntl.h>
> >>>#include <sys/io.h>
> >>>#include <sys/stat.h>
> >>>#include <sys/ioctl.h>
> >>>
> >>>#include <vxworks/vxworks.h>
> >>>
> >>>#include "vxChain.h"
> >>>#include "portutils.h"
> >>>
> >>>
> >>>#define PRIORITY_LOW 	100
> >>>#define PRIORITY_MID 	90
> >>>#define PRIORITY_HIGH 	80
> >>>
> >>>#define USE_FPU 		(VX_FP_TASK | VX_NO_STACK_FILL)
> >>>#define NO_FPU 			VX_NO_STACK_FILL
> >>>#define STACK_SIZE 		0x5000
> >>>#define TASK_OPTIONS	USE_FPU
> >>>
> >>>#define NUM_TASKS		8
> >>>#define MAX_TASKS		15
> >>>
> >>>SEM_ID		semId[MAX_TASKS * 2];
> >>>int			taskId[MAX_TASKS];
> >>>int			triggerId;
> >>>
> >>>
> >>>int root_thread_init()
> >>>{
> >>>	// Allow port I/O in userspace
> >>>	iopl(3);
> >>>=09
> >>>	vxTest();		// Just a function call (works)
> >>>//	vxSpawn();		// Spawns the function as a task (crashes)
> >>>
> >>>	return 0;=09
> >>>}
> >>>
> >>>void vxSpawn( void )
> >>>{
> >>>	taskSpawn ("Master Task", PRIORITY_HIGH,=20
> >>>				TASK_OPTIONS, STACK_SIZE,=20
> >>>				(FUNCPTR) vxTest,
> >>>				0,0,0,0,0,0,0,0,0,0); 				=09
> >>>}
> >>>=09
> >>>void root_thread_exit (void)
> >>>{
> >>>	printf ("root_thread_exit() called.\n");
> >>>}=09
> >>>
> >>>void vxTest( void )
> >>>{
> >>>	int i; =20
> >>>    char buf[80];
> >>>       =20
> >>>    for (i=3D0; i < NUM_TASKS; i++)
> >>>    {
> >>>		semId[2*i]   =3D semBCreate( SEM_Q_PRIORITY, SEM_EMPTY);   =20
> >>>		semId[2*i+1] =3D semBCreate( SEM_Q_PRIORITY, SEM_EMPTY);       =20
> >>>    }
> >>>        =20
> >>>    for (i=3D0; i < NUM_TASKS; i++)
> >>>    {=20
> >>>		sprintf(buf, "Task_%d", i);   =20
> >>>		taskId[i] =3D=20
> >>>		taskSpawn(buf, PRIORITY_LOW, TASK_OPTIONS, STACK_SIZE,
> >>>			(FUNCPTR) WorkerTask,=20
> >>>			i, 				// Task Nummer
> >>>			semId[i], 		// warten auf Semaphor
> >>>			semId[i+1],   	// anzutriggerndes Semaphor
> >>>			0,0,0,0,0,0,0);	=09
> >>>		=09
> >>>		printf ("task[%d] =3D 0x%08X, errno =3D %d\n", i, taskId[i], errnoGe=
t());
> >>>    }
> >>>
> >>>    triggerId =3D taskSpawn ("Trigger task", PRIORITY_MID,=20
> >>>    					TASK_OPTIONS, STACK_SIZE,
> >>>						(FUNCPTR) TriggerTask, 0,0,0,0,0,0,0,0,0,0);
> >>>	printf ("taskTrigger =3D 0x%08X\n", triggerId);
> >>>=09
> >>>	taskSuspend(taskIdSelf());
> >>>}
> >>>
> >>>void TriggerTask( void )
> >>>{
> >>>	while( 1 )
> >>>	{
> >>>		taskDelay(1);
> >>>		semGive(semId[0]);
> >>>	}
> >>>}
> >>>
> >>>FUNCPTR WorkerTask(int i0,int i1,int i2,int i3,int i4,int i5,int i6,int
> >>>i7,int i8,int i9)
> >>>{
> >>>    unsigned int task_num 	=3D (unsigned int) i0;
> >>>    int sem_to_wait 		=3D i1;
> >>>    int sem_to_trigger		=3D i2;
> >>>
> >>>	iopl(3);
> >>>    while (1)
> >>>    {
> >>>		semTake(sem_to_wait, WAIT_FOREVER);
> >>>		if (task_num < 8)
> >>>		{
> >>>			lpt_peak_bit (task_num);=09
> >>>		}=09
> >>>		semGive(sem_to_trigger);		=09
> >>>    }
> >>>    return 0;
> >>>}   =20
> >>>
> >>>
> >>>
> >>>Fusion 0.9.1
> >>>Kernel 2.6.13-ipipe
> >>>Suse 9.3
> >>>Any Ideas?
> >>>Thanks=20
> >>>Jan-Peter
> >>>
> >>
> >>
> >>--=20
> >>
> >>Philippe.
> >>
> >=20
> >=20
>=20
>=20
> --=20
>=20
> Philippe.
>=20

--=20
10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
+++ GMX - die erste Adresse f=FCr Mail, Message, More +++

