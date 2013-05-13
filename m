Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Stephan Kappertz <stephan.kappertz@kabelmail.de>
In-Reply-To: <518D2815.7000602@xenomai.org>
Date: Mon, 13 May 2013 12:37:06 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <19C79116-400B-4A5C-BFDA-87EEF8799554@kabelmail.de>
References: <516BA4E9.3070201@xenomai.org>	<90FBAEE5-D70C-4563-B9DB-776D6E4E7FA9@kabelmail.de>	<516D933F.8060502@xenomai.org>	<F484004F-9908-449C-A4DA-CB73E47EE764@kabelmail.de>	<5182B1B5.1000107@xenomai.org>	<12E434B4-4F26-44AC-8D50-2CF70B5089E1@kabelmail.de>	<5183FFB3.1000006@xenomai.org>	<8D9AB79C-4A66-4511-B08B-ACF825FED1BF@kabelmail.de>	<518A98F5.30000@xenomai.org>	<0ECFC8C0-CF1D-4D65-9724-B0A1A91887DC@kabelmail.de>	<518CF43E.3080601@xenomai.org>	<5F179C54-A023-4C27-9082-13195B16B9BB@kabelmail.de>	<518D07BB.1060900@xenomai.org>	<A359148C-7FCB-4D8C-A5DC-461065767DDA@kabelmail.de>
	<518D24E8.6070305@xenomai.org> <518D2815.7000602@xenomai.org>
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
Cc: Xenomai <xenomai@xenomai.org>

Am 10.05.2013 um 19:02 schrieb Gilles Chanteperdrix:

> On 05/10/2013 06:48 PM, Gilles Chanteperdrix wrote:
>=20
>> On 05/10/2013 06:40 PM, Stephan Kappertz wrote:
>>=20
>>>>>>=20
>>>>>=20
>>>>> I'm using your git repository directly. Applied my post.patch and
>>>>> compiled the kernel. So this is 3.8.0. Looks like my Xenomai user
>>>>> space compile was broken. Still working on fixing it.
>>>>=20
>>>>=20
>>>> What options did you pass to the configure script?
>>>>=20
>>>>=20
>>>> --=20
>>>>                                                               =
Gilles.
>>>>=20
>>>=20
>>> ../configure --target=3Darm-buildroot-linux-uclibcgnueabi =
--host=3Darm-buildroot-linux-uclibcgnueabi --build=3Di686-pc-linux-gnu =
--prefix=3D/usr --exec-prefix=3D/usr --sysconfdir=3D/etc =
--program-prefix=3D"" --enable-static --enable-shared  =
CFLAGS=3D"-march=3Darmv7-a -mfpu=3Dvfp3" LDFLAGS=3D"-march=3Darmv7-a =
-mfpu=3Dvfp3" --includedir=3D/usr/include/xenomai/
>>>=20
>>> This is a buildroot build.
>>=20
>>=20
>> Could you:
>> - tell me what version of gcc, binutils, etc... you use?
>> - show me a disassembly of the xeno_bind_skip_opt function in =
libxenomai.so?
>> - instrument the function xeno_sigill_handler in
>> src/skins/common/bind.c to see if you are indeed taking the SIGILL =
signal?
>=20
>=20
> Sorry, you do not take the SIGILL handler, please instrument
> xeno_bind_skin_opt to print the value of "muxid" returned by the
> XENOMAI_SYSBIND system call.
>=20
> --=20
>                                                                Gilles.
>=20


Ok, here's the compiler spec:

$ arm-linux-gnueabi-gcc -v
Using built-in specs.
COLLECT_GCC=3Darm-linux-gnueabi-gcc
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc/arm-linux-gnueabi/4.6/lto-wrapper
Target: arm-linux-gnueabi
Configured with: ../src/configure -v --with-pkgversion=3D'Ubuntu/Linaro =
4.6.3-1ubuntu5' --with-bugurl=3Dfile:///usr/share/doc/gcc-4.6/README.Bugs =
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
--host=3Di686-linux-gnu --target=3Darm-linux-gnueabi =
--program-prefix=3Darm-linux-gnueabi- =
--includedir=3D/usr/arm-linux-gnueabi/include =
--with-headers=3D/usr/arm-linux-gnueabi/include =
--with-libs=3D/usr/arm-linux-gnueabi/lib
Thread model: posix
gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)

Binutils are 2.22:

arm-linux-gnueabi-as -v
GNU assembler version 2.22 (arm-linux-gnueabi) using BFD version (GNU =
Binutils for Ubuntu) 2.22


Now what's interesting is: as soon as I am adding an instrumentation =
"fprintf(stdout, "Xenomai: xeno_bind_skin_opt muxid =3D %d\n", muxid);" =
to "static inline int xeno_bind_skin(unsigned skin_magic, const char =
*skin, const char *module)", binding succeeds and all xeno-test pass. =
The other option to get it work was:  declaring "int =
xeno_bind_skin(unsigned skin_magic, const char *skin, const char =
*module);" in bind.h and defining it in bind.c.

If I'm only instrumenting xeno_bind_skin_opt(), I see that it never gets =
called in the original code.

Do you still want to see the disassembly?

-- Stephan



