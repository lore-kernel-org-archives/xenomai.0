Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 27 Nov 2007 14:53:16 -0500
Message-ID: <BF58A8AFB316514587D61EADBFBF4C410165FD26@domain.hid>
In-Reply-To: <18252.28684.840291.855543@domain.hid>
From: "Kyle Howell" <khowell@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Interrupts lost during sleep / unblock cycles
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

>  > I have been debugging a stall problem for a couple of=20
> days, and I think  > I've put together enough info to check=20
> with the pros. Everything below  > was experienced on a P4=20
> (Celeron) running 2.6.20 / Xenomai 2.3.4. I've  > also=20
> reproduced it on 2.6.19.7 / 2.3.1. A quick test *did not*=20
> reproduce  > this problem on a Core2 running x86_64 2.6.22.9=20
> / 2.4RC3.=20
>  >
>  > I've reduced the problem to a fairly simple example below:
>  >
>  > The Overview:
>  > - Running a single real-time process with one standard=20
> thread and one RT  > task  > - The RT task loops on a 1sec=20
> rt_task_sleep  > - The standard thread loops on=20
> nanosleep(10msec) and rt_task_unblock of  > the RT task.
>  > - When an unrelated interrupt arrives at the wrong time,=20
> the entire  > system will hang until the 1sec task_sleep expires.
>  > - After resuming, everything runs normally until another=20
> interrupt lands  > at the wrong moment.
>=20
> Do you observe the same behaviour without the interrupt shield ?

It doesn't appear so. I'll have to let it run longer to be 100% sure,
but the usual stressing isn't causing the problem. That's not expected
behavior with the interrupt shield, is it?

-- Kyle Howell

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
This email and any files transmitted with it are
confidential and intended solely for the use of the
named recipient or recipients.  If you have received
this email in error please notify the sender
immediately. =20

