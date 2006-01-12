Message-ID: <43C67EE5.1040301@domain.hid>
Date: Thu, 12 Jan 2006 17:08:05 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <43C61CC6.5090802@domain.hid> <43C638B1.2050607@domain.hid>
In-Reply-To: <43C638B1.2050607@domain.hid>
Content-Type: multipart/mixed; boundary="------------090904060300010903050504"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090904060300010903050504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Wolfgang Grandegger wrote:
> 
>> Hi Philippe,
>>
>> I just realized that recent changes in ksrc/arch/powerpc/switch.S have 
>> broken the build of Xenomai with linuxppc_2_4_devel on PPC:
>>
>>  #include <asm/offsets.h> does not exist
>>  Symbols like SAVE_NVGPRS do not exist
>>
> 
> Fixed.

Thanks. Attached is a little patch fixing a build problem with Linux 
2.6.14 for PowerPC (ocotea, AMCC 440GX). But I'm not sure when exactly 
the change happened.

>> For the time being, I will stick with an older version for testing 
>> RTnet (where I'm currently debugging "floating point used in kernel" 
>> errors on the MPC8260),
>>
>> Thanks.
>>
>> Wolfgang.
>>
> 
> 


--------------090904060300010903050504
Content-Type: text/x-patch;
 name="linux-2.6.14-ipipe-wrapper.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.14-ipipe-wrapper.patch"

+ diff -u linux-2.6.14-ipipe/include/asm-generic/xenomai/wrappers.h.ORIG1 linux-2.6.14-ipipe/include/asm-generic/xenomai/wrappers.h
--- linux-2.6.14-ipipe/include/asm-generic/xenomai/wrappers.h.ORIG1	2006-01-12 16:13:28.958070000 +0100
+++ linux-2.6.14-ipipe/include/asm-generic/xenomai/wrappers.h	2006-01-12 16:56:08.623129271 +0100
@@ -150,7 +150,7 @@
 /* Device registration */
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,13)
 #define DECLARE_DEVCLASS(clname) struct class *clname
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,14)
 #define wrap_class_device_create class_device_create
 #else /* < 2.6.15 */
 #define wrap_class_device_create(c,p,dt,dv,fmt,args...) class_device_create(c,dt,dv,fmt , ##args)

--------------090904060300010903050504--

