Date: Thu, 14 Nov 2019 05:05:27 +0000
From: Jeff Webb <jeff.webb@protonmail.com>
Reply-To: Jeff Webb <jeff.webb@protonmail.com>
Subject: RE: INTR-REMAP error with UDD driver
Message-ID: <abVhmVLZoPCMWqAbSv547Q_VzyvVJlNAswLDgIKZpMzhMhOvYJNQYRGT6rz470Lgp_xFfkgLpsUSzHdOpFyyXuww10kuZ0VSUH-Nyf82P0I=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "pero@wolfram.com" <pero@wolfram.com>

I would like to revive this thread from several months ago:

https://xenomai.org/pipermail/xenomai/2019-March/040498.html

The issue is that on some hardware (a specific rack-mount PC with a PICMG d=
aughtercard on a backplane containing PCI and PCIe slots) I get an INTR-REM=
AP error when trying to receive legacy (not MSI) interrupts from a custom F=
PGA-based PCI card using a UDD driver.  The card did work properly in one o=
ut of the five PCI slots on that machine, but UDD interrupts did not work i=
n the other four slots.

Please review the original thread for more details about the specific error=
.

Here are a few more tidbits I have gathered:

- The UDD driver / userspace code works fine on the other hardware

- The UDD driver / userspace code works fine in one PCI slot out of five on=
 this hardware.

- With another backplane model, but same processor card, the problem occurs=
 in all four of the PCI slots.

- An almost identical pure-linux UIO version of the driver / userspace code=
 works in all the cases I tested, even when the UDD version fails, and even=
 with the same xenomai-patched kernel used for UDD testing.

In one of the previous posts in this thread a few months ago, Per =C3=96ber=
g mentioned experiencing something similar.  Based on the information that =
was shared, I tried my code with linux version 4.9.38, but it still failed.=
  This prompted me to try other linux / ipipe / xenomai combinations.  Thes=
e are my findings:

Interrupts work:
xenomai-2.6.5   ipipe-core-3.18.20-x86-7.patch  (2016-07-05)
xenomai-3.0.9+  ipipe-core-3.18.20-x86-7.patch  (2016-07-05)
xenomai-3.0.9+  ipipe-core-4.1.18-x86-9.patch   (2017-05-25)

INTR-REMAP error:
xenomai-3.0.9+  ipipe-core-4.4.43-x86-6.patch   (2017-02-25)
xenomai-3.0.9+  ipipe-core-4.4.43-x86-7.patch   (2017-05-25)
xenomai-3.0.9+  ipipe-core-4.4.43-x86-8.patch   (2017-06-14)
xenomai-3.1-rc3 ipipe-core-4.4.196-cip38-x86-19.patch (2019-11-04)
xenomai-3.0.9+  ipipe-core-4.9.38-x86-4.patch   (2017-10-03)
xenomai-3.0.9   ipipe-core-4.14.132-x86-6.patch (2019-07-03)

The Xenomai 2.6.5 version of course does not use UDD, but uses the old pthr=
ead_intr_* userspace functions.

Hopefully this additional information can shed a little light on the matter=
.

Thanks in advance for any input you can provide,

-Jeff Webb


