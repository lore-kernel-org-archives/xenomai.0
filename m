Subject: Re: [PATCH v3] y2038: testsuite/smokey/y2038: testcase for settime64
 and gettime64
References: <1617099822-19340-1-git-send-email-chensong@tj.kylinos.cn>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <86a5c936-e393-4598-b3b5-c22af9623ef2@siemens.com>
Date: Tue, 30 Mar 2021 21:54:24 +0200
In-Reply-To: <1617099822-19340-1-git-send-email-chensong@tj.kylinos.cn>
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
To: chensong <chensong@tj.kylinos.cn>, xenomai@xenomai.org

Hi Song!

On 30.03.21 12:23, chensong wrote:
> new test case for clock_settime64 and clock_gettime64 and reorganize
> run_2038.
> 
> If you want to trigger and verify y2038 problem, please be careful and
> make sure it has no impact to your test device.
> 
> Signed-off-by: chensong <chensong@tj.kylinos.cn>
> 
> ---
> v3:
> 1, rename structs, variables
> 2, reorganize registration in run_y2038
> 3, remove unnecessary definitions
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 109 ++++++++++++++++++++++++++++++---
>  1 file changed, 102 insertions(+), 7 deletions(-)
> 
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index 1d61bbd..b927a41 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -17,6 +17,36 @@
>  
>  smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
>  
> +
> +#define TEST_NAME(name) test_ ## name
> +struct test_info {
> +	char *name;
> +	int (*test_fn)(void);
> +};
> +
> +static int test_sc_cobalt_sem_timedwait64(void);
> +static int test_sc_cobalt_clock_gettime64(void);
> +static int test_sc_cobalt_clock_settime64(void);
> +
> +static struct test_info test_table[] = {
> +	{
> +		.name = "sc_cobalt_sem_timedwait64",
> +		.test_fn = TEST_NAME(sc_cobalt_sem_timedwait64),
> +	},
> +	{
> +		.name = "sc_cobalt_clock_gettime64",
> +		.test_fn = TEST_NAME(sc_cobalt_clock_gettime64),
> +	},
> +	{
> +		.name = "sc_cobalt_clock_settime64",
> +		.test_fn = TEST_NAME(sc_cobalt_clock_settime64),
> +	},
> +	{
> +		.name = NULL,
> +		.test_fn = NULL,
> +	},
> +};
> +
>  /*
>   * libc independent data type representing a time64_t based struct timespec
>   */
> @@ -25,7 +55,8 @@ struct xn_timespec64 {
>  	int64_t tv_nsec;
>  };
>  
> -#define NSEC_PER_SEC 1000000000
> +#define NSEC_PER_SEC		1000000000
> +#define USEC_PER_SEC		1000000
>  
>  static void ts_normalise(struct xn_timespec64 *ts)
>  {
> @@ -114,10 +145,10 @@ static int test_sc_cobalt_sem_timedwait64(void)
>  
>  	/*
>  	 * The semaphore is already exhausted, so calling again will validate
> -	 * the provided timeout now. Providing an invalid adress has to deliver
> +	 * the provided timeout now. Providing an invalid address has to deliver
>  	 * EFAULT
>  	 */
> -	ret = syscall(code, &sem, (void*) 0xdeadbeefUL);
> +	ret = syscall(code, &sem, (void *)0xdeadbeefUL);
>  	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
>  		return errno;
>  
> @@ -163,13 +194,77 @@ static int test_sc_cobalt_sem_timedwait64(void)
>  	return 0;
>  }
>  
> +static int test_sc_cobalt_clock_gettime64(void)
> +{
> +	long ret;
> +	int code = __xn_syscode(sc_cobalt_clock_gettime64);
> +	struct xn_timespec64 ts64;
> +
> +	/* Make sure we don't crash because of NULL pointers */
> +	ret = syscall(code, NULL, NULL);
> +	if (ret == -1 && errno == ENOSYS) {
> +		smokey_note("clock_gettime64: skipped. (no kernel support)");
> +		return 0; // Not implemented, nothing to test, success
> +	}
> +	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
> +		return errno;
> +
> +	/* Providing an invalid address has to deliver EFAULT */
> +	ret = syscall(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
> +	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
> +		return errno;
> +
> +	/* Provide a valid 64bit timespec*/
> +	ret = syscall(code, CLOCK_REALTIME, &ts64);
> +	if (!smokey_assert(ret == 0) || !smokey_assert(errno == EFAULT))
> +		return errno;
> +
> +	return 0;
> +}
> +
> +static int test_sc_cobalt_clock_settime64(void)
> +{
> +	long ret;
> +	int code = __xn_syscode(sc_cobalt_clock_settime64);
> +	struct xn_timespec64 ts64;
> +	struct timespec now;
> +
> +	/*Get current time and set it back at the end of the test*/
> +	clock_gettime(CLOCK_REALTIME, &now);
> +
> +	/* Make sure we don't crash because of NULL pointers */
> +	ret = syscall(code, NULL, NULL);
> +	if (ret == -1 && errno == ENOSYS) {
> +		smokey_note("clock_settime64: skipped. (no kernel support)");
> +		return 0; // Not implemented, nothing to test, success
> +	}
> +	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
> +		goto out;
> +
> +	/* Providing an invalid address has to deliver EFAULT */
> +	ret = syscall(code, CLOCK_REALTIME, (void *)0xdeadbeefUL);
> +	if (!smokey_assert(ret == -1) || !smokey_assert(errno == EFAULT))
> +		goto out;
> +
> +	/* Provide a valid 64bit timespec*/
> +	ts64.tv_sec  = now.tv_sec;
> +	ts64.tv_nsec = now.tv_nsec;
> +	ret = syscall(code, CLOCK_REALTIME, &ts64);
> +	if (!smokey_assert(ret == 0) || !smokey_assert(errno == EFAULT))
> +		goto out;
> +
> +out:
> +	clock_settime(CLOCK_REALTIME, &now);
> +	return errno;
> +}
> +
> +
>  static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
>  {
> -	int ret;
> +	struct test_info *ti;
>  
> -	ret = test_sc_cobalt_sem_timedwait64();
> -	if (ret)
> -		return ret;
> +	for (ti = test_table; ti->test_fn != NULL; ti++)
> +		ti->test_fn();

I guess that went to far now. The assertions inside the test functions
will show us where we failed, but they won't report the value of errno.
That has to be done here and was the main benefit of your approach.

Note that the "name" field of struct test_info and all related stuff is
completely unused if we don't use it here.
>  
>  	return 0;
>  }
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

