Date: Sat, 09 Mar 2019 00:09:44 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: INTR-REMAP error with UDD driver
Message-ID: <N7E2LsRlK56RvbebkFcJQQ2dDxADQFafW5IiU9i0JwAbPo30P8vwTcA-0EXDsurbTFDNMYxZhYUdHUxWDiKgQNWBsjhXm7UnkquCZUPYu2Q=@codecraftsmen.org>
In-Reply-To: <f29704ba-2c88-e82a-ebf8-359ac6398423@siemens.com>
References: <SVZrPK0MQbayn-KPZ4wIvVLcbdluegH0Vxlth0h7DnkST5oo2K5_0Nu6vd-FBcRz3cYtRj5Jl9Wp2nTHSCp-udTCw2_fAcY--f7JNMVUHrg=@protonmail.com>
 <46f899f8-8e3a-8ad5-77d3-5ed0bbc2c546@siemens.com>
 <Mtsj7WK6Smi457BA0VbXiS2OruDJeJ4CvnxF51uGtYcZGGtpR5cCZayoFwt_bxbfxqAvU56y7nmrNxAoT6RthUqGsS1lTYnUDU4vC_3P4Fw=@codecraftsmen.org>
 <f29704ba-2c88-e82a-ebf8-359ac6398423@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Friday, March 8, 2019 9:00 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote=
:

> On 08.03.19 15:07, Jeff Webb wrote:
>
> > On Friday, March 8, 2019 1:14 AM, Jan Kiszka jan.kiszka@siemens.com wro=
te:
> >
> > > On 08.03.19 02:35, Jeff Webb via Xenomai wrote:
> > >
> > > > I have implemented a simple UDD mini-driver (interrupt handler) and=
 an associated Xenomai userspace test program. This pair of programs works =
as intended on one machine. When I tried running the same programs on anoth=
er machine, I got this error when the first interrupt occurred:
> > > > kernel: [ 75.122305] DMAR: DRHD: handling fault status reg 2
> > > > kernel: [ 75.123175] DMAR: [INTR-REMAP] Request device [f0:1f.0] fa=
ult index ee00 [fault reason 37] Blocked a compatibility format interrupt r=
equest
> > >
> > > This means the device is under IOMMU interrupt remapping regime, but =
it was
> > > programmed to use a standard MSI/MSI-X request, rather than requestin=
g that
> > > parameters (address/data tuple) from the Linux interrupt management l=
ayer that
> > > will assign a remapping slot and hand out the right values. Now you i=
nterrupt is
> > > stuck in the filter.
> > > Before suggesting the workaround/hack to disable interrupt remapping:=
 How did
> > > you program MSI/-X? Via proper Linux pci_* helpers?
> >
> > The PCI card I am working with does not implement MSI interrupts, but j=
ust uses the legacy interrupt pin A. It's confusing to me that this error i=
s associated with MSI. Since this behavior is slot-dependent, I figured at =
first that the error is from another device on the same interrupt line, but=
 I get the same error on several different slots. There is only one slot wh=
ere things work as expected.
>
> Ok, then we may have an issue with how we register legacy INTx at the IOA=
PIC
> when interrupt remapping is on. Basically, the IOAPIC sends MSI-like mess=
ages as
> well that are subject to remapping. So its registers need to be programme=
d with
> the right translatable values, just like the MSI registers of a device. L=
inux
> does that, it's in charge of the IOMMU. I don't recall how we (Xenomai/I-=
pipe)
> fill the IOAPIC if a line was not used before under Linux. Possibly, ther=
e is
> the wrong Linux function triggered. But maybe it's also something differe=
nt.
>
> I assume you tested that your card would work find if it used only regula=
r Linux
> driver services, no RTDM, right? That would be good in order to exclude a
> general platform issue, maybe a BIOS (ACPI) bug in describing which PCI s=
lot is
> under which IOMMU regime.

I just wrote a similar UIO driver and user-space program.  The UIO version =
works when the card is in any slot.  The UDD version only works when the ca=
rd is in one slot (out of 5).  The UDD version does not work in the "bad" s=
lots even if the UIO version is run first.  All of the UIO testing is with =
the same kernel as the UDD testing.

Thanks,

-Jeff


