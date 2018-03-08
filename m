MIME-Version: 1.0
In-Reply-To: <1365131872.3062771.1520443277957.JavaMail.zimbra@triolcorp.com.ua>
References: <193431298.3050958.1520439447908.JavaMail.zimbra@triolcorp.com.ua>
 <CALLqZ8RWOEEcNXGT7k_ckrJT8Us417Snhh_6aUCbVrotR6objw@mail.gmail.com>
 <1365131872.3062771.1520443277957.JavaMail.zimbra@triolcorp.com.ua>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 8 Mar 2018 11:35:32 -0500
Message-ID: <CALLqZ8R2xhO2d22C193=rYb6p=Av=J6q+K+CgjQU2beq9NxoNA@mail.gmail.com>
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

Here is a sample makefile for an out of kernel module that you can use
to create a custom rtdm module.

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------
#this should be the path to your patched kernel source that has the
ipipe patches and Xenomai links applied
#if you are using the O option when building the kernel (build takes
place out of tree) use that directory
XENO_KDIR :=3D <path to patched kernel source>

#This is only needed if you are cross compiling, if you are not cross
compiling then leave these blank
CROSS_COMPILE=3Darm-linux-gnueabihf-
ARCH=3Darm

PWD :=3D $(shell pwd)

#name of your module that you are compiling
obj-m+=3Drtdm_hello.o

all:
make ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CROSS_COMPILE) M=3D$(PWD) -C
$(XENO_BUILD) modules
clean:
make ARCH=3D$(ARCH) CROSS_COMPILE=3D$(CROSS_COMPILE) M=3D$(PWD) -C
$(XENO_BUILD) modules
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------

For your purposes you don't need the CROSS_COMPILE and ARCH options
you can omit those so your make lines should look like this,
     make M=3D$(PWD) -C $(XENO_BUILD) modules


I'll be creating a simple sample driver, maybe similar to how it's
done in LDD3 and post it.  This is all depending on when I get time to
do so , no time line lol

-Greg

On Wed, Mar 7, 2018 at 12:21 PM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=
=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=
=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<shevchenko.taras@triolcorp.com.ua> wrote:
> Yes I use UDOO-x86 with pentium n3720
> I try to build  custom.
> And i try to build some from kernel  - just to be shure thats all correct=
.(Maybe it s not right way) but I get the same errors
> Unfortunately, there is not many examples for x86_64
>
> ----- Original Message -----
> From: "Greg Gallagher" <greg@embeddedgreg.com>
> To: "=D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=D0=BE =D0=A2=D0=B0=D1=80=
=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=
=D1=87" <shevchenko.taras@triolcorp.com.ua>
> Cc: "xenomai" <xenomai@xenomai.org>
> Sent: Wednesday, March 7, 2018 7:11:24 PM
> Subject: Re: [Xenomai] cant compile rtdm module
>
> Are you trying to build a custom RTDM module or a built in one?  The
> built in ones can be enabled in the menuconfig stage of the kernel
> build.  What board are you using? UDOO-x86?
>
> -Greg
>
> On Wed, Mar 7, 2018 at 11:17 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=
=BA=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=
=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
> <shevchenko.taras@triolcorp.com.ua> wrote:
>>
>> Hi,
>> I can successfully compile and run code with Xenomai api in user space
>> but if i try to compile rtdm code there is many error
>> I try to use own code and your example from /kernel/drivers/gpio - outpu=
ts below
>>
>> please guide me how to compile and run simple rtdm module
>>
>> yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$ make=
 V=3D1
>> make: *** No targets. Stop.
>> yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$ make=
 V=3D1 -C /usr/src/linux-headers-4.9.38-xenomai-3.0.5 M=3D$PWD modules
>> make: Entering directory '/usr/src/linux-headers-4.9.38-xenomai-3.0.5'
>> test -e include/generated/autoconf.h -a -e include/config/auto.conf || (=
 \
>> echo >&2; \
>> echo >&2 " ERROR: Kernel configuration is invalid."; \
>> echo >&2 " include/generated/autoconf.h or include/config/auto.conf are =
missing.";\
>> echo >&2 " Run 'make oldconfig && make prepare' on kernel src to fix it.=
"; \
>> echo >&2 ; \
>> /bin/false)
>> mkdir -p /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.tmp_v=
ersions ; rm -f /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.t=
mp_versions/*
>> make -f ./scripts/Makefile.build obj=3D/home/yeti/xenoInstall/xenomai-3.=
0.5/kernel/drivers/gpio
>> (cat /dev/null; ) > /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/=
gpio/modules.order
>> make -f ./scripts/Makefile.modpost
>> find /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.tmp_versi=
ons -name '*.mod' | xargs -r grep -h '\.ko$' | sort -u | sed 's/\.ko$/.o/' =
| scripts/mod/modpost -a -i ./Module.symvers -I /home/yeti/xenoInstall/xeno=
mai-3.0.5/kernel/drivers/gpio/Module.symvers -o /home/yeti/xenoInstall/xeno=
mai-3.0.5/kernel/drivers/gpio/Module.symvers -S -w -s -T -
>> make: Leaving directory '/usr/src/linux-headers-4.9.38-xenomai-3.0.5'
>> yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

