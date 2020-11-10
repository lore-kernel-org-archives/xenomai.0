Subject: Re: [PATCH 5/5] lib/cobalt/clock.c:dispatch clock_settime
References: <1604372743-2986-1-git-send-email-chensong@tj.kylinos.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0ca03935-6895-f31e-f9ad-c910e0e22e36@siemens.com>
Date: Tue, 10 Nov 2020 11:24:03 +0100
MIME-Version: 1.0
In-Reply-To: <1604372743-2986-1-git-send-email-chensong@tj.kylinos.cn>
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
To: chensong <chensong@tj.kylinos.cn>, xenomai@xenomai.org, henning.schild@siemens.com


On 03.11.20 04:05, chensong wrote:
> Regarding sizeof time_t, dispatch 32bit timespec to clock_settime
> and 64bit timespec to clock_settime64.
> 
> Signed-off-by: chensong <chensong@tj.kylinos.cn>
> ---
>  lib/cobalt/clock.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
> index 11fd1aa..44b2f3f 100644
> --- a/lib/cobalt/clock.c
> +++ b/lib/cobalt/clock.c
> @@ -237,7 +237,11 @@ COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct timespec *tp))
>  {
>  	int ret;
>  
> -	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
> +	if (sizeof(time_t) > 4)
> +		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime64,
> +					clock_id, tp);
> +	else
> +		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);

Maybe do a single

XENOMAI_SYSCALL2(sizeof(time_t) > 4 ? sc_cobalt_clock_settime64
                                    : sc_cobalt_clock_settime, ...)

But we need ABI revision negotiation here. If a new lib is run on a
kernel that does not have settime64, things will fail (the other way
around is fine). We need to ensure that new userspace can check for this
upfront while old userspace will happily run (hard requirement for
making these patches part of 3.1.x).

Jan

>  	if (ret) {
>  		errno = ret;
>  		return -1;
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

