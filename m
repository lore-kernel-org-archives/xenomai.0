Message-ID: <46D2B432.2010405@domain.hid>
Date: Mon, 27 Aug 2007 13:23:30 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <op.txptjeaot06gyn@domain.hid>
In-Reply-To: <op.txptjeaot06gyn@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rtdm driver Problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Axel Beierlein wrote:
> Hello,
>=20
> i try to port a standard serial Driver into an RTDM one following Jan=C2=
=B4s =20
> example 16550A.c.
> When i try to initialize the rx/tx timeouts in my set_config routine wi=
th:
>=20
> 	if (testbits(config->config_mask, RTSER_SET_TIMEOUT_RX))
>             ctx->config.rx_timeout =3D config->rx_timeout;
>=20
> and call an rt_dev_open("sername",0) in my testapplikation i get an =20
> "floating point used in kernel ...." on my ppc.
> I use all the structures that Jan have defined.
> Could it bee that the uint64_t var=C2=B4s rx_timeout / tx_timeout are t=
he =20
> reasons (especially the <unsigned long long int> typedef for an ppc)?

How do you compile the RTDM driver?

Wolfgang.


