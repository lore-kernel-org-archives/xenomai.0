Subject: Re: [PATCH 2/2] boilerplate: drop likely/unlikely annotations
References: <20201204114335.2513658-1-rpm@xenomai.org>
 <20201204114335.2513658-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <78f7e3fe-7703-de33-40ca-a6362df37adc@siemens.com>
Date: Fri, 11 Dec 2020 07:43:41 +0100
MIME-Version: 1.0
In-Reply-To: <20201204114335.2513658-2-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 04.12.20 12:43, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> We have no more in-tree users of these. Besides, let's assume that the
> CPU's branch predictor always has better clues than we might have when
> assessing the likeliness of a condition.
> 
> Bonus: this clears a recurring source of namespace clashes with C++
> frameworks like Boost.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  include/boilerplate/compiler.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compiler.h
> index 94b9f8cad..263af6b0c 100644
> --- a/include/boilerplate/compiler.h
> +++ b/include/boilerplate/compiler.h
> @@ -29,11 +29,6 @@
>  #define __stringify_1(x...)	#x
>  #define __stringify(x...)	__stringify_1(x)
>  
> -#ifndef likely
> -#define likely(x)	__builtin_expect(!!(x), 1)
> -#define unlikely(x)	__builtin_expect(!!(x), 0)
> -#endif
> -
>  #ifndef __noreturn
>  #define __noreturn	__attribute__((__noreturn__))
>  #endif
> 

Thanks, both applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

