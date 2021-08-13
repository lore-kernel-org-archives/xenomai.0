Subject: Re: [PATCH] testsuite/smokey: Fixing a registry leak of the
 posix_select test
References: <20210812163822.55293-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <36d9bb86-b497-d8dc-b57a-f30bb13f1683@siemens.com>
Date: Fri, 13 Aug 2021 08:59:53 +0200
MIME-Version: 1.0
In-Reply-To: <20210812163822.55293-1-florian.bezdeka@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 12.08.21 18:38, Florian Bezdeka wrote:
> According to POSIX message queues have kernel persistence, which means
> they are not cleaned up until the next reboot.
> 
> The test has a mq_unlink() as "precondition", so it will clean up
> failed test runs silently but /proc/xenomai/registry/usage will still
> report a "leak" once the test has completed.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/posix-select/posix-select.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testsuite/smokey/posix-select/posix-select.c b/testsuite/smokey/posix-select/posix-select.c
> index e9bf938b3..0a59e4968 100644
> --- a/testsuite/smokey/posix-select/posix-select.c
> +++ b/testsuite/smokey/posix-select/posix-select.c
> @@ -138,6 +138,8 @@ static int run_posix_select(struct smokey_test *t, int argc, char *const argv[])
>  	usleep(300000);
>  	smp_rmb();
>  	ret = test_status;
> +
> +	mq_unlink("/select_test_mq");
>  out:
>  	pthread_join(tcb, NULL);
>  	
> 

Why only cleaning up on successful runs, ie. why doing this before the
"out:" label?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

