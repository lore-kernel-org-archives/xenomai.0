Message-ID: <62e8601b-3066-959a-5436-5063ea61efe8@rambler.ru>
Date: Thu, 2 Jun 2022 18:44:13 +0300
MIME-Version: 1.0
Content-Language: ru-RU
From: Leonid Gasheev via Xenomai <feedcom@rambler.ru>
Subject: linux-evl: 5.18.1: build error for arch/arm
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


A series of patches extracted from v5.18-evl-rebase has been applied to 
the kernel version v5.18.1

toolchain/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin

Build for the arm64 architecture is completed successfully.
But for arm:
arch/arm/kernel/irq.c: In function ‘handle_arch_irq_pipelined’:
arch/arm/kernel/irq.c:167:19: warning: cast between incompatible 
function types from ‘int (*)(struct pt_regs *)’ to ‘void (*)(void *)’ 
[-Wcast-function-type]
    call_with_stack((void (*)(void *))handle_irq_pipelined, regs,
                    ^
arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:496: Error: instruction not allowed in IT 
block -- `tst r0,r0'
arch/arm/kernel/entry-armv.S:785: Error: instruction not allowed in IT 
block -- `tst r1,#0x0001'
make[2]: *** [scripts/Makefile.build:389: arch/arm/kernel/entry-armv.o] 
Error 1
-- 
Leonid Gasheev

