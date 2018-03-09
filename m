MIME-Version: 1.0
In-Reply-To: <2091412133.3257704.1520601515758.JavaMail.zimbra@triolcorp.com.ua>
References: <5mv4cvt97tp1qjmddllhjpp3.1520597294434@embeddedgreg.com>
 <1150022191.3242478.1520599224202.JavaMail.zimbra@triolcorp.com.ua>
 <2091412133.3257704.1520601515758.JavaMail.zimbra@triolcorp.com.ua>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 9 Mar 2018 09:59:11 -0500
Message-ID: <CALLqZ8QqV=1We1QFaxjc85Hs=nS+trY7JKL4bQ_pi7Yo5URx0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] cant compile rtdm module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?0KjQtdCy0YfQtdC90LrQviDQotCw0YDQsNGBINCT0YDQuNCz0L7RgNGM0LXQstC40Yc=?= <shevchenko.taras@triolcorp.com.ua>
Cc: xenomai <xenomai@xenomai.org>

Is it possible to try this from the git repos instead of the tar
packages? If you clone git://git.xenomai.org/xenomai-3.git and then
checkout the stable-3.0.x branch and try trying compiling the kernel
again.  Once you've done that you should be to point your module
makefile to the build directory and all should be good.  I testing
this out on a generic x86 box so hopefully it works for your setup.
If not we can continue to debug.

