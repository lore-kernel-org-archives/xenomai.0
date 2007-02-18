Message-ID: <45D868C5.3000307@domain.hid>
Date: Sun, 18 Feb 2007 15:55:01 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] buildbot: how to setup for ppc with 2.6.19 kernel?
References: <200702181351.53069.niklaus.giger@domain.hid>
In-Reply-To: <200702181351.53069.niklaus.giger@domain.hid>
Content-Type: multipart/mixed; boundary="------------020903060303050708060007"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020903060303050708060007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Niklaus Giger wrote:
> Hi
> 
> Compiling ppc fails for me with 2.6.19 kernels. 
> ( I compile on a Pegasos PPC 601 Debian Linux).
> 
> If I use ARCH=ppc then I get the following error:
>>   CHK     include/linux/version.h
>>   CHK     include/linux/utsrelease.h
>>   CHK     include/linux/compile.h
>> gcc: include/asm/byteorder.h: No such file or directory

Hmm, strange.

>> gcc: no input files
>>   CC      arch/ppc/xenomai/hal.o
>> arch/ppc/xenomai/hal.c: In function 'rthal_arch_init':
>> arch/ppc/xenomai/hal.c:353: error: invalid type argument of '->'
>> make[1]: *** [arch/ppc/xenomai/hal.o] Fehler 1

That looks like an altivec problem. Does the attached patch for Xenomai 
help?

> Trying to use ARCH=powerpc fails already while configuring the kernel
> like this:
>>  make ARCH=powerpc menuconfig
>>   HOSTCC  scripts/kconfig/mconf.o
>>   HOSTLD  scripts/kconfig/mconf
>> scripts/kconfig/mconf arch/powerpc/Kconfig
>> init/Kconfig:564:warning: 'select' used by config symbol 'XENOMAI' refer to
>> undefined symbol 'IPIPE' #
>> # configuration written to .config
>> #
> And a make gives me
>>  make ARCH=powerpc menuconfig
>>   HOSTCC  scripts/kconfig/mconf.o
>>   HOSTLD  scripts/kconfig/mconf
>> scripts/kconfig/mconf arch/powerpc/Kconfig
>> init/Kconfig:564:warning: 'select' used by config symbol 'XENOMAI' refer to
>> undefined symbol 'IPIPE' #
>> # configuration written to .config
>> #

The powerpc tree is not yet supported.

> What is wrong? Did I miss something in my setup? Wrong config?

Seems to be an untested configuration!?

Wolfgang.

--------------020903060303050708060007
Content-Type: text/x-patch;
 name="xenomai-altivec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-altivec.patch"

+ diff -u xenomai/ksrc/arch/powerpc/hal.c.OLD xenomai/ksrc/arch/powerpc/hal.c
--- xenomai/ksrc/arch/powerpc/hal.c.OLD	2007-02-18 15:25:24.000000000 +0100
+++ xenomai/ksrc/arch/powerpc/hal.c	2007-02-18 15:46:17.000000000 +0100
@@ -347,11 +347,7 @@
 int rthal_arch_init(void)
 {
 #ifdef CONFIG_ALTIVEC
-#ifdef CONFIG_PPC64
     if (!(cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)) {
-#else /* !CONFIG_PPC64 */
-    if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)) {
-#endif /* CONFIG_PPC64 */
         printk
             ("Xenomai: ALTIVEC support enabled in kernel but no hardware found.\n"
              "         Disable CONFIG_ALTIVEC in the kernel configuration.\n");

--------------020903060303050708060007--

