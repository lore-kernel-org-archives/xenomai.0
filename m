MIME-Version: 1.0
References: <mailman.3.1547809201.5156.xenomai@xenomai.org>
 <4ddd614.76d7.168751f9385.Coremail.kunzj@126.com>
 <CALLqZ8RZHCDBur7ewCKnKJXu9j4VOdeucgJchF9rKCC_oeGVWA@mail.gmail.com>
 <2a791fcc.20e9.16889759d7f.Coremail.kunzj@126.com>
 <CAOf5uwki6gaSPg=6zCOxHEvWh8X0mOORazXmNczazzmVD4U54g@mail.gmail.com>
 <41880ccc.22f4.168899ba6f6.Coremail.kunzj@126.com>
In-Reply-To: <41880ccc.22f4.168899ba6f6.Coremail.kunzj@126.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 26 Jan 2019 11:18:28 +0100
Message-ID: <CAOf5uwn6GMtmDUj0O_zs5092ToX52APnKqqzax+jeJ19mhOFtQ@mail.gmail.com>
Subject: Re: Re: Re: Help: System freeze when edge interrupt trigger,
 Xenomain3.0.8, ipipe-arm main line, am335x
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
To: JackZhang <kunzj@126.com>
Cc: Greg Gallagher <greg@embeddedgreg.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi JackZhang

On Sat, Jan 26, 2019 at 11:01 AM JackZhang <kunzj@126.com> wrote:
>
> Thanks, Michael
> I have kernel 4.1.18 + xenomai 3.0.6 works too, but can't work with ti's =
drm drivers.
> Ti's sdk[1] with own kernel based on 4.1.18, can not work with ipipe patc=
h, and i it's
> hard to solve the conflict.
>
> Now, Ti's drm driver code is in the new kernel 4.14, so the best way is t=
hat ipipe-arm
> can work with the 4.14 kernel.

What is you requirement? Running opengl qt application + realtime?

Michael

>
> [1]. http://processors.wiki.ti.com/index.php?title=3DProcessor_SDK_Linux_=
Release_Notes&oldid=3D214754
>
> At 2019-01-26 17:36:34, "Michael Nazzareno Trimarchi" <michael@amarulasol=
utions.com> wrote:
>
> >Hi Jack
> >
> >
> >On Sat, Jan 26, 2019 at 10:20 AM JackZhang via Xenomai
> ><xenomai@xenomai.org> wrote:
> >>
> >> Hi, Grep, thanks.
> >>
> >>
> >>
> >> >Have you tried this with the 4.9 or 4.4 kernel and ipipe patch? I
> >> >think 4.4 (which is based on a SLTS) has been tested on beaglebone
> >> >(similar processor). Did you mean kernel 4.14 not 3.14?
> >>
> >>   I mean kernel 4.14. Sorry for mistake.
> >> >I think I've reproduced this on a Beaglebone which is based on a
> >> >similar processor, I'll look into it this week.
> >>   Thank you very much!
> >
> >I have 4.1.6 + xenomai 3.0.7 and seems that it works
> >
> >Michael
> >
> >>
> >>
> >> =E5=9C=A8 2019-01-22 23:18:03=EF=BC=8C"Greg Gallagher" <greg@embeddedg=
reg.com> =E5=86=99=E9=81=93=EF=BC=9A
> >> >On Tue, Jan 22, 2019 at 5:34 AM =E5=BC=A0=E5=BB=BA=E6=98=86 via Xenom=
ai <xenomai@xenomai.org> wrote:
> >> >>
> >> >> Hello everyone, here is some new clues:
> >> >> 1. I tried xenomai 3.0.8, kernel 3.14.17 and ipipe-core-4.14.71-arm=
-4.patch. Still the same question.
> >> >
> >> >Have you tried this with the 4.9 or 4.4 kernel and ipipe patch?  I
> >> >think 4.4 (which is based on a SLTS) has been tested on beaglebone
> >> >(similar processor). Did you mean kernel 4.14 not 3.14?
> >> >
> >> >> 2. It seems the system is locked up once a gpio interrupt is trigge=
red.
> >> >>
> >> >> 3. Some debug information show that, once a gpio interrupt is trigg=
ered, the function
> >> >>
> >> >>     'omap_gpio_irq_handler' is triggered all the time.
> >> >I think I've reproduced this on a Beaglebone which is based on a
> >> >similar processor, I'll look into it this week.
> >> >
> >> >> There may be a little bug exists, but i don't know how to amend it.=
 Thank you very much, if anyone can help.
> >> >>
> >> >
> >> >-Greg
> >> >> >------------------------------
> >> >> >
> >> >> >Message: 3
> >> >> >Date: Fri, 18 Jan 2019 11:48:12 +0800 (CST)
> >> >> >From: =E5=BC=A0=E5=BB=BA=E6=98=86 <kunzj@126.com>
> >> >> >To: xenomai@xenomai.org
> >> >> >Subject: Help: System freeze when edge interrupt trigger,
> >> >> >       Xenomain3.0.8, ipipe-arm main line, am335x
> >> >> >Message-ID: <55c89c76.3420.1685f12c488.Coremail.kunzj@126.com>
> >> >> >Content-Type: text/plain; charset=3D"gbk"
> >> >> >
> >> >> >Hello!
> >> >> >    The system freeze when interrupt is triggered. I clone ipipe-a=
rm master, and use xenomai 3.0.8 following xenomai startup tutorial.
> >> >> >The hardware cpu is am3358. System works fine after start up, but =
the system immediately locks up when a edge interrupt. For example,
> >> >> >the mmc card in pluged in. Is it something worng ? Thank you very =
much!
> >> >> >
> >> >> >    The kernel config file and dts attached.
> >> >> >
> >> >> >
> >> >> >-------------- next part --------------
> >> >> >A non-text attachment was scrubbed...
> >> >> >Name: .config
> >> >> >Type: application/octet-stream
> >> >> >Size: 129591 bytes
> >> >> >Desc: not available
> >> >> >URL: <http://xenomai.org/pipermail/xenomai/attachments/20190118/53=
8175f9/attachment.obj>
> >> >> >-------------- next part --------------
> >> >> >A non-text attachment was scrubbed...
> >> >> >Name: am335x-dnk-v1_LCD800x480_TM070RDH13.dts
> >> >> >Type: application/octet-stream
> >> >> >Size: 29436 bytes
> >> >> >Desc: not available
> >> >> >URL: <http://xenomai.org/pipermail/xenomai/attachments/20190118/53=
8175f9/attachment-0001.obj>
> >> >> >
> >> >> >------------------------------
> >> >> >
> >> >> >Subject: Digest Footer
> >> >> >
> >> >> >
> >> >> >
> >> >> >
> >> >> >------------------------------
> >> >> >
> >> >> >End of Xenomai Digest, Vol 81, Issue 17
> >> >> >***************************************
> >
> >
> >
> >--
> >| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> >| COO  -  Founder                                      Cruquiuskade 47 |
> >| +31(0)851119172                                 Amsterdam 1018 AM NL |
> >|                  [`as] http://www.amarulasolutions.com               |



--=20
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |

