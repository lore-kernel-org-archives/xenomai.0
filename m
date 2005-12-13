Message-ID: <439F0CCF.4060609@domain.hid>
Date: Tue, 13 Dec 2005 19:02:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] events and domains
References: <439F0806.4070206@domain.hid>
In-Reply-To: <439F0806.4070206@domain.hid>
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
To: Giuseppe Lipari <lipari@domain.hid>
Cc: xenomai@xenomai.org

Giuseppe Lipari wrote:
> Dear all,
>=20
> We are new to Xenomai and Adeos. We have some questions and I could not
> find answers to these in the documentation (but maybe we are not very
> good at finding things!). We hope someone can help!
>=20
> 1) Adeos is able to handle events that are passed to domains.
> I understand that events are hw interrupts and "other things". In the
> docs, I see that an event can be a "soft interrupt". As soft interrupt
> can have different meanings in different contexts, what do you actually
> mean with "soft interrupt"??
>

Virtual interrupts (virq) actually. Pseudo-IRQ channels that are not=20
mapped to real hardware but rather allocated by software to propagate=20
software-generated events. For instance, Xeno uses a virq for carrying=20
out asynchronous procedure calls from the primary to the secondary=20
domain (see /proc/xenomai/apc).

> 2) Also, what exactly are hooks? In particular, when there is a
> context-switch between two non-Xenomai (Linux) threads running in user
> space, is any hook-event generated?
>=20

Hooks =3D=3D callbacks. Yes, Xeno uses this to track and monitor what the=
=20
hell Linux is doing at any time wrt user-space tasks mapped to shadow=20
Xeno threads. In nucleus/shadow.c, see do_schedule_event().

> 3) when a Xenomai thread starts executing, does it start in primary or
> in secondary mode?
>=20

Primary, always. It's written in stone.

> 4) is the memory of a Xenomai thread allocated in user space? (I guess
> yes, but just to be sure!)
>=20

No difference from regular Linux threads. Actually, a Xenomai thread=20
running in user-space is a Linux thread on stero=EFd. To this end, what w=
e=20
call a shadow thread context is mapped to the initial Linux task=20
context, so that the Xenomai scheduler can handle it too, in parallel to=20
the regular Linux scheduler (in a mutally exclusive fashion though).

> 5) if  two UVMs are active at the same time, how they are scheduled wit=
h
> respect to each other? (I guess SCHED\_FIFO, but it looks somewhat
> strange to me: why not SCHED\_RR, at least for the application tasks?).
>=20

It's explained in the "Introduction to UVMs" document.

>=20
> Giuseppe Lipari and Paolo Gai
>=20
>=20
>=20


--=20

Philippe.

