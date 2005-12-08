Message-ID: <43986283.2030800@domain.hid>
Date: Thu, 08 Dec 2005 18:42:43 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: FW: [Xenomai-help] insmod: error inserting	'./xeno_posix.ko':-1
	Unknown symbol in module
References: <002001c5fc03$0c00d610$0200000a@domain.hid>
In-Reply-To: <002001c5fc03$0c00d610$0200000a@domain.hid>
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
> Hi,
> 
> I have deselected the ACPI which is the power management stuff..
> 
> When I startup, in dmesg I see :
> 
> Local APIC disabled by bios. You can enable it with lapic Mapped apic to
> ffffd000
> 
> This means that the APIC is turned off by bios... so far so good...
> 
> The only lines containing APIC in the .config of the kernel are : 
> 
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> 
> I have no idea where these options are in the make menuconfig menu. When I

(c'mon...)
Processor type and features  --->
   Local APIC support on uniprocessors

-- hl


