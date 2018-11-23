Subject: Re: [PATCH] Rename __clz to xenomai_count_leading_zeros
References: <VI1PR0701MB21260355274B872433DC1B60B5DA0@VI1PR0701MB2126.eurprd07.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b4ce6760-78c2-e6ca-ca5b-e7e30a1006e9@siemens.com>
Date: Fri, 23 Nov 2018 13:49:56 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR0701MB21260355274B872433DC1B60B5DA0@VI1PR0701MB2126.eurprd07.prod.outlook.com>
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
To: Giulio Moro <g.moro@qmul.ac.uk>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 22.11.18 13:41, Giulio Moro via Xenomai wrote:
>  From 398a77d3d172c10cda9826a7cc2a15266ff4c6a9 Mon Sep 17 00:00:00 2001
> From: Giulio Moro <giuliomoro@yahoo.it>
> Date: Sat, 10 Nov 2018 20:23:10 +0000
> Subject: [PATCH] Rename __clz to xenomai_count_leading_zeros.
> 
> This is to avoid namespace conflicts (e.g.: with Clang's arm_acle.h)
> 
> Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
> ---
>   include/boilerplate/compiler.h    | 2 +-
>   lib/boilerplate/heapmem.c         | 3 ++-
>   lib/copperplate/heapobj-heapmem.c | 3 ++-
>   lib/copperplate/heapobj-pshared.c | 3 ++-
>   4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compiler.h
> index ffeb6a4db..0fcc17be1 100644
> --- a/include/boilerplate/compiler.h
> +++ b/include/boilerplate/compiler.h
> @@ -93,7 +93,7 @@ void __invalid_operand_size(void);
>   		__ret;							\
>   	})
> 
> -#define __clz(__v)							\
> +#define xenomai_count_leading_zeros(__v)				\
>   	({								\
>   		int __ret;						\
>   		if (!__v)						\
> diff --git a/lib/boilerplate/heapmem.c b/lib/boilerplate/heapmem.c
> index 9b5e1a636..8728e0d15 100644
> --- a/lib/boilerplate/heapmem.c
> +++ b/lib/boilerplate/heapmem.c
> @@ -435,7 +435,8 @@ void *heapmem_alloc(struct heap_memory *heap, size_t size)
>   		bsize = size = HEAPMEM_MIN_ALIGN;
>   		log2size = HEAPMEM_MIN_LOG2;
>   	} else {
> -		log2size = sizeof(size) * CHAR_BIT - 1 - __clz(size);
> +		log2size = sizeof(size) * CHAR_BIT - 1 -
> +			xenomai_count_leading_zeros(size);
>   		if (log2size < HEAPMEM_PAGE_SHIFT) {
>   			if (size & (size - 1))
>   				log2size++;
> diff --git a/lib/copperplate/heapobj-heapmem.c b/lib/copperplate/heapobj-heapmem.c
> index 2b99b3d39..2737fa7ac 100644
> --- a/lib/copperplate/heapobj-heapmem.c
> +++ b/lib/copperplate/heapobj-heapmem.c
> @@ -68,7 +68,8 @@ int __heapobj_init_private(struct heapobj *hobj, const char *name,
>   int heapobj_init_array_private(struct heapobj *hobj, const char *name,
>   			       size_t size, int elems)
>   {
> -	size_t log2 = sizeof(size) * CHAR_BIT - 1 - __clz(size);
> +	size_t log2 = sizeof(size) * CHAR_BIT - 1 -
> +		xenomai_count_leading_zeros(size);
> 
>   	/*
>   	 * Heapmem aligns individual object sizes on the next ^2
> diff --git a/lib/copperplate/heapobj-pshared.c b/lib/copperplate/heapobj-pshared.c
> index 77b45844f..5310d9092 100644
> --- a/lib/copperplate/heapobj-pshared.c
> +++ b/lib/copperplate/heapobj-pshared.c
> @@ -488,7 +488,8 @@ static void *sheapmem_alloc(struct shared_heap_memory *heap, size_t size)
>   		bsize = size = SHEAPMEM_MIN_ALIGN;
>   		log2size = SHEAPMEM_MIN_LOG2;
>   	} else {
> -		log2size = sizeof(size) * CHAR_BIT - 1 - __clz(size);
> +		log2size = sizeof(size) * CHAR_BIT - 1 -
> +			xenomai_count_leading_zeros(size);
>   		if (log2size < SHEAPMEM_PAGE_SHIFT) {
>   			if (size & (size - 1))
>   				log2size++;
> --
> 2.11.0
> 
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

