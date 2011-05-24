Message-ID: <4DDB76C6.2090008@domain.hid>
Date: Tue, 24 May 2011 11:13:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DDA66CF.2010307@domain.hid> <4DDB349B.5030209@domain.hid>
In-Reply-To: <4DDB349B.5030209@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL] native: Fix msendq fastlock leakage
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 2011-05-24 06:31, Gilles Chanteperdrix wrote:
> On 05/23/2011 03:53 PM, Jan Kiszka wrote:
>> The following changes since commit aec30a2543afa18fa7832deee85e187b0faeb1f0:
>>
>>   xeno-test: fix reference to @XENO_TEST_DIR@ (2011-05-15 21:20:41 +0200)
>>
>> are available in the git repository at:
>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>
>> Jan Kiszka (1):
>>       native: Fix msendq fastlock leakage
>>
>>  include/native/task.h    |    5 +++++
>>  ksrc/skins/native/task.c |   13 ++++++-------
>>  2 files changed, 11 insertions(+), 7 deletions(-)
>>
>> ------8<------
>>
>> When a native task terminates without going through rt_task_delete, we
>> leaked the fastlock so far. Fix it by moving the release into the delete
>> hook. As the ppd is already invalid at that point, we have to save the
>> heap address in the task data structure.
> 
> I Jan, I once worked on a patch to reverse the ppd cleanup order, in order
> to fix bugs of this kind. Here it comes. I do not remember why I did not
> commit it, but I guess it was not working well. Could we restart working
> from this patch?
> 
> From 038ecf08cd66b3112e0fe277d71d294b8eb83bcc Mon Sep 17 00:00:00 2001
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Date: Sun, 29 Aug 2010 14:52:08 +0200
> Subject: [PATCH] nucleus: reverse ppd cleanup order
> 
> ---
>  ksrc/nucleus/shadow.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> index b2d4326..725ae43 100644
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -556,7 +556,7 @@ static unsigned ppd_lookup_inner(xnqueue_t **pq,
>  	}
>  	while (holder &&
>  	       (ppd->key.mm < pkey->mm ||
> -		(ppd->key.mm == pkey->mm && ppd->key.muxid < pkey->muxid)));
> +		(ppd->key.mm == pkey->mm && ppd->key.muxid > pkey->muxid)));
>  
>  	if (ppd->key.mm == pkey->mm && ppd->key.muxid == pkey->muxid) {
>  		/* found it, return it. */
> @@ -566,7 +566,7 @@ static unsigned ppd_lookup_inner(xnqueue_t **pq,
>  
>  	/* not found, return successor for insertion. */
>  	if (ppd->key.mm < pkey->mm ||
> -	    (ppd->key.mm == pkey->mm && ppd->key.muxid < pkey->muxid))
> +	    (ppd->key.mm == pkey->mm && ppd->key.muxid > pkey->muxid))
>  		*pholder = holder ? link2ppd(holder) : NULL;
>  	else
>  		*pholder = ppd;
> @@ -589,10 +589,11 @@ static int ppd_insert(xnshadow_ppd_t * holder)
>  	}
>  
>  	inith(&holder->link);
> -	if (next)
> +	if (next) {
>  		insertq(q, &next->link, &holder->link);
> -	else
> +	} else {
>  		appendq(q, &holder->link);
> +	}
>  	xnlock_put_irqrestore(&nklock, s);
>  
>  	return 0;
> @@ -640,7 +641,7 @@ static inline void ppd_remove_mm(struct mm_struct *mm,
>  	xnqueue_t *q;
>  	spl_t s;
>  
> -	key.muxid = 0;
> +	key.muxid = ~0UL;
>  	key.mm = mm;
>  	xnlock_get_irqsave(&nklock, s);
>  	ppd_lookup_inner(&q, &ppd, &key);

Unfortunately, that won't help. I think we are forced to clear
xnshadow_thrptd before calling into xnpod_delete_thread, but we would
need that for xnshadow_ppd_get (=>xnpod_userspace_p()).

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

