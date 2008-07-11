Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Jul 2008 15:00:35 +0200
Message-ID: <0C9896A4B6D338488AD6FFFE58BAEF1002A3A100@domain.hid>
References: <4876C37B.70205@domain.hid> <4876F7CC.6010808@domain.hid>
From: "DOURNES Guillaume" <Guillaume.DOURNES@lgm.fr>
Subject: [Xenomai-help]  IRQ on USB
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

 Hello,

I developp a software under Xenomai. My software acquire information =
from pci boards (serial link, digital input, analog input, etc ...). =
Each driver board is under Xenomai.
My problem is that my keyboard and my mouse irq are in conflict with =
another pci board. My BIOS doesn't allow to affect the IRQ. And so when =
I want to use the keyboard or my mouse, the software freeze because an =
IRQ is shared beetwen Linux (Keyboard and Mouse) and Xenomai (an PCI =
board).
My keyboard and my mouse are USB, under a KVM switch.
So, Is it possible to change (affect) an USB IRQ ? Or Is it possible to =
pass the usb driver under Xenomai to have the IRQ shared into the same =
world : Xenomai ?
If everybody has another solution, it will be wellcome.

Thanks,

Guillaume.

-----Message d'origine-----
De : xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] =
De la part de Gilles Chanteperdrix
Envoy=E9 : vendredi 11 juillet 2008 08:04
=C0 : Guillaume Millet
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai-help] use of RTAI-Lab or equivalent, with Scicos =
and Comedi

Guillaume Millet wrote:
> Hello,
>=20
> is there a project similar to RTAI-Lab=20
> =
(https://www.rtai.org/index.php?module=3Dpagemaster&PAGE_user_op=3Dview_p=
a
> ge&PAGE_id=3D8&MMN_position=3D23:23, tutorial on=20
> https://www.rtai.org/RTAILAB/RTAI-Lab-tutorial.pdf) with block=20
> diagrams for Scicos and acquisition devices supported by Comedi ?
> I know the existence of Comedi over RTDM, but I haven't seen Xenomai=20
> blocks for Scicos. Could RTAI-Lab be used with Xenomai ? Sorry if my=20
> question is stupid, I am a newbie in real-time development.

No, rtai-lab has not been ported to Xenomai, but this should be =
certainly doable, since I have heard of at least one project which =
generates code for Xenomai with Matlab/Simulink (and without rtai-lab).

--=20


					    Gilles.

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help


