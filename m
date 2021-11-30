From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <CALLqZ8SFtM6Z-7n-DU-Z_XT7QnT7zGAy0mJCndavAo8s-k8fKQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 30 Nov 2021 18:13:23 +0100
MIME-Version: 1.0
Message-ID: <d25-61a65b80-2f-1ed4ee4@258913550>
Subject: =?utf-8?q?Re=3A?= IRQ not raised switching from =?utf-8?q?4=2E4=2Ex?=
 to =?utf-8?q?4=2E19=2Ex?=
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
Cc: xenomai@xenomai.org

Le Mardi, Novembre 30, 2021 16:32 CET, Greg Gallagher <greg@embeddedgre=
g.com> a =C3=A9crit: 
 
> On Tue, Nov 30, 2021 at 9:59 AM Fran=C3=A7ois Legal via Xenomai <
> xenomai@xenomai.org> wrote:
> 
> > So I guess I have the beginning of the explanation.
> > By checking the GIC registers more thoroughly, I found out the trig=
ger
> > type was not set properly (my device uses edge interrupts, and GIC =
was
> > setup with level interrupts)
> > What's not clear is that the interrupt trigger type is set, if I
> > understand correctly, when one calls platform=5Fget=5Firq (if IRQ f=
lags are set
> > in the DT, they are setup at that moment).
> > That seems to work OK for linux interrupts, but somehow, these flag=
s get
> > reset for xenomai interrupts (and that did not seem to be the case =
earlier).
> > Still digging there to find out what's going on.
> >
> > I found out that rtdm=5Firq=5Frequest can have RTDM=5FIRQTYPE=5FEDG=
E as flag
> > argument, but I'm still not sure how this flag gets handed to ipipe=
 and
> > then to the GIC.
> >
> > Still searching
> >
> > Fran=C3=A7ois
> >
> > Le Mardi, Novembre 30, 2021 14:28 CET, Fran=C3=A7ois Legal via Xeno=
mai <
> > xenomai@xenomai.org> a =C3=A9crit:
> >
> > > Hello,
> > >
> > > I'm experiencing a weird issue while transitioning Xenomai 3.1 fr=
om
> > linux 4.4 to 4.19.
> > > Platform is Zynq 7000 ARM Cortex A9.
> > > Using the exact same hardware, porting a network device driver, t=
he
> > interrupts that should trigger whenever a packet is sent or receive=
d do not
> > grif any more. I can see the network packets being sent & received =
by
> > devmem'ing to the device memory and buffers, but no interrupt ever =
happens.
> > >
> > > I checked the various GIC registers, and everything seems to be O=
K.
> > >
> > > Any idea ?
> > >
> > > Thanks in advance
> > >
> > > Fran=C3=A7ois
> > >
> >
> 
> Hi Francois,
>    I can help and take a look later tonight if you still are having i=
ssues.
> 
> Thanks
> 
> Greg
> 

Well, I've been digging this for some hours now, and I still can't  fin=
d the bottom of it. What I can tell, is that regular linux IRQ request =
calls request=5Fthreaded=5Firq which in turns will call something ... t=
hat calls =5F=5Firq=5Fset=5Ftrigger, which in turns calls the correspon=
ding chip (the GIC here) routine to setup level/edge interrupts.

I can't find where that could be in ipipe.

Fran=C3=A7ois

> >
> >
> >
> >


