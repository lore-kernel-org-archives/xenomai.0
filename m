Date: Fri, 08 Mar 2019 14:07:26 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: INTR-REMAP error with UDD driver
Message-ID: <Mtsj7WK6Smi457BA0VbXiS2OruDJeJ4CvnxF51uGtYcZGGtpR5cCZayoFwt_bxbfxqAvU56y7nmrNxAoT6RthUqGsS1lTYnUDU4vC_3P4Fw=@codecraftsmen.org>
In-Reply-To: <46f899f8-8e3a-8ad5-77d3-5ed0bbc2c546@siemens.com>
References: <SVZrPK0MQbayn-KPZ4wIvVLcbdluegH0Vxlth0h7DnkST5oo2K5_0Nu6vd-FBcRz3cYtRj5Jl9Wp2nTHSCp-udTCw2_fAcY--f7JNMVUHrg=@protonmail.com>
 <46f899f8-8e3a-8ad5-77d3-5ed0bbc2c546@siemens.com>
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

On Friday, March 8, 2019 1:14 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote=
:

> On 08.03.19 02:35, Jeff Webb via Xenomai wrote:
>
> > I have implemented a simple UDD mini-driver (interrupt handler) and an =
associated Xenomai userspace test program. This pair of programs works as i=
ntended on one machine. When I tried running the same programs on another m=
achine, I got this error when the first interrupt occurred:
> > kernel: [ 75.122305] DMAR: DRHD: handling fault status reg 2
> > kernel: [ 75.123175] DMAR: [INTR-REMAP] Request device [f0:1f.0] fault =
index ee00 [fault reason 37] Blocked a compatibility format interrupt reque=
st
>
> This means the device is under IOMMU interrupt remapping regime, but it w=
as
> programmed to use a standard MSI/MSI-X request, rather than requesting th=
at
> parameters (address/data tuple) from the Linux interrupt management layer=
 that
> will assign a remapping slot and hand out the right values. Now you inter=
rupt is
> stuck in the filter.
>
> Before suggesting the workaround/hack to disable interrupt remapping: How=
 did
> you program MSI/-X? Via proper Linux pci_* helpers?

The PCI card I am working with does not implement MSI interrupts, but just =
uses the legacy interrupt pin A.  It's confusing to me that this error is a=
ssociated with MSI.  Since this behavior is slot-dependent, I figured at fi=
rst that the error is from another device on the same interrupt line, but I=
 get the same error on several different slots.  There is only one slot whe=
re things work as expected.

Thanks for the response,

-Jeff

>
> Jan
>
> > I would guess that the [f0:1f.0] in the message is a PCI bus address, b=
ut I don't see this via lspci. The closest match is:
> > 00:1f.0 ISA bridge [0601]: Intel Corporation Q67 Express Chipset LPC Co=
ntroller [8086:1c4e] (rev 05)
> > After the first attempt, I see no more of these messages until I reboot=
, but the UDD driver never receives an interrupt in any case.
> > I tried moving my PCI card to five different slots, and finally found o=
ne where everything work properly on the second machine. I can at continue =
to make progress using the working slot, but I would really like to resolve=
 the issue with the other slots. Does anyone have any idea what to try next=
?
> > I am using these sources:
> > linux-4.14.89.tar
> > ipipe-core-4.14.89-x86-2.patch
> > xenomai-3.0.8.tar
> > I have attached the boot log, config, and cpu information.
> > Thanks,
> > -Jeff Webb
>
> --
>
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux



