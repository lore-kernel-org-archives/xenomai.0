Message-ID: <45F9124C.1080109@domain.hid>
Date: Thu, 15 Mar 2007 10:30:52 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] kernel building problems with current svn and AT91
References: <45F90CD5.9080701@domain.hid> <45F90F15.90509@domain.hid>
In-Reply-To: <45F90F15.90509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: xenomai@xenomai.org

Steven Scholz wrote:
> I wrote,
> 
>> I just updated to the current xenomai svn.
>>
>> After patching linux 2.6.19 for AT91RM9200 a
>>
>>  make ARCH=arm CROSS_COMPILE=arm-softfloat-linux-gnu- at91rm9200ek_defconfig
>>
>> results in
>> ...
>> file arch/arm/xenomai/Kconfig already scanned?
>> make[1]: *** [at91rm9200ek_defconfig] Error 1
>> make: *** [at91rm9200ek_defconfig] Error 2
> 
> I used
> 
> scripts/prepare-kernel.sh --linux=linux-2.6.19 --arch=arm
> --outpatch=xenomai-svn-2007-03-15-2.6.19-arm.patch tmp/ --verbose
> 
> 
> to generate the patch.
> 
> And the patch contains duplicate lines like
> 
> --- linux/arch/arm/Makefile	2006-11-29 22:57:37.000000000 +0100
> +++ linux-patched/arch/arm/Makefile	2007-03-15 10:01:23.000000000 +0100
> @@ -236,3 +236,13 @@
>    echo  '                  (distribution) /sbin/installkernel or'
>    echo  '                  install to $$(INSTALL_PATH) and run lilo'
>  endef
> +
> +drivers-$(CONFIG_XENOMAI) += arch/arm/xenomai/
> +
> +drivers-$(CONFIG_XENOMAI) += arch/arm/xenomai/
> +
> +drivers-$(CONFIG_XENOMAI) += arch/arm/xenomai/
> +
> +drivers-$(CONFIG_XENOMAI) += arch/arm/xenomai/
> +
> +drivers-$(CONFIG_XENOMAI) += arch/arm/xenomai/
> 
> and the whole block "menu "Real-time sub-system" in init/KConfig appears
> five times!

Nevermind!!!

I did not realize that I have to clean the tmp/ dir before creating a new
patch using --outpatch!!!

Steven

