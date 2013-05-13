Message-ID: <5190CCF5.6040203@xenomai.org>
Date: Mon, 13 May 2013 13:22:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <516BA4E9.3070201@xenomai.org>	<90FBAEE5-D70C-4563-B9DB-776D6E4E7FA9@kabelmail.de>	<516D933F.8060502@xenomai.org>	<F484004F-9908-449C-A4DA-CB73E47EE764@kabelmail.de>	<5182B1B5.1000107@xenomai.org>	<12E434B4-4F26-44AC-8D50-2CF70B5089E1@kabelmail.de>	<5183FFB3.1000006@xenomai.org>	<8D9AB79C-4A66-4511-B08B-ACF825FED1BF@kabelmail.de>	<518A98F5.30000@xenomai.org>	<0ECFC8C0-CF1D-4D65-9724-B0A1A91887DC@kabelmail.de>	<518CF43E.3080601@xenomai.org>	<5F179C54-A023-4C27-9082-13195B16B9BB@kabelmail.de>	<518D07BB.1060900@xenomai.org>	<A359148C-7FCB-4D8C-A5DC-461065767DDA@kabelmail.de>
	<518D24E8.6070305@xenomai.org> <518D2815.7000602@xenomai.org>
	<19C79116-400B-4A5C-BFDA-87EEF8799554@kabelmail.de>
In-Reply-To: <19C79116-400B-4A5C-BFDA-87EEF8799554@kabelmail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raspberry and Beaglebone patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: Xenomai <xenomai@xenomai.org>

On 05/13/2013 12:37 PM, Stephan Kappertz wrote:

> Am 10.05.2013 um 19:02 schrieb Gilles Chanteperdrix:
> 
>> On 05/10/2013 06:48 PM, Gilles Chanteperdrix wrote:
>> 
>>> On 05/10/2013 06:40 PM, Stephan Kappertz wrote:
>>> 
>>>>>>> 
>>>>>> 
>>>>>> I'm using your git repository directly. Applied my
>>>>>> post.patch and compiled the kernel. So this is 3.8.0. Looks
>>>>>> like my Xenomai user space compile was broken. Still
>>>>>> working on fixing it.
>>>>> 
>>>>> 
>>>>> What options did you pass to the configure script?
>>>>> 
>>>>> 
>>>>> -- Gilles.
>>>>> 
>>>> 
>>>> ../configure --target=arm-buildroot-linux-uclibcgnueabi
>>>> --host=arm-buildroot-linux-uclibcgnueabi
>>>> --build=i686-pc-linux-gnu --prefix=/usr --exec-prefix=/usr
>>>> --sysconfdir=/etc --program-prefix="" --enable-static
>>>> --enable-shared  CFLAGS="-march=armv7-a -mfpu=vfp3"
>>>> LDFLAGS="-march=armv7-a -mfpu=vfp3"
>>>> --includedir=/usr/include/xenomai/
>>>> 
>>>> This is a buildroot build.
>>> 
>>> 
>>> Could you: - tell me what version of gcc, binutils, etc... you
>>> use? - show me a disassembly of the xeno_bind_skip_opt function
>>> in libxenomai.so? - instrument the function xeno_sigill_handler
>>> in src/skins/common/bind.c to see if you are indeed taking the
>>> SIGILL signal?
>> 
>> 
>> Sorry, you do not take the SIGILL handler, please instrument 
>> xeno_bind_skin_opt to print the value of "muxid" returned by the 
>> XENOMAI_SYSBIND system call.
>> 
>> -- Gilles.
>> 
> 
> 
> Ok, here's the compiler spec:
> 
> $ arm-linux-gnueabi-gcc -v Using built-in specs. 
> COLLECT_GCC=arm-linux-gnueabi-gcc 
> COLLECT_LTO_WRAPPER=/usr/lib/gcc/arm-linux-gnueabi/4.6/lto-wrapper 
> Target: arm-linux-gnueabi Configured with: ../src/configure -v
> --with-pkgversion='Ubuntu/Linaro 4.6.3-1ubuntu5'
> --with-bugurl=file:///usr/share/doc/gcc-4.6/README.Bugs
> --enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/usr
> --program-suffix=-4.6 --enable-shared --enable-linker-build-id
> --with-system-zlib --libexecdir=/usr/lib --without-included-gettext
> --enable-threads=posix
> --with-gxx-include-dir=/usr/arm-linux-gnueabi/include/c++/4.6.3
> --libdir=/usr/lib --enable-nls --enable-clocale=gnu
> --enable-libstdcxx-debug --enable-libstdcxx-time=yes
> --enable-gnu-unique-object --enable-plugin --enable-objc-gc
> --enable-multilib --disable-sjlj-exceptions --with-arch=armv7-a
> --with-float=softfp --with-fpu=vfpv3-d16 --with-mode=thumb
> --disable-werror --enable-checking=release --build=i686-linux-gnu
> --host=i686-linux-gnu --target=arm-linux-gnueabi
> --program-prefix=arm-linux-gnueabi-
> --includedir=/usr/arm-linux-gnueabi/include
> --with-headers=/usr/arm-linux-gnueabi/include
> --with-libs=/usr/arm-linux-gnueabi/lib Thread model: posix gcc
> version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
> 
> Binutils are 2.22:
> 
> arm-linux-gnueabi-as -v GNU assembler version 2.22
> (arm-linux-gnueabi) using BFD version (GNU Binutils for Ubuntu) 2.22
> 
> 
> Now what's interesting is: as soon as I am adding an instrumentation
> "fprintf(stdout, "Xenomai: xeno_bind_skin_opt muxid = %d\n", muxid);"
> to "static inline int xeno_bind_skin(unsigned skin_magic, const char
> *skin, const char *module)", binding succeeds and all xeno-test pass.
> The other option to get it work was:  declaring "int
> xeno_bind_skin(unsigned skin_magic, const char *skin, const char
> *module);" in bind.h and defining it in bind.c.
> 
> If I'm only instrumenting xeno_bind_skin_opt(), I see that it never
> gets called in the original code.
> 
> Do you still want to see the disassembly?


Are you using a dynamic or static build of xenomai? If dynamic, could
you put
libxenomai.so and libnative.so somewhere where I could download them? If
static, could you make "arith" somewhere where I could download it?

Also, I am interested in your kernel configuration.

-- 
                                                                Gilles.

