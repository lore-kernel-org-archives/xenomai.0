Message-ID: <277ba7fe2960fb0c7e83f74ded4670e1.squirrel@sourcetrek.com>
In-Reply-To: <55B24764.3040801@xenomai.org>
References: <E1ZIZjP-0001py-FB@sd-51317.xenomai.org>
 <5515ffa50f7d05764c02821440947bc5.squirrel@sourcetrek.com>
 <55B244BB.3030402@xenomai.org>
 <94d86bd72ae5132919da743a2a044bdb.squirrel@sourcetrek.com>
 <55B24764.3040801@xenomai.org>
Date: Fri, 24 Jul 2015 16:15:19 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : boilerplate: add
 offsetof() shorthand
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


Philippe Gerum wrote:
> On 07/24/2015 04:04 PM, Gilles Chanteperdrix wrote:
>>
>> Philippe Gerum wrote:
>>> On 07/24/2015 03:20 PM, Gilles Chanteperdrix wrote:
>>>>
>>>> git repository hosting wrote:
>>>>> Module: xenomai-3
>>>>> Branch: next
>>>>> Commit: 2a584d6763c64f9e566b5f53094d57dd72688857
>>>>> URL:
>>>>> http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=2a584d6763c64f9e566b5f53094d57dd72688857
>>>>>
>>>>> Author: Philippe Gerum <rpm@xenomai.org>
>>>>> Date:   Thu Jul 23 19:13:29 2015 +0200
>>>>>
>>>>> boilerplate: add offsetof() shorthand
>>>>>
>>>>> ---
>>>>>
>>>>>  include/boilerplate/compiler.h |    4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/include/boilerplate/compiler.h
>>>>> b/include/boilerplate/compiler.h
>>>>> index e27d165..876e004 100644
>>>>> --- a/include/boilerplate/compiler.h
>>>>> +++ b/include/boilerplate/compiler.h
>>>>> @@ -54,4 +54,8 @@
>>>>>  #define __aligned(__n)	__attribute__((aligned (__n)))
>>>>>  #endif
>>>>>
>>>>> +#ifndef offsetof
>>>>> +#define offsetof(__type, __member)  __builtin_offsetof(__type,
>>>>> __member)
>>>>> +#endif
>>>>
>>>> offsetof should be defined by glibc headers. By adding a definition,
>>>> you
>>>> risk a compiler warning about multiple definitions if someone uses the
>>>> proper glibc header.
>>>>
>>>>
>>>
>>> There is hardly any risk of that kind when using the gcc builtin.
>>>
>>
>> builtin or not, if I compile the following program:
>>
>> #include <stddef.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>>
>> #define offsetof(__type, __member)  __builtin_offsetof(__type,__member)
>
>
> Your program is wrong in the first place, since offsetof() is defined by
> stddef.h. Given that 3.x assumes a modern compiler with offsetof()
> available from there, you are just asking for troubles, especially since
> you explicitly omit the guard, which is not the best way to get things
> working either.

I did that on purpose to illustrate the case that would happen if stddef
was included after compiler.h, because the compiler stddef.h does not
contain any guard. The guard in compiler.h does not work if compiler.h is
included first.

>
> What can be done is including stddef.h from compiler.h, and provide a
> placeholder for offsetof() based on the null cast trick. That would make
> more sense.

Not really, stddef.h has been defining offetof for ages.



-- 
                                            Gilles.
https://click-hack.org


