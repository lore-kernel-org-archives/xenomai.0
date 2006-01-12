Message-ID: <43C6A3B9.2070109@domain.hid>
Date: Thu, 12 Jan 2006 19:45:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43C61CC6.5090802@domain.hid> <43C638B1.2050607@domain.hid>
	<43C67EE5.1040301@domain.hid>
In-Reply-To: <43C67EE5.1040301@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Xenomai broken on Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> Philippe Gerum wrote:
> 
>> Wolfgang Grandegger wrote:
>>
>>> Hi Philippe,
>>>
>>> I just realized that recent changes in ksrc/arch/powerpc/switch.S 
>>> have broken the build of Xenomai with linuxppc_2_4_devel on PPC:
>>>
>>>  #include <asm/offsets.h> does not exist
>>>  Symbols like SAVE_NVGPRS do not exist
>>>
>>
>> Fixed.
> 
> 
> Thanks. Attached is a little patch fixing a build problem with Linux 
> 2.6.14 for PowerPC (ocotea, AMCC 440GX). But I'm not sure when exactly 
> the change happened.
>

Looks like specific to 2.6.14-DENX (kernel.org shows the additional "parent" 
parameter only starting with 2.6.15).
http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git;a=blobdiff;h=a9e72ac3fb9fd066ebc5607bd28cfdd4ba8f010e;hp=95d607a48f06edd22c6be64e0feaf74d1aa63467;hb=3692e2d8099f19a4d1ff95df94cc82b394f86931;f=include/linux/device.h

We likely need to find a way to specifically identify this tree.

>>> For the time being, I will stick with an older version for testing 
>>> RTnet (where I'm currently debugging "floating point used in kernel" 
>>> errors on the MPC8260),
>>>
>>> Thanks.
>>>
>>> Wolfgang.
>>>
>>
>>
> 
> 
> ------------------------------------------------------------------------
> 
> + diff -u linux-2.6.14-ipipe/include/asm-generic/xenomai/wrappers.h.ORIG1 linux-2.6.14-ipipe/include/asm-generic/xenomai/wrappers.h
> --- linux-2.6.14-ipipe/include/asm-generic/xenomai/wrappers.h.ORIG1	2006-01-12 16:13:28.958070000 +0100
> +++ linux-2.6.14-ipipe/include/asm-generic/xenomai/wrappers.h	2006-01-12 16:56:08.623129271 +0100
> @@ -150,7 +150,7 @@
>  /* Device registration */
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,13)
>  #define DECLARE_DEVCLASS(clname) struct class *clname
> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15)
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,14)
>  #define wrap_class_device_create class_device_create
>  #else /* < 2.6.15 */
>  #define wrap_class_device_create(c,p,dt,dv,fmt,args...) class_device_create(c,dt,dv,fmt , ##args)


-- 

Philippe.

