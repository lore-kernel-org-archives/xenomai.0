Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 3 Feb 2008 11:44:03 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3768AE@slcmail.slc.mew.int>
In-Reply-To: <18342.2341.145336.903743@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768AD@slcmail.slc.mew.int>
	<18342.2341.145336.903743@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] periodic task question
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

This is the relevant code. In aperiodic mode, it works fine. In periodic
mode (125us timebase) then when I activate this task by sending data to
/dev/dsp the sound plays very fast and then the watchdog kills the
thread. If I change this to set the period only after rt_cond_wait()
returns, it works fine.

static void sound_func(void *data)
{      =20
    rt_task_set_periodic(&sound_task, TM_NOW,
rt_timer_ns2ticks(ST_AUDIO_PERIOD));

    for (;;) //go until suspended or thread deletion
    {=20
	if(!playing) {
            rt_mutex_acquire(&sound_mutex, TM_INFINITE);
            rt_cond_wait(&sound_cond, &sound_mutex, TM_INFINITE);
            rt_mutex_release(&sound_mutex);
        }
       =20
        rt_task_wait_period(0); //wait for next tick
    }
}

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Sunday, February 03, 2008 11:34 AM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] periodic task question
>=20
> Steven Seeger wrote:
>  > If I want a periodic task to wait on a condition variable whose
purpose
>  > is to wait until the task is needed again, should I set it
non-periodic
>  > first and then set it periodic again after it wakes up?
>  >
>  >
>  >
>  > If I am running in periodic timebase mode, I notice weird behavior
>  > without this behavior. It seems ok in aperiodic mode, however.
>=20
> Could you reduce your code to a minimal example showing this
behaviour?
>=20
>  > Also, if I set the native skin to periodic mode, the latency
default
>  > setting of 4200 doesn't change tick types, therefore it causes all
my
>  > calls to rt_task_set_periodic() fail with jiffies less than this.
>=20
> Try the attached patch. It looks like a condition got negated when
> replacing the test by a predicate.
>=20
> --
>=20
>=20
> 					    Gilles Chanteperdrix.

