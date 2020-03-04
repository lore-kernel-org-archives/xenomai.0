MIME-Version: 1.0
References: <7232-5e5fd080-9-2896e5c0@29286504>
 <eca01f47-9200-821c-cf69-af8fcce5703f@siemens.com>
In-Reply-To: <eca01f47-9200-821c-cf69-af8fcce5703f@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 4 Mar 2020 11:12:04 -0500
Message-ID: <CALLqZ8Tkf0TKd5aydGwF_UTii4Hk1aerJpNnG_2mWhDYhg9fGg@mail.gmail.com>
Subject: Re: GPIO interrupt not working on Zynq7000
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Mar 4, 2020 at 11:08 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 04.03.20 17:00, Fran=C3=A7ois Legal via Xenomai wrote:
> > Le Mercredi, Mars 04, 2020 16:48 CET, Greg Gallagher <greg@embeddedgreg=
.com> a =C3=A9crit:
> >
> >> hi,
> >>
> >> On Wed, Mar 4, 2020 at 9:40 AM Fran=C3=A7ois Legal <devel@thom.fr.eu.o=
rg> wrote:
> >>>
> >>> Le Mercredi, Mars 04, 2020 14:57 CET, Greg Gallagher <greg@embeddedgr=
eg.com> a =C3=A9crit:
> >>>
> >>>> Hi,
> >>>>
> >>>> On Wed, Mar 4, 2020 at 4:01 AM Fran=C3=A7ois Legal via Xenomai <
> >>>> xenomai@xenomai.org> wrote:
> >>>>
> >>>>> Hello,
> >>>>>
> >>>>> trying to diagnose an interrupt problem on a Zynq 7000 hardware. Th=
e
> >>>>> environment is linux 4.4.189, xenomai 3.0.9.
> >>
> >> Are you building directly from the ipipe repo or applying one of the
> >> patches?  If it's a patch what patch are you applying?
> >
> > I'm applying ipipe-core-4.4.176-arm-10.patch with slight modifications =
(KUSER_TSC is not enabled for Zynq 7000 in that patch)
> >
>
> You know that you can find a newer version in
> https://gitlab.denx.de/Xenomai/ipipe/tree/ipipe-4.4.y-cip? I'm just not
> releasing it as I'm lacking test feedback on the updates. It is not
> supposed to resolve the GPIO issue, though.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

I'll have to look at this a little more closely, I don't think you
need to clear the pending status unless something changed upstream on
us.  The chained handler should be calling a mask and ack to hold the
line  and then unmask once the handler is called.  In userspace you're
just calling select on the gpio path?  I can test this with just the
ipipe first and see if we can isolate the issue to either the ipipe or
Xenomai.  It may take me a couple of days to get setup with my Zynq
board again, can you try the 4.4.y branch Jan mentioned, I'll use that
as a starting point when I start debugging.

Thanks

Greg

