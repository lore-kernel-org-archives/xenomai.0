Date: Wed, 2 Jun 2010 22:59:55 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100602205955.GA2590@domain.hid>
References: <4C0395C1.6050902@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4C0395C1.6050902@domain.hid>
Subject: Re: [Xenomai-help] Analogy: unable to use sampling frequency higher
 that 10kHz
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Hi,=20

Daniele Nicolodi wrote:
> Hello. I finally went back to work to my data acquisition
> infrastructure. I'm now trying to increase the sampling frequency of my
> control loop. I do not have any problem up to 10 kHz, but when I
> increase the sampling frequency above this limits the ADC driver stop
> working fine. In the kernel log I obtain a huge list of
>=20
> Analogy: analogy_ni_pcmio: ni_mio_common: interrupt: didn't clear
> interrup? status=3D0x9030
>=20
> From where can I start to investigate this problem?

At the end of the IRQ handling function, a status register is read
again just to be sure the interrupt flag has been cleared. If it is
not the case the message you presented above is printed (by the way, I
will fix the spelling mistake...).

With TRIG_WAKE_EOS, I am pretty sure (I have not checked in the DAQ
STC manual yet) that an interrupt is generated at every scan, which would
mean that the CPU would handle an interrupt every 100=B5s at least. So
it may not be surprising that, sometimes, the interrupt N + 1 is
triggered during the execution of the handler for the interrupt N.

I am wondering whether we should remove this trace at least when
TRIG_WAKE_EOS is specified.

>=20
> I encounter this problem only when I use analogy commands with the
> TRIG_WAKE_EOS flag. If I do not specify this flag all works fine up to
> 100 kHz. However I need my data in real time, and therefore I need to
> specify this flag.
>=20
> Cheers,
> --=20
> Daniele
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Alexis.

