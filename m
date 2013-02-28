Message-ID: <512F4005.60000@siemens.com>
Date: Thu, 28 Feb 2013 12:31:17 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com> <512C9E78.1060208@siemens.com>
	<512CC5C6.8050204@hilscher.com> <512CC6A3.1010005@siemens.com>
	<512F120A.5060109@hilscher.com>
In-Reply-To: <512F120A.5060109@hilscher.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerome Poncin <JPoncin@hilscher.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-02-28 09:15, Jerome Poncin wrote:
> Hello,
> 
> I tried to put one IRQ only for my cifX board without success. I have
> not enough IRQ on my PC and the most of them are shared.
> I modified Linux kernel to limit driver, I checked that all was correct
> in BIOS etc. I had the same problem for a driver on another system.

And it is impossible to disable/unload drivers that conflict with that
IRQ? Nor do you have a modern system at hand? Those tend to use more MSI
than legacy IRQs for the on-board devices (or did you disable
CONFIG_PCI_MSI?) and provide more legacy IRQ lines (8 instead of 4).

> It's not really important for the moment because the normal use of the
> driver is polling.

Then remove IRQ support. If it's untested, it's worthless.

> Therefore for me, the part of Xenomai kernel driver for CifX is finished
> and can be integrated to next release of Xenomai.
> I don't know how to integrate my source to Xenomai kernel, therefore I
> give you my last release of Xenomai kernel driver for cifX with the
> makefile for compilation option.

First of all, reformat your driver according to kernel coding style
(check with linux/scripts/checkpatch.pl). Then provide it in form of a
patch against Xenomai git head. The patch should add the driver source
code under ksrc/drivers/cifx (or so) and change the Makefiles and
Kconfigs as required. Make sure the result is properly built along a
normal Xenomai kernel build. We can then perform a code review and merge
the code if it is fine.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

