Message-ID: <54509195.2030006@xenomai.org>
Date: Wed, 29 Oct 2014 08:04:53 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <544F6117.7070101@bmwedler.de> <544F6988.1030005@xenomai.org>
 <544F9DB1.1050504@bmwedler.de> <544FA001.6070305@xenomai.org>
 <54508FB3.8080600@bmwedler.de>
In-Reply-To: <54508FB3.8080600@bmwedler.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using pipes in 3.0rc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Registrierungen <regist@bmwedler.de>, xenomai@xenomai.org

On 10/29/2014 07:56 AM, Registrierungen wrote:
> Addendum:
> I am using a x64 Kernel.
> Does it matter?

No, it does not. Do you plan to debug with gdb as I suggested?

> 
> 
> Am 28.10.2014 14:54, schrieb Philippe Gerum:
>> On 10/28/2014 02:44 PM, Registrierungen wrote:
>>> Thanks for your support.
>>>
>>> Unfortainly it din'twork for me.
>>> I patched and recompiled and installed xenomai and my app,
>>> but i have still the same error.
>>>
>>> Have you got another idea, or need some other informations from my side?
>> You may want to trace your app with gdb, configuring with
>> --enable-debug=full, then single-stepping in rt_pipe_create() to
>> pinpoint the failing call in there.
>>
>>> Sascha
>>>
>>> Am 28.10.2014 11:01, schrieb Philippe Gerum:
>>>> On 10/28/2014 10:25 AM, Registrierungen wrote:
>>>>> Hello,
>>>>>
>>>>> i try to switch with my working project from Xenomai 2.6 to 3.0rc
>>>>> Cobaltusing the native/alchemy skin.
>>>>>
>>>>> Creating tasks,etc. seems to works fine.
>>>>>
>>>>> If i try to open a pipe from the realtime taks using rt_pipe_create it
>>>>> returns with the error -88.
>>>> This is -ENOTSOCK, you can check all error codes there:
>>>> /usr/include/asm-generic/errno-base.h
>>>> /usr/include/asm-generic/errno.h
>>>>
>>>> ENOTSOCK is not raised by the alchemy API, so this must be a syscall
>>>> taking the wrong route to the glibc in the core lib.
>>>> Please try this patch:
>>>>
>>>> diff --git a/lib/alchemy/pipe.c b/lib/alchemy/pipe.c
>>>> index 93da9be..439a00f 100644
>>>> --- a/lib/alchemy/pipe.c
>>>> +++ b/lib/alchemy/pipe.c
>>>> @@ -166,8 +166,8 @@ int rt_pipe_create(RT_PIPE *pipe,
>>>>       }
>>>>         if (poolsize > 0) {
>>>> -        ret = setsockopt(pcb->sock, SOL_XDDP, XDDP_POOLSZ,
>>>> -                 &poolsize, sizeof(poolsize));
>>>> +        ret = __RT(setsockopt(pcb->sock, SOL_XDDP, XDDP_POOLSZ,
>>>> +                      &poolsize, sizeof(poolsize)));
>>>>           if (ret)
>>>>               goto fail_sockopt;
>>>>       }
>>>> @@ -181,7 +181,7 @@ int rt_pipe_create(RT_PIPE *pipe,
>>>>       memset(&saddr, 0, sizeof(saddr));
>>>>       saddr.sipc_family = AF_RTIPC;
>>>>       saddr.sipc_port = minor;
>>>> -    ret = bind(sock, (struct sockaddr *)&saddr, sizeof(saddr));
>>>> +    ret = __RT(bind(sock, (struct sockaddr *)&saddr, sizeof(saddr)));
>>>>       if (ret)
>>>>           goto fail_sockopt;
>>>>  
>>>>> Has anything changed handling pipes in 3.0?
>>>> All user-visible changes are reported here:
>>>> http://localhost/xenomai/migrating-from-xenomai-2-x-to-3-x/
>>>>
>>>
>>
> 


-- 
Philippe.

