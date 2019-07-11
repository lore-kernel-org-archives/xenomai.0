Subject: Re: [PATCH 1/2] demo/alchemy/altency: Use sigdebug_reason()
References: <20190710214612.27506-1-richard@nod.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cb8c32d6-60e9-f31e-0089-b104dbf6694e@xenomai.org>
Date: Thu, 11 Jul 2019 10:25:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190710214612.27506-1-richard@nod.at>
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

On 7/10/19 11:46 PM, Richard Weinberger via Xenomai wrote:
> Since cobalt adds 0xfccf0000 to si_value we can no longer
> use the raw value.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  demo/alchemy/altency.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/demo/alchemy/altency.c b/demo/alchemy/altency.c
> index 83cc806b5d7f..4b49755edaba 100644
> --- a/demo/alchemy/altency.c
> +++ b/demo/alchemy/altency.c
> @@ -461,7 +461,7 @@ static void sigdebug(int sig, siginfo_t *si, void *context)
>  {
>  	const char fmt[] = "%s, aborting.\n"
>  		"(enabling CONFIG_XENO_OPT_DEBUG_TRACE_RELAX may help)\n";
> -	unsigned int reason = si->si_value.sival_int;
> +	unsigned int reason = sigdebug_reason(si);
>  	int n __attribute__ ((unused));
>  	static char buffer[256];
>  
> 

Ack.

-- 
Philippe.

