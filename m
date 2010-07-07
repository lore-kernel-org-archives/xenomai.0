Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 7 Jul 2010 10:20:59 -0500
Message-ID: <181804936ABC2349BE503168465576460F384F38@domain.hid>
In-Reply-To: <4C347815.9050107@domain.hid>
References: <181804936ABC2349BE503168465576460F3847C2@domain.hid> 
	<4C347815.9050107@domain.hid>
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
> Sent: Wednesday, July 07, 2010 7:50 AM
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
>=20
> Hi,
>=20
> I had a look at the code, and chances are, that in fact it=20
> never worked.
> The native skin threads are created with asynchronous type,=20
> and the rest  of the skin assumes that it is always the case.=20
> To kill a native skin thread, you are supposed to use=20
> rt_task_delete instead of pthread_cancel, and if you did not=20
> change the thread cancellation type, it will work. If you are=20
> interested in waiting for the thread deletion, you can create=20
> the thread joinable with T_JOINABLE, then wait for it with=20
> rt_task_join.
>=20
> We can, of course, modify the code to allow changing the=20
> native thread cancellation type. But the question is: what is=20
> the use-case?
>=20
>=20
> --=20
> 					    Gilles.


I was not creating a native thread though.  I was creating a POSIX
thread, which used some native skin calls.  I do not have a RT_TASK in
this case to even use with rt_task_delete, unless there is something to
convert from a pthread_t to a RT_TASK I'm not aware of.  In any case I'm
wanting to cancel a POSIX thread, not a native one.

My usage case is basically as I described previously.  I have some code
sectioned off in a static library.  This code uses only native calls for
stuff like mutexes and condition variable using the assumption that the
end application using the library need not link against the POSIX skin.
In one of the applications it was using a POSIX skin, with POSIX
threads, and was cancelling a thread that was blocked with rt_cond_wait.

Just out of curiosity, is there anything analogous to pthread cleanup
handlers in the native skin?  You mentioned earlier that you cannot use
the rt_add_hook in userspace.  So is there anyway then to protect
against the situation described earlier, where you delete a thread
waiting on a condition variable.  Will the thread reacquire the mutex
before deletion as in the POSIX case and does the rt_task_delete make
sure not to delete the thread while it is holding the mutex in this
case?

