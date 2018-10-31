Subject: Re: [PATCH] Add the xsc field when rtps reads the sched/acct file.
References: <20181029062239.2566-1-christophe.blaess@logilin.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bdcbded6-a0c9-5aa9-3a4a-4371a62387a6@siemens.com>
Date: Wed, 31 Oct 2018 18:47:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181029062239.2566-1-christophe.blaess@logilin.fr>
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
To: Christophe BLAESS <christophe.blaess@logilin.fr>, xenomai@xenomai.org

On 29.10.18 07:22, Christophe BLAESS wrote:
> The rtps tools reads the /proc/xenomai/sched/acct file but didn't
> take the xsc field in account and failed to display some Xenomai
> threads. This patch adds the missing field when rtps reads a line.
> 
> Signed-off-by: Christophe Blaess <christophe.blaess@logilin.fr>
> ---
>   utils/ps/rtps.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/utils/ps/rtps.c b/utils/ps/rtps.c
> index bf5400e8d..6a07f110d 100644
> --- a/utils/ps/rtps.c
> +++ b/utils/ps/rtps.c
> @@ -25,15 +25,15 @@
>   #define PROC_ACCT  "/proc/xenomai/sched/acct"
>   #define PROC_PID  "/proc/%d/cmdline"
>   
> -#define ACCT_FMT_1  "%u %d %lu %lu %lu %lx %Lu %Lu %Lu"
> +#define ACCT_FMT_1  "%u %d %lu %lu %lu %lu %lx %Lu %Lu %Lu"
>   #define ACCT_FMT_2  ACCT_FMT_1 " %[^\n]"
> -#define ACCT_NFMT_1 9
> -#define ACCT_NFMT_2 10
> +#define ACCT_NFMT_1 10
> +#define ACCT_NFMT_2 11
>   
>   int main(int argc, char *argv[])
>   {
>   	char cmdpath[sizeof(PROC_PID) + 32], cmdbuf[BUFSIZ], acctbuf[BUFSIZ], name[64];
> -	unsigned long ssw, csw, pf, state, sec;
> +	unsigned long ssw, csw, xsc, pf, state, sec;
>   	unsigned long long account_period,
>   		exectime_period, exectime_total, v;
>   	unsigned int cpu, hr, min, msec, usec;
> @@ -49,12 +49,12 @@ int main(int argc, char *argv[])
>   
>   	while (fgets(acctbuf, sizeof(acctbuf), acctfp) != NULL) {
>   		if (sscanf(acctbuf, ACCT_FMT_2,
> -		      &cpu, &pid, &ssw, &csw, &pf, &state,
> +		      &cpu, &pid, &ssw, &csw, &xsc, &pf, &state,
>   		      &account_period, &exectime_period,
>   		      &exectime_total, name) != ACCT_NFMT_2) {
>   			strcpy(name, "");
>   			if (sscanf(acctbuf, ACCT_FMT_1,
> -			      &cpu, &pid, &ssw, &csw, &pf, &state,
> +			      &cpu, &pid, &ssw, &csw, &xsc, &pf, &state,
>   			     &account_period, &exectime_period,
>   			     &exectime_total) != ACCT_NFMT_1) {
>   				break;
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

