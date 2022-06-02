Message-ID: <bf181341-b4ec-8137-9afa-1a4f1abab247@rambler.ru>
Date: Thu, 2 Jun 2022 23:04:14 +0300
MIME-Version: 1.0
Subject: Re: linux-evl: 5.18.1: build error for arch/arm
Content-Language: ru-RU
From: Leonid Gasheev via Xenomai <feedcom@rambler.ru>
References: <62e8601b-3066-959a-5436-5063ea61efe8@rambler.ru>
In-Reply-To: <62e8601b-3066-959a-5436-5063ea61efe8@rambler.ru>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

02.06.2022 18:44, Leonid Gasheev via Xenomai пишет:
> 
> A series of patches extracted from v5.18-evl-rebase has been applied to 
> the kernel version v5.18.1
> 
> toolchain/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin
> 
> Build for the arm64 architecture is completed successfully.
> But for arm:
> arch/arm/kernel/irq.c: In function ‘handle_arch_irq_pipelined’:
> arch/arm/kernel/irq.c:167:19: warning: cast between incompatible 
> function types from ‘int (*)(struct pt_regs *)’ to ‘void (*)(void *)’ 
> [-Wcast-function-type]
>     call_with_stack((void (*)(void *))handle_irq_pipelined, regs,
>                     ^
> arch/arm/kernel/entry-armv.S: Assembler messages:
> arch/arm/kernel/entry-armv.S:496: Error: instruction not allowed in IT 
> block -- `tst r0,r0'
> arch/arm/kernel/entry-armv.S:785: Error: instruction not allowed in IT 
> block -- `tst r1,#0x0001'
> make[2]: *** [scripts/Makefile.build:389: arch/arm/kernel/entry-armv.o] 
> Error 1

A similar situation with the 5.15.43 kernel.
The build for the arm fails:

arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:470: Error: instruction not allowed in IT 
block -- `tst r0,r0'
arch/arm/kernel/entry-armv.S:760: Error: instruction not allowed in IT 
block -- `tst r1,#0x0001'
make[2]: *** [scripts/Makefile.build:390: arch/arm/kernel/entry-armv.o] 
Error 1
make[1]: *** [scripts/Makefile.build:551: arch/arm/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1870: arch/arm] Error 2
make: *** Waiting for unfinished jobs....
kernel/audit_tree.c:33:9: error: redefinition of ‘struct node’
   struct node {
          ^~~~
In file included from ./include/linux/cpu.h:17,
                  from ./arch/arm/include/asm/cpu.h:11,
                  from ./arch/arm/include/asm/smp_plat.h:12,
                  from ./arch/arm/include/asm/irq_work.h:5,
                  from ./include/linux/irq_work.h:56,
                  from ./include/linux/irq.h:19,
                  from ./include/asm-generic/hardirq.h:17,
                  from ./arch/arm/include/asm/hardirq.h:10,
                  from ./include/linux/hardirq.h:12,
                  from ./include/linux/highmem.h:10,
                  from ./include/linux/bvec.h:10,
                  from ./include/linux/skbuff.h:17,
                  from kernel/audit.h:14,
                  from kernel/audit_tree.c:2:
./include/linux/node.h:84:8: note: originally defined here
  struct node {
         ^~~~
make[1]: *** [scripts/Makefile.build:288: kernel/audit_tree.o] Error 1


Any thoughts. I am grateful in advance.
-- 
Leonid Gasheev

