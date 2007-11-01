Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 1 Nov 2007 09:25:54 +0100
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0E3060D@EINT11.einet.ad.eivd.ch>
In-Reply-To: <18216.54719.707985.682768@domain.hid>
References: <44D6D942646F9E43B7CFFFD3F250EDCD08E9C3@domain.hid><FDBBB5CC70676540B3EF7CFE83FD94E0E305D2@domain.hid>
	<18216.54719.707985.682768@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: Re: [Xenomai-help] task rate control with alarm and semaphore
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
Cc: xenomai@xenomai.org, MEYLAN Jean-philippe <Jean-philippe.Meylan@domain.hid>


>-----Original Message-----
>From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>Sent: mercredi 31 octobre 2007 20:22
>To: ROSSIER Daniel
>Cc: MEYLAN Jean-philippe; xenomai@xenomai.org
>Subject: Re: [Xenomai-help] task rate control with alarm and semaphore
>
>ROSSIER Daniel wrote:
> > >-----Original Message-----
> > >From: xenomai-help-bounces@domain.hid
> > [mailto:xenomai-help-bounces@domain.hid]
> > >On Behalf Of MEYLAN Jean-philippe
> > >Sent: mercredi 31 octobre 2007 11:46
> > >To: xenomai@xenomai.org
> > >Subject: [Xenomai-help] task rate control with alarm and semaphore
> > >
> > >Hello,
> > >
> > >I'm working on the creation of a Xenomai target for Mathwork's
> > >Real Time Workshop. In order to achieve this, I would like to
> > >control the execution rate of a task with a semaphore periodically
> > >released by an alarm handler. The tasks does nothing else but
>waiting
> > >(in a loop) on the semaphore. If the task can immediately take
> > >the sempahore, it means that the rate is too fast for it because
> > >the semaphore has been released before the end of its current
> > iteration.
> > >
> > >My problem is that I cannot decrease the alarm period under 40us
> > >without facing this situation. I cannot figure what is the cause of
> > >all that overhead (maybe it comes from the rt_alarm_wait call ?). I
> > >have tried to use event flags instead of semaphores but I get the
> > >same results.
> > >
> > >Do you have any idea ?
> > >
> > >Here is the code of the main task and the alarm handler:
> > >
> > >void tBaseRate(void * cookie)
> > >{
> > >  while (1) {
> > >    if (rt_sem_p(&rtClockSem, TM_NONBLOCK) =3D=3D 0) {
> > >      printf("Rate for BaseRate task too fast.\n");
> > >    } else {
> > >      rt_sem_p(&rtClockSem, TM_INFINITE);
> > >    }
> > >}
> > >
> > >void clockHandler(void * cookie)
> > >{
> > >  int status;
> > >  while (1) {
> > >    status =3D rt_alarm_wait(&clockDesc);
> > >    if (!status) {
> > >      status =3D rt_sem_v(&rtClockSem);
> > >      if (status)
> > >        printf ("Semaphore error : %d\n", status);
> > >    } else
> > >      printf ("Alarm error: %d\n", status);
> > >  }
> > >}
> >
> > This example is very interesting. To make sense, the semaphore must
>be
> > initialized to 0 so that
> > the first invokation to rt_sem_p() in tBaseRate will suspend the
>task.
> > But if the message
> > "Rate for BaseRate task too fast" is displayed the next loop, it
>means
> > that the time elapsed between
> > the alarm and the next rt_sem_p() is more than 40us. Weird. Having a
>IRQ
> > latency of about 5us, it means
> > that the nucleus spend 35us to handle the switch between the alarm
>and
> > the task itself.
>
>The interrupt latency is one thing, here you have two context switches
>after the interrupt, which basically means that the latency is at least
>twice the _scheduling_ latency.
>

Thanks Gilles; for You, does the scheduling latency seem to be honest
(something like 17-18us) ?
(I know that this scheme could be simpler with a periodic task, but the
goal here is to perform
a comparison between Xenomai and RTOS-32, therefore we try to keep the
same conditions; so far,
RTOS-32 supports an alarm rated at 10us).

>--
>
>
>					    Gilles Chanteperdrix.

Daniel

