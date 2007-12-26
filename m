Date: Wed, 26 Dec 2007 11:10:54 +0000 (GMT)
From: Michael Trimarchi <trimarchimichael@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Message-ID: <178999.65515.qm@domain.hid>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

Hi=0A----- Messaggio originale -----=0A> Da: Gilles Chanteperdrix <gilles.c=
hanteperdrix@domain.hid>=0A> A: Michael Trimarchi <trimarchimichael@domain.hid=
>=0A> Cc: adeos-main@gna.org> Inviato: Mercoled=EC 26 dicembre 2007, 6:5=
9:31=0A> Oggetto: Re: [Adeos-main] at91sam9260=0A> =0A> On Dec 20, 2007 7:4=
4 PM, Michael Trimarchi wrote:=0A> > Hi,=0A> >=0A> > > Ok. Could you try so=
mething ? It will work with I-pipe only but will=0A> > > break Xenomai, so =
do not try to run Xenomai over this modification.=0A> > >=0A> >=0A> > I tri=
ed the adeos-2.6.20-arm-1.8-02 patch and linux 2.6.20 and I obtained the=0A=
> > same results. When the system is not loaded I can't receive from the se=
rial=0A> > line using the adeos patch and null modem cable.=0A> >=0A> > AT9=
1sam9260 8MB ram (using filesystem on ramdisk)=0A> > I removed spi flash su=
pport, mmc support.=0A> > I have only serial driver and using lrz for recei=
ving file=0A> >=0A> > Can I do some tests for you using my board?=0A> =0A> =
in drivers/serial/atmel_serial.c, add the IRQF_DISABLED flag to request_irq=
.=0A> =0A> When linux is running without adeos, the AT91 serial driver inte=
rrupt=0A> is shared with the timer interrupt, so it automatically gets this=
=0A> flag. Adeos does not use the same hardware timer as linux, so, when=0A=
> adeos is enabled the serial interrupt is no longer shared with the=0A> ti=
mer interrupt and it no longer gets this flag.=0A> =0AI will try.=0A =0ATha=
nk's=0A=0A=0A      ___________________________________ =0AL'email della pro=
ssima generazione? Puoi averla con la nuova Yahoo! Mail: =0Ahttp://it.docs.=
yahoo.com/nowyoucan.html

