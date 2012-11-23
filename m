Message-ID: <50AFA44E.4070506@xenomai.org>
Date: Fri, 23 Nov 2012 17:29:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <04934a1da80b9542fe5e0375b07d3663@isir.upmc.fr>
	<50AF48DA.9010200@xenomai.org>
	<80c97c7c58b1c913fd0fb2ec83a86b3d@isir.upmc.fr>
In-Reply-To: <80c97c7c58b1c913fd0fb2ec83a86b3d@isir.upmc.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone from
 Angstrom branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: WONG Sheng Chao <wong@isir.upmc.fr>
Cc: xenomai@xenomai.org

On 11/23/2012 01:35 PM, WONG Sheng Chao wrote:
> On Fri, 23 Nov 2012 10:58:50 +0100, Gilles Chanteperdrix wrote:
>> On 11/23/2012 10:45 AM, WONG Sheng Chao wrote:
>>> Hi
>>>
>>> I am trying to get Xenomai working on the beaglebone (AM3359) and I 
>>> had
>>> been following the instructions from this mailing list
>>>
>>> http://www.xenomai.org/pipermail/xenomai/2012-September/026190.html
>>>
>>> The steps that I went through was such
>>>
>>> 1) I configured the Angstorm distribution with linux kernel 3.2.21 
>>> for
>>> beaglebone using bitbake
>>>
>>> 2) Copied the kernel source from it and saved it as
>>> {original_angstrom_kernel}
>>>
>>> 3) I then ran the patch script from xenomai-2.6.1
>>>
>>> $./prepare-kernel.sh --linux={original_angstrom_kernel} --arch=arm
>>>
>>> --adeos=/xenomai-2.6.1/ksrc/arch/arm/patches/ipipe-core-3.2.21-arm-1.patch
>>>
>>> 4) There were four conflicting files, namely
>>>
>>> arch/arm/common/gic.c
>>> arch/arm/mach-omap2/irq.c
>>> arch/arm/plat-mxc/gic.c
>>> arch/arm/plat-omap/include/plat/irqs.h
>>>
>>> 5) I compared these four files to the vanilla linux-kernel-3.2.21 
>>> and
>>> patch these 4 files individually from {original_angstrom_kernel} 
>>> with
>>> {vanilla-kernel-3.2.21}. Now i save the newly patched kernel source 
>>> as
>>> {pre_patched_original_angstrom_kernel}
>>>
>>> 6) I ran the prepare-kernel script again with the --linux directed 
>>> to
>>> the {pre_patched_original_angstrom_kernel} and the patch went 
>>> through
>>> fine. So now i have a copy of i-pipe patched source
>>> {ipipe_patched_original_angstrom_kernel}
>>>
>>> 7) I proceed with copying the .config function from
>>> arch/arm/configs/omap2plus_defconfig and run the make menuconfig 
>>> with
>>>
>>> $make ARCH=arm CROSS_COMPILE=arm-angstrom-linux-gnueabi- menuconfig
>>>
>>> and save the kernel configuration
>>>
>>> 8) i then proceed to compile the kernel with the following command
>>>
>>> $make ARCH=arm CROSS_COMPILE=arm-angstrom-linux-gnueabi- uImage
>>>
>>> 9) The compilation fails and it gives the following error
>>>
>>>   arch/arm/mach-omap2/devices.c:1096:12: error: 'AM33XX_IRQ_ICSS0_0'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1101:12: error: 'AM33XX_IRQ_ICSS0_1'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1106:12: error: 'AM33XX_IRQ_ICSS0_2'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1111:12: error: 'AM33XX_IRQ_ICSS0_3'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1116:12: error: 'AM33XX_IRQ_ICSS0_4'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1121:12: error: 'AM33XX_IRQ_ICSS0_5'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1126:12: error: 'AM33XX_IRQ_ICSS0_6'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1131:12: error: 'AM33XX_IRQ_ICSS0_7'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1260:12: error: 
>>> 'AM33XX_IRQ_CPSW_C0_RX'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1260:3: error: initializer element 
>>> is
>>> not constant
>>> | arch/arm/mach-omap2/devices.c:1260:3: error: (near initialization 
>>> for
>>> 'am33xx_cpsw_resources[2].start')
>>> | arch/arm/mach-omap2/devices.c:1261:3: error: initializer element 
>>> is
>>> not constant
>>> | arch/arm/mach-omap2/devices.c:1261:3: error: (near initialization 
>>> for
>>> 'am33xx_cpsw_resources[2].end')
>>> | arch/arm/mach-omap2/devices.c:1265:12: error: 
>>> 'AM33XX_IRQ_DMTIMER5'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1265:3: error: initializer element 
>>> is
>>> not constant
>>> | arch/arm/mach-omap2/devices.c:1265:3: error: (near initialization 
>>> for
>>> 'am33xx_cpsw_resources[3].start')
>>> | arch/arm/mach-omap2/devices.c:1266:3: error: initializer element 
>>> is
>>> not constant
>>> | arch/arm/mach-omap2/devices.c:1266:3: error: (near initialization 
>>> for
>>> 'am33xx_cpsw_resources[3].end')
>>> | arch/arm/mach-omap2/devices.c:1270:12: error: 
>>> 'AM33XX_IRQ_DMTIMER6'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1270:3: error: initializer element 
>>> is
>>> not constant
>>> | arch/arm/mach-omap2/devices.c:1270:3: error: (near initialization 
>>> for
>>> 'am33xx_cpsw_resources[4].start')
>>> | arch/arm/mach-omap2/devices.c:1271:3: error: initializer element 
>>> is
>>> not constant
>>> | arch/arm/mach-omap2/devices.c:1271:3: error: (near initialization 
>>> for
>>> 'am33xx_cpsw_resources[4].end')
>>> | arch/arm/mach-omap2/devices.c:1275:12: error: 'AM33XX_IRQ_CPSW_C0'
>>> undeclared here (not in a function)
>>> | arch/arm/mach-omap2/devices.c:1275:3: error: initializer element 
>>> is
>>> not constant
>>> | arch/arm/mach-omap2/devices.c:1275:3: error: (near initialization 
>>> for
>>> 'am33xx_cpsw_resources[5].start')
>>> | arch/arm/mach-omap2/devices.c:1276:3: error: initializer element 
>>> is
>>> not constant
>>> | arch/arm/mach-omap2/devices.c:1276:3: error: (near initialization 
>>> for
>>> 'am33xx_cpsw_resources[5].end')
>>>
>>> I read from this link
>>> http://www.xenomai.org/pipermail/xenomai/2012-July/000476.html that 
>>> for
>>> the kernel to boot properly on the AM3359 two changes needs to be 
>>> made.
>>> I had yet to made these changes as i want to see if the kernel 
>>> source
>>> would compiled and to verify my steps.
>>>
>>> Is my approach correct? Any advice on how to solve this problem?
>>
>> There is no correct approach, there is more than one way to do it. 
>> Does
>> the un-patched kernel compile with the .config you use? If yes, does 
>> the
>> patched kernel compile with CONFIG_IPIPE and CONFIG_XENOMAI disabled?
> 
> 
> Sorry about the private reply Gilles, I clicked the reply button 
> instead of reply all.
> 
> 
> The un-patched kernel compile fine with the original .config.
> 
> The ipipe patched kernel with CONFIG_IPIPE and CONFIG_XENOMAI disable 
> shows the same compilation error as before.

This looks like an error due to some changes made by the I-pipe patch to
the include files. In order to debug this, you have to simply
pre-process the file, and try and understand what happens. If at the top
of the build tree, you run "make arch/arm/mach-omap2/devices.i" with the
proper make variables set, the kernel makefile should generate the
pre-processed file.

-- 
					    Gilles.

