MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18348.44849.357119.536298@domain.hid>
Date: Fri, 8 Feb 2008 20:36:17 +0100
In-Reply-To: <d6c8ef150802081121i8d96538l73ed596f46731d11@domain.hid>
References: <178999.65515.qm@domain.hid>
	<d6c8ef150802081121i8d96538l73ed596f46731d11@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: adeos-main@gna.org

Bosko Radivojevic wrote:
 > On Dec 26, 2007 12:10 PM, Michael Trimarchi <trimarchimichael@domain.hid>
 > wrote:
 >=20
 > > Hi
 > > ----- Messaggio originale -----
 > > > Da: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
 > > > A: Michael Trimarchi <trimarchimichael@domain.hid>
 > > > Cc: adeos-main@gna.org
 > > > Inviato: Mercoled=EC 26 dicembre 2007, 6:59:31
 > > > Oggetto: Re: [Adeos-main] at91sam9260
 > > >
 > > > On Dec 20, 2007 7:44 PM, Michael Trimarchi wrote:
 > > > > Hi,
 > > > >
 > > > > > Ok. Could you try something ? It will work with I-pipe only but =
will
 > > > > > break Xenomai, so do not try to run Xenomai over this modificati=
on.
 > > > > >
 > > > >
 > > > > I tried the adeos-2.6.20-arm-1.8-02 patch and linux 2.6.20 and I
 > > obtained the
 > > > > same results. When the system is not loaded I can't receive from t=
he
 > > serial
 > > > > line using the adeos patch and null modem cable.
 > > > >
 > > > > AT91sam9260 8MB ram (using filesystem on ramdisk)
 > > > > I removed spi flash support, mmc support.
 > > > > I have only serial driver and using lrz for receiving file
 > > > >
 > > > > Can I do some tests for you using my board?
 > > >
 > > > in drivers/serial/atmel_serial.c, add the IRQF_DISABLED flag to
 > > request_irq.
 > > >
 > > > When linux is running without adeos, the AT91 serial driver interrupt
 > > > is shared with the timer interrupt, so it automatically gets this
 > > > flag. Adeos does not use the same hardware timer as linux, so, when
 > > > adeos is enabled the serial interrupt is no longer shared with the
 > > > timer interrupt and it no longer gets this flag.
 > > >
 > > I will try.
 > >
 > Hi all!
 >=20
 > Are there some conclusions or test reports regarding this discussion?
 >=20
 > Thanx!

I received a mail from Michael recently telling me that he observes the
same behaviour with the PREEMPT_RT patch, so the I-pipe patch is
probably out of cause. He now suspects a hardware issue (one serial port
pin seems to be shared with another peripheral, as I think I understood).

--=20


					    Gilles Chanteperdrix.

