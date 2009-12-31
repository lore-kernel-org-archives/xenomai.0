Message-ID: <954372.96938.qm@domain.hid>
Date: Thu, 31 Dec 2009 02:24:26 -0800 (PST)
From: Yigal Goldberger <yigal_gold@domain.hid>
In-Reply-To: <258879.2941.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Fw: Re: signaling to a thread waiting on an
	event in the kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,
I found the issue - Nothing to do with the blocked thread (waiting on the s=
ignal ) .
Just some bug in my application...It works just fine now.

Thanks,
Yigal Goldbnerger.

--- On Mon, 12/28/09, Yigal Goldberger <yigal_gold@domain.hid> wrote:

> From: Yigal Goldberger <yigal_gold@domain.hid>
> Subject: [Xenomai-help] Fw: Re: signaling to a thread waiting on an event=
 in the kernel
> To: xenomai@xenomai.org
> Date: Monday, December 28, 2009, 7:57 PM
> Hi,
> CC'ing the mailing list .
>=20
> --- On Mon, 12/28/09, Yigal Goldberger <yigal_gold@domain.hid>
> wrote:
>=20
> > From: Yigal Goldberger <yigal_gold@domain.hid>
> > Subject: Re: [Xenomai-help] signaling to a thread
> waiting on an event in the kernel
> > To: "Philippe Gerum" <rpm@xenomai.org>
> > Date: Monday, December 28, 2009, 6:01 PM
> > Hi Philippe,
> > Thanks for quickly responding .
> > My system is a powerpc based board ( MPC8272 by
> freesacle
> > ).
> > The kernel is 2.6.29.4 .
> > Xenomai v2.4.8.
> >=20
> > My app hangs on the RTDM syscall invoking
> > rtdm_event_timedwait() from your
> > driver .(It does not return from this function call
> at
> > all)
> > The system does not lock up badly . My so called
> Monitor
> > process (the process that issues the
> kill(Pid,SIGTERM),
> > functions well and communicates fine.
> > I'd like to mention that when the application process
> is
> > not blocked (in normal operation) it does respond to
> the
> > signal and terminates correctly , but when it is
> "stuck"|
> > such as on the infinite event wait it becomes non
> responsive
> > to external signals.
> >=20
> > Thanks,
> > Yigal.
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > --- On Mon, 12/28/09, Philippe Gerum <rpm@xenomai.org>
> > wrote:
> >=20
> > > From: Philippe Gerum <rpm@xenomai.org>
> > > Subject: Re: [Xenomai-help] signaling to a
> thread
> > waiting on an event in the kernel
> > > To: "Yigal Goldberger" <yigal_gold@domain.hid>
> > > Cc: xenomai@xenomai.org
> > > Date: Monday, December 28, 2009, 4:52 PM
> > > On Mon, 2009-12-28 at 01:59 -0800,
> > > Yigal Goldberger wrote:
> > > > Hi,
> > > >=20
> > > > I want to have the ability to restart a
> process
> > at all
> > > times.
> > > > I have a situation where a thread is waiting
> on
> > an
> > > event in the kernel with :=20
> > > > rtdm_event_timedwait(&args,0,NULL)
> > >=20
> > > >=A0=A0=A0- infinite wait (I need this infinite
> > > wait ...)=20
> > > >=20
> > > > and I cannot restart it with=A0 :
> > > >=20
> > > > kill(Pid,SIGTERM) .
> > > >=20
> > > > from a different process .
> > > >=20
> > > > Suggestions are most welcome.
> > > >=20
> > >=20
> > > Please be more specific:
> > >=20
> > > - what happens when SIGTERM is sent, exactly?
> does
> > your app
> > > hang on the
> > > RTDM syscall invoking rtdm_event_timedwait()
> from
> > your
> > > driver, or does
> > > the entire system lock up badly?
> > > - did you check whether rtdm_event_timedwait()
> > returned
> > > with an error
> > > code, such as -EINTR?
> > > - which platform, whick kernel release, which
> Xenomai
> > > release are you
> > > running?
> > >=20
> > > Btw, rtdm_event_wait(&event) is a shorthand
> for
> > > rtdm_event_timedwait(&event,0,NULL).
> > >=20
> > > > Yigal Goldberger.
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=A0 =A0 =A0=A0=A0
> > > >=20
> > > >
> _______________________________________________
> > > > Xenomai-help mailing list
> > > > Xenomai-help@domain.hid
> > > > https://mail.gna.org/listinfo/xenomai-help
> > >=20
> > >=20
> > > --=20
> > > Philippe.
> > >=20
> > >=20
> > >=20
> >=20
> >=20
> >=20
> >
>=20
>=20
>=20
> =A0 =A0 =A0=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> =0A=0A=0A      

