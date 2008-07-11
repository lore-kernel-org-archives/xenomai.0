Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Jul 2008 15:58:46 +0200
Message-ID: <0C9896A4B6D338488AD6FFFE58BAEF1002A3A13B@serveur3.lgm.com>
References: <4876C37B.70205@domain.hid> <4876F7CC.6010808@domain.hid>
	<0C9896A4B6D338488AD6FFFE58BAEF1002A3A100@domain.hid>
	<48776124.7030600@domain.hid>
From: "DOURNES Guillaume" <Guillaume.DOURNES@lgm.fr>
Subject: Re: [Xenomai-help] IRQ on USB
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

Sorry for post this message with rtai-lab. I don't know how to create a =
new post.

I have already read the FAQ. All my PCI slot are used, All my pci board =
are used with my software, so i cannot disable some drivers. And my BIOS =
doesn't allow to affect IRQ.
My software run correctly when I remove a specific PCI board driver to =
avoid IRQ conflict beetween Xeno and Linux. But when i have all driver =
mounted, the usb driver for keyboard and mouse become a problem, because =
of IRQ conflict with a pci board IRQ.
So, Is it possible to change (affect) an USB IRQ ?
Is it possible to pass the usb driver under Xenomai to have the IRQ =
shared into the same world : Xenomai ?

Guillaume.

-----Message d'origine-----
De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9 : vendredi 11 juillet 2008 15:33
=C0 : DOURNES Guillaume
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai-help] IRQ on USB

DOURNES Guillaume wrote:
> Hello,
>=20
> I developp a software under Xenomai. My software acquire information=20
> from pci boards (serial link, digital input, analog input, etc ...).
> Each driver board is under Xenomai. My problem is that my keyboard and =

> my mouse irq are in conflict with another pci board. My BIOS doesn't=20
> allow to affect the IRQ. And so when I want to use the keyboard or my=20
> mouse, the software freeze because an IRQ is shared beetwen Linux=20
> (Keyboard and Mouse) and Xenomai (an PCI board). My keyboard and my=20
> mouse are USB, under a KVM switch. So, Is it possible to change=20
> (affect) an USB IRQ ? Or Is it possible to pass the usb driver under=20
> Xenomai to have the IRQ shared into the same world :
> Xenomai ? If everybody has another solution, it will be wellcome.

Hi,

I do not see what this has to do with rtai-lab.

Now about the IRQ conflict issue, try the FAQ, come back when you have =
done it.

Regards.

--=20
                                                  Gilles.


