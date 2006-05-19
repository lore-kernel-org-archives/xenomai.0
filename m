Message-ID: <6ee4c8380605190702l323f5d57v234d055b1cfeff5a@domain.hid>
Date: Fri, 19 May 2006 10:02:44 -0400
From: "Brian L." <bluczkie@domain.hid>
Sender: zorander@domain.hid
Subject: Re: [Xenomai-help] rt_task_delete behavior
In-Reply-To: <446C29A9.3030508@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <6ee4c8380605172215i34e83797i709de4a314412618@domain.hid>
	<446C29A9.3030508@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

CPU   PID   PRI   TIMEOUT   STAT   NAME
0     0        0     0      R      ROOT


On 5/18/06, Philippe Gerum <rpm@xenomai.org> wrote:
> Brian L. wrote:
> > I'm calling what amounts to rt_task_delete(rt_task_self()) and the
> > task simply hangs, with this call never returning.
> > rt_task_delete(NULL) behaves identically.
> >
> > What could cause this behavior? The problem is embedded within a
> > nontrivial application, but it seems that it's not behaving according
> > to spec which says that the caller will only block when:
> >
> > 1. The target is in a "safe section"
> >
> > and
> >
> > 2. The caller is not the target
> >
> > Any ideas?
> >
>
> Could you post the output of
>
> $ cat /proc/xenomai/sched
>
> TIA,
>
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> >
>
>
> --
>
> Philippe.
>

