Message-ID: <434B6DA2.6080806@domain.hid>
Date: Tue, 11 Oct 2005 09:45:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <b647ffbd0510100450n19552d5fq@domain.hid>	
	<434A585B.40905@domain.hid>	
	<b647ffbd0510100529v2c96d260r@domain.hid>	
	<434A601C.7000605@domain.hid>
	<b647ffbd0510102343w3828a0cs@domain.hid>
In-Reply-To: <b647ffbd0510102343w3828a0cs@domain.hid>
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
> On 10/10/05, Philippe Gerum <rpm@xenomai.org> wrote:
> 
>>Dmitry Adamushko wrote:
>>
>>>>As you noticed below, the point is that this feature should be active for
>>>>kernel-based code only; for user-space, we're toast: typical chicken-and-egg
>>>>problem since we need the registry to cross the space boundaries but the
>>>>registry requires a name to index the object first. So yes, we need to check for
>>>>anonymous calls in every service taking a symbolic name in native/syscalls.c,
>>>>and return -EINVAL when applicable.
>>>
>>>
>>>I thought that "libnative" would be a better place since this way we
>>>would avoid the user mode -> kernel mode switch.
>>>
>>>
>>>
>>>>...Or, we might auto-generate some dummy name in native/syscalls.c we would pass
>>>>to the registry when this situation arises, so that anonymous creation and use
>>>
>>>>from user-space would still be possible.
>>>
>>>
>>>Yep, in this case a name would be a string == object's address, thus
>>>it's unique.
>>>
>>>Ok, I'd probably vote for the 2-nd approach.
>>>
>>
>>Definitely better since this keeps the semantics consistent across execution spaces.
>>
> 
> 
> Then we still have a difference in behaviour of the objectes depending
> on where they are craeted. I mean, the NULL-named user-space objects
> will be displayed under some, well, not-that-informative names (e.g.
> 0xc3264780) while the kernel-based ones will not have an entry in the
> registry (they are really NULL-named).
> 
> So,
> 
> 1) don't display such names in /proc;
> 2) make a common mechanism for both spaces.
> 
> rt_mutex_create()   // for other objects as well
> {
> ...
> - xnobject_copy_name(mutex->name,name);
> +xnobject_create_name(mutex->name,name, object);
> ...
> }
> 
> xnobject_create_name(dst,src, object)
> {
>       if (src)
>             xnobject_copy_name(mutex->name,name);
>       else
>             snprintf(dst, XNOBJECT_NAME_LEN, "%p", object);
> }
> 
> // the slightly ugly thing is that we need to be sure that dst is
> always object->name so it's really of XNOBJECT_NAME_LEN size.
> 

We should pass the size along with the copy buffer, mainly for readability, and 
also as a safety belt.

> Then we don't need "*name = '\n';" in syscall.c:__rt_object_create().
> But this bit should be removed in any case.
> 
> What do you think?
> 
> Frankly, I like this approach better. All objects get some name if
> they are NULL-named by a user and the code changes are a bit more
> graceful. To show them in /proc or not is still another question.

I'd like we don't generalize an exception case here. The fact that for some 
internal reason we need to put a dummy name on anon objects created from 
user-space should not make all anon objects from kernel space have a registry 
slot too, this would just be overkill (registry slots don't come for free actually).

That said, the remaining point basically is: how do we avoid anon objects with 
auto-generated names from appearing under /proc? I'm not a fan of "magic values" 
which would distinguish a real name from a dummy one, so I'd rather use the 
existing possibility of passing a NULL pnode pointer to rt_registry_enter(), 
which would still index an object without actually exporting it to the /proc 
interface. The question is: how could we make the *_create() calls invoking 
rt_registry_enter() with a NULL pnode when applicable, without changing the 
kernel-based interface of the API.

-- 

Philippe.

