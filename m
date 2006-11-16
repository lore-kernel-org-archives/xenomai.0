Message-ID: <455CBC4A.5010108@domain.hid>
Date: Thu, 16 Nov 2006 20:30:18 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_rtcan_mem.ko, what are it's parameters?
References: <54b161f50611160749p5405415fk6702af8243428fa4@domain.hid>
	<455C8B8A.80105@domain.hid>
In-Reply-To: <455C8B8A.80105@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Frits de Klark wrote:
>> Hello everyone,
>>
>> I finally got my PCI CAN card today. It's an Advantech 1680 and
>> provides, as
>> far as I'm informed, a memory mapped SJA1000 controller.
>> I=B4m trying to load the xeno_rtcan_mem module now, but I'm not sure w=
hat
>> parameters I should pass. More specific: What value(s) should I give t=
o the
>> 'mem' parameter? Is this an I/O address I found in /proc/pci under the=
 1680
>> device?
>=20
> I'm not sure that this will work, but you can give it a try in any case=
.
> Do you have a reference driver for that board? Or some manual describin=
g
> the mapping of the SJA1000 into the PCI address space?

It was not working for the IXXAT PCI card, at least (but I have not yet=20
understodd why). Check with "$ lspci -vv" how the device is mapped and=20
what IRQ number is used. The right thing is to implement a PCI driver.

> AFAIK, Wolfgang is working on a generic SJA1000 PCI driver. So far we
> only have a driver for the PEAK PCI adapter, but that one is going to b=
e
> generalised. So you could become a first-grade test candidate for
> another piece of hardware supported by that driver. :)
>=20
> Wolfgang, what the status?

As already mention, I'm currently working on a driver for the IXXAT PCI=20
card. As I see it, a generic driver is not feasible as the mapping, the=20
recognition of the second channel and the IRQ handling is quite different=
.

Is there a Linux driver on the CRROM your got with your Advantech 1680=20
PCI card? That would help a lot.

Wolfgang.

Wolfgang.


