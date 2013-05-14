Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Stephan Kappertz <stephan.kappertz@kabelmail.de>
In-Reply-To: <519219C0.9000209@xenomai.org>
Date: Tue, 14 May 2013 13:19:55 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFFF25D8-A98A-48F1-89C6-B7DCC7B76209@kabelmail.de>
References: <516BA4E9.3070201@xenomai.org> <516D933F.8060502@xenomai.org>
	<F484004F-9908-449C-A4DA-CB73E47EE764@kabelmail.de>
	<5182B1B5.1000107@xenomai.org>
	<12E434B4-4F26-44AC-8D50-2CF70B5089E1@kabelmail.de>
	<5183FFB3.1000006@xenomai.org>
	<8D9AB79C-4A66-4511-B08B-ACF825FED1BF@kabelmail.de>
	<518A98F5.30000@xenomai.org>
	<0ECFC8C0-CF1D-4D65-9724-B0A1A91887DC@kabelmail.de>
	<518CF43E.3080601@xenomai.org>
	<5F179C54-A023-4C27-9082-13195B16B9BB@kabelmail.de>
	<518D07BB.1060900@xenomai.org>
	<A359148C-7FCB-4D8C-A5DC-461065767DDA@kabelmail.de>
	<518D24E8.6070305@xenomai.org> <518D2815.7000602@xenomai.org>
	<19C79116-400B-4A5C-BFDA-87EEF8799554@kabelmail.de>
	<41BEC449-99F8-4C31-AA75-B98690DB3F23@kabelmail.de>
	<5191DC82.6090509@xenomai.org>
	<E7E166CE-6815-443A-AC5A-D8B103122CE5@kabelmail.de>
	<5191ED8D.90105@xenomai.org>
	<42470BFE-71B5-41BD-9A90-EA3ACF1D1C1C@kabelmail.de>
	<519201D7.6050800@siemens.com>
	<BBCD4113-6506-4F69-9E29-AC39CBD5686C@kabelmail.de>
	<51921369.4000703@siemens.com> <51921! 9C0.9000209@xenomai.org>
Subject: Re: [Xenomai] Raspberry and Beaglebone patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>


Am 14.05.2013 um 13:02 schrieb Gilles Chanteperdrix:

