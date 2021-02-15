References: <ab085b30-c555-6259-a542-15a310c839e2@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] testsuite/smokey/sched-quote: Make more deterministic
 and simplify
In-reply-to: <ab085b30-c555-6259-a542-15a310c839e2@siemens.com>
Date: Mon, 15 Feb 2021 19:18:00 +0100
Message-ID: <87v9ati49z.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> As optimization can shrink __do_work to just two instruction, the
> calibration loop needs to run longer.
>
> At this chance, drop the pthread_kill to stop the thread and rely in
> both cases on the throttle mechanism.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  testsuite/smokey/sched-quota/sched-quota.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
> index 5c35b551d8..ff7c584e39 100644
> --- a/testsuite/smokey/sched-quota/sched-quota.c
> +++ b/testsuite/smokey/sched-quota/sched-quota.c
> @@ -199,13 +199,14 @@ static double run_quota(int quota)
>  	req.tv_nsec = 0;
>  	clock_nanosleep(CLOCK_MONOTONIC, 0, &req, NULL);
>  
> -	for (n = 0, count = 0; n < nrthreads; n++) {
> +	for (n = 0, count = 0; n < nrthreads; n++)
>  		count += counts[n];
> -		pthread_kill(threads[n], SIGDEMT);
> -	}
>  
>  	percent = ((double)count / TEST_SECS) * 100.0 / loops_per_sec;
>  
> +	atomic_set(&throttle, 1);
> +	smp_wmb();
> +
>  	for (n = 0; n < nrthreads; n++) {
>  		smokey_trace("done quota_thread[%d], count=%lu", n, counts[n]);
>  		pthread_cancel(threads[n]);
> @@ -224,7 +225,7 @@ static double run_quota(int quota)
>  static unsigned long long calibrate(void)
>  {
>  	struct timespec start, end, delta;
> -	const int crunch_loops = 10000;
> +	const int crunch_loops = 100000;
>  	unsigned long long ns, lps;
>  	unsigned long count;
>  	struct timespec req;
> @@ -255,10 +256,8 @@ static unsigned long long calibrate(void)
>  	req.tv_nsec = 0;
>  	clock_nanosleep(CLOCK_MONOTONIC, 0, &req, NULL);
>  
> -	for (n = 0, lps = 0; n < nrthreads; n++) {
> +	for (n = 0, lps = 0; n < nrthreads; n++)
>  		lps += counts[n];
> -		pthread_kill(threads[n], SIGDEMT);
> -	}
>  
>  	atomic_set(&throttle, 1);
>  	smp_wmb();
> -- 
> 2.26.2

Ack.

PS: another option for do_work() would have been to run hairy fp stuff
instead of a trivial integer increment, but I guess we don't care that
much if extending the loop count is enough.

-- 
Philippe.

