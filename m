Subject: Re: [PATCH] lib/cobalt: init: do not call pthread_atfork() from
 atfork() handlers
References: <20190503150939.3594-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <838373f1-0e7a-906c-f908-056a74ab17cf@siemens.com>
Date: Mon, 27 May 2019 09:17:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190503150939.3594-1-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 03.05.19 17:09, Philippe Gerum via Xenomai wrote:
> Since glibc 2.28, calling pthread_atfork() over the context of a fork
> handler hangs, due to unexpected recursive locking on a common lock
> both want to acquire.  To fix this, the cobalt fork handler needs to
> be registered outside of the atfork handling context it installs.
> 
> At this chance, group all base inits which do not need to be
> reiterated in the forkee to exclude them from the atfork context.
> 
> The problematic change was introduced between glibc-2.27.9000 and
> glibc-2.28 [1]; it triggered a bug in the glibc test suite [2].
> 
> [1] git://sourceware.org/git/glibc.git, 27761a104
> [2] git://sourceware.org/git/glibc.git, 669ff911e
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   lib/cobalt/init.c | 43 +++++++++++++++++++++++++------------------
>   1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
> index abd990692..02a99c569 100644
> --- a/lib/cobalt/init.c
> +++ b/lib/cobalt/init.c
> @@ -184,20 +184,26 @@ static void low_init(void)
>   	cobalt_ticks_init(f->clock_freq);
>   }
>   
> +static int cobalt_init_2(void);
> +
>   static void cobalt_fork_handler(void)
>   {
>   	cobalt_unmap_umm();
>   	cobalt_clear_tsd();
>   	cobalt_print_init_atfork();
> -	if (cobalt_init())
> +	if (cobalt_init_2())
>   		exit(EXIT_FAILURE);
>   }
>   
> -static void __cobalt_init(void)
> +static inline void commit_stack_memory(void)
>   {
> -	struct sigaction sa;
> +	char stk[PTHREAD_STACK_MIN / 2];
> +	cobalt_commit_memory(stk);
> +}
>   
> -	low_init();
> +static void cobalt_init_1(void)
> +{
> +	struct sigaction sa;
>   
>   	sa.sa_sigaction = cobalt_sigdebug_handler;
>   	sigemptyset(&sa.sa_mask);
> @@ -228,20 +234,9 @@ static void __cobalt_init(void)
>   			    " sizeof(cobalt_sem_shadow): %Zd!",
>   			    sizeof(sem_t),
>   			    sizeof(struct cobalt_sem_shadow));
> -
> -	cobalt_mutex_init();
> -	cobalt_sched_init();
> -	cobalt_thread_init();
> -	cobalt_print_init();
>   }
>   
> -static inline void commit_stack_memory(void)
> -{
> -	char stk[PTHREAD_STACK_MIN / 2];
> -	cobalt_commit_memory(stk);
> -}
> -
> -int cobalt_init(void)
> +static int cobalt_init_2(void)
>   {
>   	pthread_t ptid = pthread_self();
>   	struct sched_param parm;
> @@ -249,7 +244,12 @@ int cobalt_init(void)
>   
>   	commit_stack_memory();	/* We only need this for the main thread */
>   	cobalt_default_condattr_init();
> -	__cobalt_init();
> +
> +	low_init();
> +	cobalt_mutex_init();
> +	cobalt_sched_init();
> +	cobalt_thread_init();
> +	cobalt_print_init();
>   
>   	if (__cobalt_control_bind)
>   		return 0;
> @@ -288,12 +288,19 @@ int cobalt_init(void)
>   	return 0;
>   }
>   
> +int cobalt_init(void)
> +{
> +	cobalt_init_1();
> +
> +	return cobalt_init_2();
> +}
> +
>   static int get_int_arg(const char *name, const char *arg,
>   		       int *valp, int min)
>   {
>   	int value, ret;
>   	char *p;
> -	
> +
>   	errno = 0;
>   	value = (int)strtol(arg, &p, 10);
>   	if (errno || *p || value < min) {
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

