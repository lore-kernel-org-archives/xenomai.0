Message-ID: <4B4DC060.1060200@domain.hid>
Date: Wed, 13 Jan 2010 13:45:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1aa9845a1001110940o6bab200apde40348cc8e21bca@domain.hid>	<4B4B6D53.8050606@domain.hid>	<1aa9845a1001111053q58e082b1n75599eed79feec5a@domain.hid>	<1aa9845a1001121054r245187bfq5bf4f65fd031238f@domain.hid>	<4B4CCCC5.4020808@domain.hid>
	<1aa9845a1001130436t76834232j75977b2ab11422e1@domain.hid>
In-Reply-To: <1aa9845a1001130436t76834232j75977b2ab11422e1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai not booting on a dell server
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saravanan S <sarans1987@domain.hid>
Cc: xenomai@xenomai.org

Saravanan S wrote:
> First of all Thank you stefan for also helping out.Today I was going through
> the various options in the system set up of the server when I stumbled upon
> power management option.It was set to Active Power Controller.I set it to OS
> control and when i booted into xenomai and run xeno test got worst case
> latency of around 8 us which is decent .So all this while i guess the ACPI
> options were not being used.

Ok. This "Active Power Controller" is a bios setting, right? Then it
probably uses SMIs.

> This apart i think ideally latency should be around 3 us.What settings can i
> change further.
> 
> Currently i am not enabling Low Latency Desktop option.Should I???
> 
> And Stefan here are the outputs you requested.I have also attached them in
> text files.
> 
> lspci -nn
> 00:1f.0 ISA bridge [0601]: Intel Corporation 82801IB (ICH9) LPC Interface
> Controller [8086:2918] (rev 02)

This is the peripheral which IDs you should add to ksrc/arch/x86/smi.c


> We also need to find out why xeon option in processor is not working.Anyway
> thanks Gilles and Stefan

And some other things I told you to check in my first answer to your mail.

-- 
					    Gilles.

