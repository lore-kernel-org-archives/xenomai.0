Message-ID: <48B3C1B3.2050404@domain.hid>
Date: Tue, 26 Aug 2008 10:41:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48B313B5.9050308@domain.hid> <48B32E0C.7000105@domain.hid>
	<48B33926.9060808@domain.hid> <48B3B999.6000707@domain.hid>
	<48B3BE60.4020709@domain.hid>
In-Reply-To: <48B3BE60.4020709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xnregistry_fetch & friends
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> But then I wonder
>>>>>
>>>>>  a) why xnregistry_fetch uses nklock at all (even for totally uncritical
>>>>>     XNOBJECT_SELF!)
>>>>>
>>>> registry_validate() returns a pointer we want to dereference; we'd better keep
>>>> this unpreemptable, although it's useless for the self-fetching op (which is an
>>>> unused calling mode so far). If using xnregistry_remove() while fetching the
>>>> object, the worst case is that your action ends up acting upon an object of the
>>>> same type, instead of the initially intended one. If that's a problem, goto safe;
>>> I still don't see the benefit in picking up the object pointer under
>>> nklock compared to the overhead of acquiring and releasing that lock.
>>> That's all not truly safe anyway. Even if you ensure that handle and
>>> object match, someone may change that pair before we can do the lookup
>>> under nklock.
>> Indeed, this is the whole point of the discussion unless I'm mistaken.
>>
>>> In my understanding, registry slots either contain NULL or a pointer to
>>> some object. If that object is valid, that is checked _after_ releasing
>>> the lock, so we are unsafe again, _nothing_ gained.
>> Yes, I agree. I was focusing on _put/_get which maintain the refcount and ought
>> to be locked, but solely fetching under lock makes no sense. It's probably a
>> paranoid surge about having dynamically allocated slots, which won't happen
>> anytime soon.
> 
> Then you are fine with this patch?
> 

Yes, only nitpicking about the else statement, but the logic is ok for me. While
your are at it, you may also want to move the other self-directed requests out
of the locked section.

> ---
>  ChangeLog               |    5 +++++
>  ksrc/nucleus/registry.c |   20 ++++----------------
>  2 files changed, 9 insertions(+), 16 deletions(-)
> 
> Index: b/ChangeLog
> ===================================================================
> --- a/ChangeLog
> +++ b/ChangeLog
> @@ -1,3 +1,8 @@
> +2008-08-26  Jan Kiszka  <jan.kiszka@domain.hid>
> +
> +	* ksrc/nucleus/registry.c (xnregistry_fetch): Remove pointless
> +	locking.
> +
>  2008-08-25  Jan Kiszka  <jan.kiszka@domain.hid>
>  
>  	* include/asm-generic/wrappers.h: Provide atomic_long wrappings.
> Index: b/ksrc/nucleus/registry.c
> ===================================================================
> --- a/ksrc/nucleus/registry.c
> +++ b/ksrc/nucleus/registry.c
> @@ -1150,28 +1150,16 @@ u_long xnregistry_put(xnhandle_t handle)
>  void *xnregistry_fetch(xnhandle_t handle)
>  {
>  	xnobject_t *object;
> -	void *objaddr;
> -	spl_t s;
>  
> -	xnlock_get_irqsave(&nklock, s);
> -
> -	if (handle == XNOBJECT_SELF) {
> -		objaddr = xnpod_primary_p()? xnpod_current_thread() : NULL;
> -		goto unlock_and_exit;
> -	}
> +	if (handle == XNOBJECT_SELF)
> +		return xnpod_primary_p()? xnpod_current_thread() : NULL;
>  
>  	object = registry_validate(handle);
>  
>  	if (object)
> -		objaddr = object->objaddr;
> +		return object->objaddr;
>  	else

-	else

> -		objaddr = NULL;
> -
> -      unlock_and_exit:
> -
> -	xnlock_put_irqrestore(&nklock, s);
> -
> -	return objaddr;
> +		return NULL;
+	return NULL;
>  }
>  
>  /*@}*/
> 


-- 
Philippe.

