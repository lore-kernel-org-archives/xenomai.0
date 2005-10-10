Message-ID: <434A57A5.1070207@domain.hid>
Date: Mon, 10 Oct 2005 13:59:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0510100450n19552d5fq@domain.hid>
In-Reply-To: <b647ffbd0510100450n19552d5fq@domain.hid>
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
>>>One more thing. I had a discussion with Steven Seeger regarding the use
>>>of NULL-named objects from the user space. I cc'ed you but probably you
>>>were too buzy at that time. The problem is that one may create
>>>successfully a NULL-named object but then there is no way to use it
>>>since all further calls give an error (some funny stuff there indeed :)
>>>
>>>So a simple fix would look like:
>>>
>>>for all rt_OBJECT_create() calls in libnative:
>>>
>>>int rt_mutex_create(RT_MUTEX *mutex, const char *name)
>>>{
>>>
>>>+ if (!name)
>>>+ return -E_SOMETHING; // E_INVAL?
>>>
>>>return XENOMAI_SKINCALL2(__xeno_muxid,
>>>__xeno_mutex_create,
>>>mutex,
>>>name);
>>>}
>>>
>>>What do you think? Or are there any reasons to keep it as is now?
>>>
> 
> 
>>The reason is to allow anonymous objects to be created, so that the descriptor
>>could only be shared by tasks belonging to the same address space if they
>>happen
>>to all have access to the descriptor's memory. Kind of semi-private object if
>>you want. The fact that such an object is non-bindable should not make it
>>unusable actually.
> 
> 
> Well, but it's unusable (from the user space app.) indeed. I have
> checked it with a simple example and the original overview is enclosed
> below as is.
>

As you noticed below, the point is that this feature should be active for 
kernel-based code only; for user-space, we're toast: typical chicken-and-egg 
problem since we need the registry to cross the space boundaries but the 
registry requires a name to index the object first. So yes, we need to check for 
anonymous calls in every service taking a symbolic name in native/syscalls.c, 
and return -EINVAL when applicable.

> ====================
> I have cc:'ed Philippe since the code backtrace would be of interest
> mainly for him :)
> 
> Here is a misbehaviour of the native skin and, well, partially your's :)
> The problem is that it allows you creating of an object with a NULL
> name, but such an object will not get a record in the registry when
> created from the user-mode! This said, one can use NULL-named objects
> only from the kernel-mode when there is a direct access to the real
> RT_MUTEX structure.
> 
> Look,
> 
> rt_mutex_create()
> {
> ...
>    if (name && *name)
>         {
>         err = rt_registry_enter(mutex->name,mutex,&mutex->handle,&__mutex_pnode);
> 
> and in our case, name == "\0".
> 
> So when a creation is completed, mutex->handle == 0!
> 
> Then, goes more fun
> 
> syscall.c::__rt_mutex_delete() or __rt_mutex_lock()
> {
> ...
>  mutex = (RT_MUTEX *)rt_registry_fetch(ph.opaque);
> 
> // we know that ph.opaque == 0, so guess what would be returned? Heh,
> a handle of the current task! :)
> 
> 
> void *rt_registry_fetch (rt_handle_t handle)
> 
> {
> ...
>     if (handle == RT_REGISTRY_SELF)	// RT_REGISTRY_SELF == 0. What a
> coincidence! :)
> 	{
> 	if (!xnpod_primary_p())	// not our case if we are in the primiry mode
>             {
>             objaddr = NULL;
>             goto unlock_and_exit;
>             }
> 
> 	// that's our case
> 
>         if (xnpod_current_thread()->magic == RTAI_SKIN_MAGIC)
>             {
>             objaddr = rtai_current_task();	<=== (*)
>             goto unlock_and_exit;
>             }
>         }
> ...
> 
> So rt_registry_fetch() returns a valid handle but of the current task
> and not of a mutex.
> 
> Then __rt_mutex_delete() procedes (mutex != NULL) and calls
> rt_mutex_delete() which, in turn, calls
> 
>   mutex = rtai_h2obj_validate(mutex,RTAI_MUTEX_MAGIC,RT_MUTEX);
> 
>     if (!mutex)
>         {
>         err = rtai_handle_error(mutex,RTAI_MUTEX_MAGIC,RT_MUTEX);
>         goto unlock_and_exit;
>         }
> 
> Since this object is not of RTAI_MUTEX_MAGIC type, the EINVAL error occurs.
> 
> So to sum it up.
> 
> You have been able to create all your objects but haven't been able to
> use them properly. Probably, you are not checking a result of
> rt_mutex_lock() otherwise you would be able to get EINVAL error even
> yesterday.
> 
> Why you can't do it today? Since you have been able to create the
> NULL-named objects (that leads to allocating some memory from the
> heap) but rt_mutex_delete() failed all the time (ok, I know, who cares
> about the proper error checking when deleting :) - the memory was not
> freed. So all your heap has gone by today. You haven't reloaded
> modules, have you?
> 
> So it must be fixed. There must be an explicit prohibition on creating
> NULL-named objects from the user-mode.
> 
> --
> Best regards,
> Dmitry Adamushko
> 


-- 

Philippe.

