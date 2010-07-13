Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jul 2010 17:49:16 -0500
Message-ID: <181804936ABC2349BE503168465576460F48EB4B@exchserver.basler.com>
In-Reply-To: <4C3CE5C3.30403@domain.hid>
References: <181804936ABC2349BE503168465576460F48EB21@domain.hid> 
	<4C3CE5C3.30403@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: Re: [Xenomai-help] Timed waits with POSIX skin using CLOCK_REALTIME
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

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
> Sent: Tuesday, July 13, 2010 5:17 PM
> To: Steve Deiters
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Timed waits with POSIX skin using=20
> CLOCK_REALTIME
>=20
> Steve Deiters wrote:
> > This is probably more of a general POSIX programming=20
> question.  Some=20
> > of the timed wait routines in POSIX (pthread_mutex_timedlock, etc)=20
> > take an absolute timeout value in terms of CLOCK_REALTIME. =20
> How then=20
> > are these routines not subject to timing error when the=20
> CLOCK_REALTIME=20
> > is changed, e.g. with clock_settime?
>=20
> I am not sure I understand the question. We tried and=20
> implement what is described for instance here:
>=20
> http://www.opengroup.org/onlinepubs/009695399/functions/clock_
> settime.html
>=20
> --=20
> 					    Gilles.
>=20

It is not a question of the implementation, but more so of the
specification.

For example, if I do something similar to the following:

clock_gettime(CLOCK_REALTIME, &tv);     /* Point A */
tv.tv_sec +=3D 5;
pthread_mutex_timedlock(&mutex, &tv);   /* Point B */

And somewhere else in the sytem after point A but before point B returns
the time is changed:

clock_settime(CLOCK_REALTIME, &new_time);

If the new_time differs from the original time by a significant amount
then point B will either return ETIMEDOUT if the time was set forward,
or block for a potentially long period if the time was set backward.

This behavior seems to be indicated in the following paragraph from the
specification:

"If the value of the CLOCK_REALTIME clock is set via clock_settime(),
the new value of the clock shall be used to determine the time of
expiration for absolute time services based upon the CLOCK_REALTIME
clock. This applies to the time at which armed absolute timers expire.
If the absolute time requested at the invocation of such a time service
is before the new value of the clock, the time service shall expire
immediately as if the clock had reached the requested time normally."


I'm not actually having any problems with this, as I am not using these
routines.  I just thought it was a curious contrast compared to e.g.
rt_mutex_acquire which specifies a relative timeout.  I don't understand
how the POSIX timed services expect to have consistent timing using
absolute timeout values if they are not based at least on
CLOCK_MONOTONIC which cannot be set.

