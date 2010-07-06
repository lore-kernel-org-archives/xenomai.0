Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 6 Jul 2010 14:03:30 -0500
Message-ID: <181804936ABC2349BE503168465576460F384827@domain.hid>
In-Reply-To: <4C3378E2.2050401@domain.hid>
References: <181804936ABC2349BE503168465576460F3847C2@domain.hid> 
	<4C3378E2.2050401@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: Re: [Xenomai-help] Mixing skin calls (cancellation points)
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
> Sent: Tuesday, July 06, 2010 1:42 PM
> To: Steve Deiters
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Mixing skin calls (cancellation points)
>=20
> Steve Deiters wrote:
> > Is it in general valid to mix calls from different skins?  In=20
> > particular, can I expect the native skin calls to work as POSIX=20
> > cancellation points?  For example, if I have a POSIX thread with a=20
> > pthread_t identifier which I know calls rt_cond_wait=20
> somewhere, will=20
> > it work as a cancellation point when I call pthread_cancel?
> >=20
> > The example program attached will not cancel if I have=20
> CANCEL_DEFERRED=20
> > defined as 1 at the top, which sets the cancel type to=20
> deferred.  This=20
> > is on a PowerPC with Xenomai 2.5.3.  I think this worked=20
> with Xenomai=20
> > 2.4.10.
> >=20
> >=20
> > --------
> >=20
> >=20
> > #include <stdio.h>
> > #include <errno.h>
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <pthread.h>
> > #include <native/task.h>
> > #include <native/cond.h>
> >=20
> > #define CANCEL_DEFERRED 1
> >=20
> > RT_MUTEX mutex;
> > RT_COND cond;
> > pthread_t thread;
> >=20
> > void *entry(void *cookie)
> > {
> >    fprintf(stderr, "Starting thread\n");
> >=20
> > #if CANCEL_DEFERRED
> >    pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL); #else
> >    pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL); #endif
> >=20
> >    rt_mutex_acquire(&mutex, TM_INFINITE);
> >    rt_cond_wait(&cond, &mutex, TM_INFINITE);
> >    rt_mutex_release(&mutex);
> >=20
> >    return NULL;
> > }
>=20
> This program would also deadlock with plain POSIX: you are=20
> missing a cleanup handler which releases the mutex.
>=20
> --=20
> 					    Gilles.
>=20

My situation here is that I have some library routines, which were
written using the native skin.  It was done like this so users of the
library were not forced to link against the POSIX skin.  Not to say that
they would use the libc POSIX implementation, just that they may want=
 to
use only the native skin.

Is there a deadlock issue here if I have the cancellation as deferred?
Won't the rt_cond_wait already release the mutex.  This is similar to
pthread_cond_wait which is a cancellation point in POSIX.  I realize the
potential for deadlock if it asynchronous which is why I want the
cancellation as deferred.

If I ever do need to do something like this, can I use the
rt_task_add_hook looking at T_HOOK_DELETE in place of a POSIX cleanup
handler?

This still doesn't say whether or not I can rely on the rt_cond_wait as
a cancellation point.  If not I may have only two options: rewrite the
library using the POSIX skin and force the users to use the POSIX skin,
or force the user to use the native skin or avoid using pthread_cancel.
Neither one is an appealing option.

Thanks.


