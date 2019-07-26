Subject: Re: [PATCH] derivers/autotune: Fix UBSAN warnings
References: <8be797d8-d03d-cb27-7944-d298f017b73b@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <cea9096e-8541-2f24-bdde-dcf05e6bc8cb@xenomai.org>
Date: Fri, 26 Jul 2019 17:20:26 +0200
MIME-Version: 1.0
In-Reply-To: <8be797d8-d03d-cb27-7944-d298f017b73b@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 7/26/19 5:01 PM, Jan Kiszka wrote:
> The calculations in add_sample can overflow into undefined behavior - or
> even generate wrong results. Address that by giving related fields in
> tuner_state more space.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/drivers/autotune/autotune.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune/autotune.c
> index 2629bf9d47..9728ad6ff1 100644
> --- a/kernel/drivers/autotune/autotune.c
> +++ b/kernel/drivers/autotune/autotune.c
> @@ -56,9 +56,9 @@ struct tuner_state {
>  	xnticks_t step;
>  	int min_lat;
>  	int max_lat;
> -	int prev_mean;
> -	int prev_sqs;
> -	int cur_sqs;
> +	long prev_mean;
> +	long prev_sqs;
> +	long cur_sqs;
>  	unsigned int sum;
>  	unsigned int cur_samples;
>  	unsigned int max_samples;
> 

s64/long long to enable the fix for 32bit archs too?

-- 
Philippe.

