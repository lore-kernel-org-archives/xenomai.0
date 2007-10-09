Message-ID: <305035a40710090209r3015b12fr84d11d3d29996fcc@domain.hid>
Date: Tue, 9 Oct 2007 11:09:30 +0200
From: "Gregory CLEMENT" <gclement00@domain.hid>
In-Reply-To: <2ff1a98a0710090146h2684608bjc4d7b91ed7cc0d95@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <515338.44993.qm@domain.hid>
	<80b317760709110456k2ef95162t19d833da7c5781de@domain.hid>
	<46E699C6.80609@domain.hid>
	<305035a40709140817q452ca77dude2af88ce6fc3dd9@domain.hid>
	<18186.42065.560821.557825@domain.hid>
	<305035a40710082339t16c75581sd07c7f05ed7df9c2@domain.hid>
	<18187.11479.59369.746670@domain.hid>
	<305035a40710090103n7f14377ema39ed8aab42207a6@domain.hid>
	<2ff1a98a0710090146h2684608bjc4d7b91ed7cc0d95@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

2007/10/9, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> On 10/9/07, Gregory CLEMENT <gclement00@domain.hid> wrote:
> > 2007/10/9, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> > > Gregory CLEMENT wrote:
> > >  > 2007/10/8, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> > >  > > gclement00 at gmail.com (Gregory CLEMENT) wrote:
> > >  > >  > 2007/9/11, Bill Gatliff <bgat@domain.hid>:
> > >  > >  > > Richard Genoud wrote:
> > >  > >  > > >>   For an industrial control application, i need to port =
an RTOS pn ARM9 specifically, cirrus logic based ARM. Can anyone suggest me=
 the chances of porting RT Linux on this ARM core. if not any other RTOS pl=
ease.
> > >  > >  > > >>
> > >  > >  > > >
> > >  > >  > > > Hi !
> > >  > >  > > >
> > >  > >  > > > we've started to port xenomai and RTAI to arm9 (AT91RM920=
0 & AT91SAM926x)
> > >  > >  > > >
> > >  > >  > > > you can download the patches here :
> > >  > >  > > > http://www.adeneo.adetelgroup.com/srt/adeneoen/flb/show?l=
ocation.id:=3D1452
> > >  > >  > > >
> > >  > >  > > > Richard.
> > >  > >  > > >
> > >  > >  > >
> > >  > >  > > Xenomai already supports the AT91RM9200.
> > >  > >  >
> > >  > >  > Indeed and now Xenomai supports also AT91SAM9260,  AT91SAM926=
1 and
> > >  > >  > AT91SAM9263 as our patches are now in adeos.
> > >  > >
> > >  > > Hi,
> > >  > >
> > >  > > I have found this mail by chance with Google, and could not leav=
e it
> > >  > > unanswered.
> > >  > >
> > >  > > First, let me clarify the situation of Xenomai ARM port. It is a
> > >  > > collective work which was started more that two years ago,
> > >  >
> > >  > I never said anything else.
> > >
> > > Read the quoted text again: "we've started to port xenomai and RTAI t=
o arm9 (AT91RM9200 & AT91SAM926x)"
> >
> > OK, but it is not me who said this. The person who said this wasn't
> > really aware of our work, and misunderstood what we have done.
> >
> > >
> > >  > >  > For RTAI we have now a working systeme with have better max l=
atency
> > >  > >  > than Xenomai ( 50us instead of around 100us for Xenomai). I p=
lan to
> > >  > >  > update the patches on our site with this new version and comm=
unicate
> > >  > >  > on it on RTAI list as soon as I have some free time.
> > >  > >
> > >  > > A good place for discussing about these figures would have been =
Xenomai
> > >  > > mailing list, a place where we could have answered you immediate=
ly. Are
> > >  > > you sure you are not comparing Xenomai user-space scheduling lat=
ency
> > >  > > with RTAI kernel-space scheduling latency ?
> > >  >
> > >  > I thought a best place was RTAI list, as we ever communicated on
> > >  > Xenomai latency on xenomai and adeos list. For example in
> > >  > https://mail.gna.org/public/adeos-main/2007-05/msg00002.html .
> > >  > Unfortunately, I have now a lot to do, and a very few extra time f=
or
> > >  > it :o/ I hope will be able to work on it soon.
> > >  >
> > >  >
> > >  > Sorry if it this thread hurt you, it wasn't our intention to claim=
 a
> > >  > work we didn't have done. And I hope we will be able to work again=
 on
> > >  > the subject as there is still room for improvement.
> > >
> > > The thing I do not appreciate is the claim about latencies. Either yo=
u
> > > are right, and we should find what the problem is, or you are compari=
ng
> > > apples and oranges, and your statistics are totally irrelevant.
> >
> > But you have the test latency we ran. We compared latency in the best
> > mode of both RTAI and Xenomai, ie in kernel mode.
>
> If I read the statistics you posted on the Adeos mailing list, here:
> https://mail.gna.org/public/adeos-main/2007-06/msg00023.html
>
> You had latencies smaller than 100us already in user-space. So, the
> fact that you get higher latencies in kernel-space is highly
> suspicious.

Where do you see it is in user space ? The latency are colected in
kernel module, it is just display wich is in user space.
Then the 100us I mentionned are under calibrator load, which is the
application which give the worse resulats. On the result yout point
the max lantency is 200us.
We reached 100us by set dbgu priority to 6, and maintain timer
priority to 7. Indeed serial output on dbu give bad latency as it its
peripheral ID is 0, so with the same level of priority in AIC, its
interrupt are treated first. We change this in adeos fot both RTAI and
Xenomai.
Maybe this change can be done in adeos main tree.

>
> > In RTAI path from it to RTAI seems more direct than in Xenomai even in
> > kernel mode. I say this by reading code, it is not just a guess. So it
> > is not surprising to me that there is better latency in RTAI. I am not
> > sure there is a problem to find, the software architecture are
> > different.
>
> Latencies are supposed to be due to hardware effects, the software
> path should have little effect. If software has such an high effect
> then we have a problem. But as I said, a 100 us latency in
> kernel-space is suspicious if you get latencies smaller than 100us in
> user-space.
>
> > You can test RTAI on AT91RM9200 (as AT91RM9200 is merly equal to
> > AT91SAM926x) the patches are on RTAI contrib repository:
> > http://www.rtai.org/RTAICONTRIB/
>
> You are the one who publishes comparisons, so you are the one who
> should run the tests rigorously.

I thinks our tests are rigorous, but I am open to disuss of it.

>
> --
>                                                Gilles Chanteperdrix
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

