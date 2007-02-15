Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] pthread_make_periodic_np and clock_gettime
Date: Thu, 15 Feb 2007 07:58:45 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A82C5D7@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: Xenomai-help@domain.hid

Sorry for the stupid question but: what is tick_arg ? Do  I have to =
configure it within Xenomai or is it a kernel parameter ?=20
The timing of my target in principal is fine. When I set=20
   tstart.tv_sec=3D0;
   tstart.tv_nsec=3D0;=20
both to zero, my task gets peiodic (task runs every second). Just when =
using clock_gettime(CLOCK_REALTIME,&tstart) I get into trouble.

Roderik


> -----Urspr=FCngliche Nachricht-----
> Von: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
> Gesendet: Mittwoch, 14. Februar 2007 18:44
> An: Gilles Chanteperdrix
> Cc: Wildenburg, Roderik RAEK3 MRA; Xenomai-help@domain.hid
> Betreff: Re: [Xenomai-help] pthread_make_periodic_np and clock_gettime
>=20
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >  > Roderik_Wildenburg@domain.hid wrote:
> >  > > Can anybody tell me, how I have to set the 2.=20
> parameter (starttp)=20
> > of  > > pthread_make_periodic_np ?
> >  > > When I use clock_gettime to fill startp I get a giant timeout=20
> > value in  > > the /proc/xenomai/sched list and my task=20
> never gets periodic.
> >  > >
> >  > > Is this just a problem of my hardware(PPC)/xenomai(2.3)=20
> > combination or  > > does anybody else have the same problem.
> >  > >
> >  > > See attached code example for easier testing.
> >  > >
> >  >
> >  > Confirmed over v2.3.x in periodic mode, aperiodic is=20
> fine. Gilles?
> >=20
> > Ok. I will have a look at it.
> >=20
>=20
> Hmm, something went wrong here. I think I passed a too fast=20
> tick_arg to the kernel yesterday which smashed the timing.=20
> I'm now running the pperiodic demo at tick_arg=3D1000000 successfully.
>=20
> So, Roderik, either you did some similar mistake, or it's a PPC issue.
>=20
> Jan
>=20
>

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

