From: "Lopes, Alexandre" <alexandre.lopes.ext@zeiss.com>
Date: Fri, 15 Jan 2016 11:30:42 +0000
Message-ID: <79A9E4882C44D44FA53B5AB15E619801260C7E3E@ADEERL01SMS001.cznet.zeiss.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Analogy and PCI-6289 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I am currently using Xenomai 3.0 rc4 (3.18.12 Linux Kernel)
and trying to get Analogy to work with the following NI cards:
* PCI-6289
* PCI-6713

>From what I have read, both should be supported by the analogy_ni_pcimio
driver.

The problem is that, while I can get the 6713 to work, I am unable
to get the 6289 to work.

At boot both cards are recognized by Analogy:

[   13.172013] Analogy: MITE: Available NI device IDs: 0x1870 0x70ac

and both show up on the output of lspci

03:02.0 Unassigned class [ff00]: National Instruments PCI-6289
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Step=20
        ping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort
        - <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f7e03000 (32-bit, non-prefetchable) [size=3D4K]
        Region 1: Memory at f7e02000 (32-bit, non-prefetchable) [size=3D4K]
        Kernel driver in use: analogy_mite

03:03.0 Unassigned class [ff00]: National Instruments PCI-6713
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Step
        ping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort
        - <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 256 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f7e01000 (32-bit, non-prefetchable) [size=3D4K]
        Region 1: Memory at f7e00000 (32-bit, non-prefetchable) [size=3D4K]
        Kernel driver in use: analogy_mite
       =20
       =20
The PCI-6713 works flawlessly.

After running=20

analogy_config analogy0 analogy_ni_pcimio 3,3

I get:

cat 00-analogy_ni_pcimio
       =20
--  Subdevices --

| idx | type
|  00 | Unused subdevice
|  01 | Analog output subdevice
|  02 | Digital input/output subdevice
|  03 | Unused subdevice
|  04 | Unused subdevice
|  05 | Calibration subdevice
|  06 | Memory subdevice
|  07 | Digital input/output subdevice
|  08 | Unused subdevice
|  09 | Serial subdevice
|  10 | Unused subdevice
|  11 | Counter subdevice
|  12 | Counter subdevice
|  13 | Counter subdevice

cat devices

--  Analogy devices --

| idx | status | driver
|  00 | Linked | pci-6713
|  01 | Unused | No driver
|  02 | Unused | No driver
|  03 | Unused | No driver
|  04 | Unused | No driver
|  05 | Unused | No driver
|  06 | Unused | No driver
|  07 | Unused | No driver
|  08 | Unused | No driver
|  09 | Unused | No driver

but for the 6289

sudo analogy_config analogy1 analogy_ni_pcimio 3,2

returns

analogy_config: a4l_attach(analogy_ni_pcimio) failed err=3D-1
analogy_config: check the procfs information:
 - analogy devices: /proc/analogy/devices
 - analogy drivers: /proc/analogy/drivers
=20
and in dmesg
=20
[1792.306659] Analogy: a4l_assign_driver: call(drv->attach) failed (ret=3D-=
2)

I have already tried to swap pci slots, to use only one card, to omit the d=
river parameters
etc. and the end result is always the same: I can attach the driver to the =
6713 but not to
the 6289.

Could anyone help me shed some light on the issue?

Thanks!

Alexandre

