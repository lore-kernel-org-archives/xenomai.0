MIME-Version: 1.0
In-Reply-To: <CAHZXL1MbwU6y-yAnPyVx3CNJuOOJk3VqiJs3MunXQeJPRcRxpA@mail.gmail.com>
References: <CALRX=SG7y+x_+-L57YFqtcM=HECp0USEZ=6i0aDBjTuy4XHxjg@mail.gmail.com>
 <CAHZXL1MbwU6y-yAnPyVx3CNJuOOJk3VqiJs3MunXQeJPRcRxpA@mail.gmail.com>
Date: Thu, 29 Jan 2015 16:18:25 +0100
Message-ID: <CALRX=SGC2+Eebp945gSGCnNa-f_KjC_XmnewbvK0g19--2Gxng@mail.gmail.com>
From: Giovanni Balestrieri <balestrieri.gepp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Error building Linux 3.8.13 with Xenomai 2.6.4 patch
 using Buildroot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Letec 64 <letec64@gmail.com>
Cc: xenomai@xenomai.org

Thank you for the links, the tutorials don't use Buildroot. Can I build the
system with Buildroot and compile the kernel separately?


2015-01-29 15:06 GMT+01:00 Letec 64 <letec64@gmail.com>:

> Hello
> try to check this:
> http://wiki.linuxcnc.org/cgi-bin/wiki.pl?RaspbianXenomaiBuild
> and this:
> https://code.google.com/p/picnc/wiki/RPiXenomaiKernel
> I used it some month ago with success
>
> Now I wondering how to build Xenomai for BananaPI, but it looks like
> Allwinner A20 is not supported yet.
> Petr
>
> On Thu, Jan 29, 2015 at 2:46 PM, Giovanni Balestrieri <
> balestrieri.gepp@gmail.com> wrote:
>
>> Hi,
>> I would like to build a system, for a Raspberry Pi, with Xenomai real ti=
me
>> features using Buildroot. I'm following the steps provided by this link:
>>
>> http://www.xenomai.org/pipermail/xenomai/2014-March/030412.html
>>
>> I don't know how to apply the patches in the correct order using
>> Buildroot.
>> This order should work.
>>
>> patch -Np1 <
>> ../xenomai-2.6.3/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspb=
erry-pre-2.patch
>> ../xenomai-2.6.3/scripts/./prepare-kernel.sh --arch=3Darm --linux=3D./
>>
>> --adeos=3D../xenomai-2.6.3/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-3=
.patch
>> patch -Np1 <
>> ../xenomai-2.6.3/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspb=
erry-post-2.patc
>>
>> I've tried with the configuration at the end of the message but the
>> compilation ends with 2 errors.
>>
>> *The Problem:*
>>
>>
>> During the compilation of the kernel I get the following errors:
>> [...]
>>                  from kernel/xenomai/nucleus/heap.c:67:
>> include/asm-generic/xenomai/syscall.h: In function
>> =E2=80=98__xn_safe_strncpy_from_user=E2=80=99:
>> include/asm-generic/xenomai/syscall.h:147:2: error: implicit declaration
>> of
>> function =E2=80=98__strncpy_from_user=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
>> cc1: some warnings being treated as errors
>> make[4]: *** [kernel/xenomai/nucleus/bufd.o] Error 1
>> make[4]: *** Waiting for unfinished jobs....
>> [...]
>>   AS      arch/arm/lib/getuser.o
>> cc1: some warnings being treated as errors
>> make[4]: *** [kernel/xenomai/nucleus/heap.o] Error 1
>> make[3]: *** [kernel/xenomai/nucleus] Error 2
>> make[2]: *** [kernel/xenomai] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>> [...]
>>   CC      lib/bitmap.o
>> make[1]: *** [kernel] Error 2
>> make[1]: *** Waiting for unfinished jobs....
>> cc1: some warnings being treated as errors
>> make[4]: *** [drivers/xenomai/testing/switchtest.o] Error 1
>> make[4]: *** Waiting for unfinished jobs....
>>   AS      arch/arm/lib/testsetbit.o
>> [...]
>>   CC      net/ipv4/route.o
>> cc1: some warnings being treated as errors
>> make[4]: *** [drivers/xenomai/testing/timerbench.o] Error 1
>> make[3]: *** [drivers/xenomai/testing] Error 2
>> make[2]: *** [drivers/xenomai] Error 2
>> make[1]: *** [drivers] Error 2
>>   CC      net/dns_resolver/dns_query.o
>> [...]
>>   LD      net/built-in.o
>> make[1]: Leaving directory
>>
>> `/home/userk/Development/Linux/RaspberryPi/buildroot-2013.11/output/buil=
d/linux-d996a1b'
>> make: ***
>>
>> [/home/userk/Development/Linux/RaspberryPi/buildroot-2013.11/output/buil=
d/linux-d996a1b/.stamp_built]
>> Error 2
>>
>> *The Configuration of Buildroot:*
>>
>> I've specified in the Buildroot configuration files the following option=
s.
>> (In bold the options related to the patches)
>>
>> Target Options
>>
>>    - Target Architecture: ARM (little endian)
>>    - Target Architecture Variant: arm1176jzf-s
>>    - Target ABI: EABI
>>    - Floating point strategy: VFPv2
>>    - ARM instruction set: ARM
>>
>> Toolchain:
>>
>>    - Toolchain type: Buildroot toolchain
>>    - Kernel Headers: Linux 3.10.X kernel headers
>>    - C libary: uClibc
>>    - uClibc C library Version: uClibc 0.9.33.X
>>    - GCC compiler Version:  4.7.X
>>    - Enable C++ support
>>
>> Kernel:
>>
>>    - Kernel version: Kernel version (Custom Git repository)
>>    (git://github.com/raspberrypi/linux.git) URL of custom repository
>>        (*d996a1b*) Custom repository version
>>    Custom Kernel Patches
>>    (../Xenomai-RPI/xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/
>>    *ipipe-core-3.8.13-raspberry-pre-2.patch*
>>    ../Xenomai-RPI/xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/
>>    *ipipe-core-3.8.13-raspberry-post-2.patch*)
>>    - Kernel configuration: Using a defconfig
>>    - Defconfig name: bcmrpi_quick
>>    - Kernel binary format: zImage
>>    - Linux Kernel Extensions
>>     [*] Adeos/Xenomai Real-time patch
>>    (../Xenomai-RPI/xenomai-2.6.4/ksrc/arch/arm/patches/
>>    *ipipe-core-3..8.13-arm-4.patch*)
>>     [ ] RTAI Real-time patch
>>
>> Target Packages
>>
>>    - (*) Xenomai Userspace
>>          (2.6.4) Custom Xenomai version
>>          [*]   Install testsuite
>>          [ ]   RTCan utilities
>>          [ ]   Analogy libs and utils
>>          [*]   Native skin library
>>          [*]   POSIX skin library
>>
>>
>> Is the problem related to a bad configuration of Buildroot?
>>
>> Thank you very much,
>> GB
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
>
>