> On 05/14/2013 12:35 PM, Jan Kiszka wrote:
>=20
>> On 2013-05-14 11:44, Stephan Kappertz wrote:
>>>=20
>>> Am 14.05.2013 um 11:20 schrieb Jan Kiszka:
>>>=20
>>>> On 2013-05-14 11:11, Stephan Kappertz wrote:
>>>>>=20
>>>>> Am 14.05.2013 um 09:53 schrieb Gilles Chanteperdrix:
>>>>>=20
>>>>>> On 05/14/2013 09:33 AM, Stephan Kappertz wrote:
>>>>>>=20
>>>>>>>=20
>>>>>>> Am 14.05.2013 um 08:41 schrieb Gilles Chanteperdrix:
>>>>>>>=20
>>>>>>>> On 05/13/2013 01:20 PM, Stephan Kappertz wrote:
>>>>>>>>=20
>>>>>>>>> Am 13.05.2013 um 12:37 schrieb Stephan Kappertz:
>>>>>>>>>=20
>>>>>>>>>> Am 10.05.2013 um 19:02 schrieb Gilles Chanteperdrix:
>>>>>>>>>>=20
>>>>>>>>>>> On 05/10/2013 06:48 PM, Gilles Chanteperdrix wrote:
>>>>>>>>>>>=20
>>>>>>>>>>>> On 05/10/2013 06:40 PM, Stephan Kappertz wrote:
>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> I'm using your git repository directly. Applied my =
post.patch and
>>>>>>>>>>>>>>> compiled the kernel. So this is 3.8.0. Looks like my =
Xenomai user
>>>>>>>>>>>>>>> space compile was broken. Still working on fixing it.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> What options did you pass to the configure script?
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>                                                          =
Gilles.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> ../configure --target=3Darm-buildroot-linux-uclibcgnueabi =
--host=3Darm-buildroot-linux-uclibcgnueabi --build=3Di686-pc-linux-gnu =
--prefix=3D/usr --exec-prefix=3D/usr --sysconfdir=3D/etc =
--program-prefix=3D"" --enable-static --enable-shared  =
CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" LDFLAGS=3D"-march=3Darmv7-a =
-mfpu=3Dvfp3" --includedir=3D/usr/include/xenomai/
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> This is a buildroot build.
>>>>>>>>>>>>=20
>>>>>>>>>>>>=20
>>>>>>>>>>>> Could you:
>>>>>>>>>>>> - tell me what version of gcc, binutils, etc... you use?
>>>>>>>>>>>> - show me a disassembly of the xeno_bind_skip_opt function =
in libxenomai.so?
>>>>>>>>>>>> - instrument the function xeno_sigill_handler in
>>>>>>>>>>>> src/skins/common/bind.c to see if you are indeed taking the =
SIGILL signal?
>>>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> Sorry, you do not take the SIGILL handler, please instrument
>>>>>>>>>>> xeno_bind_skin_opt to print the value of "muxid" returned by =
the
>>>>>>>>>>> XENOMAI_SYSBIND system call.
>>>>>>>>>>>=20
>>>>>>>>>>> --
>>>>>>>>>>>                                                           =
Gilles.
>>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> Ok, here's the compiler spec:
>>>>>>>>>>=20
>>>>>>>>>> $ arm-linux-gnueabi-gcc -v
>>>>>>>>>> Using built-in specs.
>>>>>>>>>> COLLECT_GCC=3Darm-linux-gnueabi-gcc
>>>>>>>>>> =
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc/arm-linux-gnueabi/4.6/lto-wrapper
>>>>>>>>>> Target: arm-linux-gnueabi
>>>>>>>>>> Configured with: ../src/configure -v =
--with-pkgversion=3D'Ubuntu/Linaro 4.6.3-1ubuntu5' =
--with-bugurl=3Dfile:///usr/share/doc/gcc-4.6/README.Bugs =
--enable-languages=3Dc,c++,fortran,objc,obj-c++ --prefix=3D/usr =
--program-suffix=3D-4.6 --enable-shared --enable-linker-build-id =
--with-system-zlib --libexecdir=3D/usr/lib --without-included-gettext =
--enable-threads=3Dposix =
--with-gxx-include-dir=3D/usr/arm-linux-gnueabi/include/c++/4.6.3 =
--libdir=3D/usr/lib --enable-nls --enable-clocale=3Dgnu =
--enable-libstdcxx-debug --enable-libstdcxx-time=3Dyes =
--enable-gnu-unique-object --enable-plugin --enable-objc-gc =
--enable-multilib --disable-sjlj-exceptions --with-arch=3Darmv7-a =
--with-float=3Dsoftfp --with-fpu=3Dvfpv3-d16 --with-mode=3Dthumb =
--disable-werror --enable-checking=3Drelease --build=3Di686-linux-gnu =
--host=3Di686-linux-gn
>>>>> u --target=3Darm-linux-gnueabi --program-prefix=3Darm-linux-gnueabi-=
 --includedir=3D/usr/arm-linux-gnueabi/include =
