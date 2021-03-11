Subject: Re: [y2038][PATCH v3 4/4] y2038: lib/cobalt: Add support of
 sc_cobalt_sem_timedwait64
References: <20210308170206.313181-5-florian.bezdeka@siemens.com>
 <20210310130935.255197-1-florian.bezdeka@siemens.com>
 <20210310130935.255197-5-florian.bezdeka@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <60498293.1030201@tj.kylinos.cn>+7F1DE540BEABF820
Date: Thu, 11 Mar 2021 10:38:11 +0800
MIME-Version: 1.0
In-Reply-To: <20210310130935.255197-5-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org, jan.kiszka@siemens.com, rpm@xenomai.org, chensong@kylinos.cn



On 2021年03月10日 21:09, Florian Bezdeka via Xenomai wrote:
> In case libcobalt is build with -D_TIME_BITS=64
> sc_cobalt_sem_timedwait64 will be used instead of
> sc_cobalt_sem_timedwait.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>   lib/cobalt/semaphore.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/lib/cobalt/semaphore.c b/lib/cobalt/semaphore.c
> index 45705d48f..bff005440 100644
> --- a/lib/cobalt/semaphore.c
> +++ b/lib/cobalt/semaphore.c
> @@ -373,7 +373,12 @@ COBALT_IMPL(int, sem_timedwait, (sem_t *sem, const struct timespec *abs_timeout)
>
>   	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
>
> +#ifdef __USE_TIME_BITS64
> +	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, _sem,
> +			       abs_timeout);
> +#else
>   	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait, _sem, abs_timeout);
> +#endif
>
>   	pthread_setcanceltype(oldtype, NULL);
>
>

shall we take cobalt_features_available into account?

Song



