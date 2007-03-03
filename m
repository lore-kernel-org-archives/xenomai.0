Message-ID: <45E999D3.80704@domain.hid>
Date: Sat, 03 Mar 2007 17:52:51 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] MPC8641D and CONFIG_PPC_MERGE
References: <45E8D44F.7070200@domain.hid>
	<45E90B60.6060406@domain.hid> <45E92BDF.60909@domain.hid>
	<45E994FB.6000004@domain.hid>
In-Reply-To: <45E994FB.6000004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeff Koftinoff <jeffk@domain.hid>
Cc: xenomai@xenomai.org

Jeff Koftinoff kirjoitti:
> Thank you for your responses, Wolfgang.
> 
> I still have some confusion; I was able to build and run a xenomai 2.2.0 
> patched linux 2.6.14 kernel on a Apple EMac, which has a 7447A processor 
> in it - with no changes, and was able to get good latency results in my 
> tests.

I think the older kernels still supported Apple hardware under the "ppc" 
arch, but in the more recent kernels it's moved to the "powerpc" arch.

> I am currently playing with a 8641D dual core power pc, it is basically 
> two 7448 processors in one package which is almost identical to the 
> 7447A, along with peripherals (ethernet/serial/pcie).  Yet I can't seem 
> to get xenomai compiled for it, even in non-smp mode.
> The 8641D needs a newer kernel than 2.6.14 ( 2.6.19 is okay ).
> What should I do?

If you have followed Linux kernel development and understand the new 
genirq stuff (and eventually irq threads), or are willing to dig into 
it, then why not start a brave porting effort and try to, for example, 
first make your eMac work on newer kernels with adeos/xenomai stuff applied.

-- Heikki Lindholm

