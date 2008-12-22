Message-ID: <20081222133253.lscsfad40kswkwsc@domain.hid>
Date: Mon, 22 Dec 2008 13:32:53 +0200
From: Mehmet Alphan Ulusoy <alphan@domain.hid>
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>
	<492EF786.4040303@domain.hid>
	<20081128181906.mnv2mvjgo44wgoc0@domain.hid>
	<49301B0B.9010208@domain.hid>
	<20081128182944.qp8yhwpk6cw8cwss@domain.hid>
	<49302630.4080104@domain.hid>
	<D6B7B711-7E2F-466D-857F-53EB7A7C30DC@su.sabanciuniv.edu>
	<B41FD0F2-09C0-4DB6-B36C-892B72A63875@domain.hid>
	<C7714144-0328-4258-95BD-133AB45C72E9@domain.hid>
	<494F6250.50707@domain.hid>
In-Reply-To: <494F6250.50707@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Zombie user tasks
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


On Mon 22 Dec 2008 11:48:00 EET, Gilles Chanteperdrix wrote:

> Alphan Ulusoy wrote:
>> I've recompiled the kernel after turning off the preemptible RCU
>> option. I left CONFIG_PREEMPT as it is for the time being. Can
>> preemptible RCU option be the cause ?
>
> I do not think so. However, I have no idea what the problem could be.
> Are you sure that you ran wait on the given pid? In order to be sure,
> you can try and send SIGCHLD to the process father?
>

I wait for the child processes using while ((status =3D =20
waitpid(-1,NULL,WNOHANG)) >1); in the signal handler of the process =20
father.

> What would be really interesting too, is to have the process status. So,
> in function sched_show_task, file kernel/sched.c, could you try and
> print p->state in hexadecimal? In the dump you sent, the state is shown
> as a question mark, so we do not really know in what state the task is.
>

The output of the sched says the task is 'relaxed shadow', I believe =20
what you ask for is something else. I will try to make the change you =20
suggested and hopefully send you the dump once the task turns into a =20
zombie.

> You should also recompile your kernel with frame pointers, if it is not
> already the case.
>

OK, will do that.

thanks,

alphan

> --
>                                                  Gilles.
>
>



