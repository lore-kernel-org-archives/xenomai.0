Message-ID: <512F48AA.8020601@hilscher.com>
Date: Thu, 28 Feb 2013 13:08:10 +0100
From: Jerome Poncin <JPoncin@hilscher.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com> <512C9E78.1060208@siemens.com>
	<512CC5C6.8050204@hilscher.com> <512CC6A3.1010005@siemens.com>
	<512F120A.5060109@hilscher.com> <512F4005.60000@siemens.com>
In-Reply-To: <512F4005.60000@siemens.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

"And it is impossible to disable/unload drivers that conflict with that=20
IRQ? "
=3D> I disable a maximum but other driver on the same IRQ are SATA, USB,=20
etc...

Nor do you have a modern system at hand? Those tend to use more MSI
than legacy IRQs for the on-board devices (or did you disable
CONFIG_PCI_MSI?) and provide more legacy IRQ lines (8 instead of 4).
=3D> OK I will see and try.

Then remove IRQ support. If it's untested, it's worthless.
=3D> You are right, but I prefer put a compilation condition with #ifdef fo=
r the future.

First of all, reformat your driver according to kernel coding style
(check with linux/scripts/checkpatch.pl). Then provide it in form of a
patch against Xenomai git head. The patch should add the driver source
code under ksrc/drivers/cifx (or so) and change the Makefiles and
Kconfigs as required. Make sure the result is properly built along a
normal Xenomai kernel build. We can then perform a code review and merge
the code if it is fine.
=3D> OK thank you for all these information, I will try.

Thank you for your help,

Hilscher France
12, rue du 35=E8me R=E9giment d'Aviation
Miniparc du Ch=EAne
69500 BRON
France
T=E9l. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http://www.hilscher.fr
HILSCHER FRANCE 	J=E9r=F4me Poncin
jponcin@hilscher.com
Ing=E9nieur D=E9veloppement Logiciel
T=E9l. : +33 (0) 4 72 37 98 44





Le 28/02/2013 12:31, Jan Kiszka a =E9crit :
> On 2013-02-28 09:15, Jerome Poncin wrote:
>> Hello,
>>
>> I tried to put one IRQ only for my cifX board without success. I have
>> not enough IRQ on my PC and the most of them are shared.
>> I modified Linux kernel to limit driver, I checked that all was correct
>> in BIOS etc. I had the same problem for a driver on another system.
> And it is impossible to disable/unload drivers that conflict with that
> IRQ? Nor do you have a modern system at hand? Those tend to use more MSI
> than legacy IRQs for the on-board devices (or did you disable
> CONFIG_PCI_MSI?) and provide more legacy IRQ lines (8 instead of 4).
>
>> It's not really important for the moment because the normal use of the
>> driver is polling.
> Then remove IRQ support. If it's untested, it's worthless.
>
>> Therefore for me, the part of Xenomai kernel driver for CifX is finished
>> and can be integrated to next release of Xenomai.
>> I don't know how to integrate my source to Xenomai kernel, therefore I
>> give you my last release of Xenomai kernel driver for cifX with the
>> makefile for compilation option.
> First of all, reformat your driver according to kernel coding style
> (check with linux/scripts/checkpatch.pl). Then provide it in form of a
> patch against Xenomai git head. The patch should add the driver source
> code under ksrc/drivers/cifx (or so) and change the Makefiles and
> Kconfigs as required. Make sure the result is properly built along a
> normal Xenomai kernel build. We can then perform a code review and merge
> the code if it is fine.
>
> Jan
>

