MIME-Version: 1.0
In-Reply-To: <CAMwkeZzYbE8DKnmDNMbU58Qi0HC4YWNKJRjxs-8n8Q75tY1j8w@domain.hid>
References: <CAMwkeZzYbE8DKnmDNMbU58Qi0HC4YWNKJRjxs-8n8Q75tY1j8w@domain.hid>
Date: Mon, 3 Oct 2011 23:09:29 +0200
Message-ID: <CAMesUR5oL33XfP_BienmYeabgmL_0sea8UFnLFxJC5yZ-igEKw@domain.hid>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Module unloading and reloading does not work
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Fernando_Herrero_Carr=F3n?= <elferdo@domain.hid>
Cc: Xenomai-help@domain.hid

Hi,

2011/9/30 Fernando Herrero Carr=F3n <elferdo@domain.hid>:
> Dear list,
>
> I am testing Xenomai 2.6.0-rc4 on a 2.6.38.8 linux kernel. I have two car=
ds,
> one NI 6713 for AO and one NI 6143 for AI. I use the analogy_ni_pcimio fo=
r
> both, and it loads well. I can run the config program succesfully too.
>
> If I remove the devices using 'analogy_config -r ...', then unload the
> modules with:
>
> rmmod analogy_ni_pcimio analogy_ni_mio analogy_ni_tio analogy_8255
> analogy_ni_mite xeno_analogy
>
> then load them again and try to reconfigure, I get the following error on
> dmesg (I include the boot messages and the execution of a "cmd_read"):
>
> [=A0=A0 55.735198] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6=
713
> board
> [=A0=A0 55.735246] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 2=
1
> [=A0=A0 60.143227] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6=
143
> board
> [=A0=A0 60.143274] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 2=
0
> [=A0=A0 79.772511] Analogy: a4l_ioctl_cancel: no acquisition to cancel on=
 this
> context
> [=A0=A0 79.772517] Analogy: analogy_ni_pcimio: ni_ai_cmd: start
> [=A0=A0 79.772525] Analogy: analogy_ni_pcimio: ni_ai_cmd:
> Interrupt_A_Enable_Register =3D 0x0021
> [=A0=A0 79.772531] Analogy: analogy_ni_pcimio: ni_ai_cmd: exit
> [=A0=A0 80.572613] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt:
> a_status=3D90f0 ai_mite_status=3D00200000
> [=A0=A0 80.572616] Analogy: analogy_ni_pcimio: ni_mio_common: SC_TC inter=
rupt
> [=A0 236.290044] Analogy: MITE: Available NI device IDs: 0x1870 0x70c0
> [=A0 246.113821] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-614=
3
> board
> [=A0 246.113872] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 20
> [=A0 246.113876] Analogy: analogy_ni_pcimio: pcimio_attach: irq not avail=
able
> [=A0 246.113879] Analogy: a4l_request_irq: IRQ registration failed
> [=A0 251.563782] Analogy: analogy_ni_pcimio: pcimio_attach: found pci-671=
3
> board
> [=A0 251.563824] Analogy: analogy_ni_pcimio: pcimio_attach: found irq 21
> [=A0 251.563828] Analogy: analogy_ni_pcimio: pcimio_attach: irq not avail=
able
> [=A0 251.563830] Analogy: a4l_request_irq: IRQ registration failed
>
> BTW, the analogy_config program does not report those errors.
>
> This is bothering because I'm fiddling with the drivers and everytime I
> change something I have to reboot. Anyone experiencing the same problem?

Sorry. I will try to fix that as soon as possible.

>
> Thanks for your help,
> Fernando
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

Alexis.

