Subject: Re: [PATCH 5/8] testsuite/smokey: reset main()'s SCHED_OTHER policy
 before each test
References: <20190601151502.27216-1-rpm@xenomai.org>
 <20190601151502.27216-6-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3bec3f3f-509a-69ff-bac1-aee18494bf90@siemens.com>
Date: Mon, 3 Jun 2019 13:09:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190601151502.27216-6-rpm@xenomai.org>
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

On 01.06.19 17:14, Philippe Gerum wrote:
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   testsuite/smokey/main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/testsuite/smokey/main.c b/testsuite/smokey/main.c
> index 12321dfc5..5702e825a 100644
> --- a/testsuite/smokey/main.c
> +++ b/testsuite/smokey/main.c
> @@ -22,6 +22,7 @@
>   
>   int main(int argc, char *const argv[])
>   {
> +	struct sched_param param = { .sched_priority = 0 };
>   	struct smokey_test *t;
>   	int ret, fails = 0;
>   
> @@ -29,6 +30,7 @@ int main(int argc, char *const argv[])
>   		return 0;
>   
>   	for_each_smokey_test(t) {
> +		pthread_setschedparam(pthread_self(), SCHED_OTHER, &param);
>   		ret = t->run(t, argc, argv);
>   		if (ret) {
>   			if (ret == -ENOSYS) {
> 

Is that a cosmetic cleanup, or did we see tests failing or doing the wrong 
thing? Just to clarify the importance of this fix, also for stable (a few word 
in the commit log would have done that trick for me ;) ).

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

