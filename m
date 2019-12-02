Subject: Re: [PATCH 5/5] testsuite/smokey: Add pthread_setschedprio to
 setsched test case
References: <cover.1575270738.git.jan.kiszka@siemens.com>
 <4af0372c57edcd1be1eb82ed7f8756d4ca4c5d69.1575270738.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8ae0167d-4ef1-8ef8-0d5e-a32f8459b395@siemens.com>
Date: Mon, 2 Dec 2019 10:19:14 +0100
MIME-Version: 1.0
In-Reply-To: <4af0372c57edcd1be1eb82ed7f8756d4ca4c5d69.1575270738.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org

On 02.12.19 08:12, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Now that this path goes via an own syscall, better test it.
> 
> At this chance, make sure that the test runs the scheduler changes from
> primary mode.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   testsuite/smokey/setsched/setsched.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/testsuite/smokey/setsched/setsched.c b/testsuite/smokey/setsched/setsched.c
> index f227f654cc..111de9f378 100644
> --- a/testsuite/smokey/setsched/setsched.c
> +++ b/testsuite/smokey/setsched/setsched.c
> @@ -77,6 +77,8 @@ static void *thread_body(void *arg)
>   	check_rt_schedparams(SCHED_FIFO, 1);
>   	check_linux_schedparams(SCHED_FIFO, 1);
>   
> +	cobalt_thread_harden();
> +

Seems this causes failures now when not building userspace with 
--enable-lazy-setsched. Will check if we can catch that case and handle 
it gracefully.

Jan

>   	if (smokey_check_status(cobalt_thread_stat(thread_pid, &stats)))
>   		pthread_exit((void *)(long)-EINVAL);
>   	msw = stats.msw;
> @@ -94,6 +96,23 @@ static void *thread_body(void *arg)
>   
>   	check_linux_schedparams(SCHED_FIFO, 2);
>   
> +	cobalt_thread_harden();
> +
> +	if (smokey_check_status(cobalt_thread_stat(thread_pid, &stats)))
> +		pthread_exit((void *)(long)-EINVAL);
> +	msw = stats.msw;
> +
> +	if (smokey_check_status(pthread_setschedprio(pthread_self(), 3)))
> +		pthread_exit((void *)(long)-EINVAL);
> +
> +	check_rt_schedparams(SCHED_FIFO, 3);
> +
> +	if (smokey_check_status(cobalt_thread_stat(thread_pid, &stats)) ||
> +	    !smokey_assert(stats.msw == msw))
> +		pthread_exit((void *)(long)-EINVAL);
> +
> +	check_linux_schedparams(SCHED_FIFO, 3);
> +
>   	return (void *)0L;
>   }
>   
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

