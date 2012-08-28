From: Paul <paul_c@tuxcnc.org>
Date: Tue, 28 Aug 2012 01:34:28 +0100
References: <201208262252.27556.paul_c@tuxcnc.org>
	<201208272322.05160.paul_c@tuxcnc.org> <503BF463.50603@xenomai.org>
In-Reply-To: <503BF463.50603@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201208280134.28998.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] oops on ARM1176 SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


Thanks Gilles

On Monday 27 August 2012, Gilles Chanteperdrix wrote:
> > Unloading any of the skins result in the kernel halting. It appears
> > as if it is a deadlock, but I suspect it is timer related - A
> > subject for another thread perhaps.
>
> Mmmm... does not look too tested either. Try the following patch:
> diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
> index 4286e4a..9838dc4 100644
> --- a/kernel/ipipe/timer.c
> +++ b/kernel/ipipe/timer.c
> @@ -317,6 +317,7 @@ void ipipe_timer_stop(unsigned cpu)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0evtdev->mult =3D timer->r=
eal_mult;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0evtdev->shift =3D timer->=
real_shift;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0evtdev->set_mode =3D time=
r->real_set_mode;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0evtdev->set_next_event =3D =
timer->real_set_next_event;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0timer->real_mult =3D time=
r->real_shift =3D 0;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0timer->real_set_mode =3D =
NULL;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0timer->real_set_next_even=
t =3D NULL;

Another bug fixed \o/


Regards, Paul.

