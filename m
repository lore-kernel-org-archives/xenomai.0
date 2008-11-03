Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Nov 2008 07:21:11 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int>
In-Reply-To: <490ECE11.208@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
	<490ECE11.208@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] fpu context switch issue
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

Hi Gilles. Thank you for getting back to me.

I do not see "fxsr" in /proc/cpuinfo. I checked around with Google and
it seems this chip doesn't have FXSR support. Do I need to do something
else in this case? We are currently using a new board. I will check
/proc/cpuinfo on the old board and see if it says FXSR. We never had
this problem with the old board.

I understand that some libraries do things on startup, but this one
doesn't seem to. In fact, linking that library in only adds 8 bytes to
the code. Very strange. I really think it would fail even without
linking that in but I can't produce it. I have other apps that are more
complicated but do not use that library that also have issues with
doubles on startup.

I also realized I didn't remove access to the run variable when I
attached the code. That variable is obviously not being used.=20

I will post the results of switchtest later today. Thank you for the
suggestion.

Steven

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Monday, November 03, 2008 3:10 AM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] fpu context switch issue
>=20
> Steven Seeger wrote:
> > I'm having a weird issue. Sometimes when I run the attached program
I
> > see one of the "shouldn't see this" printouts. However, it only
fails
> if
> > I also link in another userspace library that doesn't do anything.
> (No
> > libraries are being called here.)
>=20
> Some libraries do things when loaded, even if no function is called:
if
> a C++ library declares a global or static object with a non trivial
> constructor, the constructor is run when the library is loaded. The
> same
> goes for C functions declared with the "constructor" attribute.
>=20
> >
> >
> >
> > I've had issues with a couple of other xenomai apps. I get a nan on
a
> > double operation sometimes right after the app first loads, and then
> > it's ok after that. This error in the attached program always
happens
> on
> > the first call in the higher priority task (started second.)
> >
> >
> >
> > Running 2.4.5 with 2.6.26.3 and also 2.6.25.9. AMD Geode LX800
board.
>=20
> Could you try to run the "switchtest" program, and see if it has bugs
> too ? Also, do you see the "fxsr" flag in /proc/cpuinfo ?
>=20
> --
>                                                  Gilles.

