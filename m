From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <C7EFC96D-FF5D-4150-A63D-1FFF25412FE7@domain.hid>
References: <AANLkTi=yDXty82va8JGzmRA453e021EvomyYitaQTCTg@domain.hid>
	<4C5C83E5.9040508@domain.hid>
	<C7EFC96D-FF5D-4150-A63D-1FFF25412FE7@domain.hid>
Date: Sun, 08 Aug 2010 01:17:58 +0200
Message-Id: <20100807231758.AAC87B715A@gemini.denx.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] migration scenario to xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guenter Ebermann <guenter.ebermann@domain.hid>
Cc: xenomai@xenomai.org

Dear Guenter Ebermann,

In message <C7EFC96D-FF5D-4150-A63D-1FFF25412FE7@domain.hid> you wrot=
e:
>=20
> I know the PCI-host infrastructure of the linux kernel - device enumera=
tion and
> driver structure. But AFAIK the PCI infrastructure of the linux kernel =
"only"
> deals with the use case where linux is the master/host on the PCI bus. =
 Our
> aquisition device must be a bus master PCI slave/device - this means it=
 is
> plugged into a normal PC via PCI-express. Therefor linux on the card is=
 not
> allowed to make bus enumeration. We will have to port our own PCI-devic=
e-driver
> which uses the DMA controller to make PCI-burst-transfers to host memor=
y. Is
> there a infrastructure I dont know of, which can help us in this task? =
E.g.: A
> existing general purpose DMA Api which I only have to extend to the DMA
> controller (I think it is a kind of Freescale Bestcomm) of our new CPU.

You do not want to use a MPC5200 in any new product. Actually, you do
not want to use the BestComm in any product.

As for PCIe support: both U-Boot and Linux support initialization of
hardware with respective capabilities as root complex or as end point.
For example, the AMCC PPC 440SPe is running in some storage controller
applications, where for example two of the PCIe busses are configured
as root complex and the third is used in end point mode.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
"There was no difference between  the  behavior  of  a  god  and  the
operations of pure chance..."   - Thomas Pynchon, _Gravity's Rainbow_

