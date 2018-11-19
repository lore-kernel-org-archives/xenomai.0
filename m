Subject: Re: include/boilerplate/compiler.h breaks clang 3.9's arm_acle.h
References: <VI1PR0701MB21264AF72FDA99A8694C2E6AB5DE0@VI1PR0701MB2126.eurprd07.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d0e4aced-93eb-1e3c-ed39-7b406df3ee53@siemens.com>
Date: Mon, 19 Nov 2018 08:41:43 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR0701MB21264AF72FDA99A8694C2E6AB5DE0@VI1PR0701MB2126.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 17.11.18 01:38, Giulio Moro via Xenomai wrote:
> I have clang 3.9.1 (on Debian Stretch) on armv7.
> 
> the below minimal program clz-test.c:
> 
> ```
> #include <stdlib.h>
> #include <arm_acle.h>
> 
> int main()
> {
>      return __clz(0);
> }
> ```
> 
> will fail to build when compiled with
> 
> `clang -I/usr/xenomai/include/cobalt -I/usr/xenomai/include clz-test.c` , as follows:
> ```
> In file included from test-clz.c:2:
> /usr/lib/llvm-3.9/bin/../lib/clang/3.9.1/include/arm_acle.h:142:1: error: expected identifier or '('
> __clz(uint32_t __t) {
> ^
> /usr/xenomai/include/boilerplate/compiler.h:87:3: note: expanded from macro '__clz'
>          ({                                                              \
>           ^
> In file included from test-clz.c:2:
> /usr/lib/llvm-3.9/bin/../lib/clang/3.9.1/include/arm_acle.h:142:1: error: expected ')'
> /usr/xenomai/include/boilerplate/compiler.h:87:3: note: expanded from macro '__clz'
>          ({                                                              \
>           ^
> /usr/lib/llvm-3.9/bin/../lib/clang/3.9.1/include/arm_acle.h:142:1: note: to match this '('
> /usr/xenomai/include/boilerplate/compiler.h:87:2: note: expanded from macro '__clz'
>          ({                                                              \
>          ^
> 2 errors generated.
> ```
> 
> (compiler.h is included indirectly by `stdlib.h`)
> 
> This is because clang provides a definition of __clz as an inline function in /usr/lib/llvm-3.9/lib/clang/3.9.1/include/arm_acle.h :
> 
> static __inline__ uint32_t __attribute__((__always_inline__, __nodebug__))
> __clz(uint32_t __t) {
>    return __builtin_clz(__t);
> }
> 
> however, xenomai-3/include/boilerplate/compiler.h defines __clz() as a macro, hence the issue.
> 
> Note that compiler.h similarly defines a macro for __ctz , but that is not defined in clang's arm_acle.h, so no issue with that one.
> 
> The patch below addresses the issue, leveraging clang's `__has_builtin()` feature, while keeping things the same for gcc:
> 
> diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compiler.h
> index bcef7d4cc..8697a24b0 100644
> --- a/include/boilerplate/compiler.h
> +++ b/include/boilerplate/compiler.h
> @@ -83,6 +83,15 @@ void __invalid_operand_size(void);
>                  __ret;                                                  \
>          })
> 
> +#ifdef __clang__
> +#if __has_builtin(__builtin_clz)
> +#define DONT_DEF_CLZ
> +#endif /* has_builtin */
> +#endif /* __clang_ */
> +
> +#ifdef DONT_DEF_CLZ
> +#undef DONT_DEF_CLZ
> +#else /* DONT_DEF_CLZ */
>   #define __clz(__v)                                                     \
>          ({                                                              \
>                  int __ret;                                              \
> @@ -101,6 +110,7 @@ void __invalid_operand_size(void);
>                          }                                               \
>                  __ret;                                                  \
>          })
> +#endif /* DONT_DEF_CLZ */
> 
>   #ifdef __cplusplus
>   }
> 
> 

We should do

#define __clz	__clz

in the clang case and then

#ifndef __clz

That should save some boilerplate code. Could you send a proper patch (see 
CONTRIBUTING.md)?

Thanks!
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

