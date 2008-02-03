Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 3 Feb 2008 12:05:33 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3768B0@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] FW:  periodic task question
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



> -----Original Message-----
> From: Steven Seeger
> Sent: Sunday, February 03, 2008 12:01 PM
> To: 'Gilles Chanteperdrix'
> Subject: RE: [Xenomai-help] periodic task question
>=20
> I guess I don't see the difference here. I lock the mutex first, and
then
> wait on the conditional. The only time that conditional is ever
signaled
> is after something else sets playing to non-zero. (This code actually
> clears playing after locking that mutex, however I didn't put that in
> here.)
>=20
> What may be causing the problem is the other person who is locking
> sound_mutex is a non-realtime thread via write ops for a character
device.
> Oops. Perhaps I need a new method for this. :) (rt_mutex_acquire() is
> returning -1.)
>=20
> Steven
>=20
> > -----Original Message-----
> > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> > Sent: Sunday, February 03, 2008 11:54 AM
> > To: Steven Seeger
> > Subject: RE: [Xenomai-help] periodic task question
> >
> > Steven Seeger wrote:
> >  > This is the relevant code. In aperiodic mode, it works fine. In
> > periodic
> >  > mode (125us timebase) then when I activate this task by sending
data
> to
> >  > /dev/dsp the sound plays very fast and then the watchdog kills
the
> >  > thread. If I change this to set the period only after
rt_cond_wait()
> >  > returns, it works fine.
> >  >
> >  > static void sound_func(void *data)
> >  > {
> >  >     rt_task_set_periodic(&sound_task, TM_NOW,
> >  > rt_timer_ns2ticks(ST_AUDIO_PERIOD));
> >  >
> >  >     for (;;) //go until suspended or thread deletion
> >  >     {
> >  > 	if(!playing) {
> >  >             rt_mutex_acquire(&sound_mutex, TM_INFINITE);
> >  >             rt_cond_wait(&sound_cond, &sound_mutex, TM_INFINITE);
> >  >             rt_mutex_release(&sound_mutex);
> >  >         }
> >
> > This code is wrong, it should be:
> >
> > rt_mutex_acquire(&sound_mutex, TM_INFINITE);
> > while (!playing)
> >         rt_cond_wait(&sound_cond, &sound_mutex, TM_INFINITE);
> > rt_mutex_release(&sound_mutex);
> >
> > Here is the relevant doc of pthread_cond_wait:
> >        A condition variable must always be associated with a mutex,
to
> > avoid
> >        the race condition where a thread prepares to wait on a
condition
> > vari-
> >        able and another thread signals the condition  just  before
the
> > first
> >        thread actually waits on it.
> >
> >
> > --
> >
> >
> > 					    Gilles Chanteperdrix.

