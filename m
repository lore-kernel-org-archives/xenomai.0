Date: Wed, 3 Feb 2016 08:33:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160203073322.GF18030@hermes.click-hack.org>
References: <8db451acc3862440f398037d839fe83@cweb14.nm.nhnsystem.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8db451acc3862440f398037d839fe83@cweb14.nm.nhnsystem.com>
Subject: Re: [Xenomai] ubuntu15.04 - xenomai3.0.1 - kernel 3.18.20 - build
 error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?67CV7J6s7ZmN?= <1805pjh@naver.com>
Cc: xenomai@xenomai.org

On Wed, Feb 03, 2016 at 03:45:05PM +0900, 박재홍 wrote:
> ﻿hello
>  
> after ipipe patched,  build error  
>  
>  
> # cd linux-3.18.20
>  
> # ../xenomai-3.0.1/scripts/prepare-kernel.sh --arch=x86_64 --ipipe=../ipipe-core-3.18.20-x86-4.patch
>  
> # make menuconfig 
> -&gt; "Power Management and ACPI options" -- "CPU Frequency scaling" -- "CPU Frequency scaling"
> -&gt; "Power Management and ACPI options" -- "ACPI(~) Support" -- "Processor"
> -&gt; "Power Management and ACPI options" -- "Cpuidle Driver for Intel Processors"
> -&gt; "Power Management and ACPI options" -- "CPU idle PM Support"
> -&gt; "Bus options(PCI etc.)" -- "Message Signaled Interrupts (MSI and MSI-X)"
> -&gt; "Device Drivers" -- "Input device support" -- "Miscellaneous devices" -- "PC Speaker support"
> all disabled
>  
> #make
>  
> ##################error###############################################3
>  
>   CC [M]  drivers/net/wireless/rtlwifi/rtl8192ee/trx.o
>   CC [M]  drivers/staging/unisys/uislib/uisutils.o
>   CC [M]  drivers/usb/misc/lvstest.o
>   CC [M]  drivers/uwb/umc-drv.o
>   CC [M]  drivers/staging/speakup/thread.o
>   CC [M]  drivers/uwb/whci.o
>   CC [M]  drivers/net/wireless/rtlwifi/rtl8192se/sw.o
> drivers/staging/unisys/uislib/uisutils.c: In function ‘uisctrl_register_req_handler’:
> drivers/staging/unisys/uislib/uisutils.c:101:8: error: ‘VERSION’ undeclared (first use in this function)
>         VERSION, NULL);
>         ^
> drivers/staging/unisys/uislib/uisutils.c:101:8: note: each undeclared identifier is reported only once for each function it appears in
> drivers/staging/unisys/uislib/uisutils.c: In function ‘uisctrl_register_req_handler_ex’:
> drivers/staging/unisys/uislib/uisutils.c:154:19: error: ‘VERSION’ undeclared (first use in this function)
>          "uislib", VERSION, NULL);
>                    ^
> scripts/Makefile.build:257: recipe for target 'drivers/staging/unisys/uislib/uisutils.o' failed
> make[5]: *** [drivers/staging/unisys/uislib/uisutils.o] Error 1
> scripts/Makefile.build:402: recipe for target 'drivers/staging/unisys/uislib' failed
> make[4]: *** [drivers/staging/unisys/uislib] Error 2
> scripts/Makefile.build:402: recipe for target 'drivers/staging/unisys' failed
> make[3]: *** [drivers/staging/unisys] Error 2
> make[3]: *** 끝나지 않은 작업을 기다리고 있습니다....
>   CC [M]  drivers/net/wireless/rtlwifi/rtl8192se/table.o
>   CC [M]  drivers/staging/speakup/varhandlers.o
>   CC [M]  drivers/staging/rtl8723au/os_dep/usb_intf.o
>   CC [M]  drivers/usb/misc/sisusbvga/sisusb.o
>   LD [M]  drivers/net/wireless/rtlwifi/rtl8192ee/rtl8192ee.o
>   CC [M]  drivers/usb/misc/sisusbvga/sisusb_init.o
>   CC [M]  drivers/usb/misc/sisusbvga/sisusb_con.o
>  
> ########################################################################################
>  
> help me please

Hi,

assuming you do not need it, could you try and disable the option:
CONFIG_UNISYSSPAR
?

Regards.

-- 
					    Gilles.
https://click-hack.org

