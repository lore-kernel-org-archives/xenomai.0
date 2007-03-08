From: "Bernard Dautrevaux" <bernard.dautrevaux@domain.hid>
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid><E1HOs43-0008OG-Ki@domain.hid>
	<45EFFE22.9060401@domain.hid> <E1HPJMF-0008IL-F2@domain.hid>
Subject: RE: [Xenomai-help] RTCAN and tsc
Date: Thu, 8 Mar 2007 18:36:12 +0100
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAOtQApUEfglBvKTF3jr1t1bigwAAEAAAALx+DKgbdNVEi6wAAVh/Ga4BAAAAAA==@ac6.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <E1HPJMF-0008IL-F2@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Sebastian Smolorz' <ssm@domain.hid>, rolandtollenaar@domain.hid
Cc: xenomai@xenomai.org

Hi everybody,

Maybe I'm making an error, but AFAIK, the SJA1000 on-chip registers are =
clocked by a rather slow clock, that is limited to about 24MHz. I =
remember a case where interrupts were handled by the CPU (a 600MHz =
thing) too fast for the SJA1000, resulting in the chip not yet aware =
that it generates the interrupt.=20

To be more precise, the IRQ gets out, probably immediately through some =
sort of asynchronous logic, but the fact was only clocked in the =
interrupt status register at about 16MHz, thus the CPU was able to read =
the interrupt status register, thus clearing the coming interrupt state, =
before the interrut was latched, and thus the IRQ was lost...

The net result was that we had to add quite a lot of udelay() calls to =
slow down the driver to the senator's pace of the SJA1000... Are you =
sure you're not running in this kind of problem?

Just my .02=E2=82=AC

Bernard


> -----Message d'origine-----
> De : xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] De la part de Sebastian Smolorz
> Envoy=C3=A9 : jeudi 8 mars 2007 15:13
> =C3=80 : rolandtollenaar@domain.hid
> Cc : xenomai@xenomai.org
> Objet : Re: [Xenomai-help] RTCAN and tsc
>=20
> Roland Tollenaar wrote:
> > Hi
> >
> > >> What does this mean? This is as good as it gets?
> > >
> > > Hm. To be more verbose on what happens between the beginning of=20
> > > rtcan_sja_interrupt and rtcan_rcv please remove the "inline" from=20
> > > the functions rtcan_sja_err_interrupt in the file=20
> > > ksrc/drivers/can/sja1000/rtcan_sja1000.c line 156 and from the=20
> > > function rtcan_sja_rx_interrupt in the same file in line=20
> 87. Compile=20
> > > your modules/kernel again and repeat the tracer/latency test.
> > >
> > > I assume that most of the time is spent in the latter=20
> function where=20
> > > several SJA HW regs are read out. A slow access to the=20
> regs could be=20
> > > the explanation for the long time the interrupt handler=20
> has to spend.
> >
> > Where are the registers located? On the dongle or are these=20
> in the PC?
>=20
> These are registers located in the SJA1000 CAN controller.
>=20
> > Just to know whether there might not be a problem with the=20
> PEAK device.
> > Is there any way you could check what the access times are to=20
> > rtcan_sja_interrupt on your systems when performing the same=20
> > experiment and recieving messages (pref PDO with length 8)=20
> over the bus?
>=20
> Unfortunately, I do not have the opportunity to perform tests=20
> with the driver ATM.
>=20
> >
> > I am developing on a pretty high-end machine here,
>=20
> Didn't you speak of 486's in a previous mail?
>=20
> > in fact every aspect
> > almost as fast as is on the market at the moment so its=20
> would surprise=20
> > me if there is a hardware shortcoming if the registers you speak of=20
> > are on the PC.
> >
> > In the mean time I will try doing as you suggest, I presume=20
> you want=20
> > me to send the frozen trace to you again after that.
>=20
> Exactly.
>=20
> > Is it worth while removing the virtual driver from the kernel build=20
> > and running over rtcan0.
>=20
> Turn it off although it is unlikely that it has something to=20
> do with the problem. But you never know.
>=20
> > Is there any chance that you have never encountered this problem
>=20
> I never worked with the virtual device.
>=20
> --
> Sebastian
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


