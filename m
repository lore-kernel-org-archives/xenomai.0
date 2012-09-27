Message-ID: <506496C2.9030302@xenomai.org>
Date: Thu, 27 Sep 2012 20:11:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkCgA42HcOWaLuzmkaLPaSW2zCTEux3rdzKmUYeu1Egzyg@mail.gmail.com>
In-Reply-To: <CAOiXNkCgA42HcOWaLuzmkaLPaSW2zCTEux3rdzKmUYeu1Egzyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Error requesting IRQ on DM3730 (BeagleBoard xM)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrey Nechypurenko <andreynech@googlemail.com>
Cc: xenomai@xenomai.org

On 09/27/2012 06:25 PM, Andrey Nechypurenko wrote:

> Hi,
> 
> I am currently working on simple RTDM driver for quadrature encoder
> and want to register the handler for interrupt from GPIO pin using
> rtdm_irq_request(). My platform is BeagleBoard xM (TI DM3730 ARM CPU),
> 3.2.21 Linux kernel with Xenomai-2.6.1.
> 
> When insmod-ing the driver for the very first time, I am getting the
> following error message. However, after rmmod-ing and inserting the
> driver again, the error message is not appearing any more. All
> subsequent insertions and removals also do not generate any errors.
> 
> [  109.244410] I-pipe: Detected stalled head domain, probably caused by a bug.
> [  109.244417]         A critical section may have been left unterminated.
> [  109.258596] [<c001250c>] (unwind_backtrace+0x0/0xe0) from
> [<c0075ba4>] (ipipe_request_irq+0x1c/0)
> [  109.269958] [<c0075ba4>] (ipipe_request_irq+0x1c/0xd0) from
> [<c007ca30>] (rthal_irq_request+0x34)
> [  109.281951] [<c007ca30>] (rthal_irq_request+0x34/0x3c) from
> [<c007ed48>] (xnintr_attach+0x54/0x1)
> [  109.292274] [<c007ed48>] (xnintr_attach+0x54/0x100) from
> [<c00b7c20>] (rtdm_irq_request+0x34/0x5)
> [  109.302221] [<c00b7c20>] (rtdm_irq_request+0x34/0x5c) from
> [<bf826890>] (initializeEncoders+0xa4)
> [  109.313102] [<bf826890>] (initializeEncoders+0xa4/0xe0 [tb6612fng])
> from [<bf826708>] (initpwm+0)
> [  109.324364] [<bf826708>] (initpwm+0x130/0x1a4 [tb6612fng]) from
> [<bf829094>] (init_module+0x94/0)
> [  109.334984] [<bf829094>] (init_module+0x94/0xf0 [tb6612fng]) from
> [<c0008748>] (do_one_initcall+)
> [  109.345146] [<c0008748>] (do_one_initcall+0x94/0x174) from
> [<c00653cc>] (sys_init_module+0x161c/)
> [  109.354948] [<c00653cc>] (sys_init_module+0x161c/0x17f4) from
> [<c000dbc0>] (ret_fast_syscall+0x0)
> [  109.364657] ------------[ cut here ]------------
> [  109.369472] WARNING: at include/linux/ipipe_debug.h:88
> xnintr_attach+0xb0/0x100()
> [  109.377267] Modules linked in: tb6612fng(O+) sdmak(O)
> lpm_omap3530(O) dsplinkk(O) cmemk(O) easycn
> [  109.391566] [<c001250c>] (unwind_backtrace+0x0/0xe0) from
> [<c0036028>] (warn_slowpath_common+0x4)
> [  109.401362] [<c0036028>] (warn_slowpath_common+0x4c/0x64) from
> [<c0036058>] (warn_slowpath_null+)
> [  109.411430] [<c0036058>] (warn_slowpath_null+0x18/0x1c) from
> [<c007eda4>] (xnintr_attach+0xb0/0x)
> [  109.423816] [<c007eda4>] (xnintr_attach+0xb0/0x100) from
> [<c00b7c20>] (rtdm_irq_request+0x34/0x5)
> [  109.434047] [<c00b7c20>] (rtdm_irq_request+0x34/0x5c) from
> [<bf826890>] (initializeEncoders+0xa4)
> [  109.444919] [<bf826890>] (initializeEncoders+0xa4/0xe0 [tb6612fng])
> from [<bf826708>] (initpwm+0)
> [  109.456206] [<bf826708>] (initpwm+0x130/0x1a4 [tb6612fng]) from
> [<bf829094>] (init_module+0x94/0)
> [  109.466824] [<bf829094>] (init_module+0x94/0xf0 [tb6612fng]) from
> [<c0008748>] (do_one_initcall+)
> [  109.478492] [<c0008748>] (do_one_initcall+0x94/0x174) from
> [<c00653cc>] (sys_init_module+0x161c/)
> [  109.489746] [<c00653cc>] (sys_init_module+0x161c/0x17f4) from
> [<c000dbc0>] (ret_fast_syscall+0x0)
> [  109.500334] ---[ end trace c1c770f3aa0b8c03 ]---
> 
> I am stuck searching for possible reasons for this error message and
> would appreciate any help or hints.


The message is likely a false positive. Could you post the init_module code?

-- 
                                                                Gilles.

