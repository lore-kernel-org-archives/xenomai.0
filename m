Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Oct 2007 11:45:42 +0100
Message-ID: <44D6D942646F9E43B7CFFFD3F250EDCD08E9C3@domain.hid>
From: "MEYLAN Jean-philippe" <Jean-philippe.Meylan@domain.hid>
Subject: [Xenomai-help] task rate control with alarm and semaphore
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

Hello,

I'm working on the creation of a Xenomai target for Mathwork's
Real Time Workshop. In order to achieve this, I would like to=20
control the execution rate of a task with a semaphore periodically
released by an alarm handler. The tasks does nothing else but waiting
(in a loop) on the semaphore. If the task can immediately take=20
the sempahore, it means that the rate is too fast for it because
the semaphore has been released before the end of its current iteration.

My problem is that I cannot decrease the alarm period under 40us
without facing this situation. I cannot figure what is the cause of
all that overhead (maybe it comes from the rt_alarm_wait call ?). I
have tried to use event flags instead of semaphores but I get the
same results.

Do you have any idea ?

Here is the code of the main task and the alarm handler:

void tBaseRate(void * cookie)
{
  while (1) {
    if (rt_sem_p(&rtClockSem, TM_NONBLOCK) =3D=3D 0) {
      printf("Rate for BaseRate task too fast.\n");
    } else {
      rt_sem_p(&rtClockSem, TM_INFINITE);
    }
}

void clockHandler(void * cookie)
{
  int status;
  while (1) {
    status =3D rt_alarm_wait(&clockDesc);
    if (!status) {
      status =3D rt_sem_v(&rtClockSem);
      if (status)
        printf ("Semaphore error : %d\n", status);
    } else
      printf ("Alarm error: %d\n", status);
  }
}

Thank you very much.

Best regards,

Jean-Philippe Meylan

