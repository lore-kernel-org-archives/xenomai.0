MIME-Version: 1.0
References: <004e01d43564$4970d4c0$dc527e40$@sepro-group.com>
 <f5ec79d7-be26-3d87-8d1b-8714d4f3a14a@xenomai.org>
 <007001d4361f$01d02010$05706030$@sepro-group.com>
 <346547f0-852d-ffe7-d1ff-f156db9a59d1@gmail.com>
 <00d201d439f1$8ccd3fb0$a667bf10$@sepro-group.com>
In-Reply-To: <00d201d439f1$8ccd3fb0$a667bf10$@sepro-group.com>
From: Edouard Tisserant <edouard.tisserant@gmail.com>
Date: Thu, 23 Aug 2018 23:09:55 +0200
Message-ID: <CAOgDLiEp0SzdwJ9G5+T_zUSM-CAKMompHqWE3SXwfmbJhx1meg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] TR: RTNet - how to setup rt_fec on IMX6Q (Xenomai
 3.0.7)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=C3=A9phane_Reichert?= <sreichert@sepro-group.com>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hi St=C3=A9phane.

Well, sorry for untested patch, and thanks for your help in debugging it !

Looking back in recent changes in rtnet, this problem may be related
to this commit (changes on 8139too.c are explicit):
https://gitlab.denx.de/Xenomai/xenomai/commit/3e97e64ee27ce01e8488d06c52bc4=
681729b30b9

Patching fec.c in a similar way may certainly help, since apparently
signatures are now incompatible.

Please let me know if it helps.

Best regards,
Edouard.


Le mer. 22 ao=C3=BBt 2018 =C3=A0 10:24, St=C3=A9phane Reichert
<sreichert@sepro-group.com> a =C3=A9crit :
>
> Hello Edouard,
>
> Thanks again for your patch.
>
> I tried it on my kernel, but unfortunately I am facing the same issue
> (ioctl: Resource temporarily unavailable error message on rtping).
>
> Best regards
> St=C3=A9phane
>
> -----Message d'origine-----
> De : Edouard Tisserant [mailto:edouard.tisserant@gmail.com]
> Envoy=C3=A9 : mardi 21 ao=C3=BBt 2018 23:19
> =C3=80 : St=C3=A9phane Reichert; xenomai@xenomai.org
> Objet : Re: [Xenomai] TR: RTNet - how to setup rt_fec on IMX6Q (Xenomai
> 3.0.7)
>
> Hello St=C3=A9phane.
>
> I'm porting EtherLAB to Xenomai3 on Imx6, using RTNet instead of EtherLAB
> provided drivers.
>
> This is still work in progress, but the fec.c patch I have now may help.
> Find it attached.
>
> I built it last time on kernel 4.9.51 and xenomai 3.0.6. This is largely
> untested, your feedback is welcome.
>
> Beware content of DTS for vanilla FEC from kernel 4.x may not be compatib=
le
> anymore with the one expected by FEC from RTnet. You may have to patch yo=
u
> DTS accordingly.
>
> Best regards,
>
> Edouard
>
>
>
> On 17/08/2018 13:39, St=C3=A9phane Reichert wrote:
> > Hello Philippe,
> >
> > I have noticed in the file fec.c that the function fec_enet_ioctl did
> > not match the prototype of do_ioctl (it looks like "request" and "arg"
> > parameters are switched). Is it a mistake ?
> >
> > (I tried to switch these parameters but it didn't solved my problem as
> > well).
> >
> > Stephane
> >
> >
> > -----Message d'origine-----
> > De : Philippe Gerum [mailto:rpm@xenomai.org] Envoy=C3=A9 : vendredi 17 =
ao=C3=BBt
> > 2018
> > 10:28 =C3=80 : St=C3=A9phane Reichert; xenomai@xenomai.org Objet : Re: =
[Xenomai]
> > RTNet - how to setup rt_fec on IMX6Q (Xenomai 3.0.7)
> >
> > On 08/16/2018 03:23 PM, St=C3=A9phane Reichert wrote:
> >> Hello,
> >>
> >>
> >>
> >> We are trying to use the rt_fec driver for RTNet on a iMX6Q board.
> >>
> >>
> >>
> >> I have patched the KConfig to add this driver on buildroot and it
> >> compiles perfectly.
> >>
> >>
> >>
> >> But now, I am not able to use it on our board (it works when I =E2=80=
=9Crtping=E2=80=9D
> >> the loopback,
> >>
> >> but it doesn=E2=80=99t work if I try to ping an external board).
> > The fec driver does not seem to tell the stack about the carrier
> > enable state. If so, you may want to try the following patch:
> >
> > diff --git a/kernel/drivers/net/drivers/fec.c
> > b/kernel/drivers/net/drivers/fec.c
> > index 36870ba16..d94ec690f 100644
> > --- a/kernel/drivers/net/drivers/fec.c
> > +++ b/kernel/drivers/net/drivers/fec.c
> > @@ -1323,6 +1323,7 @@ fec_enet_open(struct rtnet_device *ndev)
> >               return ret;
> >       }
> >       phy_start(fep->phy_dev);
> > +     rtnetif_carrier_on(ndev);
> >       rtnetif_start_queue(ndev);
> >       fep->opened =3D 1;
> >       return 0;
> >
> > --
> > Philippe.
> >
> > _______________________________________________
> > Xenomai mailing list
> > Xenomai@xenomai.org
> > https://xenomai.org/mailman/listinfo/xenomai
>

