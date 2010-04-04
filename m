From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Sun, 4 Apr 2010 19:04:55 -0400
Message-ID: <245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>
References: <20100401230843.GF3755@domain.hid>
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>
	<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>
	<4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
	<4BB5BA2D.1080604@domain.hid>
	<k2rb88603c31004020243k8d9681f8y453b25393bb5d3a0@domain.hid>,
	<4BB5C1D5.8030804@domain.hid>
In-Reply-To: <4BB5C1D5.8030804@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Henri Roosen <henriroosen@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> > Actually that is what I thought in the first place, however Jan's
> > comment "That's not true, Xenomai threads can run in non-RT scheduling
> > classes as well. They may just gain RT priority while holding some
> > lock that is requested by a RT thread as well." made me think I was
> > wrong...
> >
> > So we would really need a SCHED_IDLE for Xenomai then to solve this pro=
blem?
>
> I don't think so. But we do need to solve the issue that a non-RT thread
> stays too long in primary mode and is thus scheduled by Xenomai with the
> wrong priority /wrt other Linux task at its level.
>=20
> For the time being, you can work around this by issuing a Linux syscall
> before entering long processing loops - unless your task doesn't do this
> anyway, e.g. to perform some Linux I/O.
>

I think that's need. Currently the statistics task takes a mutex and waits =
on a message queue for messages. That's the only time it should potentially=
 run in primary mode. After it returns the Mutex it should continue running=
 with a policy similar to SCHED_IDLE to give other tasks a chance to run. I=
 see how switching back to secondary mode could be achieved by issuing a Li=
nux syscall. Is there another way which doesn't involve changing the source=
 code of our application? (The proper way?)

Andreas




