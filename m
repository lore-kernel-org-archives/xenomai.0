From: "Sebastien DI MERCURIO" <sebastien.di-mercurio@domain.hid>
References: <8E970E0F84BD44C9B4C41942F86F2F34@domain.hid>
	<498082B7.2000609@domain.hid>
Date: Mon, 2 Feb 2009 12:32:16 +0100
Message-ID: <AC207919863B474A81EC0EEE48B5A6DE@insatoulouse.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <498082B7.2000609@domain.hid>
Subject: Re: [Xenomai-help] TR: Kernel panic with (Kernel-2.6.27/Xenomai
	-2.4.6)
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
Cc: xenomai@xenomai.org

Sorry for the delay.

It seems it was a problem specific to VirtualBox. The same kernel works =
fine
on a real machine.

Thanks for your help=20

-----Message d'origine-----
De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9 : mercredi 28 janvier 2009 17:07
=C0 : Sebastien DI MERCURIO
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai-help] TR: Kernel panic with (Kernel-2.6.27/Xenomai
-2.4.6)

Sebastien DI MERCURIO wrote:
> Hello,
> =20
> I have compiled and installed linux kernel 2.6.27 in a fedora distro=20
> running in Virtualbox. Everything worked fine.
> After that, I patched the kernel using xenomai-2.4.6 script=20
> "prepare-kernel.sh". So, the adeos patch used was=20
> adeos-ipie-2.6.27-x86-2.1-01.patch. No problem.
> =20
> Then I have configured the newly patched kernel for activate xenomai=20
> and nucleus (find the .config file in attachment). I compiled the=20
> kernel. No error, no problem.
> =20
> But when I boot the patched kernel, it produces a panic, apparently in =

> xeno_sys_init (look at the screen copy of vitualbox).

Do you have the same error if you boot this kernel on a real machine ?


--=20
                                                 Gilles.


