From: "George Pontis" <gpontis@z9.com>
References: <04a701ce864f$91047590$b30d60b0$@z9.com>
	<51F182E4.70907@xenomai.org>
	<00d101ce8a1b$32cfeac0$986fc040$@z9.com>
	<51F59545.5090805@xenomai.org>
In-Reply-To: <51F59545.5090805@xenomai.org>
Date: Sun, 28 Jul 2013 18:59:22 -0700
Message-ID: <020101ce8bff$3eb6c5d0$bc245170$@z9.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: Re: [Xenomai] cannot open switchtest device ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Sunday, July 28, 2013 3:04 PM
> To: George Pontis
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] cannot open switchtest device ?
>=20
> On 07/26/2013 06:14 PM, George Pontis wrote:
>=20
> >> -----Original Message-----
> >> From: Gilles Chanteperdrix =
[mailto:gilles.chanteperdrix@xenomai.org]
> >> Sent: Thursday, July 25, 2013 12:56 PM
> >> To: George Pontis
> >> Cc: xenomai@xenomai.org
> >> Subject: Re: [Xenomai] cannot open switchtest device ?
> >>
> >> On 07/21/2013 10:19 PM, George Pontis wrote:
> >>
> >>> I find a problem trying to run xeno-test when it goes to open the =
switchtest
> >>> device. Before this post I searched the web and found a thread =
started by
> >>> "raespi".
> >>> We have a similar situation in which we are both using buildroot, =
but I'm
> >>> not sure that the underlying cause is the same. I am building a =
kernel for
> >>> 3.8.13 using
> >>> the patches from git, and also the current git xenomai. ( Current =
as of a
> >>> month ago ). The target is an custom board based on the iMX53.
> >>>
> >>> To narrow the source of the problem, I modified switchtest.c to =
report on
> >>> any case where the open() returns a negative number. I also made a
> >> temporary
> >>> patch
> >>> to not prepend the name with "/dev/". I might add that I'm using a =
new
> RTDM
> >>> driver named fpga_rtdm that can be opened and access successfully.
> >>> Here's what happens:
> >>
> >>
> >> This may look like a stupid suggestion, but that is the only =
explanation
> >> I see: you are probably using glibc's open instead of xenomai's =
open.
> >> This may happen for instance if you are compiling xenomai libraries
> >> statically and switchtest Makefile does not use the "wrap-link.sh" =
script.
> >> --
> >>                                                                   =
Gilles.
> >
> > Not stupid, that was a useful suggestion. Both are dynamically =
linked, and I'm
> actually using
> > uClibc for this embedded system.
> >
> > I tried to open the switchtest device from my application and it was
> successful.
> > One difference was that my application was opening these with a call =
to
> rt_dev_open(),
> > while the switchtest.c file used open(). Also, when building =
switchtest the
> open() is
> > resolved with open64() due to selecting large file support.
> >
> > A quick mod of the switchtest code to use rt_dev_open() instead of =
open()
> would not build
> > without more effort.
>=20
>=20
> Hi George,
>=20
> I added a wrapper for open64, could you try the current git contents, =
or
> apply the following patch to the tree you use?
>=20
> http://git.xenomai.org/?p=3Dxenomai-
> 2.6.git;a=3Dcommit;h=3Dd6127b245ed9876ce4153bac2996d88d0d7355c6
>=20
> Regards.
>=20
> --
>                                                                  =
Gilles.

I built from the current git tree and tried it: xeno-test ran to =
completion.

Thank you Gilles.

George =20



