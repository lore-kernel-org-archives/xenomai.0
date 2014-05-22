Message-ID: <537E4E01.2030108@xenomai.org>
Date: Thu, 22 May 2014 21:20:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1400785908.61926.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <537E4DBE.5060406@xenomai.org>
In-Reply-To: <537E4DBE.5060406@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] threadobj_set_schedparam and SCHED_OTHER on mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/22/2014 09:19 PM, Philippe Gerum wrote:
> On 05/22/2014 09:11 PM, Matthias Schneider wrote:
>> Hi,
>>
>> Since commit
>>   2d102939333201169493688dd91258164bd9737c
>> copperplate: more robustness for threadobj_set_schedparam()
>>
>> threadobj_set_schedparam() seems no longer to allow
>> SCHED_OTHER on mercury, due to prepare_rr_corespec() always
>> returning SCHED_FIFO.
>>
>> i.e. threadobj_set_schedparam( prio 0, SCHED_OTHER) does not work
>> anymore.
>>
>
> This should help. With those latest changes, the issue with the priority
> range available for SCHED_RR with Cobalt should be fixed.
>
> diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
> index 8792927..dc5c905 100644
> --- a/lib/copperplate/threadobj.c
> +++ b/lib/copperplate/threadobj.c
> @@ -1486,7 +1486,9 @@ int threadobj_set_schedparam(struct threadobj
> *thobj, int policy,
>       if (thobj->schedlock_depth > 0)
>           return __bt(-EPERM);
>
> -    _policy = prepare_rr_corespec(thobj, policy, param_ex);
> +    _policy = policy;
> +    if (rr == SCHED_RR)
> +        _policy = prepare_rr_corespec(thobj, policy, param_ex);
>       /*
>        * NOTE: if the current thread suddently starves as a result
>        * of switching itself to a scheduling class with no runtime
>

Typo.

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index 8792927..4515c9e 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1486,7 +1486,9 @@ int threadobj_set_schedparam(struct threadobj 
*thobj, int policy,
  	if (thobj->schedlock_depth > 0)
  		return __bt(-EPERM);

-	_policy = prepare_rr_corespec(thobj, policy, param_ex);
+	_policy = policy;
+	if (policy == SCHED_RR)
+		_policy = prepare_rr_corespec(thobj, policy, param_ex);
  	/*
  	 * NOTE: if the current thread suddently starves as a result
  	 * of switching itself to a scheduling class with no runtime

-- 
Philippe.

