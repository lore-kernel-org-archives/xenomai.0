Message-ID: <4C6F9D1D.1070805@domain.hid>
Date: Sat, 21 Aug 2010 11:32:13 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid>
	<4C6932E8.7050701@domain.hid>		<4C694AB3.8050407@domain.hid>
	<4C698E16.5050806@domain.hid>	<1282040830.1730.232.camel@domain.hid>
	<4C6E75BD.3030404@domain.hid>
In-Reply-To: <4C6E75BD.3030404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
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

On 20/08/10 14:31, Theo Veenker wrote:
> Here are my results. I've built 5 kernels:
> K1: 2.6.32.15 (without the adeos patch applied)
> K2: 2.6.32.15 + 2.5.4
> K3: 2.6.32.15 + 2.5.4 CONFIG_SMP off, CONFIG_X86_UP_API on, CONFIG_XENOMAI off, CONFIG_IPIPE on
> K4: 2.6.32.15 + 2.5.4 as (3) with CONFIG_X86_UP_IOAPIC on
> K5: 2.6.32.7 with adeos-ipipe-2.6.32.7-x86-2.5-01.patch
> 
> I now tested these kernels on four systems:
> A1: MSI 945P with Ubuntu 8.04
> A2: MSI 945P with Ubuntu 10.04
> B1: MSI p45 neo3 with Ubuntu 8.04
> B2: MSI p45 neo3 with Ubuntu 10.04
> 
> A1 and A2 are identical systems from the same batch and B1 and B2 also.
> 
> What worked:
> 	A1		A2		B1		B2
> ----------------------------------------------------------------
> K1	Y		Y		Y		Y
> K2	Y		N/Y		Y		N
> K3	Y		N/Y		Y		N
> K4	Y		N/Y		Y		N
> K5	Y		N/Y		Y		N
> 
> The No/Yes cases means on this system sometimes the kernel would boot
> (same as others have reported before). In the No cases I got no ouput
> on the attached console.

Hello. I would like to add my system to the statistics. I have an x86
single core host where the latest xenomai kernel I'm able to run is
2.6.30 with adeos patch 2.4.something (sorry, I do not have access to
this machine right now). Using adeos patch version 2.6 produces the same
problem as reported by Theo: no output after the boot loader.

I'm also using the latest grub provided by debian, version 1.92 I think.
I'll try with a different grub version when I'll be back to work.

Cheers,
-- 
Daniele

