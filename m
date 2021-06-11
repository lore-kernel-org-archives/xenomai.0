Subject: Re: [PATCH][3.x] kernel: syscall: Correctly check for x32
References: <20210611075706.29544-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4c58b839-6b7d-35f3-2900-2a0fa1ad0356@siemens.com>
Date: Fri, 11 Jun 2021 10:31:15 +0200
MIME-Version: 1.0
In-Reply-To: <20210611075706.29544-1-richard@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 11.06.21 09:57, Richard Weinberger via Xenomai wrote:
> Since 10.2 gcc it sets __ILP32__ even for i386.
> To check for x32 we need to check for __x86_64__ being set too.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> While x32 is gone in master, 3.x stable still has it.
> Without this patch it is not possible to build Xenomai for i386
> with a recent gcc toolchain.
> ---
>  kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
> index aa9936dfd..1626430c1 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
> @@ -18,7 +18,7 @@
>  #ifndef _COBALT_X86_ASM_UAPI_SYSCALL_H
>  #define _COBALT_X86_ASM_UAPI_SYSCALL_H
>  
> -#ifdef __ILP32__
> +#if defined(__x86_64__) && defined(__ILP32__)
>  #define __xn_syscall_base  __COBALT_X32_BASE
>  #else
>  #define __xn_syscall_base  0
> 

Thanks, applied to stable/v3.1.x. No one should be doing gcc-10 with
v3.0.x anymore...

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

