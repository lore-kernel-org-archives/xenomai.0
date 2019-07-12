Subject: Re: [PATCH 2/2] alchemy/mutex: Fix typo in comment
References: <20190710214612.27506-1-richard@nod.at>
 <20190710214612.27506-2-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <57fc51ff-d29d-2acb-d7a9-e5cfde319a22@siemens.com>
Date: Fri, 12 Jul 2019 12:16:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190710214612.27506-2-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>, xenomai@xenomai.org

On 10.07.19 23:46, Richard Weinberger via Xenomai wrote:
> s/rt_mutex_acquite/rt_mutex_acquire
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  lib/alchemy/mutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
> index ffdc2dbea323..42cd1375b34b 100644
> --- a/lib/alchemy/mutex.c
> +++ b/lib/alchemy/mutex.c
> @@ -182,7 +182,7 @@ out:
>   *
>   * - -EBUSY is returned upon an attempt to destroy the object
>   * referenced by @a mutex while it is referenced (for example, while
> - * being used in a rt_mutex_acquite(), rt_mutex_acquire_timed() or
> + * being used in a rt_mutex_acquire(), rt_mutex_acquire_timed() or
>   * rt_mutex_acquire_until() by another task).
>   *
>   * @apitags{mode-unrestricted, switch-secondary}
> 

Thanks, both applied to next. Will go to stable as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

