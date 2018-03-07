MIME-Version: 1.0
In-Reply-To: <193431298.3050958.1520439447908.JavaMail.zimbra@triolcorp.com.ua>
References: <193431298.3050958.1520439447908.JavaMail.zimbra@triolcorp.com.ua>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 7 Mar 2018 12:11:24 -0500
Message-ID: <CALLqZ8RWOEEcNXGT7k_ckrJT8Us417Snhh_6aUCbVrotR6objw@mail.gmail.com>
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

Are you trying to build a custom RTDM module or a built in one?  The
built in ones can be enabled in the menuconfig stage of the kernel
build.  What board are you using? UDOO-x86?

-Greg

On Wed, Mar 7, 2018 at 11:17 AM, =D0=A8=D0=B5=D0=B2=D1=87=D0=B5=D0=BD=D0=BA=
=D0=BE =D0=A2=D0=B0=D1=80=D0=B0=D1=81 =D0=93=D1=80=D0=B8=D0=B3=D0=BE=D1=80=
=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
<shevchenko.taras@triolcorp.com.ua> wrote:
>
> Hi,
> I can successfully compile and run code with Xenomai api in user space
> but if i try to compile rtdm code there is many error
> I try to use own code and your example from /kernel/drivers/gpio - output=
s below
>
> please guide me how to compile and run simple rtdm module
>
> yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$ make =
V=3D1
> make: *** No targets. Stop.
> yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$ make =
V=3D1 -C /usr/src/linux-headers-4.9.38-xenomai-3.0.5 M=3D$PWD modules
> make: Entering directory '/usr/src/linux-headers-4.9.38-xenomai-3.0.5'
> test -e include/generated/autoconf.h -a -e include/config/auto.conf || ( =
\
> echo >&2; \
> echo >&2 " ERROR: Kernel configuration is invalid."; \
> echo >&2 " include/generated/autoconf.h or include/config/auto.conf are m=
issing.";\
> echo >&2 " Run 'make oldconfig && make prepare' on kernel src to fix it."=
; \
> echo >&2 ; \
> /bin/false)
> mkdir -p /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.tmp_ve=
rsions ; rm -f /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.tm=
p_versions/*
> make -f ./scripts/Makefile.build obj=3D/home/yeti/xenoInstall/xenomai-3.0=
.5/kernel/drivers/gpio
> (cat /dev/null; ) > /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/g=
pio/modules.order
> make -f ./scripts/Makefile.modpost
> find /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.tmp_versio=
ns -name '*.mod' | xargs -r grep -h '\.ko$' | sort -u | sed 's/\.ko$/.o/' |=
 scripts/mod/modpost -a -i ./Module.symvers -I /home/yeti/xenoInstall/xenom=
ai-3.0.5/kernel/drivers/gpio/Module.symvers -o /home/yeti/xenoInstall/xenom=
ai-3.0.5/kernel/drivers/gpio/Module.symvers -S -w -s -T -
> make: Leaving directory '/usr/src/linux-headers-4.9.38-xenomai-3.0.5'
> yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

