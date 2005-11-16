Message-ID: <437AC773.6070501@domain.hid>
Date: Wed, 16 Nov 2005 06:45:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange pipe behaviour
References: <OF904A8BBE.F91DE4A2-ONC12570B9.005BDDF6-C12570B9.005CB25A@datacon.at>
	<4378D175.7010304@domain.hid>
In-Reply-To: <4378D175.7010304@domain.hid>
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
> Hi,
>=20
> I have the following piece of code:
>=20
> RT_PIPE_MSG *msg;
>=20
> while ((r =3D rt_pipe_receive(&mypipe, &msg, TM_INFINITE)) >=3D 0) {
>     /* whatever */
>     rt_pipe_free(msg);
> }
>=20
> When that thread enters, it blocks, as expected, in the rt_pipe_receive
> call.
>=20
> Then, from user space, I do:
>=20
> echo -en "\x00" > /dev/rtp0
>=20
> What happens is:
>=20
> 1- rt_pipe_receive returns with r >=3D 0.
> 2- /* whatever */
> 3- Message is freed using rt_pipe_free.
> 4- Next call to rt_pipe_receive returns with r =3D -EINTR.
>=20
> The only explanation I could come up with is that when the pipe is
> closed by the user mode process, the rt_pipe_receive tells the rt task
> by returning -EINTR. Is this right?.

Yes.

  According to the docs, -EINTR is
> only returned if rt_task_unblock() has been called...
>=20

Actually, this is what happened through the internal interface.
driver::release(pipe) -> nucleus::unblock(sleepers_on_pipe)

> Nacho.
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20

Philippe.

