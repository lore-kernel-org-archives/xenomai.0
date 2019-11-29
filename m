Subject: Re: [PATCH 2/2] cobalt/sched: quota: fix use-after-free in
 quota_remove operation
References: <20191129150303.11116-1-rpm@xenomai.org>
 <20191129150303.11116-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <61ecd1f1-8bef-d120-0776-4e0feffed4c2@siemens.com>
Date: Fri, 29 Nov 2019 18:48:20 +0100
MIME-Version: 1.0
In-Reply-To: <20191129150303.11116-2-rpm@xenomai.org>
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

On 29.11.19 16:03, Philippe Gerum via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> KASAN detected this issue while removing a quota group, as a result of
> accessing members from the xnsched_quota_group struct after the
> container struct was freed.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/cobalt/posix/sched.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
> index f018ac3e8..7e457a9a8 100644
> --- a/kernel/cobalt/posix/sched.c
> +++ b/kernel/cobalt/posix/sched.c
> @@ -446,8 +446,12 @@ int set_quota_config(int cpu, union sched_config *config, size_t len)
>   		}
>   		list_del(&group->next);
>   		xnlock_put_irqrestore(&nklock, s);
> +		iq->tgid = tg->tgid;
> +		iq->quota = tg->quota_percent;
> +		iq->quota_peak = tg->quota_peak_percent;
> +		iq->quota_sum = quota_sum;

Good catch.

But do some of these setting make sense in the first place? Our manual says:

"All three operations fill in the @a config.info structure with the 
information reflecting the state of the scheduler on @a cpu with respect 
to @a policy, after the requested changes have been applied."

The group is gone now, so only quota_sum should have a meaning.

Jan

>   		xnfree(group);
> -		break;
> +		return 0;
>   	case sched_quota_set:
>   		xnlock_get_irqsave(&nklock, s);
>   		sched = xnsched_struct(cpu);
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

