Message-ID: <28245271.1213187856046.JavaMail.ngmail@domain.hid>
Date: Wed, 11 Jun 2008 14:37:36 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <2ff1a98a0806110518ob7cb5b5h7c0471e3c3ce8c09@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <2ff1a98a0806110518ob7cb5b5h7c0471e3c3ce8c09@domain.hid>
	<14821321.1213179993177.JavaMail.ngmail@domain.hid>
	<2ff1a98a0806110516h46fa524br98b2b8409beedc7d@domain.hid>
Subject: Re: [Xenomai-help] Are xmm-registers saved with a (task) context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Gilles,

thanks for your response.
With the MMX registers, you are right. They are actually aliased with the F=
PU registers.
However, the XMM registers (SSE, SSE2) are not aliased.=20
The aliased MMX registers AND the not-aliased XMM registers are available w=
ith today's CPUs,
i.e. you still have to take card when using MMX registers.
(All information according to Intel's 64 and IA-32 Architectures
Software Developer=92s Manual, Volume 1, Chapters 9,10,11)

>From your mail before I assume that the (not-aliased) XMM registers are sav=
ed with the switching routine
and can be used without have to save/restore them.

Regards

Mathias


> > The xmm register are saved by the FPU switching routines. Note
> > however, that depending on the x86 you are using the xmm registers are
> > aliased to the FPU register or are separate registers. So, on machines
> > where the xmm registers are aliased to normal FPU registers, you have
> > to do the save restore on your own if you want to use MMX, SSE, or
> > SSE2 and use FPU instructions in the same thread.
>=20
> This probably applies to very old CPUs, xmm are separate registers now.
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Jetzt komfortabel bei Arcor-Digital TV einsteigen: Mehr Happy Ends, mehr He=
rzschmerz, mehr Fernsehen! Erleben Sie 50 digitale TV Programme und optiona=
l 60 Pay TV Sender, einen elektronischen Programmf=FChrer mit Movie Star Be=
wertungen von TV Movie. Au=DFerdem, aktuelle Filmhits und spannende Dokus i=
n der Arcor-Videothek. Infos unter www.arcor.de/tv

