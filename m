References: <a01aeee1-306e-ba93-2a57-02a744f0e818@utpvision.it>
 <24f99f30-49c9-c4e7-5409-ac64b0f2894b@alaxarxa.net>
From: "Simone M. Zucchi" <simone.zucchi@utpvision.it>
Message-ID: <21c4631c-0003-0490-6ea7-c3afa6741ada@utpvision.it>
Date: Wed, 10 Jan 2018 14:04:30 +0100
MIME-Version: 1.0
In-Reply-To: <24f99f30-49c9-c4e7-5409-ac64b0f2894b@alaxarxa.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai 3.0.6 doesn't build the patched kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
thank you.
I cloned that git and proceeded the standard way (prepare-kernel.sh) but 
it fails anyway:

In file included from kernel/xenomai/bufd.c:23:0:
arch/x86/xenomai/include/asm/xenomai/syscall.h: In function 
‘__xn_get_syscall_nr’:
arch/x86/xenomai/include/asm/xenomai/syscall.h:46:31: error: implicit 
declaration of function ‘__COBALT_CALL32_SYSNR’ 
[-Werror=implicit-function-declaration]
  #define __xn_syscall(regs) __COBALT_CALL32_SYSNR(__xn_reg_sys(regs) \
                                ^
arch/x86/xenomai/include/asm/xenomai/syscall.h:60:32: note: in expansion 
of macro ‘__xn_syscall’
   return __xn_syscall_p(regs) ? __xn_syscall(regs) :
                                 ^~~~~~~~~~~~
cc1: some warnings being treated as errors
scripts/Makefile.build:293: recipe for target 'kernel/xenomai/bufd.o' failed
make[3]: *** [kernel/xenomai/bufd.o] Error 1
scripts/Makefile.build:544: recipe for target 'kernel/xenomai' failed
make[2]: *** [kernel/xenomai] Error 2
make[2]: *** Waiting for unfinished jobs....



I'm using kernel 4.9.51 with its relative ipipe patch...
Am I doing something wrong?
Thanks,

Simone

On 01/09/2018 10:24 AM, Leopold Palomo-Avellaneda wrote:
> On 09/01/18 09:33, Simone M. Zucchi wrote:
>> Hello everybody,
>> I've looked up at
>> https://xenomai.org/pipermail/xenomai/2017-November/037941.html and got the same
>> situation.
>> I was wondering if something has moved since November about Debian and 3.0.6.
>> Thanks,
> Please,
>
> check this repo
>
> https://anonscm.debian.org/gitweb/?p=collab-maint/xenomai.git
>
> that has the patches to solve this issue
>
> Leopold
>

