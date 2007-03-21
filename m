Message-ID: <4601554E.5040302@domain.hid>
Date: Wed, 21 Mar 2007 16:54:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
References: <032120071354.7273.46013902000B45CE00001C692212020784070E0301020A98@domain.hid>
In-Reply-To: <032120071354.7273.46013902000B45CE00001C692212020784070E0301020A98@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: xenomai@domain.hid
Cc: xenomai@xenomai.org

xenomai@domain.hid wrote:
> Hello,
> 
> Just to give you a little background, I am a software engineer with alot of experience in VxWorks.  I am currently investigating moving a large, high speed, data aquisition system from a multi single board computer, VME based system over to a PC with a PCI-Express expansion bus and create a portable slimmed down version.  While the time constraints I have are in the 10s of microseconds, I do have a need for consistency.  I have some experience with eCos but would like the bennefits that linux will offer.
> 
> I have a need for the same software work in various configurations in both a server configuration and a portable configuration.  The systems that I have are as follows :
> 
> Dell Precision M65 Laptop with 2.16ghz dual core processor
>    4gb memory
>   Nvidia Quadro FX350 Graphics
>    SATA disk
>    Configuration 1 :
>         Docking station containing Pentek 7131 Digital Receiver
>    Configuration 2:
>         ExpressCard expansion chassis containing multiple Pentek 7131 Digial Receivers
>                                  and IOTech 2100 Data Digital/Analog I/O cards
>   
> Dell Precision 690 with 2 Dual core 5160 3ghz Processors (Woodcrest)
>   8gb memory
>   Nvidia Quadro 4500 
>   Multiple 15k SAS disks with both Perc5E and/or LSI Logic 8580E SAS Controller
>   Multiple slot expansion chassis connected 8x to the server containing multiple cards
> 
> I have tried the RTAI approach with little success and have since
> switched to Xenomai with limited success. I currently am using the
> 2.6.17 kernel due to no success with patching the .19 kernel.
> When patching the .19 kernel for some reason the Real Time menu in
> the configuration contains only the APM/ACPI warning and no menu
> options  there were however no errors when patching.

Could you send us the .config which leads to this situation ?

> For the 2.6.17 kernel installation was fairly smooth but with one
> hiccup.  For some reason, the patch did not add CONFIG_X86_TCS
> to the configuration.

I assume you are talking about the CONFIG_X86_TSC option. The reason why
CONFIG_X86_TSC is not set is usually that you are configuring the kernel
for a processor without tsc, for instance 486 or pentium.

Here again, sending your .config would help us.

> I added it manually by editing /arch/i386/Kconfig and adding an entry
> for X86_TCS.  This allowed me to successfully run the tests supplied
> with the Xenomai distribution.

No, you should not have to do this. The fact that you have to manually
modify arch/i386/Kconfig should ring a bell: you are doing something wrong.



> All the above has been done on the M65 Laptop which does have an
> ICH7 chipset.  I have tried both SMI enabled and disabled (ACPI
> SMI must remain enabled inorder for video to work) with no change
> in performance.  APM and CPU Freq scaling are disabled as well as
> ACPI Processor.  In this configuration the tests would run to
> completion but with disturbing results.  About ever 8-10 seconds
> the latency goes from somewhere between 1-50 micro seconds to over
> 700 microseconds.  (I'm assuming the output is in microseconds).
> It continues this in a very predictable manner.

This really looks like the TCO interrupt. Could you check that the SMI
workaround does not display a message "SMI workaround failed!" when
starting Xenomai nucleus?

> I have read the
> mailing list and have tried what others have recommended with no
> change at all.  (Shared memory is enabled).  Also, occasionally
> when I run the tests while running an X server it hard hangs the
> system.  I am not expecting the same type of problems to present
> themselves on my Server but I have a very large interest in
> getting a portable system working.

This is abnormal. Do your keyboard leds blink ?

> Are there any hard and fast configurations that I should try?
> Is there a repository of .config files for differen
> kernel/hardware configurations?
> 
> Thanks in advance for your help.  If all goes well, I hope to
> return the favor to those who can bennefit from my experience.

The configuration which should work for Xenomai configuration items is
the default configuration. If it does not work, then you came to the
right place.

-- 
                                                 Gilles Chanteperdrix

