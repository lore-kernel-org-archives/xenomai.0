Message-ID: <4B4B7062.9070203@domain.hid>
Date: Mon, 11 Jan 2010 19:39:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1aa9845a1001110940o6bab200apde40348cc8e21bca@domain.hid>
	<4B4B6DDA.6090205@domain.hid>
In-Reply-To: <4B4B6DDA.6090205@domain.hid>
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

Gilles Chanteperdrix wrote:
> Saravanan S wrote:
>> Hi,
>>
>> I am trying to install xenomai on a Dell Poweredge server (R710).The 
>> platform details are given below:
>>
>> Two quad Intel(8 cores) Xeon E5506@domain.hid 6,RAM-16
>> GB,uses SAS disks through a SAS Host Bus Adapter(HBA).
>>
>> Drivers for this HBA only available from fedora 10 onwards.
>>
>> So I patched xenomai  2.4.10 with linux 2.6.29.4 with fedora 11 as
>> the host OS.I used fedora 11 config file.I made the following changes
>> to the config file
>>
>> 1.In processor types and features: architecture->Core2/Newer Xeon, 
>> subarchitecture->Generic, thermal throttling disabled,HPET support
>> enabled
>>
>> 2.Power management stopped.
> 
> Bad. You should enable ACPI, only CONFIG_ACPI_PROCESSOR should be disabled.
> 
>> 3.Support for PCI hotplug disabled.
>>
>> 4.MSI,MSI-X disabled.
> 
> No reason to do this. If you enable these options and get problems,
> please isolate the option which causes a problem and report.
> 
>> 5.In real time subsystem all options selected.
> 
> Please keep the default settings for a first run, verify that it works,
> then enable the options you want (all of them if you want), if it does
> not work, then isolate the option which is the cause of the problem.
> 
>> 6.SMP support enabled
>>
>> 7.MTD support disabled
>>
>> 8.All other default options.
>>
>> After making and installing the modules ,when i selected the xenomai
>> kernel on rebooting it didnt boot at all.There was just a blinking
>> cursor on the screen.
> 
> Did you rebuild your OS (which is it anyway ?) initramfs/initrd? If you
> do the same procedure without activating CONFIG_IPIPE and
> CONFIG_XENOMAI, do you get

... the same behaviour?

> (snip)
> - when building a linux 2.6 kernel, you do not need to run make clean
> before building the kernel, actually, it is a waste of time
> - the list of options to disable to run with xenomai is extravagant too:
> you should not disable power management, you should enable ACPI, and the
> MSI and MSI-X should work
> CardBus should work
> I suspect Toshiba and Dell laptop support should work
> PCI hotplug should work
> MTD should work (and actually works on embedded platforms with MTD devices)
> Fusion MPT should work
> I2O should work
> ISDN should work

Systematically disabling the SMIs is not a good idea either, what to do
is documented in the TROUBLESHOOTING guide in Xenomai sources distribution.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

