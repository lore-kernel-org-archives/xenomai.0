Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 3 Feb 2008 14:38:51 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3768BC@slcmail.slc.mew.int>
In-Reply-To: <18342.13282.822800.458093@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768BB@slcmail.slc.mew.int>
	<18342.13282.822800.458093@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_read and pthread_cancel()
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

I will try to figure out a way to make this a small self contained test.
However, my debugger shows a thread waiting in pthread_join() while the
thread to be disposed is still in rt_queue_read().

PTHREAD_CANCEL_ASYNCHRONOUS is kind of dangerous. Why does
rt_task_shadow() do this? It seems the better approach is to let
cancellation be handled on the secondary domain side of things, and let
the shadow stuff clean up on its own.

If I use rt_task_shadow() do I need to use rt_task_delete()?

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Sunday, February 03, 2008 2:37 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rt_queue_read and pthread_cancel()
>=20
> Steven Seeger wrote:
>  > If I have a shadowed thread that was created with pthread_create()
and
>  > rt_task_shadow() that calls rt_queue_read() with an infinite
timeout,
> is
>  > there any reason it would not receive a cancellation point? I have
an
>  > intermittent lock in pthread_join() on that thread while it's
blocked
> in
>  > rt_queue_read(). I call pthread_cancel() on the thread first. I
have
> the
>  > rt_queue_read() call with a pthread_testcancel() before and after
it.
>=20
> You do not need to call pthread_testcancel(): rt_task_shadow sets the
> thread cancellation type to PTHREAD_CANCEL_ASYNCHRONOUS, which means
> that pthread_cancel will send a signal to this thread to terminate
> it. So, the reason for the deadlock is probably elsewhere. Could you
> reduce your application to a small self-contained test which wouls
show
> us what you are observing ?
>=20
> --
>=20
>=20
> 					    Gilles Chanteperdrix.

