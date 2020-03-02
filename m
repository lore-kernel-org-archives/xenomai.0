MIME-Version: 1.0
References: <DB8PR09MB3612215A31188B5C00AD779BF0E70@DB8PR09MB3612.eurprd09.prod.outlook.com>
 <c4a79189-6696-a109-97f6-8cadbb36923e@siemens.com>
 <VI1PR05MB5917AF77FA0B8FCCC934C810F6E70@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <d761d87d-f0c4-4bb0-17aa-694121620d17@siemens.com>
 <VI1PR05MB5917E4F66562046953DD3B1CF6E70@VI1PR05MB5917.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR05MB5917E4F66562046953DD3B1CF6E70@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 2 Mar 2020 11:24:56 -0500
Message-ID: <CALLqZ8Rv3pQBM4aOW7=Qb0Gfg37_GFGUgN9cLGtE8fBhi7mStw@mail.gmail.com>
Subject: Re: Ipipe-Patch for kernel version 5.4.23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On Mon, Mar 2, 2020 at 11:12 AM Lange Norbert via Xenomai
<xenomai@xenomai.org> wrote:
>
>
>
> > -----Original Message-----
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > Sent: Montag, 2. M=C3=A4rz 2020 16:59
> > To: Lange Norbert <norbert.lange@andritz.com>
> > Subject: Re: Ipipe-Patch for kernel version 5.4.23
> >
> > NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
> > ATTACHMENTS.
> >
> >
> > Offlist by intention?
>
> Nope, just Outlook hating me.
>
> Norbert
>
> >
> > Jan
> >
> > On 02.03.20 16:26, Lange Norbert wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Jan
> > Kiszka
> > >> via Xenomai
> > >> Sent: Montag, 2. M=C3=A4rz 2020 13:38
> > >> To: Ralf Moder <ralf.moder@hbkworld.com>; xenomai@xenomai.org
> > >> Subject: Re: Ipipe-Patch for kernel version 5.4.23
> > >>
> > >> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
> > ATTACHMENTS.
> > >>
> > >>
> > >> On 02.03.20 11:00, Ralf Moder via Xenomai wrote:
> > >>> Hello everyone,
> > >>> I need the kernel version 5.4.23 in an embedded linux project becau=
se
> > of
> > >> driver stuff but also the Xenomai extension. How big is the probabil=
ity
> > that an
> > >> I-pipe patch for the 5.4 version will be released in the next 2 to 3=
 months?
> > >>
> > >> I would first of all say that it's >0. But beyond that, it depends o=
n the
> > >> architecture: x86 should be available on 5.4 in the next months with=
 a
> > >> probability >>50% as that will be my primary target for looking into=
 how to
> > >> move forward. ARM and ARM64 currently lacks a maintainer. If we are
> > lucky,
> > >> the base enabling via Philippe's dovetail queue will enable those mo=
re or
> > less
> > >> as well. But it will definitely take someone to take responsibility =
for those
> > >> archs because my colleagues and I currently cannot invest beyond
> > integrating
> > >> contributions. There is also ppc32 (which has a maintainer), but I s=
uppose
> > >> that this is not your target.
> > >>
> > >> Jan
> > >
> > > I still can't estimate the impact of swapping to dovetail, how much "=
ripples"
> > this will cause.
> > > I suppose the cobalt usermode interface will stay the same.
> > >
> > > -   Will drivers (rtnet) be affected?
I don't think there will be a big impact, but that may depend on how
the RTDM core is ported over.

> > > -   AFAIU there finally will be shared clocks (monotonic, realtime) b=
etween
> > cobalt and linux?
> > >
> > > I would of course welcome a 5.4 kernel, allowing me to drop several
> > backported patches,
> > > at the same time it's not a really good time to swap the basic buildi=
ng blocks
> > for us.
x86 5.4 kernel?
> > >
> > > Norbert
> > > ________________________________
> > >
> > > This message and any attachments are solely for the use of the intend=
ed
> > recipients. They may contain privileged and/or confidential information=
 or
> > other information protected from disclosure. If you are not an intended
> > recipient, you are hereby notified that you received this email in erro=
r and
> > that any review, dissemination, distribution or copying of this email a=
nd any
> > attachment is strictly prohibited. If you have received this email in e=
rror,
> > please contact the sender and delete the message and any attachment fro=
m
> > your system.
> > >
> > > ANDRITZ HYDRO GmbH
> > >
> > >
> > > Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung /
> > Corporation
> > >
> > > Firmensitz/ Registered seat: Wien
> > >
> > > Firmenbuchgericht/ Court of registry: Handelsgericht Wien
> > >
> > > Firmenbuchnummer/ Company registration: FN 61833 g
> > >
> > > DVR: 0605077
> > >
> > > UID-Nr.: ATU14756806
> > >
> > >
> > > Thank You
> > > ________________________________
> > >
> ________________________________
>
> This message and any attachments are solely for the use of the intended r=
ecipients. They may contain privileged and/or confidential information or o=
ther information protected from disclosure. If you are not an intended reci=
pient, you are hereby notified that you received this email in error and th=
at any review, dissemination, distribution or copying of this email and any=
 attachment is strictly prohibited. If you have received this email in erro=
r, please contact the sender and delete the message and any attachment from=
 your system.
>
> ANDRITZ HYDRO GmbH
>
>
> Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corp=
oration
>
> Firmensitz/ Registered seat: Wien
>
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
>
> Firmenbuchnummer/ Company registration: FN 61833 g
>
> DVR: 0605077
>
> UID-Nr.: ATU14756806
>
>
> Thank You
> ________________________________