--with-headers=3D/usr/arm-linux-gnueabi/include =
--with-libs=3D/usr/arm-linux-gnueabi/l
>>>>>> ib
>>>>>>>>=20
>>>>>>>>>> Thread model: posix
>>>>>>>>>> gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
>>>>>>>>>>=20
>>>>>>>>>> Binutils are 2.22:
>>>>>>>>>>=20
>>>>>>>>>> arm-linux-gnueabi-as -v
>>>>>>>>>> GNU assembler version 2.22 (arm-linux-gnueabi) using BFD =
version (GNU Binutils for Ubuntu) 2.22
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> Now what's interesting is: as soon as I am adding an =
instrumentation "fprintf(stdout, "Xenomai: xeno_bind_skin_opt muxid =3D =
%d\n", muxid);" to "static inline int xeno_bind_skin(unsigned =
skin_magic, const char *skin, const char *module)", binding succeeds and =
all xeno-test pass. The other option to get it work was:  declaring "int =
xeno_bind_skin(unsigned skin_magic, const char *skin, const char =
*module);" in bind.h and defining it in bind.c.
>>>>>>>>>>=20
>>>>>>>>>> If I'm only instrumenting xeno_bind_skin_opt(), I see that it =
never gets called in the original code.
>>>>>>>>>>=20
>>>>>>>>>> Do you still want to see the disassembly?
>>>>>>>>>>=20
>>>>>>>>>> -- Stephan
>>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> Oops, sent you the wrong compiler spec. Xenomai libraries & =
tests are compiled with:
>>>>>>>>>=20
>>>>>>>>> $ host/usr/bin/arm-buildroot-linux-uclibcgnueabi-gcc -v
>>>>>>>>> Using built-in specs.
>>>>>>>>> COLLECT_GCC=3Dhost/usr/bin/arm-buildroot-linux-uclibcgnueabi-gcc=

>>>>>>>>> =
COLLECT_LTO_WRAPPER=3D/home/stephan/dev.ws.Centaurus_skappert/embedded/pro=
ducts/Carbon/AM335x/host/usr/libexec/gcc/arm-buildroot-linux-uclibcgnueabi=
/4.6.3/lto-wrapper
>>>>>>>>> Target: arm-buildroot-linux-uclibcgnueabi
>>>>>>>>> Configured with: =
/home/stephan/dev.ws.Centaurus_skappert/embedded/products/Carbon/AM335x/to=
olchain/gcc-4.6.3/configure =
--prefix=3D/home/stephan/dev.ws.Centaurus_skappert/embedded/products/Carbo=
n/AM335x/host/usr --build=3Di686-pc-linux-gnu --host=3Di686-pc-linux-gnu =
--target=3Darm-buildroot-linux-uclibcgnueabi --enable-languages=3Dc =
--with-sysroot=3D/home/stephan/dev.ws.Centaurus_skappert/embedded/products=
/Carbon/AM335x/host/usr/arm-buildroot-linux-uclibcgnueabi/sysroot =
--with-build-time-tools=3D/home/stephan/dev.ws.Centaurus_skappert/embedded=
/products/Carbon/AM335x/host/usr/arm-buildroot-linux-uclibcgnueabi/bin =
--disable-__cxa_atexit --enable-target-optspace --disable-libquadmath =
--disable-libgomp --with-gnu-ld --disable-libssp --disable-multilib =
--enable-tls --enable-shared --with-gmp=3D/home/stepha
>>>>> =
n/dev.ws.Centaurus_skappert/embedded/products/Carbon/AM335x/host/usr =
--with-mpfr=3D/home/stephan/dev.ws.Centaurus_skappert/embedded/products/Ca=
rbon/AM335x/host/usr --with-mpc=3D/home/stephan/dev.
>>>>>> ws
>>>>>>>> .Centaurus_skappert/embedded/products/Carbon/AM335x/host/usr =
--disable-nls --enable-threads --disable-decimal-float --with-float=3Dsoft=
 --with-abi=3Daapcs-linux --with-arch=3Darmv7-a --with-tune=3Dcortex-a8 =
