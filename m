Subject: Re: [PATCH] testsuite/gpiobench: Do calculate avg latency once when
 test is interrupted
References: <20210902072703.18815-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ec49ed00-e0ca-21f3-d097-2cfbd30cbe9b@siemens.com>
Date: Thu, 2 Sep 2021 10:33:32 +0200
MIME-Version: 1.0
In-Reply-To: <20210902072703.18815-1-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 02.09.21 09:27, Hongzhan Chen via Xenomai wrote:
> When test is interrupted, avg latency need to be calcuated once
> to avoid large latency showing even though it may not be quite
> accurate.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
> index 50afbd418..50dc7aef7 100644
> --- a/testsuite/gpiobench/gpiobench.c
> +++ b/testsuite/gpiobench/gpiobench.c
> @@ -482,6 +482,18 @@ static void print_hist(void)
>  {
>  	int i;
>  
> +	if (ti.total_cycles < (ti.max_cycles - 1)) {
> +		/* test is interrupted and force to calculate
> +		 * even though it is not accurate but to avoid
> +		 * large latency surprising us.
> +		 */
> +		printf("test is interrupted and exit exceptionally\n");
> +		printf("Please run again till it exit normally\n");
> +
> +		ti.ts.inner_avg /= (ti.total_cycles * 2);
> +		ti.ts.outer_avg /= (ti.total_cycles * 2);
> +
> +	}
>  	printf("\n");
>  	printf("# Inner Loop Histogram\n");
>  	printf("# Inner Loop latency is the latency in kernel space\n"
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

