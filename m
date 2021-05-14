MIME-Version: 1.0
References: <20210305082259.18424-1-gunter.grau@philips.com>
 <217744bd-4588-02ea-0e85-0bb7d97436c0@siemens.com>
 <AM0P122MB01003ED2C020C155D13AC0B7F2969@AM0P122MB0100.EURP122.PROD.OUTLOOK.COM>
 <CALLqZ8Rqbt5cPGck5EiQ9kKbG9tiZZJrvWjhNNBWvYeebM2+Gw@mail.gmail.com>
 <AM0P122MB01000F45C8ED23A5D6270D89F2659@AM0P122MB0100.EURP122.PROD.OUTLOOK.COM>
In-Reply-To: <AM0P122MB01000F45C8ED23A5D6270D89F2659@AM0P122MB0100.EURP122.PROD.OUTLOOK.COM>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 14 May 2021 00:42:22 -0400
Message-ID: <CALLqZ8RLeS17QHCXGWPGK80WtZF32k3ot9uvWnO0BTWRFDzQ7A@mail.gmail.com>
Subject: Re: [PATCH] arm_global_timer: Use 64 Bit hw counter for ipipe_tsc
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
To: "Grau, Gunter" <gunter.grau@philips.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Mar 22, 2021 at 7:48 AM Grau, Gunter <gunter.grau@philips.com>
wrote:

>
>
> > From: Greg Gallagher <greg@embeddedgreg.com>
> > Sent: Freitag, 5. M=C3=A4rz 2021 13:57
> > To: Grau, Gunter <gunter.grau@philips.com>
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>; xenomai@xenomai.org
> > Subject: Re: [PATCH] arm_global_timer: Use 64 Bit hw counter for
> ipipe_tsc
> >
> > Caution: This e-mail originated from outside of Philips, be careful for
> phishing.
> >
> > > On Fri, Mar 5, 2021 at 7:52 AM Grau, Gunter <gunter.grau@philips.com>
> wrote:
> > > > -----Original Message-----
> > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > Sent: Freitag, 5. M=C3=A4rz 2021 13:27
> > > > To: Grau, Gunter <gunter.grau@philips.com>; xenomai@xenomai.org;
> Greg
> > > > Gallagher <greg@embeddedgreg.com>
> > > > Subject: Re: [PATCH] arm_global_timer: Use 64 Bit hw counter for
> ipipe_tsc
> > > >
> > > > Caution: This e-mail originated from outside of Philips, be careful
> for
> > > > phishing.
> > > >
> > > >
> > > > On 05.03.21 09:22, Gunter Grau via Xenomai wrote:
> > > > > When using the arm_global_timer as source for ipipe_tsc the mask
> was
> > > > > configured with 32 Bit.
> > > > > However this timer is a native 64 Bit counter. So use the complet=
e
> > > > > hardware register by configuring a 64 Bit mask on initialization.
> > > > > The ipipe_tsc implementation is already 64 Bit ready and reads th=
is
> > > > > register as described in the reference manual, so no further
> changes
> > > > > needed.
> > > > >
> > > > > Signed-off-by: Gunter Grau <gunter.grau@philips.com>
> > > > > ---
> > > > >  drivers/clocksource/arm_global_timer.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/clocksource/arm_global_timer.c
> > > > > b/drivers/clocksource/arm_global_timer.c
> > > > > index 77c116a3e85f..44c10e364f62 100644
> > > > > --- a/drivers/clocksource/arm_global_timer.c
> > > > > +++ b/drivers/clocksource/arm_global_timer.c
> > > > > @@ -82,7 +82,7 @@ static inline void gt_ipipe_cs_setup(void)
> > > > >                 .u =3D {
> > > > >                         {
> > > > >                                 .counter_paddr =3D gt_pbase,
> > > > > -                               .mask =3D 0xffffffff,
> > > > > +                               .mask =3D CLOCKSOURCE_MASK(64),
> > > > >                         }
> > > > >                 },
> > > > >                 .refresh_freq =3D refresh_gt_freq,
> > > > > --
> > > > > 2.17.1
> > > > >
> > > >
> > > > Thanks for the fixes. You may help Greg with integrating them by
> telling us
> > > > on which kernel versions they apply / have been tested.
> > > >
> > > > Jan
> > > >
> > > > --
> > > > Siemens AG, T RDA IOT
> > > > Corporate Competence Center Embedded Linux
> > >
> > >
> > > Hi,
> > >
> > > The patches apply to ipipe/master.
> > > But as I have seen so far they should even apply to 5.4.y.
> > >
> > > Unfortunately we are currently using a very old kernel on imx6.
> > > So I can report this patches has been tested on 4.1.x only.
> > >
> > > Thanks,
> > > Gunter
> > >
> > > [...]
> > >
> >
> > Thanks! I can test them out this weekend, I have a bunch of ipipe work
> to do.
> >
> > Thanks
> >
> > Greg
> >
>
> Hi Greg,
>
> Did you have the chance to look into the two patches?
> Is there anything I can do?
>
> Thanks,
> Gunter
>
> ________________________________
> The information contained in this message may be confidential and legally
> protected under applicable law. The message is intended solely for the
> addressee(s). If you are not the intended recipient, you are hereby
> notified that any use, forwarding, dissemination, or reproduction of this
> message is strictly prohibited and may be unlawful. If you are not the
> intended recipient, please contact the sender by return e-mail and destro=
y
> all copies of the original message.
>

Applied, thanks for the patch. Sorry it took so long, patches will be
released this weekend.

-Greg
