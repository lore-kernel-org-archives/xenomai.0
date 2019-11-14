Date: Thu, 14 Nov 2019 01:35:44 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1874484167.752858.1573716944285.JavaMail.zimbra@wolfram.com>
In-Reply-To: <abVhmVLZoPCMWqAbSv547Q_VzyvVJlNAswLDgIKZpMzhMhOvYJNQYRGT6rz470Lgp_xFfkgLpsUSzHdOpFyyXuww10kuZ0VSUH-Nyf82P0I=@protonmail.com>
References: <abVhmVLZoPCMWqAbSv547Q_VzyvVJlNAswLDgIKZpMzhMhOvYJNQYRGT6rz470Lgp_xFfkgLpsUSzHdOpFyyXuww10kuZ0VSUH-Nyf82P0I=@protonmail.com>
Subject: Re: INTR-REMAP error with UDD driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>
Cc: Jeff Webb <jeff.webb@protonmail.com>



> I would like to revive this thread from several months ago:

> https://xenomai.org/pipermail/xenomai/2019-March/040498.html

> The issue is that on some hardware (a specific rack-mount PC with a PICMG
> daughtercard on a backplane containing PCI and PCIe slots) I get an INTR-=
REMAP
> error when trying to receive legacy (not MSI) interrupts from a custom
> FPGA-based PCI card using a UDD driver. The card did work properly in one=
 out
> of the five PCI slots on that machine, but UDD interrupts did not work in=
 the
> other four slots.

This looks very close to my issue. This was under an experimenting phase of=
 the project, so unfortunately I cannot re-test anything because I don't ha=
ve the hardware. If I recall correctly the hardware involved where=20

PC
---------------
One of these worked, the other did not (sorry, this is all I can remember)
* Advantech ARK-3500, embedded PC [1] (hard to find a  good description)
* Advantech AIMB-585, Motherboard [2]=20

This definitely worked
* HP Z620 Workstation=20


PCI/PCIe
* PCAN-PCI Express Four Channel, not manufactured any more (Closest is 2 Ch=
annel IPEH-003027)

[1] https://advdownload.advantech.com/productfile/PIS/ARK-3500/Product%20-%=
20Datasheet/ARK-3500_DS(11.16.16)20161116101733.pdf
[2] https://advdownload.advantech.com/productfile/PIS/AIMB-585/Product%20-%=
20Datasheet/AIMB-585_DS(12.28.17)20171228141058.pdf

> Please review the original thread for more details about the specific err=
or.

> Here are a few more tidbits I have gathered:

> - The UDD driver / userspace code works fine on the other hardware

> - The UDD driver / userspace code works fine in one PCI slot out of five =
on this
> hardware.

> - With another backplane model, but same processor card, the problem occu=
rs in
> all four of the PCI slots.

> - An almost identical pure-linux UIO version of the driver / userspace co=
de
> works in all the cases I tested, even when the UDD version fails, and eve=
n with
> the same xenomai-patched kernel used for UDD testing.

This also fits my memory of the issue I had.=20

> In one of the previous posts in this thread a few months ago, Per =C3=96b=
erg
> mentioned experiencing something similar. Based on the information that w=
as
> shared, I tried my code with linux version 4.9.38, but it still failed. T=
his
> prompted me to try other linux / ipipe / xenomai combinations. These are =
my
> findings:

> Interrupts work:
> xenomai-2.6.5 ipipe-core-3.18.20-x86-7.patch (2016-07-05)
> xenomai-3.0.9+ ipipe-core-3.18.20-x86-7.patch (2016-07-05)
> xenomai-3.0.9+ ipipe-core-4.1.18-x86-9.patch (2017-05-25)

> INTR-REMAP error:
> xenomai-3.0.9+ ipipe-core-4.4.43-x86-6.patch (2017-02-25)
> xenomai-3.0.9+ ipipe-core-4.4.43-x86-7.patch (2017-05-25)
> xenomai-3.0.9+ ipipe-core-4.4.43-x86-8.patch (2017-06-14)
> xenomai-3.1-rc3 ipipe-core-4.4.196-cip38-x86-19.patch (2019-11-04)
> xenomai-3.0.9+ ipipe-core-4.9.38-x86-4.patch (2017-10-03)
> xenomai-3.0.9 ipipe-core-4.14.132-x86-6.patch (2019-07-03)

> The Xenomai 2.6.5 version of course does not use UDD, but uses the old
> pthread_intr_* userspace functions.

> Hopefully this additional information can shed a little light on the matt=
er.

> Thanks in advance for any input you can provide,

> -Jeff Webb

Per =C3=96berg=20

