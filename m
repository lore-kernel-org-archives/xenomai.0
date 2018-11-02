Subject: =?utf-8?q?Re=3A_=5BI=2DPIPE=5D_ipipe=2Dcore=2D4=2E14=2E71=2Dx86=2D1_released?=
Date: Fri, 02 Nov 2018 14:20:31 +0100
From: =?utf-8?q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>
References: <20181101175938.D29167FB@centrum.cz>,
 <33f0bc4d-f8ef-9950-74ac-8b62bca6f015@xenomai.org>
 000000001f9d00090368043c91bd
In-Reply-To: 000000001f9d00090368043c91bd
MIME-Version: 1.0
Message-Id: <20181102142031.712D8BE3@centrum.cz>
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
To: =?utf-8?q?Henning_Schild?= <henning.schild@siemens.com>, =?utf-8?q?Philippe_Gerum?= <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

You are right.
The errors were because of version 3.0.7. I didn't realize, that prepare-kernel.sh script doesn't only apply the patch. But it also copies part of the xenomai to the kernel.
 
Meanwhile I tried the latest git (probably master branch). I got another error (simple to fix) in one of the rtnet drivers:
drivers/xenomai/net/drivers/e1000e/netdev.c: In function ‘e1000e_set_interrupt_capability’:
drivers/xenomai/net/drivers/e1000e/netdev.c:1225:11: error: implicit declaration of function ‘pci_enable_msix’; did you mean ‘pci_enable_msi’? [-Werror=implicit-function-declaration]
     err = pci_enable_msix(adapter->pdev,
           ^~~~~~~~~~~~~~~
           pci_enable_msi
 
Petr Cervenka
 
______________________________________________________________
> Od: "Henning Schild" <henning.schild@siemens.com>
> Komu: "Philippe Gerum" <rpm@xenomai.org>
> Datum: 02.11.2018 11:07
> Předmět: Re: [I-PIPE] ipipe-core-4.14.71-x86-1 released
>
> CC: <xenomai@xenomai.org>
Am Thu, 1 Nov 2018 18:38:47 +0100
 schrieb Philippe Gerum <rpm@xenomai.org>:
 
 > On 11/1/18 5:59 PM, Petr Červenka wrote:
 > > Hello.
 > >  
 > > Is it really finished?
 > > I have problems to compile the patched kernel.
 > >  
 > > At first, when it compiles machine.c, there is such error:
 > >   CC      arch/x86/xenomai/machine.o
 > > In file included from ./include/asm-generic/xenomai/syscall.h:23:0,
 > >                  from
 > > arch/x86/xenomai/include/asm/xenomai/syscall.h:24, from
 > > arch/x86/xenomai/machine.c:22: ./arch/x86/include/asm/uaccess.h: In
 > > function ‘set_fs’: ./arch/x86/include/asm/uaccess.h:33:9: error:
 > > dereferencing pointer to incomplete type ‘struct task_struct’
 > > current->thread.addr_limit = fs; ^~
 > >  
 > > After an ad-hoc fix, there are some other errors for example during
 > > compiling of thread.c, mostly connected to fpu: fpu.fpregs_active,
 > > fpu.active_state, __fpregs_deactivate(), __fpregs_activate(),
 > > clts(), stts(), SLAB_NOTRACK, ... Am I doing something wrong?
 > >    
 > 
 > You are likely not using the proper Xenomai branch, you need -next.
 
 I would not suggest next, master and stable/v3.0.x should do. But
 v3.0.7 and older will not work.
 
 As far as i understood we will soon have a v3.1, for people that like
 their releases ;).
 
 Henning