--disable-largefile --with-pkgversion=3D'Buildroot 2013.02' =
--with-bugurl=3Dhttp://bugs.buildroot.net/
>>>>>>>>> Thread model: posix
>>>>>>>>> gcc version 4.6.3 (Buildroot 2013.02)
>>>>>>>>>=20
>>>>>>>>> /dev.ws.Centaurus_skappert/embedded/products/Carbon/AM335x$ =
host/usr/bin/arm-buildroot-linux-uclibcgnueabi-as -v
>>>>>>>>> GNU assembler version 2.21.1 =
(arm-buildroot-linux-uclibcgnueabi) using BFD version (GNU Binutils) =
2.21.1
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Hi Stefan,
>>>>>>>>=20
>>>>>>>> I have no other explanation than that the combination of the =
toolchain
>>>>>>>> you use with Xenomai code you use produces broken code.
>>>>>>>>=20
>>>>>>>> The version of libnative.so generated with a similar toolchain
>>>>>>>> (codesourcery 2012.03) has three pointers in its .init_array =
section,
>>>>>>>> these are the pointers to the functions which are invoked upon =
library
>>>>>>>> startup:
>>>>>>>> frame_dummy
>>>>>>>> __init_xeno_interface
>>>>>>>> __init_native_tskey
>>>>>>>>=20
>>>>>>>> The version of libnative.so you sent me has four pointers in =
its
>>>>>>>> .init_array section:
>>>>>>>> 0x2458
>>>>>>>> 0x2254
>>>>>>>> 0x22b8
>>>>>>>> 0x2308
>>>>>>>>=20
>>>>>>>> I do not have the function names, I believe, because the binary =
you sent
>>>>>>>> me is stripped. However, 0x2308 looks like =
__init_xeno_interface, 0x2254
>>>>>>>> looks like __init_native_tskey, and 0x22b8 has the following =
disassembly:
>>>>>>>>=20
>>>>>>>> 22b8:    e92d4008        push    {r3, lr}
>>>>>>>> 22bc:    e59f3030        ldr     r3, [pc, #48]   ; 22f4 =
<free@plt+0x108>
>>>>>>>> 22c0:    e59f0030        ldr     r0, [pc, #48]   ; 22f8 =
<free@plt+0x10c>
>>>>>>>> 22c4:    e08f3003        add     r3, pc, r3
>>>>>>>> 22c8:    e59f102c        ldr     r1, [pc, #44]   ; 22fc =
<free@plt+0x110>
>>>>>>>> 22cc:    e59f202c        ldr     r2, [pc, #44]   ; 2300 =
<free@plt+0x114>
>>>>>>>> 22d0:    e7930000        ldr     r0, [r3, r0]
>>>>>>>> 22d4:    e08f1001        add     r1, pc, r1
>>>>>>>> 22d8:    e59f3024        ldr     r3, [pc, #36]   ; 2304 =
<free@plt+0x118>
>>>>>>>> 22dc:    e08f2002        add     r2, pc, r2
>>>>>>>> 22e0:    e08f3003        add     r3, pc, r3
>>>>>>>> 22e4:    e5900000        ldr     r0, [r0]
>>>>>>>> 22e8:    ebffff5f        bl      206c <fprintf@plt>
>>>>>>>> 22ec:    e3a00001        mov     r0, #1
>>>>>>>> 22f0:    ebffff99        bl      215c <exit@plt>
>>>>>>>>=20
>>>>>>>> Which means that it calls directly fprintf and exit, without =
even
>>>>>>>> calling xeno_bind_skin_opt. So, it looks like an "optimized" =
version of
>>>>>>>> __init_xeno_interface, assuming xeno_bind_skin_opt always =
return -1.
>>>>>>>>=20
>>>>>>>> So, questions now:
>>>>>>>> - what commit in xenomai git are you using?
>>>>>>>> - could you try another toolchain ?
>>>>>>>>=20
>>>>>>>> Regards.
>>>>>>>> --
>>>>>>>>                                                             =
Gilles.
>>>>>>>>=20
>>>>>>>=20
>>>>>>> Yes, you are correct. I'm seeing that with the libraries =
compiled with -g and unstripped I just sent you.
>>>>>>>=20
>>>>>>> I'm using http://git.xenomai.org/xenomai-2.6.git @ master, last =
commit:
>>>>>>>=20
>>>>>>> commit 9b645b0fbf5fe6068358f4bbc25469ebd24b822f
>>>>>>> Author: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>>>> Date:   Fri May 10 15:27:38 2013 +0200
>>>>>>>=20
>>>>>>>  native: avoid calling copy_from_user with hard irqs off
>>>>>>>=20
>>>>>>> I also tried 2.6.2.1 release and that version does work =
(compile) correctly.
>>>>>>=20
>>>>>>=20
>>>>>> Could you try git bisect to see which commit causes it?
>>>>>>=20
>>>>>> --
>>>>>>                                                              =
Gilles.
>>>>>>=20
>>>>>=20
>>>>> Similar to the printf instrumentation making it working, it starts =
to fail after the commit removing the extra code from xeno_bind_skin:
>>>>>=20
>>>>> a9aa9557f1df4f515791f42b8cf7bb301b31365a is the first bad commit
>>>>> commit a9aa9557f1df4f515791f42b8cf7bb301b31365a
>>>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> Date:   Tue Apr 23 14:32:01 2013 +0200
>>>>>=20
>>>>>   Remove mlockall alert handler
>>>>>=20
>>>>>   The probability of such errors is negligible now because we lock
>>>>>   unconditionally. So we can remove the machinery that used to =
report such
>>>>>   bugs to the user. The nucleus will still raise a signal if =
userspace
>>>>>   willingly unlocked the memory - it will get what it deserves (an
>>>>>   untranslated signal).
>>>>>=20
>>>>>   Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>=20
>>>>> :040000 040000 72a70a220c9760bcbe39e3325a18a7deab1058ca =
7db151f89a86e5f40112695fb21480803f51c64c M   include
>>>>> :040000 040000 3587a708c726f968bc5d8eb9ab85b2717eb8c4d0 =
f327044f164ab16487d5d4c5efdea1bda7101f80 M   src
>>>>>=20
>>>>=20
>>>> Oh, you ran into an ugly gcc bug that won't be fixed for that =
version
>>>> anymore: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D56712
>>>>=20
>>>> We just started carrying this workaround locally, still undecided =
what
>>>> to do upstream.
>>>>=20
>>>>=20
>>>> native: Work around gcc-2.6
>>>>=20
>>>> This avoid that gcc bug 56712 lets the initialization of the native =
skin
>>>> fail. See http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D56712 for =
the
>>>> background. Affects in particular Ubuntu 12.4 LTS.
>>>>=20
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>> src/skins/native/init.c |    8 ++++++--
>>>> 1 files changed, 6 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/src/skins/native/init.c b/src/skins/native/init.c
>>>> index e380ca6..8e77e1c 100644
>>>> --- a/src/skins/native/init.c
>>>> +++ b/src/skins/native/init.c
>>>> @@ -50,8 +50,7 @@ void __init_native_tskey(void)
>>>> }
>>>> #endif /* !HAVE___THREAD */
>>>>=20
>>>> -static __attribute__ ((constructor))
>>>> -void __init_xeno_interface(void)
>>>> +static void __init_xeno_interface(void)
>>>> {
>>>>      int err;
>>>>=20
>>>> @@ -71,3 +70,8 @@ void __init_xeno_interface(void)
>>>>      }
>>>>      fork_handler_registered =3D 1;
>>>> }
>>>> +
>>>> +static __attribute__ ((constructor)) void __init_wrapper(void)
>>>> +{
>>>> +     __init_xeno_interface();
>>>> +}
>>>>=20
>>>>=20
>>>> Jan
>>>>=20
>>>> --
>>>> Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
>>>> Corporate Competence Center Embedded Linux
>>>>=20
>>>=20
>>> Ah, thanks for the info. I can confirm that xeno-test succeeds with =
gcc 4.6.3 after applying your patch.
>>=20
>> OK, I pushed the patch for upstream merge. It's probably better to =
carry
>> the workaround than letting users find out the reason the hard way.
>> Gilles, please consider it for 2.6.3.
>=20
>=20
> Ok, but does not the workaround of un-inlining xeno_bind_skin make =
more
> sense?
>=20
> --=20
>                                                                Gilles.
>=20

I'd say yes because it fixes all skins.

-- Stephan
=20



