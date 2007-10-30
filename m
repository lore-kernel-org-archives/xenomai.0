Message-ID: <2ff1a98a0710300629v5df42d78sf6c4795f1c4e782b@domain.hid>
Date: Tue, 30 Oct 2007 14:29:33 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200710301203.l9UC3esT009573@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <200710301203.l9UC3esT009573@domain.hid>
Subject: Re: [Xenomai-help] RT, nonRT communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

On 10/30/07, Patrick <kpa_info@domain.hid> wrote:
> > -----Message d'origine-----
> > De: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> > Envoy=E9: mardi, 30. octobre 2007 10:52
> > =C0: Patrick
> > Cc: xenomai@xenomai.org
> > Objet: Re: [Xenomai-help] TR: RT, nonRT communication
> >
> > On 10/30/07, Patrick <kpa_info@domain.hid> wrote:
> > >
> > >
> > >
> > >
> > > Hi,
> > >
> > >
> > >
> > > Is it possible to share a pthread_mutex between a rt task and a linux
> > > pthread ?
> >
> > No, it is not possible
> >
> > >
> > > My two tasks must share resources and I must protect them against
> > concurrent
> > > access.
> > >
> > > If pthread_mutex is not the correct way to do it can you tell me how =
to
> > > achieve this ?
> >
> > The way to handle these border line cases is to make your linux
> > pthread a xenomai thread running with the SCHED_OTHER scheduling
> > policy. Note that the main thread already has this property.
> >
> Ok, so if I understand I can't use a pthread_mutex between the main threa=
d
> and a rt_task ?

You CAN use a xenomai pthread_mutex between the main thread and a
rt_task, the main thread is a xenomai thread running with the
SCHED_OTHER scheduling policy.

> If I want use pthread_mutex between another pthread and a rt_task, must t=
he
> pthred be running with SCHED_OTHER ? This value is the default value for
> pthread !

The pthread must be a xenomai posix skin thread running with the
SCHED_OTHER policy. You can achieve this by creating this pthread with
xenomai wrapped pthread_create, or by setting its policy (assuming the
thread was created with the non wrapped pthread_create, i.e.
__real_pthread_create) with xenomai wrapped pthread_setschedparam.

In other words, if you use Xenomai wrapped functions, everything
should be fine. Things become tricky when you decide to use __real_*
functions.

--=20
                                               Gilles Chanteperdrix

