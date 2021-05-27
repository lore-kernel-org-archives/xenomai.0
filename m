Subject: Re: error: implicit declarations while compiling
 (xenomai3.1+ubuntu20.04)
References: <CAB9YM8jgdbEYTB8Sb7212KWcLEkRDSVjEYZ8P2qCCStaX9CuPQ@mail.gmail.com>
 <a8412431-ccfb-dcc9-dfba-2da5374bcf1a@siemens.com>
 <CAB9YM8hdM5R9nsALRGQnXZ4hX0drJdYMDy=OroH92EzA_rqi5A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f2b82aaf-f92e-ea00-e871-f089562f5a00@siemens.com>
Date: Thu, 27 May 2021 14:01:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAB9YM8hdM5R9nsALRGQnXZ4hX0drJdYMDy=OroH92EzA_rqi5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Jo=c3=a3o_Costa?= <joaocostalapin@gmail.com>
Cc: xenomai@xenomai.org

On 27.05.21 13:52, João Costa wrote:
> Thanks for your feedback.
> 
> I had no report of errors in the CLI while patching the kernel.  
> In attach you may find the .config file I am using.
> 

Thanks, will give that a try.

> I see that by default [1] goes to the ipipe-x86-4.19.y-cip
> If I change the branch/tag to ipipe-core-5.4.77-x86-2 [2] will I by
> getting the prepatched one for the version I was previously trying to use?
> 

Correct.

Jan

> Thanks
> 
> [1] https://source.denx.de/Xenomai/ipipe-x86
> <https://source.denx.de/Xenomai/ipipe-x86>
> [2] https://source.denx.de/Xenomai/ipipe-x86/-/tree/ipipe-core-5.4.77-x86-2
> <https://source.denx.de/Xenomai/ipipe-x86/-/tree/ipipe-core-5.4.77-x86-2>
> 
> 
> 
> 
> Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>
> escreveu no dia quarta, 26/05/2021 à(s) 06:03:
> 
>     On 25.05.21 20:03, João Costa via Xenomai wrote:
>     > Hello,
>     >
>     > I am having some problems with a fresh install of Xenomai 3.1 and
>     I was
>     > hoping that someone could help me out solving those
>     >  or by sharing some installation instructions for dummies.
>     >
>     > *Test bench configuration:*
>     > -Ubuntu server 20.04.2 running kernel 5.4.0-73-generic
>     > -Xenomai version 3.1
>     > -Kernel downloaded for patch/installation: linux-5.4.77.tar.gz
>     (since I
>     > could not find an exact match with ipipe patch and the kernel already
>     > running)
>     > -ipipe-core-5.4.77-x86-2.patch
>     >
>     > *I am following this instructions:*
>     > - https://www.programmersought.com/article/14375437246/
>     <https://www.programmersought.com/article/14375437246/>
>     > - had the need to install/change some packages " gcc
>     libncurses-dev flex
>     > bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev
>     > libiberty-dev build-essential kernel-package"
>     > - assumed that where is written:
>     > $makeolddefconfig
>     > it should be
>     > $make oldconfig
>     >
>     > *I am getting the following errors:*
>     > *after running* " CONCURRENCY_LEVEL=8 make-kpkg  --rootcmd fakeroot
>     > --initrd  --revision=1.0.0 kernel_image kernel_headers "
>     > *#1*
>     >
>     >> kernel/ipipe/core.c: In function ‘__ipipe_spin_lock_irqsave’:
>     >> kernel/ipipe/core.c:547:9: error: implicit declaration of function
>     >> ‘arch_mangle_irq_bits’ [-Werror=implicit-function-declaration]
>     >>   547 |  return arch_mangle_irq_bits(s, flags);
>     >>       |         ^~~~~~~~~~~~~~~~~~~~
>     >>   CC      kernel/sched/cputime.o
>     >>
>     > *#2*
>     >
>     >> kernel/ipipe/core.c: In function ‘__ipipe_spin_unlock_irqrestore’:
>     >> kernel/ipipe/core.c:574:7: error: implicit declaration of function
>     >> ‘arch_demangle_irq_bits’; did you mean ‘arch_early_irq_init’?
>     >> [-Werror=implicit-function-declaration]
>     >>   574 |  if (!arch_demangle_irq_bits(&x))
>     >>       |       ^~~~~~~~~~~~~~~~~~~~~~
>     >>       |       arch_early_irq_init
>     >>
>     > *#3*
>     >
>     >>  arch/x86/kernel/process.c: In function ‘mwait_idle’:
>     >> arch/x86/kernel/process.c:699:4: error: implicit declaration of
>     function
>     >> ‘__ipipe_halt_root’; did you mean ‘ipipe_test_root’?
>     >> [-Werror=implicit-function-declaration]
>     >>   699 |    __ipipe_halt_root(1);
>     >>       |    ^~~~~~~~~~~~~~~~~
>     >>       |    ipipe_test_root
>     >
>     > cc1: some warnings being treated as errors
>     >>
>     >
>     >
>     >> make[3]: *** [scripts/Makefile.build:266:
>     arch/x86/kernel/process.o] Error
>     >> 1
>     >> make[2]: *** [scripts/Makefile.build:500: arch/x86/kernel] Error 2
>     >> make[1]: *** [Makefile:1729: arch/x86] Error 2
>     >
>     >
>     >  make[1]: *** [Makefile:1729: kernel] Error 2
>     >
>     >
>     > *Notes:*
>     > - I am not sure it my answers when executing the $make oldconfig
>     were the
>     > correct ones and/or can be related to these problems
>     > - Also, the checks/unchecks in the kernel menu ($menuconfig) are not
>     > exactly like the ones on those instructions since there are items
>     that do
>     > not appear or are enabled/embedded by default and cannot be unselected
>     >
> 
>     Strange. There was either a problem with patching the kernel (you can
>     cross-check by downloading a prepatched one from [1]), or you found a
>     .config that exposes a build error (then please share it).
> 
>     Jan
> 
>     [1] https://source.denx.de/Xenomai/ipipe-x86
>     <https://source.denx.de/Xenomai/ipipe-x86>
> 
>     -- 
>     Siemens AG, T RDA IOT
>     Corporate Competence Center Embedded Linux
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

