Message-ID: <54F58A4C.7030006@xenomai.org>
Date: Tue, 03 Mar 2015 11:17:48 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
In-Reply-To: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>, xenomai@xenomai.org

On 03/03/2015 09:49 AM, Helder Daniel wrote:
> ./configure --with-core=mercury --enable-registry
> 
> When trying to run apps it gives me an error saying that the registry
> daemon is not working:
> 
>    3"004.187| WARNING: [main] cannot connect to registry daemon
>    3"004.187| BUG: [main] initialization failed, EAGAIN
> 
> Also could not find registry at /var/run/xenomai/...
> This folder is not even present.
>

If the registry could not be mounted, then you can't see it, that is
expected.

1. Do you have /var/run on your system?

2. Does passing --registry-root=/tmp to the application fix the issue?

3. Did you enable CONFIG_FUSE_FS in your kernel configuration? You need
this for supporting the new registry.

> But Apps were compiled with xenomai support, using xeno-config to get the
> parameters. The makefile that i use with my apps:
> 
> target =  simple
> skin   :=  native       #or in v3.x SKIN   :=  alchemy

For compat purpose with legacy Makefiles, you can use "native" with
xeno-config. It will implicitly translate this to "alchemy".

> I patch a kernel 2.14.28 with patch ipipe-core-3.14.28-x86-7.patch
> 
> I think this is the right patch for that kernel.
> It give me no errors when patching, but I am not sure because I tried
> before to patch kernel 2.16.2 with ipipe-core-3.16-x86-2.patch
> it gave me also no errors when patching, but then I suspected that maybe it
> is the wrong kernel source and that this patch is to apply on a 3.16
> kernel(3.16 not 3.16.2). Is this right?
> 

Sorry, I can't figure out whether you are actually reporting an issue,
or just thinking out loud. In any case, ipipe-core-3.16-x86-2 does not
mean that the relevant patch was based on 3.16.2. Instead, this means
that it's the second revision of that patch for 3.16[.0].
Note the architecture label separating the kernel release from the
revision number.

> So I patch another kernel, from kernel.org archives, with another patch:
> 
> kernel 2.14.28 with ipipe-core-3.14.28-x86-7.patch
> 
> hoping thats the right patch to this kernel.
> 
> When I run make menuconfig the Xenomai/cobalt section was present so i
> think the patch was applied correcty.
> 

There is no correlation here. You might have portions of the pipeline
patch failing to apply to your kernel, with the Xenomai Kconfig bits
applying properly. You would end up with a half-baked kernel in such an
event.

> I configure it according to xenomai install notes:
> 
> http://xenomai.org/installing-xenomai-3-x/#Configuring_and_compiling_the_Cobalt_kernel
> 
> namely:

> # CONFIG_CC_STACKPROTECTOR is not set
> # CONFIG_INPUT_PCSPKR is not set
> 

Disabling these ones is not required with Xenomai 3 over x86_32/64,
although I haven't enabled PCSPKR for ages. At any rate, the obsolete
TSC emulation code that required to disable it is gone.

> /usr/xenomai/bin/latency
> 
> it gives the error:
> 
> Xenomai/cobalt: low_init(): binding failed: Function not implemented error
> 

This is expected since the Cobalt core could not initialize on your system.

> The same with Apps of my own.
> 

All apps have to run low_init() successfully for attaching to the
real-time system, so this is expected too.

> I tried to find for xenomai in boot log with:
> 
> dmesg | grep -i xenomai
> 
> it returns me:
> 
> [    0.868031] [Xenomai] scheduling class idle registered.
> [    0.868031] [Xenomai] scheduling class rt registered.
> [    0.868031] [Xenomai] init failed, code -19
> 

The machine setup likely failed during the Xenomai inits. Typically,
failing to grab the hardware timer would beget this. I would try on real
hardware to confirm that the issue may be caused by the virtualized
platform.

> Also I noticed in the boot messages some issue with xenomai and udev:
> 
> udevd[337]: specified group 'xenomai' unknown

You have to define such group if you plan to apply this udev rule to
RTDM devices.

> PS: I am running on Debian 7.8 on a virtual machine (VMWare player 7) on a
> AMD Athlon processor and also on a dual core
> Intel core 2 duo P8600.
> I did not try to install on a physical pc yet because the idea is to get a
> VMware image Xenomai ready for student to run rigth at the beginning of the
> course.
> However previous versions of xenomai were sucessfuly ran over VMware, so I
> was not expecting issues here (but maybe I should try on a physicl pc)
> 

Xenomai 3 relies on the same pipeline series than Xenomai 2.x running on
recent kernels, there is nothing in the Cobalt core that will prevent
from running over a virtual environment. I'm not using VMware so I won't
comment further. KVM is fine and the preferred VM system among Xenomai
maintainers, some also reported success with virtualbox.

-- 
Philippe.

