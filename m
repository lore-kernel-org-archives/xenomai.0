Message-ID: <2F8EE677D406514ABE53EF9C0934A666042ABE01@domain.hid>
From: Laurent.POYART@fr.thalesgroup.com
Date: Wed, 28 Nov 2007 14:38:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Low priority primary mode threads scheduling v	s
	linux regular th read.
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

Gilles wrote:
> The problem is that when Tx2 is running in secondary mode, it needs =
to
> voluntary switch to primary mode. When in secondary mode, Tx2 is
> suspended from Xenomai nucleus point of view, so xnpod_resume_thread
> cause the SIGHARDEN signal to be sent to Tx2, but Tx2 needs to run a
> little bit to handle the signal which will cause it to switch to
> primary mode.
>=20
> So, in my opinion (but I may be wrong) TL will continue to run until
> it lets Tx2 run.

I think there is a misundestanding. In my example (see bellow), Tx2 is =
not in secondary mode . It is a primary mode thread which is blocked =
while waiting for an RT event (xenomai domain). I wanted to be sure of =
the scheduling issue between the TL (linux regular thread) which is =
running and the Tx2 (primary) which becomes runnable.
In my opinion, TL will continue to run (because of the Tx1 status) but =
I'm not sure.

Regards.
Laurent.


> -----Message d'origine-----
> De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Envoy=E9 : mercredi 28 novembre 2007 14:09
> =C0 : Laurent.POYART@fr.thalesgroup.com
> Cc : xenomai@xenomai.org
> Objet : Re: [Xenomai-help] Low priority primary mode threads=20
> scheduling
> vs linux regular th read.
>=20
>=20
> On Nov 28, 2007 9:24 AM,  <Laurent.POYART@fr.thalesgroup.com> wrote:
> > Hi,
> >
> > It was said in a previous thread under title "scheduling of=20
> low priority primary mode Xenomai threads versus high=20
> priority secondary mode Xenomai threads":
> > <<Plain regular Linux threads unknown from the Xenomai=20
> scheduler are always preempted by primary mode threads, but=20
> they _do_ compete for the CPU with secondary mode threads=20
> according to their priority and scheduling class>>
> > Consider the following example with 3 Threads (coupling=20
> between Xenomai and Linux schedulers is On):
> > *       TL : regular linux thread with high priority=20
> (unknown from Xenomai Scheduler) =3D> ready to run.
> > *       Tx1 : xenomai real time thread with medium priority=20
> in primary mode =3D> running.
> > *       Tx2 : xenomai real time thread with low priority in=20
> primary mode =3D> blocked (waiting for an event).
> > Tx1, which is running, issues a linux system call and then=20
> switches to secondary mode. TL and Tx1 compete for the CPU=20
> and TL takes the CPU control (am I right?).
> > Then an interrupt occurs and gives the necessary condition=20
> to unblock the Tx2 thread. Does the sentence <<Plain regular=20
> Linux threads unknown from the Xenomai scheduler are always=20
> preempted by primary mode threads>> means that Tx2 will=20
> preempt TL or does TL keep control of the CPU because it is=20
> still in competition with the secondary mode thread Tx2 which=20
> has a higher priority compared to Tx1?
>=20
> The problem is that when Tx2 is running in secondary mode, it needs =
to
> voluntary switch to primary mode. When in secondary mode, Tx2 is
> suspended from Xenomai nucleus point of view, so xnpod_resume_thread
> cause the SIGHARDEN signal to be sent to Tx2, but Tx2 needs to run a
> little bit to handle the signal which will cause it to switch to
> primary mode.
>=20
> So, in my opinion (but I may be wrong) TL will continue to run until
> it lets Tx2 run.
>=20
>=20
> --=20
>                                                Gilles Chanteperdrix
>=20

