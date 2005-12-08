Message-ID: <43980FF6.1070104@domain.hid>
Date: Thu, 08 Dec 2005 12:50:30 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] insmod: error inserting './xeno_posix.ko': -1
	Unknown symbol in module
References: <000001c5fbe4$1f2d87c0$0200000a@domain.hid>
In-Reply-To: <000001c5fbe4$1f2d87c0$0200000a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Martijn Hazenberg (GOVA)" <martijn@domain.hid>
Cc: xenomai@xenomai.org

Martijn Hazenberg (GOVA) kirjoitti:
> Hi Heikki,
> 
> When i first do the insmod of xeno_hal.ko
> Dmesg comes with : 
> 
> Xenomai : 	local APIC absent or disabled!
> 		Disable APIC support or pass "lapic" as bootparam
> 
> What is this APIC ?

It's an interrupt controller tagged to the processor found on most 
modern Intel architecture CPUs. AFAIK some single processor systems 
disable it, although it's present on the cpu. You might first try what 
xenomai suggests: insert "lapic" to the boot parameters list for the 
kernel (lilo.conf or grub/menu.lst). If that doesn't work or makes the 
machine behave oddly, disable Local APIC in your kernel configuration 
and recompile the kernel and xeno modules.

-- hl

