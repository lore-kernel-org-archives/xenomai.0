Content-Type: text/plain; charset="utf-8"
In-Reply-To: <CALLqZ8Tkf0TKd5aydGwF_UTii4Hk1aerJpNnG_2mWhDYhg9fGg@mail.gmail.com>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
Date: Wed, 04 Mar 2020 17:28:46 +0100
MIME-Version: 1.0
Message-ID: <7230-5e5fd700-9-4d48c480@89257876>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?q?Xenomai=40xenomai=2Eorg?= <xenomai@xenomai.org>

Le Mercredi, Mars 04, 2020 17:12 CET, Greg Gallagher <greg@embeddedgreg=
.com> a =C3=A9crit: 
 
> On Wed, Mar 4, 2020 at 11:08 AM Jan Kiszka <jan.kiszka@siemens.com> w=
rote:
> >
> > On 04.03.20 17:00, Fran=C3=A7ois Legal via Xenomai wrote:
> > > Le Mercredi, Mars 04, 2020 16:48 CET, Greg Gallagher <greg@embedd=
edgreg.com> a =C3=A9crit:
> > >
> > >> hi,
> > >>
> > >> On Wed, Mar 4, 2020 at 9:40 AM Fran=C3=A7ois Legal <devel@thom.f=
r.eu.org> wrote:
> > >>>
> > >>> Le Mercredi, Mars 04, 2020 14:57 CET, Greg Gallagher <greg@embe=
ddedgreg.com> a =C3=A9crit:
> > >>>
> > >>>> Hi,
> > >>>>
> > >>>> On Wed, Mar 4, 2020 at 4:01 AM Fran=C3=A7ois Legal via Xenomai=
 <
> > >>>> xenomai@xenomai.org> wrote:
> > >>>>
> > >>>>> Hello,
> > >>>>>
> > >>>>> trying to diagnose an interrupt problem on a Zynq 7000 hardwa=
re. The
> > >>>>> environment is linux 4.4.189, xenomai 3.0.9.
> > >>
> > >> Are you building directly from the ipipe repo or applying one of=
 the
> > >> patches?  If it's a patch what patch are you applying?
> > >
> > > I'm applying ipipe-core-4.4.176-arm-10.patch with slight modifica=
tions (KUSER=5FTSC is not enabled for Zynq 7000 in that patch)
> > >
> >
> > You know that you can find a newer version in
> > https://gitlab.denx.de/Xenomai/ipipe/tree/ipipe-4.4.y-cip? I'm just=
 not
> > releasing it as I'm lacking test feedback on the updates. It is not=

> > supposed to resolve the GPIO issue, though.
> >
> > Jan
> >
> > --
> > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > Corporate Competence Center Embedded Linux
> 
> I'll have to look at this a little more closely, I don't think you
> need to clear the pending status unless something changed upstream on=

> us.  The chained handler should be calling a mask and ack to hold the=

> line  and then unmask once the handler is called.  In userspace you'r=
e
> just calling select on the gpio path?  I can test this with just the
> ipipe first and see if we can isolate the issue to either the ipipe o=
r
> Xenomai.  It may take me a couple of days to get setup with my Zynq
> board again, can you try the 4.4.y branch Jan mentioned, I'll use tha=
t
> as a starting point when I start debugging.
> 
> Thanks
> 
> Greg
 
Your comment on using the ipipe repo made me go there and have a look. =
It seems I found the answer.
In the zynq=5Fgpio=5Fhandle=5Fbank=5Firq, the ipipe repo uses "ipipe=5F=
handle=5Fdemuxed=5Firq" whereas mine used "generic=5Fhandle=5Firq"

It seems that my problem is solved now.

So I think I saw the announcement for ipipe-core-4.4.196-cip38-x86-19.p=
atch, but nothing for arm.

Thanks

Fran=C3=A7ois


