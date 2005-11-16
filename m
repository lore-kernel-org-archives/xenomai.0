Message-ID: <437B1BD5.4060206@domain.hid>
Date: Wed, 16 Nov 2005 12:45:25 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange pipe behaviour
References: <OF904A8BBE.F91DE4A2-ONC12570B9.005BDDF6-C12570B9.005CB25A@datacon.at>
	<4378D175.7010304@domain.hid> <437AC773.6070501@domain.hid>
	<437AE37D.8010304@domain.hid>
In-Reply-To: <437AE37D.8010304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
>>>1- rt_pipe_receive returns with r >=3D 0.
>>>2- /* whatever */
>>>3- Message is freed using rt_pipe_free.
>>>4- Next call to rt_pipe_receive returns with r =3D -EINTR.
>>>
>>>The only explanation I could come up with is that when the pipe is
>>>closed by the user mode process, the rt_pipe_receive tells the rt task
>>>by returning -EINTR. Is this right?.
>>
>>
>>Yes.
>>
>> According to the docs, -EINTR is
>>
>>
>>>only returned if rt_task_unblock() has been called...
>>>
>>
>>Actually, this is what happened through the internal interface.
>>driver::release(pipe) -> nucleus::unblock(sleepers_on_pipe)
>=20
>=20
> Sure, but that behaviour is *extremely* confusing for a newbie (like
> me). Should be described in the docs (this time I don't submit a patch
> because I don't quite understand the pipe internals yet).
>

If you understand enough of the API documentation to disagree with it, I =
guess=20
that you should be able to reword it in a way that seems less error-prone=
 in=20
your eyes. You don't have to explain the gory details of the implementati=
on to=20
do that.

> And anyway, I don't see the point in notifying the RT task that the
> non-RT end has closed the pipe.

Message pipes are connection-oriented thingies. You cannot just let one=20
communication end-point vanish and leave the other side lingering indefin=
itely=20
without notifying it.

  Or, in other words, if we want to
> provide such a notification, we should provide also opening notificatio=
n.
>=20

That's irrelevant. rt_pipe_connect() from kernel space is semantically si=
milar=20
to open(some_named_fifo,O_RDWR|O_NONBLOCK) from user-space, since the cal=
ler=20
does not wait for the other end-point to show up. But even in that case, =
closing=20
the named fifo at the other side causes any subsequent read() on the conn=
ecting=20
side to be notified of the closure. The same goes for message pipes. The =
only=20
thing you could argue is that read() would first return a zero-sized mess=
age=20
first as an end-of-file marker, then an error upon all subsequent reads; =
since=20
we don't want to forcibly close the kernel side upon user-space closure, =
a=20
possible change would be to make rt_pipe_recv() return -EPIPE instead of =
-EINTR=20
in that specific case.

And actually, the nucleus interface does provide support for registering =
a=20
connection notification handler, but it is not exported by the native ski=
n since=20
it would buy us nothing in the context of a regular API.

> By the way, where is the xnpipe_* API documentation? I could not find i=
t
> in the online docs (firefox downloads the file search.php when I try to
> use the search feature).
>=20

Still undocumented portion.

>=20
>>>Nacho.
>>>
>>>
>>>
>>>
>>>_______________________________________________
>>>Xenomai-help mailing list
>>>Xenomai-help@domain.hid
>>>https://mail.gna.org/listinfo/xenomai-help
>>>
>>
>>
>=20
>=20


--=20

Philippe.

