Message-ID: <487F0D84.8010705@domain.hid>
Date: Thu, 17 Jul 2008 11:14:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1216282324.3472.29.camel@domain.hid>
In-Reply-To: <1216282324.3472.29.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Generel problem with realtime-tops(like adeos)
 over	linux-kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?=22Schl=E4gl_=5C=22Manfred_jun=2E=5C=22=22?= <manfred.schlaegl@domain.hid>
Cc: xenomai@xenomai.org

Schl=E4gl Manfred jun. wrote:
> Hi!
>=20
> I think we've discovered a generell logical problem with realtime-tops
> like adeos over the linux-kernel.
>=20
> The basic-assumption of such an system is: Linux is not a
> realtime-system, so it is not able to provide realtime to it's services=
,
> so no linux-service is able to use realtime-capabilities, so no
> linux-service has realtime-requirements.
>>From this it follows that we are able use a top like adeos (send
> interrupts later, always interrupt the linux-kernel).
>=20
> But... Linux is able to provide hard-realtime while interrupts are
> locked. And many services(driver) use this.
>=20
> abstract example:
> {{{
> spin_lock_irqsave
> if(hardware_data_valid())
> 	process_hardware_data()
> spin_lock_irqrestore
> }}}
> works fine without adeos, but with adeos there may be a relative long
> interruption between validation and processing. The hardware may overru=
n
> and process_hardware_data is called without valid data...

For those rare cases (compared to the mass of locks that don't need
this), you can still convert the lock into a hard one again. See e.g.
how IRQ controllers (which are shared between Linux and other Adeos
domains) are handled by the I-pipe patch, watching out for
ipipe_spinlock_t specifically.

>=20
> In our case we have this problem while the rx-interrupt of our
> ethernet-driver. The dma is running permanently and generates an overru=
n
> between the error-checking(which would catch the overrun) part and the
> data-processing part of the handler.
>=20
> I think it is possible that there could be many such (latent) problems
> in linux-kernel. For example USB which itself has realtime-requirements=
,
> or eventually mtd (lost data as cause of wrong flash-write/erase
> timings), ...
>=20
> So ... what do you think about that.

Most hardware does not have such hard requirements. IIRC, USB does not.

Also note that long hard IRQ-off phases are highly disliked in mainline
Linux as well, and kernel developers will happily accept sound patches
avoiding such phases. This also simplifies the path toward PREEMPT_RT
(which effectively does the same to these locks that Adeos does).

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

