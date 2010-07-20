Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Jul 2010 13:15:05 -0500
Message-ID: <DF4FA7675C9F484AB1B63EAFDEE61762B6FDF8@domain.hid>
From: "Roberts, Patrick M AMRDEC/Aeigs" <Patrick.M.Roberts@domain.hid>
Subject: [Xenomai-help] High Latency on Dell Laptop, kernel=2.6.3.16,
	Xen= 2.5.3, Ubuntu (UNCLASSIFIED)
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
Cc: pat1micom@domain.hid, proberts@domain.hid

Classification: UNCLASSIFIED
Caveats: NONE

Hi Guys,  This is my first time using Xenomai and hoping that you can
help.  I have installed Xenomai on two different machines a netbook with
a N450 processor (latency results ~2 us) and a Dell Precision M6500
(consistent latency results ~700 us).  I have tried several iterations
and combinations of a) SMI work around on/off b) BIOS legacy suport
on/off c) power management and cpu scaling on/off, etc.   My Setup is:

1) Dell Precision M6500 with Dual Core I7 processor.
2) Base Lunix, Ubuntu Lucid Lynx 10.04
3) kernel 2.6.32.16 from kernel.org
4) xenomai 2.5.3
5) adeos patch =3D adeos-ipipe-2.6.32.11-x86-2.6-03.patch
6)  make menuconfig
    a) Processor type->HPET Timer   turn it off
    b) drivers->Plug and Play -> Plug and Play BIOS   turn it off
    c) Device->input->misc->PC speaker  turn it off
    d) Power Management->Power Management Support  (Turn off all
    e) Power management Support->CPU Frequency scaling  turn off
    f) Processortype->processor family Core 2/ newer Xeon
    g) Processortype-> -fstack-protector buffer overflow (EXPERIMENT)
turn off
    h) realtime->machine->smiworkaround->enable SMI workaround  turn on
(global disable on/off)
    i) devicedriver->Serial ATA (prod)->AHCI SATA Support  (ON not
module)

7) Other options experimented with
    device-driver->USB support->OHCI HCD  <m>
    device-driver->usb support->UHCI HCD  <m>
    device-driver->usb support->ehci hcd  <m>
    device-driver->usb support->USB MASS  <m>
    processor types -> High Memory support, change from 4 to <off>
    processor types -> PAE (Phys...) to <off>
    processor types -> Premption Model  <Preemptible Kernel (Low
Desktop)
    processor types -> Symmetric multi-processing support already <*>
    Real-time sub-system --> Xenomai->drivers->Testing driver->Contect
switch-> (enabled)

I never did see any mention of SMI work around in my kernel logs.  I did
see a mention of SMI interrupts are used for thermal cpu throttling.

Any suggestions are appreciated.
Thanks,
Patrick M. Roberts
Classification: UNCLASSIFIED
Caveats: NONE



