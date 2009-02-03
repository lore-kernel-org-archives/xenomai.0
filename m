Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 3 Feb 2009 17:49:20 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F6B58DC@ukmail.uk.wirelessworld.airvananet.com>
In-Reply-To: <4988830A.7070800@domain.hid>
References: <4B3F8896E1733D4787DDB0EA1C7FF91F6B58D5@domain.hid>
	<4988830A.7070800@domain.hid>
From: "Mike McTernan" <mmcternan@domain.hid>
Subject: Re: [Xenomai-help] IRQ reservation and config
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi,

Right - I want the interrupt to be handled in realtime.

Is there a way to configure the interrupt as level sensitive under
Xenomai?  I can't see how to do it, hence the thought of using
request_irq(), which can do that.

Regards,

Mike

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: 03 February 2009 17:47
To: Mike McTernan
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] IRQ reservation and config

Mike McTernan wrote:
> Hi,
>=20
> I'm porting a simple driver to be under the Xenomai. RTDM  The driver
> simply blocks on read calls until an interrupt arrives, and returns a
> count.  This is on Blackfin uClinux.
>=20
> I think I've understood how to make the driver, the only thing I'm
> missing is how to reserve and configure the irq source.=20
>=20
> Should I be using the standard Linux request_irq() to do this in the
> RTDM prior to calling rtdm_irq_request()?
>=20

If you want your interrupt source to be controlled by the Xenomai core,
i.e.
with real-time guarantees, then rtdm_irq_request() is what you want. I
guess
this is why you need an RTDM driver anyway.

> Regards,
>=20
> Mike
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20
Philippe.

