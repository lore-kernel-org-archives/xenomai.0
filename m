Subject: Re: INTR-REMAP error with UDD driver
References: <abVhmVLZoPCMWqAbSv547Q_VzyvVJlNAswLDgIKZpMzhMhOvYJNQYRGT6rz470Lgp_xFfkgLpsUSzHdOpFyyXuww10kuZ0VSUH-Nyf82P0I=@protonmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3c48366f-5fec-be5e-1ea0-8e1504a249ed@siemens.com>
Date: Thu, 14 Nov 2019 08:50:21 +0100
MIME-Version: 1.0
In-Reply-To: <abVhmVLZoPCMWqAbSv547Q_VzyvVJlNAswLDgIKZpMzhMhOvYJNQYRGT6rz470Lgp_xFfkgLpsUSzHdOpFyyXuww10kuZ0VSUH-Nyf82P0I=@protonmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@protonmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "pero@wolfram.com" <pero@wolfram.com>

On 14.11.19 06:05, Jeff Webb via Xenomai wrote:
> I would like to revive this thread from several months ago:
> 
> https://xenomai.org/pipermail/xenomai/2019-March/040498.html
> 
> The issue is that on some hardware (a specific rack-mount PC with a PICMG daughtercard on a backplane containing PCI and PCIe slots) I get an INTR-REMAP error when trying to receive legacy (not MSI) interrupts from a custom FPGA-based PCI card using a UDD driver.  The card did work properly in one out of the five PCI slots on that machine, but UDD interrupts did not work in the other four slots.
> 
> Please review the original thread for more details about the specific error.
> 
> Here are a few more tidbits I have gathered:
> 
> - The UDD driver / userspace code works fine on the other hardware
> 
> - The UDD driver / userspace code works fine in one PCI slot out of five on this hardware.
> 
> - With another backplane model, but same processor card, the problem occurs in all four of the PCI slots.
> 
> - An almost identical pure-linux UIO version of the driver / userspace code works in all the cases I tested, even when the UDD version fails, and even with the same xenomai-patched kernel used for UDD testing.
> 
> In one of the previous posts in this thread a few months ago, Per Öberg mentioned experiencing something similar.  Based on the information that was shared, I tried my code with linux version 4.9.38, but it still failed.  This prompted me to try other linux / ipipe / xenomai combinations.  These are my findings:
> 
> Interrupts work:
> xenomai-2.6.5   ipipe-core-3.18.20-x86-7.patch  (2016-07-05)
> xenomai-3.0.9+  ipipe-core-3.18.20-x86-7.patch  (2016-07-05)
> xenomai-3.0.9+  ipipe-core-4.1.18-x86-9.patch   (2017-05-25)
> 
> INTR-REMAP error:
> xenomai-3.0.9+  ipipe-core-4.4.43-x86-6.patch   (2017-02-25)
> xenomai-3.0.9+  ipipe-core-4.4.43-x86-7.patch   (2017-05-25)
> xenomai-3.0.9+  ipipe-core-4.4.43-x86-8.patch   (2017-06-14)
> xenomai-3.1-rc3 ipipe-core-4.4.196-cip38-x86-19.patch (2019-11-04)
> xenomai-3.0.9+  ipipe-core-4.9.38-x86-4.patch   (2017-10-03)
> xenomai-3.0.9   ipipe-core-4.14.132-x86-6.patch (2019-07-03)
> 
> The Xenomai 2.6.5 version of course does not use UDD, but uses the old pthread_intr_* userspace functions.
> 
> Hopefully this additional information can shed a little light on the matter.
> 

This sounds like some RT interrupt enabling issue related to the IOAPIC 
in the x86 I-pipe patch. Please also test 4.19.

Are you using UDD_IRQ_CUSTOM or do you leave the interrupt registration 
to the UDD core?

And please share your kernel config.

BTW, interrupt remapping issues can be worked around by disabling the 
interrupt remapping feature (e.g. "intremap=off"). But that does not 
solve the unterlying issue, of course.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

