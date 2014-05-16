Message-ID: <53762667.4070009@xenomai.org>
Date: Fri, 16 May 2014 16:53:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1WlE09-0006CW-3k@sd-51317.dedibox.fr>
In-Reply-To: <E1WlE09-0006CW-3k@sd-51317.dedibox.fr>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : cobalt/shadow: drop
	spurious assertion
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 05/16/2014 11:00 AM, git repository hosting wrote:
> Module: xenomai-forge
> Branch: next
> Commit: fa0ad5d64caa346d29906bf602558396fc8220cd
> URL:    http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=fa0ad5d64caa346d29906bf602558396fc8220cd
>
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Fri May 16 11:01:40 2014 +0200
>
> cobalt/shadow: drop spurious assertion
>
> ---
>
>   kernel/cobalt/shadow.c |    2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/kernel/cobalt/shadow.c b/kernel/cobalt/shadow.c
> index 58a3820..c76c577 100644
> --- a/kernel/cobalt/shadow.c
> +++ b/kernel/cobalt/shadow.c
> @@ -118,8 +118,6 @@ static struct xnshadow_process *__process_hash_search(struct mm_struct *mm)
>   	unsigned bucket = process_hash_crunch(mm);
>   	struct xnshadow_process *p;
>
> -	atomic_only();
> -
>   	hlist_for_each_entry(p, &process_hash[bucket], hlink)
>   		if (p->mm == mm)
>   			return p;

Euh cette assertion me parait valide, il faut forcément le lock pour 
parcourir le hash.


-- 
					    Gilles.

