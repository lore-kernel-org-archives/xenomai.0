Message-ID: <434B689B.8050707@domain.hid>
Date: Tue, 11 Oct 2005 01:24:11 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [syscall.c] rt_bind_queue/heap()
References: <b647ffbd0510100450n19552d5fq@domain.hid>		<434A585B.40905@domain.hid>	<b647ffbd0510100529v2c96d260r@domain.hid>
	<434A601C.7000605@domain.hid>
In-Reply-To: <434A601C.7000605@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:

> Dmitry Adamushko wrote:
>
>>> As you noticed below, the point is that this feature should be 
>>> active for
>>> kernel-based code only; for user-space, we're toast: typical 
>>> chicken-and-egg
>>> problem since we need the registry to cross the space boundaries but 
>>> the
>>> registry requires a name to index the object first. So yes, we need 
>>> to check for
>>> anonymous calls in every service taking a symbolic name in 
>>> native/syscalls.c,
>>> and return -EINVAL when applicable.
>>
>>
>>
>> I thought that "libnative" would be a better place since this way we
>> would avoid the user mode -> kernel mode switch.
>>
>>
>>> ...Or, we might auto-generate some dummy name in native/syscalls.c 
>>> we would pass
>>> to the registry when this situation arises, so that anonymous 
>>> creation and use
>>> from user-space would still be possible.
>>
>>
>>
>> Yep, in this case a name would be a string == object's address, thus
>> it's unique.
>>
>> Ok, I'd probably vote for the 2-nd approach.
>>
>
> Definitely better since this keeps the semantics consistent across 
> execution spaces.
>
maybe we should go as far as formalizing the "stringification" of a 
xenomai object
as a URL:
xeno_queue:0x45abc034
xeno_mutex:0xDEADBEEF
or
xeno:queue:0x0F00BAAB
xeno:mutex:
xeno:shared:TGID=100:0xdeadbeef

it still feels a teeny bit hacky, but the url prefix at least makes its 
use explicit.
In the last example, the url includes TGID=100, the idea being that it would
only be valid for user-space processes that were thread-group 100.

I dunno whether any such objects should get entries in /proc/ipipe/Xenomai*
On one hand, it would seem a decent rendevous point, but not all objects 
should
be globally visible, and its not clear to me which they are.  Anyway, 
reading a
/proc/ipipe/* file is a clumsy way to get addresses of xeno-objects to 
bind to.

thx
jimc

