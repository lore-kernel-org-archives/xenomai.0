From: Leopold Palomo-Avellaneda <leo@domain.hid>
Date: Thu, 29 Oct 2009 11:23:20 +0100
References: <200910281314.00378.leo@domain.hid>
	<4AE96ABD.1060809@domain.hid> <4AE96B17.8000704@domain.hid>
In-Reply-To: <4AE96B17.8000704@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200910291123.21542.leo@domain.hid>
Subject: Re: [Xenomai-help] Xenomai patches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

A Dijous 29 Octubre 2009, Gilles Chanteperdrix va escriure:
> Gilles Chanteperdrix wrote:
> > Leopold Palomo-Avellaneda wrote:
> >> OTOH, the debian package has a bug. I cannot compile xenomai, using the
> >> debian way on kernels 2.6.28, 2.6.29 and 2.6.30 because the package add
> >> something that fails with make menuconfig. I should write a bug. Just
> >> for information, it's not a xenomai upstream related question. ;-)
> >
> > Please check xenomai-2.4.9.1. It may happen that the bug has been
> > already solved.
>
> 2.4.10

nops, sorry again my fingers were so fast ...

we are talking about the same? I got:

cripts/kconfig/conf -o arch/x86/Kconfig
arch/x86/Kconfig:74: unexpected option "select"
arch/x86/Kconfig:75: unexpected option "select"
make[3]: *** [oldconfig] Error 1
make[2]: *** [oldconfig] Error 2


Leo

