References: <6c55f15a-66ea-a9cd-943b-ed568f229984@xenomai.org>
 <85bfdeed-375d-7073-a53f-d9d5d22f8778@alaxarxa.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <62be2b45-b6f7-30b9-b3ee-891acd75ac60@xenomai.org>
Date: Mon, 20 Nov 2017 14:38:52 +0100
MIME-Version: 1.0
In-Reply-To: <85bfdeed-375d-7073-a53f-d9d5d22f8778@alaxarxa.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
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
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 11/20/2017 01:14 PM, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> trying to build the new Xenomai version (3.0.6), after have prepared the linux
> sources, I got this error:
> 
> In file included from arch/x86/xenomai/machine.c:22:0:
> arch/x86/xenomai/include/asm/xenomai/syscall.h: In function ‘__xn_get_syscall_nr’:
> arch/x86/xenomai/include/asm/xenomai/syscall.h:46:31: error: implicit
> declaration of function ‘__COBALT_CALL32_SYSNR’
> [-Werror=implicit-function-declaration]
>   #define __xn_syscall(regs)    __COBALT_CALL32_SYSNR(__xn_reg_sys(regs) \
>                                 ^
> arch/x86/xenomai/include/asm/xenomai/syscall.h:60:32: note: in expansion of
> macro ‘__xn_syscall’
>    return __xn_syscall_p(regs) ? __xn_syscall(regs) :
>                                  ^~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> I have used the prepare-kernel script and built the Debian packages. The
> platform is a Debian Stretch (amd64) with the default compiler.
> 
> linux version linux-4.9.51 and
> 
> http://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.9.51-x86-4.patch
> 
> as a patch.
> 
> 
> 

As a work around, drop CONFIG_IA32_EMULATION if you don't need it.

-- 
Philippe.

