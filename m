Message-ID: <48AD5DBD.5070606@domain.hid>
Date: Thu, 21 Aug 2008 14:21:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2220D86D21B55040AB683933DBD97B5A263B7AAA98@domain.hid>
In-Reply-To: <2220D86D21B55040AB683933DBD97B5A263B7AAA98@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to get pid in Xenomai?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?=22Hans_S=F8ndergaard_=28HSO=29=22?= <HSO@VIAUC.DK>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hans S=F8ndergaard (HSO) wrote:
> Hello.
> 1) Can you tell me, how to get the task id for the current (running) rt_t=
ask?
> I have tried to use getpid(), but this function always gives the same id =
as result.
> I am running several periodic rt_tasks and need their id's.

You can use rt_task_self() or pthread_self(), they will return a unique
pointer for the task. If you would like the Linux pid of the task, you
can do what cyclictest does, i.e. issue the gettid syscall.

>=20
> 2) In Xenomai the priority inheritance protocol is implemented.
> Safety-Critical Java (http://jcp.org/en/jsr/detail?id=3D302) requires the=
 priority ceiling emulation protocol.
> Have you any plan to implement and include this protocol in Xenomai?

Not that I know of, but it may be easy enough to implement, so I guess
your patch would be welcome.

--=20
                                                 Gilles.

