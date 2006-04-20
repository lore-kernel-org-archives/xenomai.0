content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] my tick takes a break !! 
Date: Thu, 20 Apr 2006 11:23:08 +0200
Message-ID: <5B122FD931231D408AC32630D1B1F7290ACAB6B6@domain.hid>
From: "Thomas, Brieuc \(GE Healthcare\)" <Brieuc.Thomas@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> > Thomas, Brieuc \(GE Healthcare\) wrote:
> >  > Hi every one !
> >  >
> >  > I really don't understand, my porting of application works very
well
> >  > (under vxworks skin), message, semaphore, timer... Except the
task !!
> >  > I've got a curious behaviour, when I've got a heavy task, the
kernel
> >  > tick counter stop during the process!!
> >  >
> >  > And take back when this one is finish.
> >  >
> >  > Therefore the other tasks are freeze and my application crash.
> >  >
> >  >
> >  >
> >  > have You already seen this case?
> >
> > I do not know if it is what you mean, but when running Xenomai, your
>> tasks are supposed to suspend sufficiently frequently to leave Linux
> > tick normally. This means that if you configured CONFIG_HZ=3D100, =
your
> > real-time activity (including kernel-space tasks and user-space
tasks in > > primary mode) is supposed to take a break at least once
every 1/100 > > second.
> >
> > --
> >
> >=20
> > 					    Gilles Chanteperdrix.
> >
> > Oh no! Sorry, I mean the real-time tick counter!
>
>If the heavy task is using intLock() then yes, it will prevent the
timer from ticking. If >you are observing something else, could you send
to this mailing list a minimal test case >illustrating what you are
observing?
>
> > But if my real-time activity don't take a break during a while (more
> than 1/100 >second), Is it dangerous for my real-time activity?=20
>
>If you do not let Linux run often enough, it will crash, and this is
dangerous for your >real-time activity.=20
>I do not know exactly how much is "often enough", and it probably
depends on many >factors, but if you want Linux timed services to work
normally, you should let Linux timer >tick regularly.
>--=20
>
>					    Gilles Chanteperdrix.
>

No I don't use intLock().
I use this test to observe the tasks behaviour, with two same priority
tasks.
The first task "testRun1" print the tick number, the number of the task
changed and if it's the same task (between my task) since last
timeslice.
The second one is the heavy task, it's print the tick number, the number
of the task changed and if it's the same task (between my task) since
last timeslice. And also some information about the progression task
(here the number of the loop with the tick number).

void testRun1()
{	printf("Start testRun1 %d taskChanged %d\n", (int)tickGet(),
taskChanged);
	const unsigned int taskId =3D 1;
	unsigned int startTime1 =3D tickGet();

	while(1)
	{	taskDelay(100);
	=09
		if(taskRunning !=3D taskId)
		{
			taskRunning =3D taskId;
			taskChanged++;
			printf("Run testRun1 %d taskChanged %d\n",
(int)tickGet(), taskChanged);
		}
		else printf("Run testRun1 %d No changed\n",
(int)tickGet());
	}
	printf("End testRun1 %d taskChanged %d\n", (int)tickGet(),
taskChanged);
}

void testRun2()
{	printf("Start testRun2 %d taskChanged %d\n", (int)tickGet(),
taskChanged);
	const unsigned int taskId =3D 2;
	unsigned int startTime1 =3D tickGet();
	taskDelay(100);

	while( //ten times for example )
	{=09
		printf("Start while tick: %d \n",(int)tickGet());
		while(//var)	// take around one second
		{	// workout
			if(taskRunning !=3D taskId)
			{
				taskRunning =3D taskId;
				taskChanged++;
				printf("Run testRun2 %d taskChanged
%d\n", (int)tickGet(), taskChanged);
			}
		}
	}
	printf("End testRun2 %d taskChanged %d\n", (int)tickGet(),
taskChanged);=20
}
***
The result see below:
***
Start testRun1 0 taskChanged 0    <--
Start testRun2 0 taskChanged 0      |
Run testRun1 100 taskChanged 1      |
Start while 1 tick: 100 NO changed  |- Changing OK, every 100ms
Run testRun2 100 taskChanged 2      |
Run testRun1 200 taskChanged 3      |
Run testRun2 200 taskChanged 4    <-- =20
Start while 2 tick: 200     <--
Start while 3 tick: 200       |
Start while 4 tick: 200       |
Start while 5 tick: 200       |- ticks break, while 10 second=20
Start while 6 tick: 200       |=20
Start while 7 tick: 200       |=20
Start while 8 tick: 200       |
Start while 9 tick: 200     <--       |
End testRun2 200 taskChanged 4
Run testRun1 300 taskChanged 5
End testRun2 30010 taskChanged 5


