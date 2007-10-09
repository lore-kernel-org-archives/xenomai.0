Message-ID: <305035a40710090341i642ca2cavc8c1e90afbce93d6@domain.hid>
Date: Tue, 9 Oct 2007 12:41:01 +0200
From: "Gregory CLEMENT" <gclement00@domain.hid>
In-Reply-To: <470B4DCD.4000303@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <515338.44993.qm@domain.hid>
	<80b317760709110456k2ef95162t19d833da7c5781de@domain.hid>
	<46E699C6.80609@domain.hid>
	<305035a40709140817q452ca77dude2af88ce6fc3dd9@domain.hid>
	<18186.42065.560821.557825@domain.hid>
	<470B4688.6010808@domain.hid>
	<305035a40710090235g54c57436u770168437f27a7f6@domain.hid>
	<470B4DCD.4000303@domain.hid>
Subject: Re: [Xenomai-core] RTOS porting on ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

2007/10/9, Jan Kiszka <jan.kiszka@domain.hid>:
> Gregory CLEMENT wrote:
> > 2007/10/9, Jan Kiszka <jan.kiszka@domain.hid>:
> >> Gilles Chanteperdrix wrote:
> >>> gclement00 at gmail.com (Gregory CLEMENT) wrote:
> >>>  >
> >>>  > For RTAI we have now a working systeme with have better max latenc=
y
> >>>  > than Xenomai ( 50us instead of around 100us for Xenomai). I plan t=
o
> >>>  > update the patches on our site with this new version and communica=
te
> >>>  > on it on RTAI list as soon as I have some free time.
> >>>
> >>> A good place for discussing about these figures would have been Xenom=
ai
> >>> mailing list, a place where we could have answered you immediately. A=
re
> >>> you sure you are not comparing Xenomai user-space scheduling latency
> >>> with RTAI kernel-space scheduling latency ?
> >> Me too asked Gregory for some discussion on this long ago but received
> >> no response.
> >>
> >> Anyway, the critical thing beyond latencies remains *maintenance*. If
> >> someone decides to apply I-pipe on RTAI *and* doesn't forget to
> >> contribute to the mandatory bits of the Adeos project, work actively
> >> within that community (test new versions and report results, track dow=
n
> >> bugs, port to new kernels releases, etc.), anyone would benefit in the
> >> end. BTW, that would surely stimulate discussions about differing
> >> numbers on both sides as well.
> >
> > And you think we didn't contribute to adeos projects, test new version
> > and report result???
> > Because it is exactly what we have done.
>
> You did this for the startup of this port, and it is highly appreciated.
> But such things require lasting effort. Probably I'm just so sceptical
> because there have been many people before posting patches once and then
> never again. Just look at RTAI's ARM history of the last, mmh, 4 years.
> I'm always happy being proved wrong regarding such scepticisms of mine!

There is no more post on adeos mailing list just because we didn't
change it, since our last post.
As I mentioned earlier we just set dbgu priority level at a different
level, it is not a big change, but I will post the patch for it.

> > Our result on RTAI are pretty recent, and the lack of discussion on it
> > is only a lack of time and not a lack of wiling.
>
> Then I'm looking forward to have this now, e.g. backed up with tracer
> outputs of both variants.

As I mentionned, that for now, I am deep under load ? Because I am,
and so I will do my best but time is not extensible unforutnately.

>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>


--=20
Gregory CLEMENT
Adeneo
Adetel Group
2, chemin du Ruisseau
69134 ECULLY - FRANCE
France
T=E9l. : +33 (0)4 72 18 08 40 - Fax : +33 (0)4 72 18 08 41

www.adetelgroup.com

