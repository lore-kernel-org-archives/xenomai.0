Subject: Re: [PATCH 1/2] cobalt/vfile: seq_file seek index must progress
References: <20210524073240.450274-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8a8f6cc0-02fc-8f3e-9ece-d016af28ec8a@siemens.com>
Date: Tue, 25 May 2021 08:00:15 +0200
MIME-Version: 1.0
In-Reply-To: <20210524073240.450274-1-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 24.05.21 09:32, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> The offset field we receive from the kernel in a vfile next() handler
> must progress in order for the loop to stop properly, independently
> from our own tracking of the end-of-list condition.
> 
> Bug is reproducible by running two loops in parallel:
> 
> - one continuously spawning an application which creates a few tenths
> of threads (10-20 would suffice) before exiting shortly after.
> 
> - another one continuously reading from /proc/xenomai/sched/{threads,
>   stat, acct}.
> 
> At some point, the vfile handler should cause a kernel crash.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  kernel/cobalt/vfile.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cobalt/vfile.c b/kernel/cobalt/vfile.c
> index c7b81a704..fae0cc377 100644
> --- a/kernel/cobalt/vfile.c
> +++ b/kernel/cobalt/vfile.c
> @@ -109,11 +109,11 @@ static void *vfile_snapshot_next(struct seq_file *seq, void *v, loff_t *offp)
>  	struct xnvfile_snapshot_iterator *it = seq->private;
>  	loff_t pos = *offp;
>  
> +	++*offp;
> +
>  	if (pos >= it->nrdata)
>  		return NULL;
>  
> -	++*offp;
> -
>  	return it->databuf + pos * it->vfile->datasz;
>  }
>  
> @@ -452,17 +452,15 @@ static void *vfile_regular_next(struct seq_file *seq, void *v, loff_t *offp)
>  	struct xnvfile_regular *vfile = it->vfile;
>  	void *data;
>  
> +	it->pos = ++(*offp);
> +
>  	if (vfile->ops->next == NULL)
>  		return NULL;
>  
> -	it->pos = *offp + 1;
> -
>  	data = vfile->ops->next(it);
>  	if (data == NULL)
>  		return NULL;
>  
> -	*offp = it->pos;
> -
>  	return data;
>  }
>  
> 

Thanks, applied to next and all stable branches.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

