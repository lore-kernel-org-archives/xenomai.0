Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 10 Oct 2007 13:24:07 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <470CADD7.8090207@domain.hid>
Message-ID: <20071010112407.256110@domain.hid>
MIME-Version: 1.0
References: 447E9383.8090403@domain.hid <470CADD7.8090207@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] [RTnet-users] compactPCI LAN Chip Support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid, Xenomai-help@domain.hid, jan.kiszka@domain.hid

Roland Tollenaar wrote:
> Hi Jan,
>=20
> I am looking for a hardware platform to host hte final result of our
> labours.
>=20
> I have a machine with the following chip:
>=20
> Intel 82541PI
>=20
> and have found the below reply of yours to an email of someone else
> asking the exact same question. However this was quite long ago and the
> e1000 seems to have evolved. So my question is: is above chip supported?
Yes, it is. I'm using rt_e1000 and it works fine.

>=20
> Is there a list on the web that can help me convert device IDs to chip
> types?
Google is your friend. I get a lot of results for that.

>=20
> Kind regards,
>=20
> Roland Tollenaar
>=20
> hinus Viljoen wrote:
> > Good day
> >
> > We intend to use RTnet in a compactPCI-based system. We have narrowed=20
> the
> > possible Single Board Computers (SBC) down to the following 5 options:
> >
> > (LAN interface chip, SBC Manufacturer, SBC Part number)
> > Intel 82546EB,  Kontron, CP6000
> > Intel 82546GB,  Advantech, MIC-3369C-M0
> > Intel 82573E,  Advantech, MIC-3390
> > Intel 82541PI,  Concurrent technologies, PP-332/021
> >
>=20
> Looks like the e1000 driver is in charge here. I put Roman in the CC as
> he happened to ask for the same driver a few days ago.
>=20
> > All the cards support Linux, which (I would assume) implies that they=20
> have
> > Linux LAN drivers.
> >
> > I have the following questions w.r.t. LAN drivers for RTnet:
> > 1. Will any of the above work with RTnet "out of the box"? From the=20
> RTnet
> > documentation I have read it does not seem that there are RTnet=20
> drivers for
> > any of the above LAN chips?
> >
>=20
> Nope.
>=20
> > 2. Have anybody had success running RTnet with one of the above LAN=20
> chips or
> > SBCs?
> >
> > 3. Are there any of the above LAN chips that have known problems=20
> under RTnet?
> >
> > 4. How difficult will it be to adapt the supplied Linux LANop drivers=20
> for
> > RTnet for someone with limited Linux driver coding experience? (I see
> > README.drvporting gives some guidelines, I'm just a bit worried about=20
> the
> > sentence "Some points may not apply to every driver, some may have to be
> > added for others.")
> >
>=20
> Surely those remarks express the unknown variables of an RTnet port. The
> most critical part is identifying and potentially converting the
> synchronisation scheme of the driver, both internally and with the
> hardware. The rest is, indeed, some kind of intelligent search&replace
> as described in the porting doc.
>=20
> It all melts down that you have to gain full control over the time your
> driver spends a) in its transmission routine and b) in the interrupt
> handler under any feasible RTnet load or other driver activity
> (startup/shutdown e.g.). The e100 copes with unbounded hardware delays
> by reducing the maximum waiting time e.g. This happens under the
> assumption that related error conditions do not occur on a
> (TDMA-)managed network, and the last years of practical use showed that
> this is valid.
>=20
> Unfortunately, such kind of conversion could not yet be applied to the
> 3c59x driver which has a more complex logic, and its timing is widely
> unknown to us. But that's basically the only exception we faced so far -
> further driver conversions depend on someone to work on it and to have
> the hardware for intensively testing it.
>=20
> So, the first step of a potential port must be analysing those two
> critical routines of the e1000 as well as all invoked subroutines and to
> understand their locking dependencies. If one of you (or both
> cooperatively) is willing to start working on this, I can only invite to
> discuss your findings here (or better on rtnet-developers). In this case
> I could jump in and comment on it as well as far as time permits. The
> analysis should not take too much time, and afterwards you can decide if
> porting is feasible and how much effort it will likely require.
>=20
> > Thanks
> > Thinus Viljoen
> >
> > Electronic Engineer
> > Aerospace Systems, a division of Denel
> > http://www.kentron.co.za
> >
> > (P.S. Sorry about the footer, which I am sure my company will add. I=20
> don't
> > have any control over it)
> >
>=20
> One is getting used to it. ;)
>=20
> Jan
>=20
>=20
>=20
> Thinus Viljoen wrote:
> > Good day
> >
> > We intend to use RTnet in a compactPCI-based system. We have narrowed=20
> the
> > possible Single Board Computers (SBC) down to the following 5 options:
> >
> > (LAN interface chip, SBC Manufacturer, SBC Part number)
> > Intel 82546EB,  Kontron, CP6000
> > Intel 82546GB,  Advantech, MIC-3369C-M0
> > Intel 82573E,  Advantech, MIC-3390
> > Intel 82541PI,  Concurrent technologies, PP-332/021
> >
>=20
> Looks like the e1000 driver is in charge here. I put Roman in the CC as
> he happened to ask for the same driver a few days ago.
>=20
> > All the cards support Linux, which (I would assume) implies that they=20
> have
> > Linux LAN drivers.
> >
> > I have the following questions w.r.t. LAN drivers for RTnet:
> > 1. Will any of the above work with RTnet "out of the box"? From the=20
> RTnet
> > documentation I have read it does not seem that there are RTnet=20
> drivers for
> > any of the above LAN chips?
> >
>=20
> Nope.
>=20
> > 2. Have anybody had success running RTnet with one of the above LAN=20
> chips or
> > SBCs?
> >
> > 3. Are there any of the above LAN chips that have known problems=20
> under RTnet?
> >
> > 4. How difficult will it be to adapt the supplied Linux LANop drivers=20
> for
> > RTnet for someone with limited Linux driver coding experience? (I see
> > README.drvporting gives some guidelines, I'm just a bit worried about=20
> the
> > sentence "Some points may not apply to every driver, some may have to be
> > added for others.")
> >
>=20
> Surely those remarks express the unknown variables of an RTnet port. The
> most critical part is identifying and potentially converting the
> synchronisation scheme of the driver, both internally and with the
> hardware. The rest is, indeed, some kind of intelligent search&replace
> as described in the porting doc.
>=20
> It all melts down that you have to gain full control over the time your
> driver spends a) in its transmission routine and b) in the interrupt
> handler under any feasible RTnet load or other driver activity
> (startup/shutdown e.g.). The e100 copes with unbounded hardware delays
> by reducing the maximum waiting time e.g. This happens under the
> assumption that related error conditions do not occur on a
> (TDMA-)managed network, and the last years of practical use showed that
> this is valid.
>=20
> Unfortunately, such kind of conversion could not yet be applied to the
> 3c59x driver which has a more complex logic, and its timing is widely
> unknown to us. But that's basically the only exception we faced so far -
> further driver conversions depend on someone to work on it and to have
> the hardware for intensively testing it.
>=20
> So, the first step of a potential port must be analysing those two
> critical routines of the e1000 as well as all invoked subroutines and to
> understand their locking dependencies. If one of you (or both
> cooperatively) is willing to start working on this, I can only invite to
> discuss your findings here (or better on rtnet-developers). In this case
> I could jump in and comment on it as well as far as time permits. The
> analysis should not take too much time, and afterwards you can decide if
> porting is feasible and how much effort it will likely require.
>=20
> > Thanks
> > Thinus Viljoen
> >
> > Electronic Engineer
> > Aerospace Systems, a division of Denel
> > http://www.kentron.co.za
> >
> > (P.S. Sorry about the footer, which I am sure my company will add. I=20
> don't
> > have any control over it)
> >
>=20
> One is getting used to it. ;)
>=20
> Jan
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
von Karl Reichert

Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger

