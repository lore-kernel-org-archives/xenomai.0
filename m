Message-ID: <2F8EE677D406514ABE53EF9C0934A666042ABE80@domain.hid>
From: Laurent.POYART@fr.thalesgroup.com
Date: Thu, 19 Jun 2008 15:29:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem using xenomai threads with eclipse
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

Hi,
I have tested with gdb in text mode and my Pc still freezes without any
message. I saw in the mailing list that there was some problems under =
title
"gdb + multi-threaded-applications + intel dual core" (which is my =
case) and
someone told to disable the dual core capability in the BIOS . I made =
this
test and I have no more the problem. I'm going to use this =
configuration as
it is not my final target.

Regards.
L.Poyart

> -----Message d'origine-----
> De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Envoy=E9 : jeudi 19 juin 2008 02:16
> =C0 : Laurent.POYART@fr.thalesgroup.com
> Cc : xenomai@xenomai.org
> Objet : Re: [Xenomai-help] Problem using xenomai threads with eclipse
>=20
>=20
> Laurent.POYART@fr.thalesgroup.com wrote:
> > Hi,
> >=20
> > I'm compiling a xenomai user land application using eclipse=20
> CDT 3.2.2  and
> > my Pc hangs when I run it using debug (gbd).=20
> >=20
> > Context:
> >=20
> > Linux kernel : 2.6.23
> > Xenomai : 2.4.1
> > Architecture: Pentium Dual Core (PC).
> > Xenomai Configuration : priority coupling.
> > Linker options: -Wl,--wrap,pthread_create -Wl,-soname=3Dpthread_rt
> > (only pthread_create is wrapped)
> >=20
> > The application code is the following (the problem is=20
> described after the
> > source code):
> >=20
> > #include<iostream>
> > #include<cassert>
> > using namespace std;
> >=20
> > #include <sys/mman.h>
> > #include <pthread.h>
> > #include <semaphore.h>
> > #include <mqueue.h>
> > #include <errno.h>
> >=20
> > // Lock used to make the thread wait for start enable
> > sem_t s_SemThreadStartEnable;
> >=20
> > // For Test
> > sem_t s_SemThreadTest;
> > =20
> > // Thread function for the Xenomai RT Thread=20
> > void* mythreadfunctionrt(void* arg)
> > {
> > 	// Wait start Enable (not wrapped =3D> linux syscall)
> >     int result =3D sem_wait(&s_SemThreadStartEnable);
> >     assert(result =3D=3D 0);
> >=20
> >     // Enter Thread Loop
> > 	while(1)
> > 	{
> > 		// Wait for lock test (is not available =3D> must=20
> preempt the
> > thread)
> > 		result =3D sem_wait(&s_SemThreadTest);
> > 		assert(result =3D=3D 0);
> > 	=09
> > 		// Never reach this point because lock is never released
> > 	}	  =20
> > 	=09
> > 	return(0);=09
> > }
> >=20
> > // Thread function for the linux Thread (not RT)
> > void* mythreadfunction(void* arg)
> > {
> > 	mq_attr mqAttributs;
> > 	mqAttributs.mq_flags =3D 0;
> > 	mqAttributs.mq_maxmsg =3D 1;=20
> > 	mqAttributs.mq_msgsize =3D  sizeof(void*);=09
> > 	mqAttributs.mq_curmsgs =3D 0;
> > 	// generates name
> > 	mqd_t handle =3D mq_open("/OEmqTest",(O_RDWR | O_CREAT),(S_IRWXU |
> > S_IRWXG),&mqAttributs);
> > 	assert(handle >=3D 0);
> > =09
> > 	while(1)
> > 	{
> > 		 // Pend on the message queue (message is a=20
> pointer size =3D
> > sizeof(void*))	=09
> > 		 char* pt_obj =3D 0;
> > 		 cout << "block on mqueue reception" << endl;
> > 		 int result =3D
> > mq_receive(handle,(char*)&pt_obj,sizeof(void*),0);
> > 		 assert(result =3D=3D 0);
> > 	}	  =20
> > 	=09
> > 	return(0);=09
> > }
> >=20
> > // =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > // Function   : AppStartTask
> > // Goal    : Application Start Task
> > // =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > void*  AppStartTask(void *p_arg)
> > {
> >     // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  LINUX =
THREAD (NOT RT) =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  REAL TIME =
PRIORITY =3D> 12 / SCHED=20
> FIFO =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 	 cout << "Create Linux Thread" << endl;=09
> >     // Thread Attributs Init
> > 	pthread_t mythread;
> > 	pthread_attr_t threadAttributs;
> > 	int result =3D pthread_attr_init(&threadAttributs);=09
> > 	assert(result =3D=3D 0);
> > 	struct sched_param  scheduleParams;
> > 	scheduleParams.sched_priority =3D 12;
> > 	result =3D
> > pthread_attr_setschedparam(&threadAttributs,&scheduleParams);
> > 	assert(result =3D=3D 0);
> > 	pthread_attr_setschedpolicy (&threadAttributs,SCHED_FIFO);
> > 	assert(result =3D=3D 0);
> > 	pthread_attr_setinheritsched
> > (&threadAttributs,PTHREAD_EXPLICIT_SCHED);
> > 	assert(result =3D=3D 0);
> >     result =3D __real_pthread_create(&mythread,
> >     						=09
> &threadAttributs,
> >     						=09
> mythreadfunction,
> >     							0);
> >     assert(result =3D=3D 0);
> >=20
> >     // Lock that enable RT thread loop
> >     sem_init(&s_SemThreadStartEnable,false,0);	=09
> // not available
> >=20
> >     // Test Lock
> >     sem_init(&s_SemThreadTest,false,0);		=09
> 	// not
> > available
> >    =20
> >     // =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  XENOMAI =
THREAD  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     // =3D=3D=3D=3D=3D=3D=3D  REAL TIME PRIORITY =3D> 11 / SCHED =
FIFO =3D=3D=3D=3D=3D=3D=3D
> > 	 cout << "Create Xenomai Thread" << endl;   =20
> >     pthread_t mythreadrt;//
> > 	pthread_attr_t threadAttributsrt;
> > 	int resultrt =3D pthread_attr_init(&threadAttributsrt);
> > 	assert(resultrt =3D=3D 0);
> > 	struct sched_param  scheduleParamsrt;
> > 	scheduleParamsrt.sched_priority =3D 11;
> > 	resultrt =3D
> > pthread_attr_setschedparam(&threadAttributsrt,&scheduleParamsrt);
> > 	assert(resultrt =3D=3D 0);
> > 	result =3D pthread_attr_setschedpolicy
> > (&threadAttributsrt,SCHED_FIFO);
> > 	assert(resultrt =3D=3D 0);
> > 	resultrt =3D pthread_attr_setinheritsched
> > (&threadAttributsrt,PTHREAD_EXPLICIT_SCHED);
> > 	assert(resultrt =3D=3D 0);
> >     resultrt =3D pthread_create(&mythreadrt,
> >     						=09
> &threadAttributsrt,
> >     						=09
> mythreadfunctionrt,
> >     							0);
> > ////// NOTE : NO PROBLEM IF A REPLACE pthread_create by
> > __real_pthread_create
> >    =20
> >     assert(resultrt =3D=3D 0);
> >   =20
> >    =20
> >     // Enable Thread Start
> > 	cout << "Enable Thread Loop Start" << endl;   =20
> >     resultrt =3D sem_post(&s_SemThreadStartEnable);
> >     assert(result =3D=3D 0);
> >    =20
> > 	// Suspend AppTask
> >     sem_t lockEnd;
> >     sem_init(&lockEnd,false,0);		// not available
> > 	cout << "Infinite wait end app" << endl;    =20
> >     sem_wait(&lockEnd);
> >=20
> >     return(0);
> > }
> >=20
> > // Function   : Main
> > int main(int argc,char* argv[])
> > {
> > 	// Mlock All for Xenomai
> > 	mlockall(MCL_CURRENT | MCL_FUTURE);
> > =09
> > 	AppStartTask(0);=09
> >=20
> > 	return 0;
> > }
> >=20
> > Problem description:
> > when I run the application with eclipse using "run" command=20
> (no debug using
> > gdb) the application run correctly and I can stop it from eclipse.
> > The console output is:
> > Create Linux Thread
> > block on mqueue reception
> > Create Xenomai Thread
> > Enable Thread Loop Start
> > Infinite wait end app
> >=20
> > when I launch the application with eclipse using "debug"=20
> command (gdb is
> > run). The console output is the same but when I stop the=20
> application, the PC
> > hangs (I need to push the reset button).
> >=20
> > this problem doesn't occur when I only use linux standard=20
> threads (all
> > __real_pthread_create).
> >=20
> > Do you have any idea? I'm I doing something totally wrong=20
> in my example.
>=20
> When running under gdb, a lot of signals are sent, so, you should be=20
> prepared to restart syscalls when EINTR is returned, instead=20
> of simply=20
> failing with assert. However, assert should not cause your=20
> system to freeze.
>=20
> Can you get any kernel messages, either by redirecting the=20
> console to a=20
> serial driver, or by running your example (with gdb) in plain=20
> text mode ?
>=20
> --=20
>=20
>=20
> 					    Gilles.
>=20

