Content-Type: text/plain; charset="utf-8"
In-Reply-To: <CALLqZ8R3Os8-0tqSvtPiikPxAZyK_jsQWiSC46FToL=FyXFYkg@mail.gmail.com>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Date: Wed, 04 Mar 2020 17:00:38 +0100
MIME-Version: 1.0
Message-ID: <7232-5e5fd080-9-2896e5c0@29286504>
Subject: =?utf-8?q?Re=3A?= GPIO interrupt not working on Zynq7000
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: =?utf-8?q?Xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Le Mercredi, Mars 04, 2020 16:48 CET, Greg Gallagher <greg@embeddedgreg=
.com> a =C3=A9crit: 
 
> hi,
> 
> On Wed, Mar 4, 2020 at 9:40 AM Fran=C3=A7ois Legal <devel@thom.fr.eu.=
org> wrote:
> >
> > Le Mercredi, Mars 04, 2020 14:57 CET, Greg Gallagher <greg@embedded=
greg.com> a =C3=A9crit:
> >
> > > Hi,
> > >
> > > On Wed, Mar 4, 2020 at 4:01 AM Fran=C3=A7ois Legal via Xenomai <
> > > xenomai@xenomai.org> wrote:
> > >
> > > > Hello,
> > > >
> > > > trying to diagnose an interrupt problem on a Zynq 7000 hardware=
. The
> > > > environment is linux 4.4.189, xenomai 3.0.9.
> 
> Are you building directly from the ipipe repo or applying one of the
> patches?  If it's a patch what patch are you applying?

I'm applying ipipe-core-4.4.176-arm-10.patch with slight modifications =
(KUSER=5FTSC is not enabled for Zynq 7000 in that patch)

> 
> > > > I'm trying to trig some realtime thread pending on a gpio read.=

> > > >
> > > > At the beginning, the system would freeze if the GPIO pin was t=
oggled,
> > > > because the GPIO int pending status was never cleared by the ex=
isting code.
> > >
> > > how do you clear it? Do you call one of the irqchip functions?
> > >
> > > >
> > > > So now I don't get the system freeze anymore, however, the RTDM=
 gpio  irq
> > > > handler never gets called whenever the interrupt is raised.
> > > >
> > > It=E2=80=99s possible what you called to clear the irq has also m=
asked the
> > > interrupt and requires a unmask. Can you post a patch of what you=
 did?
> > >
> > >
> > > > I'm not sure how to diagnose that. For what I could see, the IR=
Q is
> > > > registered in ipipe domain "xnsched=5Frealtime=5Fdomain", and I=
'm not sure if
> > > > that matches "ipipe=5Fhead=5Fdomain" that is
> > >
> > >
> > > Are you using the rtdm gpio driver? Or is this a custom rtdm driv=
er using
> > > the gpio directly?
> > >
> >
> > I also forgot to mention here, whenever the program is being run, I=
 can see my gpio pin (gpio957) in /proc/xenomai/irq, but not in /proc/i=
nterrupts.
> > However, the irq count does not increment in /proc/xenomai/irq
> >
> > >
> > > >
> > > > Any help appreciated
> > > >
> > > > Fran=C3=A7ois
> > > >
> > >
> > > Greg
> > >
> > > >
> > > >
> > > >
> >


