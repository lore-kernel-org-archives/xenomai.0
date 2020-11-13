Subject: Re: [PATCH 1/3] cobalt uapi: Introducing new feature flag for
 settime64 availability
References: <1229be33-848d-ab5b-d6dd-1b7ae38d36f9@siemens.com>
 <20201113115932.276959-1-florian.bezdeka@siemens.com>
 <20201113115932.276959-2-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a3b9965d-57d1-6d41-4cac-5e462379a66d@siemens.com>
Date: Fri, 13 Nov 2020 14:25:07 +0100
MIME-Version: 1.0
In-Reply-To: <20201113115932.276959-2-florian.bezdeka@siemens.com>
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
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>

On 13.11.20 13:00, florian.bezdeka--- via Xenomai wrote:
> From: Florian Bezdeka <florian.bezdeka@siemens.com>
> 
> Adding a new feature flag to allow the library asking for settime64
> support. That will allow the library to use the new system call if it
> is available / supported by the kernel.
> 

As proposed in the other thread, we should state that this flag is
supposed to be dropped on the next major ABI revision update.

> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/uapi/asm-generic/features.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/cobalt/uapi/asm-generic/features.h b/include/cobalt/uapi/asm-generic/features.h
> index 8a4927c49..93a96670a 100644
> --- a/include/cobalt/uapi/asm-generic/features.h
> +++ b/include/cobalt/uapi/asm-generic/features.h
> @@ -51,6 +51,7 @@ struct cobalt_featinfo {
>  #define __xn_feat_nofastsynch 0x10000000
>  #define __xn_feat_control     0x08000000
>  #define __xn_feat_prioceiling 0x04000000
> +#define __xn_feat_settime64   0x02000000
>  
>  #ifdef CONFIG_SMP
>  #define __xn_feat_smp_mask __xn_feat_smp
> @@ -70,7 +71,8 @@ struct cobalt_featinfo {
>  #define __xn_feat_generic_mask			\
>  	(__xn_feat_smp_mask		|	\
>  	 __xn_feat_fastsynch_mask 	|	\
> -	 __xn_feat_prioceiling)
> +	 __xn_feat_prioceiling		|	\
> +	 __xn_feat_settime64 )
>  
>  /*
>   * List of features both sides have to agree on: If userland supports
> @@ -101,6 +103,8 @@ const char *get_generic_feature_label(unsigned int feature)
>  		return "control";
>  	case __xn_feat_prioceiling:
>  		return "prioceiling";
> +	case __xn_feat_settime64:
> +		return "settime64";
>  	default:
>  		return 0;
>  	}
> 

Jan
-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


