References: <5730DF08.8080309@siemens.com> <5730E540.4030807@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5730E5BF.3030301@siemens.com>
Date: Mon, 9 May 2016 21:32:15 +0200
MIME-Version: 1.0
In-Reply-To: <5730E540.4030807@xenomai.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Prio ceiling mutex issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-05-09 21:30, Philippe Gerum wrote:
> On 05/09/2016 09:03 PM, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> we ran into at least one bug of the current prio ceiling support for
>> synch objects: on xnsynch_release, we only reschedule if we woken up a
>> new owner. But we also have to reschedule after dropping the ceiling
>> prio as some higher prio thread may be waiting.
>>
>> For that, I would propose to alter the return type and semantic of
>> xnsynch_release from "pointer to new owner" into "bool, true if
>> reschedule is needed". It seems, no caller of xnsynch_release makes a
>> non-boolean use of the return value anyway. And then we can simply
>> return true on "synch->status & XNSYNCH_PP".
> 
> I agree, but we need to keep the next owner check in the boolean status. Something like this would do I believe:
> 
> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
> index 976261d..f84cb6e 100644
> --- a/kernel/cobalt/synch.c
> +++ b/kernel/cobalt/synch.c
> @@ -913,10 +913,10 @@ static struct xnthread *transfer_ownership(struct xnsynch *synch,
>   *
>   * @coretags{primary-only, might-switch}
>   */
> -struct xnthread *xnsynch_release(struct xnsynch *synch,
> -				 struct xnthread *curr)
> +static bool xnsynch_release(struct xnsynch *synch,
> +			    struct xnthread *curr)
>  {
> -	struct xnthread *nextowner = NULL;
> +	bool resched = false;
>  	xnhandle_t currh, h;
>  	atomic_t *lockp;
>  	spl_t s;
> @@ -946,16 +946,18 @@ struct xnthread *xnsynch_release(struct xnsynch *synch,
>  	h = atomic_cmpxchg(lockp, currh, XN_NO_HANDLE);
>  	if ((h & ~XNSYNCH_FLCEIL) != currh)
>  		/* FLCLAIM set, synch is contended. */
> -		nextowner = transfer_ownership(synch, curr);
> +		resched = transfer_ownership(synch, curr) != NULL;
>  	else if (h != currh)	/* FLCEIL set, FLCLAIM clear. */
>  		atomic_set(lockp, XN_NO_HANDLE);
>  
> -	if (synch->status & XNSYNCH_PP)
> +	if (synch->status & XNSYNCH_PP) {
>  		clear_pp_boost(synch, curr);
> +		resched = true;
> +	}
>  
>  	xnlock_put_irqrestore(&nklock, s);
>  
> -	return nextowner;
> +	return resched;
>  }
>  EXPORT_SYMBOL_GPL(xnsynch_release);
>  
> 

OK, I didn't use bool (will change that), but otherwise did the same
with that two patches in for-forge. Or what do you mean?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

