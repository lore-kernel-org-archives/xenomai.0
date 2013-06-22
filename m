MIME-Version: 1.0
In-Reply-To: <CAFNBfteWAvsk9psCpLRV6CrkByUwG43DtjDKNak_BsvDdP+B9g@mail.gmail.com>
References: <51B73421.3050506@siemens.com>
	<CAFNBfte827XTvCApOaGaUYVcj_uLn67Yz5=qBcY4pmAPEHVbvg@mail.gmail.com>
	<CAFNBftfCrsdrbgkfzAr5ngJtYJ2PvPtJZAA1ZdBAongHAdO4xw@mail.gmail.com>
	<51BE9EC9.5090408@web.de>
	<CAFNBfteWAvsk9psCpLRV6CrkByUwG43DtjDKNak_BsvDdP+B9g@mail.gmail.com>
Date: Fri, 21 Jun 2013 22:43:57 -0300
Message-ID: <CAFNBftfN9A_dok_CEXTHG0hXwtLHhCfOrtOWgkfS+QbqeCg_Aw@mail.gmail.com>
From: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Stable update for ipipe-3.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

Hello,

I solved the issue. The compilation error was due missing header
files, due to patch application problems.

Xenomai is running on 3.8.13 kernel.

Best regards,

Flavio


2013/6/18 Flavio Castro Alves Filho <flavio.alves@gmail.com>:
> Hello Jan,
>
> 2013/6/17 Jan Kiszka <jan.kiszka@web.de>:
>> On 2013-06-17 02:17, Flavio Castro Alves Filho wrote:
>>> Hello Jan,
>>>
>>> I tried to build Linux kerne from your ipipe repository but the
>>> compilation crashed, when building for BeagleBone Black.
>>>
>>> During the patch application, I got just one error, with the inclusion
>>> of a #include directive. I solved the problem by hand and then I had
>>> the compilation error.
>>
>> Err, what did you apply against which kernel? The repository is supposed
>> to be used as-is. Or are there still additional, non-upstream patches
>> required for your board?
>
> I apply the patches from meta-beagleboard layer (master branch ... for
> mainline kernel 3.8.13) into your i-pipe repository, branch
> 'for-upstream/3.8'.
>
> I believe the patches are not upstream (There are a lot of patches).
> The compilation error is the following:
>
> flavio@Phi06:/home/prjs/beaglebone/work/ipipe-jki$ make ARCH=arm
> CROSS_COMPILE=arm-angstrom-linux-gnueabi- uImage
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      arch/arm/mach-omap2/gpmc.o
> arch/arm/mach-omap2/gpmc.c: In function 'gpmc_probe_nand_child':
> arch/arm/mach-omap2/gpmc.c:1378:2: error: implicit declaration of
> function 'of_get_nand_bus_width'
> [-Werror=implicit-function-declaration]
> arch/arm/mach-omap2/gpmc.c:1380:29: error: 'NAND_BUSWIDTH_16'
> undeclared (first use in this function)
> arch/arm/mach-omap2/gpmc.c:1380:29: note: each undeclared identifier
> is reported only once for each function it appears in
> arch/arm/mach-omap2/gpmc.c: In function 'gpmc_probe_generic_child':
> arch/arm/mach-omap2/gpmc.c:1455:2: error: implicit declaration of
> function 'of_address_to_resource'
> [-Werror=implicit-function-declaration]
> arch/arm/mach-omap2/gpmc.c:1505:2: error: implicit declaration of
> function 'of_platform_device_create'
> [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[1]: *** [arch/arm/mach-omap2/gpmc.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> flavio@Phi06:/home/prjs/beaglebone/work/ipipe-jki$
>
> I will check this out and inform you.
>
> For kernel 3.8.10, the same procedure worked fine.
>
> Best regards,
>
> Flavio
>
>>
>> Jan
>>
>>>
>>> Unfortunately I had to reboot my machine and I could not give you the
>>> complete feedback. I intend to do that tomorrow. Sorry ...
>>>
>>> Anyway, I would like to provide the feedback.
>>>
>>> Best regards
>>>
>>> Flavio
>>>
>>>
>>> 2013/6/12 Flavio Castro Alves Filho <flavio.alves@gmail.com>:
>>>> Hello,
>>>>
>>>> This weekend I'll try to test it with the current kernel version for
>>>> BeagleBone Black and I'll let you know about the results.
>>>>
>>>> Best regards,
>>>>
>>>> Flavio
>>>>
>>>>
>>>> 2013/6/11 Jan Kiszka <jan.kiszka@siemens.com>:
>>>>> Hi all,
>>>>>
>>>>> I've merged 3.8.13 into our stable 3.8 branch. This triggered some minor
>>>>> conflicts in generic and ARM code. Please see
>>>>>
>>>>> git://git.xenomai.org/ipipe-jki for-upstream/3.8
>>>>>
>>>>> for details. The result works fine for x86, and if it's also OK for the
>>>>> other arch, I'd propose this to be merged into the official 3.8 stable
>>>>> branch.
>>>>>
>>>>> Jan
>>>>>
>>>>> --
>>>>> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
>>>>> Corporate Competence Center Embedded Linux
>>>>>
>>>>> _______________________________________________
>>>>> Xenomai mailing list
>>>>> Xenomai@xenomai.org
>>>>> http://www.xenomai.org/mailman/listinfo/xenomai
>>>>
>>>>
>>>>
>>>> --
>>>> Flavio de Castro Alves Filho
>>>>
>>>> flavio.alves@gmail.com
>>>> www.linuxembarcado.com
>>>> Twitter: http://twitter.com/#!/fraviofii
>>>> LinkedIn profile: www.linkedin.com/in/flaviocastroalves
>>>
>>>
>>>
>>
>>
>
>
>
> --
> Flavio de Castro Alves Filho
>
> flavio.alves@gmail.com
> www.linuxembarcado.com
> Twitter: http://twitter.com/#!/fraviofii
> LinkedIn profile: www.linkedin.com/in/flaviocastroalves



-- 
Flavio de Castro Alves Filho

flavio.alves@gmail.com
www.linuxembarcado.com
Twitter: http://twitter.com/#!/fraviofii
LinkedIn profile: www.linkedin.com/in/flaviocastroalves

