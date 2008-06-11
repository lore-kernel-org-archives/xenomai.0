Message-ID: <2754253.1213189750006.JavaMail.ngmail@domain.hid>
Date: Wed, 11 Jun 2008 15:09:10 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <2ff1a98a0806110545u52fc2606s147fe01003a1e1cb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <2ff1a98a0806110545u52fc2606s147fe01003a1e1cb@domain.hid>
	<14821321.1213179993177.JavaMail.ngmail@domain.hid>
	<2ff1a98a0806110516h46fa524br98b2b8409beedc7d@domain.hid>
	<2ff1a98a0806110518ob7cb5b5h7c0471e3c3ce8c09@domain.hid>
	<28245271.1213187856046.JavaMail.ngmail@domain.hid>
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

Hi Gilles.
> Ok. My memories were a bit imprecise. The whole question boils down to
> know whether the "fxsave" instruction saves the XMM registers. I think
> it does, but you would probably better check in the documentation.

Ok, I have looked in the Intel documentation
for the FXSAVE operation:
"Saves the current state of the x87 FPU, MMX technology, XMM, and MXCSR reg=
isters
to a 512-byte memory location specified in the destination operand."

Thus means, every thing is fine and I can used the XMM registers without ri=
sk.

Thanks for the support.

Mathias


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Jetzt komfortabel bei Arcor-Digital TV einsteigen: Mehr Happy Ends, mehr He=
rzschmerz, mehr Fernsehen! Erleben Sie 50 digitale TV Programme und optiona=
l 60 Pay TV Sender, einen elektronischen Programmf=FChrer mit Movie Star Be=
wertungen von TV Movie. Au=DFerdem, aktuelle Filmhits und spannende Dokus i=
n der Arcor-Videothek. Infos unter www.arcor.de/tv

