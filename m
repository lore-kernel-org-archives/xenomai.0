From: "Ivan Kalatchev" <ivan.kalatchev@domain.hid>
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>	<4B4BADDD.7070900@domain.hid>	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>	<4B4C84AC.3020207@domain.hid>
	<002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>
	<4B4C96D5.7060902@domain.hid>
In-Reply-To: <4B4C96D5.7060902@domain.hid>
Date: Tue, 12 Jan 2010 16:07:38 -0500
Message-ID: <003e01ca93cb$45fb6d30$d1f24790$@kalatchev@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-ca
Subject: Re: [Xenomai-help] Viper board (ARM XScale) problems
	with	Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: 'Xenomai help' <xenomai@xenomai.org>

> > May be there should be some sort of Howto about it
> > on Xenomai site?
>=20
> Actually this is described in the howto porting the I-pipe for arm to =
a
> new board:
> http://www.xenomai.org/index.php/I-
> pipe:ArmPorting#New_variables_and_functions
> see ipipe_irq_mux_p and ipipe_demux_irq
>=20
> But the problem is that the generic code changed and I missed that
> change, so the old way is documented, not the new one.

I actually read that document, but thing is that CPLD interrupt on Viper =
is not MUX interrupt, although it is chained interrupt. That's why I =
missed it. So may be HOWTO should still mention chained interrupts =
specifically in addition to MUX interrupts. Just a thought.

Regards,

Ivan


