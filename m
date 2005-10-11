Message-ID: <434BB728.3050704@domain.hid>
Date: Tue, 11 Oct 2005 14:59:20 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0510100450n19552d5fq@domain.hid>	
	<434A585B.40905@domain.hid>	
	<b647ffbd0510100529v2c96d260r@domain.hid>	
	<434A601C.7000605@domain.hid>	
	<b647ffbd0510102343w3828a0cs@domain.hid>	
	<434B6DA2.6080806@domain.hid>
	<b647ffbd0510110547u32cea8feg@domain.hid>
In-Reply-To: <b647ffbd0510110547u32cea8feg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [syscall.c] rt_bind_queue/heap()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> On 11/10/05, Philippe Gerum <rpm@xenomai.org> wrote:
> 
>>>...
>>>So,
>>>
>>>1) don't display such names in /proc;
>>>2) make a common mechanism for both spaces.
>>>
>>>rt_mutex_create()   // for other objects as well
>>>{
>>>...
>>>- xnobject_copy_name(mutex->name,name);
>>>+xnobject_create_name(mutex->name,name, object);
>>>...
>>>}
>>>
>>>xnobject_create_name(dst,src, object)
>>>{
>>>      if (src)
>>>            xnobject_copy_name(mutex->name,name);
>>>      else
>>>            snprintf(dst, XNOBJECT_NAME_LEN, "%p", object);
>>>}
>>>
>>>// the slightly ugly thing is that we need to be sure that dst is
>>>always object->name so it's really of XNOBJECT_NAME_LEN size.
>>>
>>
>>We should pass the size along with the copy buffer, mainly for readability, and
>>also as a safety belt.
> 
> 
> We don't need that at all, since now we don't want to change a
> behaviour of NULL-named objects created from kernel-space.
> 
> 
> 
>>>Frankly, I like this approach better. All objects get some name if
>>>they are NULL-named by a user and the code changes are a bit more
>>>graceful. To show them in /proc or not is still another question.
>>
>>I'd like we don't generalize an exception case here. The fact that for some
>>internal reason we need to put a dummy name on anon objects created from
>>user-space should not make all anon objects from kernel space have a registry
>>slot too, this would just be overkill (registry slots don't come for free actually).
>>
>>That said, the remaining point basically is: how do we avoid anon objects with
>>auto-generated names from appearing under /proc? I'm not a fan of "magic values"
>>which would distinguish a real name from a dummy one, so I'd rather use the
>>existing possibility of passing a NULL pnode pointer to rt_registry_enter(),
>>which would still index an object without actually exporting it to the /proc
>>interface. The question is: how could we make the *_create() calls invoking
>>rt_registry_enter() with a NULL pnode when applicable, without changing the
>>kernel-based interface of the API.
> 
> 
> Well, I guess the only way a given *_create() call may determine a
> certain environment (kernel mode vs. user mode) is by analyzing some
> of the given arguments (ok, in case of the user mode, a previous call
> on the stack has been one of the syscall.c:__rt_object_create() ones,
> so we may track the stack... ok-ok, I'm just kidding :)
> There are only 2 arguments: rt_object *object or char *name.
> We probably can't rely on the first one since it may contain anything
> and we don't want to force a user to set it up to something certain:
> 
> /* kernel mode */
> RT_MUTEX m;
> bzero(&m); // because we use some RT_MUTEX's internal fields when
> making a call from syscall.c:__rt_mutex_create(), e.g. m->handle =
> DONT_USE_REGISTRY;
> 
> rt_mutex_create(&m, NULL);
> 
> So the only way is to deal somehow with the "name" argument. There is
> a difference already.
> 
> rt_mutex_create() being called from:
> 
> 1) kernel mode:  name == NULL;
> 2) user mode:    name == "\0" (see, syscall.c:__rt_mutex_create(), so
> *name == NULL;
> 
> Then a fix would look like:
> 
> rt_object_create()
> {
> ...
> 
> - if (name && *name)
> + if (name)
>         {
> + if (*name)
>    err = rt_registry_enter(mutex->name,mutex,&mutex->handle,&__mutex_pnode);
> + else {
> + // this is a NULL-named object being created from the user-mode or
> + // "\0"-named object from the kernel-mode
> +xnobject_create_name(mutex->name, OBJNAME_MAX_SIZE, mutex);
> + err = rt_registry_enter(mutex->name,mutex,&mutex->handle,NULL);
> +}
> 
>         if (err)
>             rt_mutex_delete(mutex);
>         }
> }
> 
> Maybe a bit ugly but should work. eerrr... I can't come up with a
> better solution at the moment.
> 

At least the magic value here would make some sense, NULL=unregistered, 
empty=registered,not-exported, otherwise=registered,exported. Looks ok for that 
purpose, since we do need the additional 2nd state here.

-- 

Philippe.

