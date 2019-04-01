Subject: Re: [PATCH 2/2] Simplify xenomai_count_leading_zeros
References: <20190313171632.5276-1-norbert.lange@andritz.com>
 <20190313171632.5276-3-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <fefccab5-b11c-bde3-07e8-704d7bfe996e@web.de>
Date: Mon, 1 Apr 2019 19:50:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190313171632.5276-3-norbert.lange@andritz.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Lange <nolange79@gmail.com>, xenomai@xenomai.org

On 13.03.19 18:16, Norbert Lange via Xenomai wrote:
> Covers now all standard integer types,
> no need for corner cases.
>
> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
>   include/boilerplate/compiler.h | 27 +++++++--------------------
>   1 file changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compil=
er.h
> index e25ab5d2c..828755cc1 100644
> --- a/include/boilerplate/compiler.h
> +++ b/include/boilerplate/compiler.h
> @@ -72,32 +72,19 @@
>   extern "C" {
>   #endif
>
> -void __invalid_operand_size(void);
> -
>   #define xenomai_count_trailing_zeros(x)					\
>   	( (x) =3D=3D 0 ? (int)(sizeof(x) * __CHAR_BIT__)			\
>   	: sizeof(x) <=3D sizeof(unsigned) ? __builtin_ctz(x)		\
>   	: sizeof(x) <=3D sizeof(unsigned long) ? __builtin_ctzl(x)	\
>   	: __builtin_ctzll(x))
>
> -#define xenomai_count_leading_zeros(__v)				\
> -	({								\
> -		int __ret;						\
> -		if (!__v)						\
> -			__ret =3D sizeof(__v) * 8;			\
> -		else							\
> -			switch (sizeof(__v)) {				\
> -			case sizeof(int):				\
> -				__ret =3D __builtin_clz((unsigned int)__v); \
> -				break;					\
> -			case sizeof(long long):				\
> -				__ret =3D __builtin_clzll(__v);		\
> -				break;					\
> -			default:					\
> -				__invalid_operand_size();		\
> -			}						\
> -		__ret;							\
> -	})
> +#define xenomai_count_leading_zeros(x)					\
> +	(int)( (x) =3D=3D 0 ? sizeof(x) * __CHAR_BIT__			\
> +	: ( sizeof(x) <=3D sizeof(unsigned) ?				\
> +			__builtin_clz(x) + sizeof(unsigned) - sizeof(x)	\
> +		: sizeof(x) <=3D sizeof(unsigned long) ?			\
> +			__builtin_clzl(x) + sizeof(unsigned long) - sizeof(x) \
> +		: __builtin_clzll(x) + sizeof(unsigned long long) - sizeof(x)))
>
>   #ifdef __cplusplus
>   }
>

Looks functionally ok, but why is it differently structured than patch 1? =
Can we
use that formatting for this one as well?

Jan

