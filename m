Subject: =?utf-8?q?Re=3A_=5BI=2DPIPE=5D_ipipe=2Dcore=2D4=2E14=2E71=2Dx86=2D1_released?=
Date: Thu, 01 Nov 2018 17:59:38 +0100
From: =?utf-8?q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20181101175938.D29167FB@centrum.cz>
Content-Type: text/plain; charset="utf-8"
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

Hello.
 
Is it really finished?
I have problems to compile the patched kernel.
 
At first, when it compiles machine.c, there is such error:
  CC      arch/x86/xenomai/machine.o
In file included from ./include/asm-generic/xenomai/syscall.h:23:0,
                 from arch/x86/xenomai/include/asm/xenomai/syscall.h:24,
                 from arch/x86/xenomai/machine.c:22:
./arch/x86/include/asm/uaccess.h: In function ‘set_fs’:
./arch/x86/include/asm/uaccess.h:33:9: error: dereferencing pointer to incomplete type ‘struct task_struct’
  current->thread.addr_limit = fs;
         ^~
 
After an ad-hoc fix, there are some other errors for example during compiling of thread.c, mostly connected to fpu:
fpu.fpregs_active, fpu.active_state, __fpregs_deactivate(), __fpregs_activate(), clts(), stts(), SLAB_NOTRACK, ...
 
Am I doing something wrong?
 
Best regards
Petr
 

