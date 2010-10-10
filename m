From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>
	<1286611432.13186.200.camel@domain.hid>
	<AANLkTinfQTmC=165zLerDF1JsYnS-XHaUtWrMuOGmN4D@mail.gmail.com>
	<AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 10 Oct 2010 23:28:36 +0200
Message-ID: <1286746116.13186.214.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2010-10-10 at 12:30 -0700, Peter Pastor wrote:
> Hey,
> 
> I have installed xenomai 2.5.5 using linux 2.6.31.8 and the
> corresponding adeos patch adeos-ipipe-2.6.31.8-x86-2.4-09.patch.
> 
> I also tried to disable CONFIG_PCI_MSI by passing pci=nomsi in grub as
> documented in /usr/src/linux/Documentation/kernel-parameters.txt. I
> did not disable the CONFIG_PCI_MSI option since it is selected by:
> AMD_IOMMU && X86_64 && PCI && ACPI ...and I did not know which of
> these options I should deselect. Also, when I disable ACPI completely,
> the kernel only detects a single cpu, although there are 8 cores in
> the system.

Disabling ACPI completely is a dead end; however you may try to disable
AMD_IOMMU if you don't have this feature supported in your chipset.

-- 
Philippe.



