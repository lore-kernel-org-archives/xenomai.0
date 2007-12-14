Message-ID: <2ff1a98a0712140146o2a3c5761i8a97d67921fedecd@domain.hid>
Date: Fri, 14 Dec 2007 10:46:39 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47624674.5070107@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <475E76A0.4010007@domain.hid> <475E7CBA.7060300@domain.hid>
	<475E7F84.1040600@domain.hid> <475E8DAE.9070405@domain.hid>
	<2ff1a98a0712110541x12633fa3yb311214d9d0245a1@domain.hid>
	<475EA9F4.3020306@domain.hid>
	<2ff1a98a0712110841y7d16bb2esfca8fdfd7419ea5e@domain.hid>
	<47624674.5070107@domain.hid>
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
Cc: xenomai-help <xenomai@xenomai.org>

On Dec 14, 2007 10:01 AM, Ignacio Garc=EDa P=E9rez <iggarpe@domain.hid> wrote=
:
>
> > After checking the sources, it appears that Xenomai never worked the
> > way you think: xnpod_set_thread_periodic returns -ETIMEDOUT if the
> > initial date is in the past. So maybe it worked for you because you
> > are using a periodic timer ?
> >
> >
> I'm using oneshot mode. The application that got broken wasn't
> unmodified. It worked in 2.3.4 and didn't work in 2.4.0 unchanged.
>
> The problem seems not to be the return value of rt_task_set_periodic,
> which returns -ETIMEDOUT for start dates in the past both in 2.3.4 and
> 2.4.0, but in the fact that in 2.3.4 the task is anyway scheduled for
> immediate execution while in 2.4.0 it is not.

I do not see this in 2.3.4 code, but let's admit it is true: then
v2.3.4 code is broken, and so is your application. Really, no RTOS
allows starting timers with dates in the past, you can check the
various Xenomai skins implementation or the posix spec. So, our advice
is to fix your application.

--=20
                                               Gilles Chanteperdrix