On Fri, Mar 9, 2018 at 8:18 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=
=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=
=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<shevchenko.taras@triolcorp.com.ua> wrote:
>
>
> Is there a list of files and folders  must I have ?
> or way to check installation ?
> like xeno -config  or something else
> yeti@yeti-UDOO-x86:/usr/xenomai/bin$ ./xeno-config
> xeno-config --verbose
>         --core=3Dcobalt
>         --version=3D"3.0.5"
>         --cc=3D"gcc"
>         --ccld=3D"/usr/xenomai/bin/wrap-link.sh gcc"
>         --arch=3D"x86"
>         --prefix=3D"/usr/xenomai"
>         --library-dir=3D"/usr/xenomai/lib"
> Usage xeno-config OPTIONS
> Options :
>         --help
>         --v,--verbose
>         --version
>         --cc
>         --ccld
>         --arch
>         --prefix
>         --[skin=3D]posix|vxworks|psos|alchemy|rtdm|smokey|cobalt
>         --auto-init|auto-init-solib|no-auto-init
>         --mode-check|no-mode-check
>         --cflags
>         --ldflags
>         --lib*-dir|libdir|user-libdir
>         --core
>         --info
>         --compat
>
>
>
> ----- Original Message -----
> From: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2=D0=B0=D1=
=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=8C=D0=B5=D0=B2=D0=
=B8=D1=87" <shevchenko.taras@triolcorp.com.ua>
> To: "Greg Gallagher" <greg@embeddedgreg.com>
> Cc: "xenomai" <xenomai@xenomai.org>
> Sent: Friday, March 9, 2018 2:40:24 PM
> Subject: Re: [Xenomai] cant compile rtdm module
>
> Im confused
> I extract tar xf xenomai-3.0.5.tar.bz2  in my home folder  /home/henoInst=
all/xenomai-3.0.5
>
> but  /usr/src/linux-headers-4.9.38-xenomai-3.0.5  I guess  it is  kernel =
source folders isn't it ?
> it consist
> /usr/src/linux-headers-4.9.38-xenomai-3.0.5/include/xenomai/rtdm
>
>
>
> and after apply patch and build kernel     folder /usr/xenomai  is appear=
ed  but therein't features.h file
>
>
>
>
>
> ----- Original Message -----
> From: "Greg Gallagher" <greg@embeddedgreg.com>
> To: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2=D0=B0=D1=80=
=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=
=D1=87" <shevchenko.taras@triolcorp.com.ua>
> Cc: "xenomai" <xenomai@xenomai.org>
> Sent: Friday, March 9, 2018 2:08:14 PM
> Subject: Re: [Xenomai] cant compile rtdm module
>
> Are the Xenomai headers loacted in your kernel source?  Where did you bui=
ld the patched kernel from?
>
>
>
>   Original Message
> From: shevchenko.taras@triolcorp.com.ua
> Sent: March 9, 2018 6:28 AM
> To: greg@embeddedgreg.com
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] cant compile rtdm module
>
> I create such makefile based on your letter
> -------------------------------------------
> obj-m :=3D rtdm_hello.o
> all:/usr/src/linux-headers-4.9.38-xenomai-3.0.5
> make -C /usr/src/linux-headers-4.9.38-xenomai-3.0.5/ M=3D$(PWD) modules
> clean:
> $(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers modules=
.order
> $(RM) -R .tmp*
> ------------------------------------------
> now I can compile and run simple Linux kernel Module
> but if i add    #include <rtdm/rtdm.h>  to my *.c file
> its crashed  and looks like some path are missed
>
> yeti@yeti-UDOO-x86:~/xenoInstall/rtdm_hello$ make
> make -C /usr/src/linux-headers-4.9.38-xenomai-3.0.5/ M=3D/home/yeti/xenoI=
nstall/rtdm_hello modules
> make[1]: Entering directory '/usr/src/linux-headers-4.9.38-xenomai-3.0.5'
>   CC [M]  /home/yeti/xenoInstall/rtdm_hello/rtdm_hello.o
> In file included from include/xenomai/rtdm/fd.h:27:0,
>                  from include/xenomai/rtdm/rtdm.h:28,
>                  from /home/yeti/xenoInstall/rtdm_hello/rtdm_hello.c:3:
> ./include/asm-generic/xenomai/syscall.h:24:34: fatal error: asm/xenomai/f=
eatures.h: No such file or directory
> compilation terminated.
>
> please help
>
>
> ----- Original Message -----
> From: "Greg Gallagher" <greg@embeddedgreg.com>
> To: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2=D0=B0=D1=80=
=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=
=D1=87" <shevchenko.taras@triolcorp.com.ua>
> Cc: "xenomai" <xenomai@xenomai.org>
> Sent: Thursday, March 8, 2018 6:35:32 PM
> Subject: Re: [Xenomai] cant compile rtdm module
>
> Here is a sample makefile for an out of kernel module that you can use
> to create a custom rtdm module.
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------
> #this should be the path to your patched kernel source that has the
> ipipe patches and Xenomai links applied
> #if you are using the O option when building the kernel (build takes
> place out of tree) use that directory
> XENO_KDIR :=3D <path to patched kernel source>
>
> #This is only needed if you are cross compiling, if you are not cross
> compiling then leave these blank
> CROSS_COMPILE=3Darm-linux-gnueabihf-
> ARCH=3Darm
>
> PWD :=3D $(shell pwd)
>
> #name of your module that you are compiling
> obj-m+=3Drtdm_hello.o
>
> all:
> make ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CROSS_COMPILE) M=3D$(PWD) -C
> $(XENO_BUILD) modules
> clean:
> make ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CROSS_COMPILE) M=3D$(PWD) -C
> $(XENO_BUILD) modules
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------------
>
> For your purposes you don't need the CROSS_COMPILE and ARCH options
> you can omit those so your make lines should look like this,
>      make M=3D$(PWD) -C $(XENO_BUILD) modules
>
>
> I'll be creating a simple sample driver, maybe similar to how it's
> done in LDD3 and post it.  This is all depending on when I get time to
> do so , no time line lol
>
> -Greg
>
> On Wed, Mar 7, 2018 at 12:21 PM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=
=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=
=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
> <shevchenko.taras@triolcorp.com.ua> wrote:
>> Yes I use UDOO-x86 with pentium n3720
>> I try to build  custom.
>> And i try to build some from kernel  - just to be shure thats all correc=
t.(Maybe it s not right way) but I get the same errors
>> Unfortunately, there is not many examples for x86_64
>>
>> ----- Original Message -----
>> From: "Greg Gallagher" <greg@embeddedgreg.com>
>> To: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2=D0=B0=D1=80=
=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=
=D1=87" <shevchenko.taras@triolcorp.com.ua>
>> Cc: "xenomai" <xenomai@xenomai.org>
>> Sent: Wednesday, March 7, 2018 7:11:24 PM
>> Subject: Re: [Xenomai] cant compile rtdm module
>>
>> Are you trying to build a custom RTDM module or a built in one?  The
>> built in ones can be enabled in the menuconfig stage of the kernel
>> build.  What board are you using? UDOO-x86?
>>
>> -Greg
>>
>> On Wed, Mar 7, 2018 at 11:17 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=
=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=
=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
>> <shevchenko.taras@triolcorp.com.ua> wrote:
>>>
>>> Hi,
>>> I can successfully compile and run code with Xenomai api in user space
>>> but if i try to compile rtdm code there is many error
>>> I try to use own code and your example from /kernel/drivers/gpio - outp=
uts below
>>>
>>> please guide me how to compile and run simple rtdm module
>>>
>>> yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$ mak=
e V=3D1
>>> make: *** No targets. Stop.
>>> yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$ mak=
e V=3D1 -C /usr/src/linux-headers-4.9.38-xenomai-3.0.5 M=3D$PWD modules
>>> make: Entering directory '/usr/src/linux-headers-4.9.38-xenomai-3.0.5'
>>> test -e include/generated/autoconf.h -a -e include/config/auto.conf || =
( \
>>> echo >&2; \
>>> echo >&2 " ERROR: Kernel configuration is invalid."; \
>>> echo >&2 " include/generated/autoconf.h or include/config/auto.conf are=
 missing.";\
>>> echo >&2 " Run 'make oldconfig && make prepare' on kernel src to fix it=
."; \
>>> echo >&2 ; \
>>> /bin/false)
>>> mkdir -p /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.tmp_=
versions ; rm -f /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.=
tmp_versions/*
>>> make -f ./scripts/Makefile.build obj=3D/home/yeti/xenoInstall/xenomai-3=
.0.5/kernel/drivers/gpio
>>> (cat /dev/null; ) > /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers=
/gpio/modules.order
>>> make -f ./scripts/Makefile.modpost
>>> find /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.tmp_vers=
ions -name '*.mod' | xargs -r grep -h '\.ko$' | sort -u | sed 's/\.ko$/.o/'=
 | scripts/mod/modpost -a -i ./Module.symvers -I /home/yeti/xenoInstall/xen=
omai-3.0.5/kernel/drivers/gpio/Module.symvers -o /home/yeti/xenoInstall/xen=
omai-3.0.5/kernel/drivers/gpio/Module.symvers -S -w -s -T -
>>> make: Leaving directory '/usr/src/linux-headers-4.9.38-xenomai-3.0.5'
>>> yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> https://xenomai.org/mailman/listinfo/xenomai
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

