Subject: Re: [PATCH 3/3] lib/cobalt: Introduce generic feature initialization
 and check API
References: <1229be33-848d-ab5b-d6dd-1b7ae38d36f9@siemens.com>
 <20201113115932.276959-1-florian.bezdeka@siemens.com>
 <20201113115932.276959-4-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <06f7264a-a5a2-b10b-4584-4e3a89104855@siemens.com>
Date: Fri, 13 Nov 2020 14:25:40 +0100
MIME-Version: 1.0
In-Reply-To: <20201113115932.276959-4-florian.bezdeka@siemens.com>
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
> The feature initialization was arch specific up to now and the
> available features (= features offered by the currently running kernel)
> were no longer accessible once the bind syscall finished.
> 
> This patch introduces a simple API for fetching the offered features
> during runtime.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  lib/cobalt/init.c     |  2 +-
>  lib/cobalt/internal.c | 10 ++++++++++
>  lib/cobalt/internal.h | 39 +++++++++++++++++++++++++++++++++++----
>  3 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
> index 6907ace36..20e28ccb0 100644
> --- a/lib/cobalt/init.c
> +++ b/lib/cobalt/init.c
> @@ -177,7 +177,7 @@ static void low_init(void)
>  		early_panic("mlockall: %s", strerror(errno));
>  
>  	trace_me("memory locked");
> -	cobalt_arch_check_features(f);
> +	cobalt_features_init(f);
>  	cobalt_init_umm(f->vdso_offset);
>  	trace_me("memory heaps mapped");
>  	cobalt_init_current_keys();
> diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
> index 43330060a..303d86f99 100644
> --- a/lib/cobalt/internal.c
> +++ b/lib/cobalt/internal.c
> @@ -565,3 +565,13 @@ void cobalt_assert_nrt(void)
>  	if (cobalt_should_warn())
>  		pthread_kill(pthread_self(), SIGDEBUG);
>  }
> +
> +unsigned int cobalt_features;
> +
> +void cobalt_features_init(struct cobalt_featinfo *f)
> +{
> +	cobalt_features = f->feat_all;
> +
> +	/* Trigger arch specific feature initialization */
> +	cobalt_arch_check_features(f);
> +}
> \ No newline at end of file
> diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
> index 4ca99d927..ac7ce24f3 100644
> --- a/lib/cobalt/internal.h
> +++ b/lib/cobalt/internal.h
> @@ -86,10 +86,6 @@ int cobalt_xlate_schedparam(int policy,
>  			    struct sched_param *param);
>  int cobalt_init(void);
>  
> -struct cobalt_featinfo;
> -
> -void cobalt_arch_check_features(struct cobalt_featinfo *finfo);
> -
>  extern struct sigaction __cobalt_orig_sigdebug;
>  
>  extern int __cobalt_std_fifo_minpri,
> @@ -98,4 +94,39 @@ extern int __cobalt_std_fifo_minpri,
>  extern int __cobalt_std_rr_minpri,
>  	   __cobalt_std_rr_maxpri;
>  
> +extern unsigned int cobalt_features;
> +
> +struct cobalt_featinfo;
> +
> +/**
> + * Arch specific feature initialization
> + *
> + * @param finfo
> + */
> +void cobalt_arch_check_features(struct cobalt_featinfo *finfo);
> +
> +/**
> + * Initialize the feature handling.
> + *
> + * @param f Feature info that will be cached for future feature checks
> + */
> +void cobalt_features_init(struct cobalt_featinfo *f)
> +	__attribute__((visibility("hidden")));

What will "hidden" do here?

> +
> +/**
> + * Check if a given set of features is available / provided by the kernel
> + *
> + * @param feat_mask A bit mask of features to check availability for. See
> + * __xn_feat_* macros for a list of defined features
> + *
> + * @return 1 if all features are available, 0 otherwise
> + */
> +inline int cobalt_features_available(unsigned int feat_mask)

Why not "static"?

And "bool" would be a better return type.

> +{
> +	if ((cobalt_features & feat_mask) == feat_mask)
> +		return 1;
> +
> +	return 0;

return ((cobalt_features & feat_mask) == feat_mask);

> +}
> +
>  #endif /* _LIB_COBALT_INTERNAL_H */
> 

Jan
-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


