MIME-Version: 1.0
In-Reply-To: <CAFkYNwYS1NLVK9Kx7ZiVWaM37mLRyfLMFHMV9=on1yjhTux6Fw@mail.gmail.com>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
 <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
 <CAFkYNwZS5Js_22DMKozYciMwVUKxPbUJ0-FoAxoY50rfxtcBQA@mail.gmail.com>
 <20150920081716.GH22852@hermes.click-hack.org>
 <CAFkYNwY_sQxtHYfB=Y-bcpGyfaENWjAwnx0Yc7VvWcEPaUH+fg@mail.gmail.com>
 <20150920170330.GA3486@hermes.click-hack.org>
 <CAFkYNwbHQXK8_YA1A0NLErdcHbYB-PpTMo09VUaae7fgQTmxfw@mail.gmail.com>
 <20150921144615.GA20753@hermes.click-hack.org>
 <CAFkYNwYS1NLVK9Kx7ZiVWaM37mLRyfLMFHMV9=on1yjhTux6Fw@mail.gmail.com>
Date: Tue, 22 Sep 2015 14:28:00 +1200
Message-ID: <CAFkYNwYZJ8QF5cUUqyDULcxNCQRoYh8guZR-M-6TdFHn26Ex7A@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Installing xenomai libraries ARM OMAP4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Having no lucks, I switched it to ipipe-ipipe-core-3.18.20-arm-5.tar.bz2
which I presume it has all the patches required. One thing puzzled me when
advanced to the second command below. I didn't see the Cobalt listed in the
menuconfig. Is it right? but after succeeded compiling it, the cat
include/generated/utsrelease.h | awk '{print $3}' | sed 's/\"//g' show the
kernel version is like 3.18.20-ipipe. Can anyone explain when Cobalt is not
listed in menuconfig, please? After installing kernel 3.18.20-ipipe, dmesg
| grep -i xenomai show nothing, but dmesg | grep -i ipipe get the
following. I had t assume it is working now. With ipipe-core-3.18.20, how
would I produce xenomai/ipipe libs and test apps?

Appreciate any comments please?

[    0.000000] Linux version 3.18.20-ipipe (qws@qws-MacBookPro) (gcc
version 4.5
[    0.623758] 3.18.20-ipipe #1 Not
tainted
[    0.623996]   [<c00d3194>]
__ipipe_do_sync_stage+0x288/0x2d0
[    0.624012]   [<c0008634>]
__ipipe_grab_irq+0x5c/0x70
[    0.624329] CPU: 1 PID: 22 Comm: kblockd Not tainted 3.18.20-ipipe
#1
[    0.624474] [<c00844b4>] (trace_hardirqs_on_caller) from [<c05b77f4>]
(__ipi)
[    0.624502] [<c05b77f4>] (__ipipe_fast_svc_irq_exit) from [<c0313648>]
(_cle)
[    0.727939] Switched to clocksource ipipe_tsc


1. make CROSS_COMPILE=${CC} ARCH=arm omap2plus_defconfig

2. make CROSS_COMPILE=${CC} ARCH=arm menuconfig

On 22 September 2015 at 14:13, vibnwis <vibnwis@gmail.com> wrote:

>
>
> On 22 September 2015 at 02:46, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On Mon, Sep 21, 2015 at 10:16:53PM +1200, vibnwis wrote:
>> > Hi Gilles,
>> >
>> > I managed to get autoreconf -if to work, and advanced to compiling the
>> > xenomai. However, yet not to the end. I got the following error. Then I
>> > switch xenomai-gch. The same error as well. Hence, I changed the CC to
>> > Ubuntu arm-linux-gnueabihf package. The same error too. The errors are
>> as
>> > follow.
>> >
>> > checking for ARM machine... configure: error: Selecting a machine with
>> > --enable-arm-mach is mandatory
>> >
>> > and the command is  ./configure CFLAGS="-march=armv7-a -mfpu=vfp3"
>> > LDFLAGS="-march=armv7-a -mfpu=vfp3" --with-core=cobalt --enable-smp
>> > --enable-pshared --build=x86_64-linux-gnu --host=arm-linux-gnueabihf
>> >
>> > if I added --enable-arm-mach, I get error messages "checking for ARM
>> > machine... configure: error: Invalid machine selected: "yes"".
>> >
>> > Googles don't seem to get any positive resolution. Appreciate any
>> > comments.
>>
>> You are trying to compile an outdated version of Xenomai, Xenomai
>> version 2.5 or earlier. You can have access to the installation
>> instructions for that particular version in the sources (the file is
>> named README.INSTALL at the top of the sources tree), or on the
>> website, using the URL:
>>
>> http://xenomai.org/documentation/xenomai-2.5/README.INSTALL
>>
>> for instance, if installing the version 2.5. Replace 2.5 with the
>> version you are actually installing.
>>
>
> I use Xenomai-3 of which I use patches namely
> kernel/cobalt/arch/arm/patches/ipipe-core-3.18.12-arm-4.patch patched the
> kernel 3.18.12. And under Xenomai-3, I autoreconf -fi to create a configure
> file and finally make it xenomai libs and test apps. Under the installed is
> has two directory, dev and usr. Under the usr/ it has xenomai/bin, etc.
>
> Have I missed out anything? in terms getting it the test apps as well as
> the related device files to work.
>
>
>> --
>>                                             Gilles.
>> https://click-hack.org
>>
>
>
