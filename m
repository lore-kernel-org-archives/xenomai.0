Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 6 Dec 2007 10:26:39 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D375FD8@domain.hid>
In-Reply-To: <2ff1a98a0712060848j4822e7eal5f8d3b8ba8dc6772@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D375FC2@domain.hid>
	<2ff1a98a0712060848j4822e7eal5f8d3b8ba8dc6772@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] more watchdog stuff
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

Thanks for the answers. For now, I think that one second is ok. We can't
use the soft lockup detect either because it doesn't say anything.

Originally (before xenomai) what we did was have a low priority linux
task ping a high priority hard realtime task (rtai) and then that would
detect all lockups. However, we were only running one app at a time
then. I think we may just have to live with what we have. :) I'm
awaiting answers from the "boss".

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Thursday, December 06, 2007 9:49 AM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] more watchdog stuff
>=20
> On Dec 6, 2007 5:41 PM, Steven Seeger
> <sseeger@domain.hid> wrote:
> >
> >
> >
> >
> > Can a Xenomai thread running in the secondary domain cause the
watchdog
> > timer to kill it?
>=20
> No, this one will be caught by Linux soft-lockup detector.
>=20
> > Also, how hard would it be to modify the watchdog system to give
timing
> > requirements in resolutions better of 1 second?
>=20
> I guess the resolution of 1 second was chosen because it allows the
> watchdog to have a very low overhead, but this can be changed easily.
>=20
> --
>                                                Gilles Chanteperdrix

