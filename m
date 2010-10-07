From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CADDF57.4070609@domain.hid>
References: <4CA8D713.8090900@domain.hid>
	<1286462018.13186.44.camel@domain.hid>
	<4CADDF57.4070609@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 17:03:37 +0200
Message-ID: <1286463817.13186.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] Problem with dm9000 and
 adeos-ipipe-2.6.34-blackfin-1.14-02.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Javier Herrero <jherrero@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2010-10-07 at 16:55 +0200, Javier Herrero wrote:
> Hi, Philippe,
>=20
> Thank you very much for your answer. I later found that the interrupt=20
> for the dm9000 was not defined OK in the platform data (it was somehow=20
> enabled both for rising edge and for high level). Surprisingly, this=20
> caused no problem without the adeos patch - this is the reason we did=20
> never caught that error before!

The pipeline magnifies bugs in this area, because IRQ delivery to the
regular kernel handler may be deferred to serve a high priority domain
first. So if the IRQ is actually level sensitive, but not masked
immediately when received before the decision is taken to defer the
handler, you usually get an IRQ storm.

>=20
> Once this was corrected, the system boots OK and the network works, but=20
> not OK - after a short while, two dm9000 driver messages 'status check=20
> fail: 70' appears. These messages indicate a problem in the reading of=20
> the dm9000 rx buffer. Once a status check of that kind appears, the=20
> driver disables automatically the dm9000 interrupts.
>=20
> Since now the system boots, I can easily check /proc/interrupt. I will=20
> also check with the patch that you suggest, and come back with any news :=
)
>=20
> Best regards,
>=20
> Javier
>=20
> El 07/10/2010 16:33, Philippe Gerum escribi=C3=B3:
> > On Sun, 2010-10-03 at 21:18 +0200, Javier Herrero wrote:
> >> Hello,
> >>
> >> I'm trying adeos on a Blackfin BF532 board with a DM9000 ethernet
> >> interface. If ethernet is down (cable disconnected) the system boots a=
nd
> >> works OK, but as soon as the ethernet cable is plugged, the system
> >> apparently hangs. After several seconds, a message  dm9000 dm9000.0:
> >> status check fail: 226 appears.
> >>
> >> I've read a previous post about problems with dm9000 and an ARM
> >> processor,
> >> https://mail.gna.org/public/xenomai-help/2010-03/msg00147.html but it
> >> seems that there was not a response.
> >>
> >
> > dm9000 is probably not the important issue, what makes a difference is
> > which kind of IRQ is handled by this device. Knowing about the output
> > of /proc/interrupts when the pipeline is disabled would help.
> >
> > You may want to upgrade to this patch as well:
> > http://download.gna.org/adeos/patches/v2.6/blackfin/older/adeos-ipipe-2=
.6.34-blackfin-1.15-01.patch
> >
> >
> >> Thank you very much. Best regards,
> >>
> >> Javier
> >>
> >
>=20

--=20
Philippe.



