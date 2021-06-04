Subject: Re: [PATCH] testsuite/smokey/y2038: Clean up error tests
References: <906b8771-b3bd-78d4-150e-bcf032ec8d61@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <75b67624-dc2f-8e1d-18d7-41025fa4b576@siemens.com>
Date: Fri, 4 Jun 2021 14:28:31 +0200
In-Reply-To: <906b8771-b3bd-78d4-150e-bcf032ec8d61@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 04.06.21 14:07, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> No checks of ret against 0 needed in those cases.

ACK. We will take care in future series.

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index e81d23557..24580f5a8 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -105,7 +105,7 @@ static int test_sc_cobalt_sem_timedwait64(void)
>  	sem_post(&sem);
>  	ret = XENOMAI_SYSCALL2(sc_nr, &sem, NULL);
>  	if (!smokey_assert(!ret))
> -		return ret ? ret : -EINVAL;
> +		return ret;
>  
>  	/*
>  	 * The semaphore is already exhausted, so calling again will validate
> @@ -189,7 +189,7 @@ static int test_sc_cobalt_clock_gettime64(void)
>  	/* Provide a valid 64bit timespec */
>  	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_MONOTONIC, &ts64);
>  	if (!smokey_assert(!ret))
> -		return ret ? ret : -EINVAL;
> +		return ret;
>  
>  	/* Validate seconds only, nanoseconds might still be zero */
>  	smokey_assert(ts64.tv_sec != 0);
> @@ -227,7 +227,7 @@ static int test_sc_cobalt_clock_settime64(void)
>  	ts64.tv_nsec = now.tv_nsec;
>  	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_REALTIME, &ts64);
>  	if (!smokey_assert(!ret))
> -		return ret ? ret : -EINVAL;
> +		return ret;
>  
>  	ret = clock_gettime(CLOCK_REALTIME, &now);
>  	if (ret)
> @@ -276,7 +276,7 @@ static int test_sc_cobalt_clock_nanosleep64(void)
>  	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME,
>  			       &next, (void *)0xdeadbeefUL);
>  	if (!smokey_assert(!ret))
> -		return ret ? ret : -EINVAL;
> +		return ret;
>  
>  	ret = clock_gettime(CLOCK_MONOTONIC, &ts2);
>  	if (ret)
> @@ -292,7 +292,7 @@ static int test_sc_cobalt_clock_nanosleep64(void)
>  
>  	ret = XENOMAI_SYSCALL4(sc_nr, CLOCK_MONOTONIC, TIMER_ABSTIME, &next, &rmt);
>  	if (!smokey_assert(!ret))
> -		return ret ? ret : -EINVAL;
> +		return ret;
>  
>  	ret = clock_gettime(CLOCK_MONOTONIC, &ts1);
>  	if (ret)
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

