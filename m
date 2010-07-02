Message-ID: <4C2D9FF0.3030502@domain.hid>
Date: Fri, 02 Jul 2010 10:14:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>	<4C2A518F.8030302@domain.hid>	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>	<4C2B0043.1070108@domain.hid>	<AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>	<22150A2C94CC924695BE248F94CD11F2D063@domain.hid>
	<AANLkTinqA_l4Jersd-1EfCMecqal2ZkSepe5DhtQAEJ3@domain.hid>
In-Reply-To: <AANLkTinqA_l4Jersd-1EfCMecqal2ZkSepe5DhtQAEJ3@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Felipe Brand=C3=A3o Cavalcanti wrote:
> Sorry for the late reply.
>=20
> Anyway, I did enable Xenomai in the kernel itself, so no modules
> involved - can't modprobe anything.
>=20
> As for the vanilla kernel, I've tried for a while to get it working
> right on my board, but no luck. I am not sure if it has support to all
> the peripherals, or if there is something that I am doing wrong (used
> the defconfig, no modifications).
>=20
> I've edited the bitbake files for the kernel, but what I usually do is
> to run the unpack script, replace the flush.c file, and keep the proces=
s
> going. The defconfig is pretty much standard, except that I've enabled
> several debugging options and got rid of a few troublesome pieces of
> code (power management, CPU Freq. scaling, etc...). As for the edits,
> they seem very similar to yours, but I didn't look at them very careful=
ly.
>=20
> Fredrik, did you managed to get a kernel compiled at all?

What about the EABI?

--=20
					    Gilles.


