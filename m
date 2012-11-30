MIME-Version: 1.0
In-Reply-To: <CAKvQZ_2Nzfgj7oK12+t3CtLj-YWBCB=nFYSDU6B4KqW4aWQpnQ@mail.gmail.com>
References: <CAMgy_J0idydJq8wzH3CwQoCa+BEbSyUyOJoWmvwc+oAB3jpZ6w@mail.gmail.com>
	<CAKvQZ_2Nzfgj7oK12+t3CtLj-YWBCB=nFYSDU6B4KqW4aWQpnQ@mail.gmail.com>
Date: Fri, 30 Nov 2012 09:46:58 +0100
Message-ID: <CAKvQZ_2E-pB1HHK=Ny1YnGQui5zxre4HT28YaHjyMb7L0qHn3w@mail.gmail.com>
From: Willy Lambert <lambert.willy@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Frustrating experience with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Shamju Joseph <shamju.joseph@gmail.com>
Cc: xenomai@xenomai.org

2012/11/30 Willy Lambert <lambert.willy@gmail.com>:
> 2012/11/29 Shamju Joseph <shamju.joseph@gmail.com>:
>> Hi all,
>>
>> (1) I had a frustrating experience with Xenomai. I tried to install
>> different combinations of Xenomai and Linux kernels. Some had compiling
>> error, some combination compiles but doesn't boot, some boots but doesn't
>> show up properly on 'dmesg | grep Xenomai' and some boots perfect but PC
>> hung when run Xenomai test programs like latency.
>>
>> (2) When we install standard Linux distributions like RHEL & Fedora, the
>> distribution will take care about installing the right device drivers for
>> the PC. But when we install vanilla kernel patched with Xenomai, how do we
>> ensure that the right drivers were installed? Is there any standard
>> procedure to do this?
>>
>> (3) I get the build errors like the following with most of the kernel &
>> Xenomai combinations. But PC boots OK most of the time with this new
>> patched kernel.
>>
>> #make modules_install install
>>
>> ERROR: modinfo: could not find module twofish
>>
>> ERROR: modinfo: could not find module twofish_common
>>
>> ERROR: modinfo: could not find module dell_wmi
>>
>> ERROR: modinfo: could not find module wmi
>>
>> ERROR: modinfo: could not find module video
>>
>> Are the problems mentioned above in (1) due to this?
>>
>> (4) I have listed below different combinations I tried and the result for
>> the reference (On Dell laptop - Precision M4500, core i5 processor, RHEL 6).
>>
>> a) linux-2.6.34.5 with xenomai-2.5.6
>>
>> ==> Can't boot
>>
>> b) linux-2.6.35.9. with xenomai-2.5.6
>>
>> On booting, the message appears
>> "MP-BIOS bug: 8254 timer not connected to IO-APIC",
>> But booted, and Laptop is hung on running latency.
>>
>> c) linux-2.6.37 with xenomai-2.5.6
>>
>> On booting, the message appears
>>
>> "MP-BIOS bug: 8254 timer not connected to IO-APIC", But booted.
>>
>> But shows only one cpu core instead of 4 cores! (on cat /proc/cpuinfo)
>>
>> d) linux-2.6.35.9 with xenomai-2.6.0
>>
>> On booting, the message appears
>>
>> "MP-BIOS bug: 8254 timer not connected to IO-APIC", But booted.
>>
>> Laptop hung on running Xenomai test programs
>>
>> [giving "noapic" as kernel boot argument also did n't help]
>>
>> e) linux-2.6.38.8 with xenomai-2.6.1
>>
>> ==> Can't boot
>> (5) I also tried with other PCs (Core duo / Pentium / with FC8) and had
>> same experience.
>> Can somebody please give some suggestions?
>>
>
> I think that you have more a "compile my kernel" frustration that a
> xenomai frustration. And then I'm not sure it's the better place to
> post.
>
> Before playing with Xenomai be sure you can build a standard version
> of the kernel on your machine and boot with it. Then you will be able
> to patch your kernel with Xenomai "quite easily" in following
> intructions.
>
> There are many instructions for building your kernel on the web, for instance :
> https://help.ubuntu.com/community/Kernel/Compile
> I personnaly use the "Alternate Build Method: The Old-Fashioned Debian
> Way" (maybe because I'm on Debian) which is quite simple and efficient
>
> The steps are always :
> 1_ getting linux kernel sources
> 2_ configuring kernel
> 3_ compiling
> 4_ installing
>
> 1/
> The current common method is using git. I personnaly using ketchup :
> http://www.linuxtopia.org/online_books/linux_kernel/kernel_configuration/apas04.html
> which is very clever to use (ketchup -r 3.X.X that's all). You should
> be able to get it from your packet manager.
>
> 2/
> The key to build successfully a kernel is to have a proper .config
> file (configuring kernel and modules). What often helps when starting
> from 0, is to get the .config file you are  currently using , which is
> in general in "/boot/config-[your kernel number]". You can get the
> current kernel number with "uname -a". Copy this file in your linux
> source tree

and rename it as ".config"


and then use "make menuconfig" or anything equivalent (you
> may forgot the "make oldconfig" for now. If you don't know what
> options mean you won't be able to pick anything different from default
> values anyway).
> You should manage the "Local Version" option which is under :
> "General Setup->Local version"
> to append a personnal version tag into your generated packet, so you
> may add a "fisrt-try" "second-try-nearly-working"
> "third-time-this-is-the-good-one"
>
>
>
> 3/ 4/ see documentation linked. If you have the buildchain installed
> (gcc, ...) it should not be a problem.
>
>
> when you manage to build and boot on you personnal recompiled kernel
> (choose a newer version from your current one for instance), then, and
> only then you will be able to try with xenomai, read and follow
> instructions and come back here to get support if necessary.
>
>
> P.S. : to xenomai community, is there a problem if I continue some
> support here, or should we go somewhere else more on topic ?
>
>
>> -Shamju Joseph
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai

