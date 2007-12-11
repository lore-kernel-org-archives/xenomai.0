Message-ID: <2ff1a98a0712110841y7d16bb2esfca8fdfd7419ea5e@domain.hid>
Date: Tue, 11 Dec 2007 17:41:32 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <475EA9F4.3020306@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <475E76A0.4010007@domain.hid> <475E7CBA.7060300@domain.hid>
	<475E7F84.1040600@domain.hid> <475E8DAE.9070405@domain.hid>
	<2ff1a98a0712110541x12633fa3yb311214d9d0245a1@domain.hid>
	<475EA9F4.3020306@domain.hid>
Subject: Re: [Xenomai-help] Application broken 2.3.4 ---> 2.4.0
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Dec 11, 2007 4:17 PM, Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid> wrote:
>
> >> 2.3.x: returns -ETIMEDOUT but schedules the task for immediate executi=
on.
> >>
> >> 2.4.0: returns -ETIMEDOUT and *does not* schedule the task for immedia=
te
> >> execution.
> >>
> >> The more I think about it the mode I think this is a bug.
> >>
> >> I just can't think of a situation in which idate is in the past and it
> >> makes sense *not scheduling* the task for immediate execution...
> >>
> >
> > Why not passing TM_NOW as an initial date if you want the task to be
> > scheduled immediately instead of passing a date in the past ? It has
> > always worked and still works with Xenomai 2.4.0.
> >
> Let's suppose some event happens at time T0 which is recorded. Then,
> after some processing I'm reading to call rt_task_set_periodic, but a
> little delay has passed. If I use:
>
> rt_task_set_periodic(&mytask, TM_NOW, period)
>
> The periodic thread will be executed at:
>
> T0+D    T0+D+period    T0+D+period*2    T0+D+period*3    ...
>
> However, if I use rt_task_set_periodic(&mytask, recorded_time, period):
>
> T0+D    T0+period    T0+period*2    T0+period*3
>
> That is, only the first execution is affected by the delay D. I think
> this option is clearly superior.

After checking the sources, it appears that Xenomai never worked the
way you think: xnpod_set_thread_periodic returns -ETIMEDOUT if the
initial date is in the past. So maybe it worked for you because you
are using a periodic timer ?

--=20
                                               Gilles Chanteperdrix

