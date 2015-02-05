Message-ID: <54D390C7.60008@xenomai.org>
Date: Thu, 05 Feb 2015 16:48:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1928985868.3780.1423040133670.JavaMail.zimbra@wandercraft.eu>
 <54D1E2AA.40000@xenomai.org>
 <2118665101.4111.1423048074765.JavaMail.zimbra@wandercraft.eu>
 <735225138.4138.1423050050231.JavaMail.zimbra@wandercraft.eu>
 <54D21CCE.5000607@xenomai.org>
 <498604834.10542.1423145127729.JavaMail.zimbra@wandercraft.eu>
 <54D38147.8010503@xenomai.org>
 <1533670141.11145.1423150163559.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <1533670141.11145.1423150163559.JavaMail.zimbra@wandercraft.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai 3 - no skin detected in program
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On 02/05/2015 04:29 PM, Huy Cong Vu wrote:
> 
> 
> ----- Mail original -----
>> De: "Philippe Gerum" <rpm@xenomai.org>
>> À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>> Cc: xenomai@xenomai.org
>> Envoyé: Jeudi 5 Février 2015 15:42:15
>> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program
> 
>> On 02/05/2015 03:05 PM, Huy Cong Vu wrote:
>>>
>>>
>>> ----- Mail original -----
>>>> De: "Philippe Gerum" <rpm@xenomai.org>
>>>> À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>>>> Cc: xenomai@xenomai.org
>>>> Envoyé: Mercredi 4 Février 2015 14:21:18
>>>> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program
>>>
>>>> On 02/04/2015 12:40 PM, Huy Cong Vu wrote:
>>>>>
>>>>>
>>>>> ----- Mail original -----
>>>>>> De: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>>>>>> À: "Philippe Gerum" <rpm@xenomai.org>
>>>>>> Cc: xenomai@xenomai.org
>>>>>> Envoyé: Mercredi 4 Février 2015 12:07:54
>>>>>> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program
>>>>>
>>>>>> ----- Mail original -----
>>>>>>> De: "Philippe Gerum" <rpm@xenomai.org>
>>>>>>> À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>, xenomai@xenomai.org
>>>>>>> Envoyé: Mercredi 4 Février 2015 10:13:14
>>>>>>> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program
>>>>>>
>>>>>>> On 02/04/2015 09:55 AM, Huy Cong Vu wrote:
>>>>>>>> Hello everyone,
>>>>>>>> I recently try to run an application compiled in native skin of Xenomai 3. When
>>>>>>>> trying to run the binary, these line appeared:
>>>>>>>> WARNING: [main] no skin detected in program
>>>>>>>> BUG: [main] initialization failed, EINVAL
>>>>>>>> I know that this is a cooperplate_init() warning when trying to initialize
>>>>>>>> native skin, but I don't understand the reason why:
>>>>>>>> if (pvlist_empty(&skins)){
>>>>>>>> warning("no skin detected in program");
>>>>>>>> ret = -EINVAL;
>>>>>>>> goto fail;
>>>>>>>> }
>>>>>>>
>>>>>>> It seems that your application was not linked against libalchemy.so.
>>>>>>> When API libraries are properly linked in, internal constructor routines
>>>>>>> populate this list. POSIX support is built-in within the Cobalt
>>>>>>> interface, so it won't appear here though.
>>>>>>>
>>>>> I change the order of the linker flags, now my app is linked against
>>>>> libalchemy.so, but this message shown up:
>>>>> symbol lookup error: /usr/xenomai/lib/libcopperplate.so.0: undefined symbol:
>>>>> main
>>>>>
>>>>> I guess that it stills a problem due to the linker flag, am I right?
>>>>>
>>>>
>>>> Yes. You seem to be using a set of flags with fine-grained tuning, some
>>>> of which might have an adverse effect on your linking stage. You should
>>>> start with the set output by xeno-config --ldflags --alchemy which are
>>>> known to work, then tune gradually as appropriate.
>>>>
>>>
>>> Hi Philippe,
>>>
>>> I'm getting close to it, but it still left some undefined reference for rtdm
>>> functions.
>>>
>>
>> rtdm_socket() is a kernel-space API for inter-driver calls, socket() is
>> what you need for creating a RTDM socket endpoint in your application.
>> The Cobalt implementation will be used provided the linker is passed the
>> proper flags (which you Makefile does).
> 
> So that means I will always end up in calling socket() for all skins (alchemy or cobalt) and let the linker flags differs it in kernel space?

You should have a look at the related documentation to understand
how/when the Xenomai/cobalt implementation of a POSIX service (e.g.
socket, ioctl, setsockopt and friends) overrides the original glibc call:

http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#Under_the_hood_the_8211wrap_flag

> My app is then compilable. But now I have 2 differents behaviors with 2 skins in the same app:
> 
> ret1 = setsockopt();
> ret2 = ioctl();
> ret3 = bind();
> 
> cobalt (posix): ret1 = -1, ret2 = ret3 = 0;
> alchemy (native): ret1 = 0, ret2 = ret3 = -1;
>

There is no information I could use here. Which RTDM driver is
implementing the address family and protocol mentioned in the socket()
call, which socket option and ioctl request codes are you passing to
this RTDM driver via the setsockopt() and ioctl() calls, what is the
errno value for each failing call?

> I put some #define NATIVE or POSIX in my app + xeno-config --alchemy or --cobalt to set flags.

The whole thing has been designed in a way that should prevent such kind
of ugly #ifdefery. Definitely not the way to go.

> Is there a known issue related to this, or it only occurs in my case? 
>  

There is no known issue regarding RTDM sockets and their usage. Again,
you have access to several examples in demo/posix/cobalt illustrating
RTDM socket usage. You may want to have look there first.

>>
>>> I prepared a minimal test case attached in this email, which have only 1 call to
>>> rtdm_socket. The call to ldflags include only --cobalt, I don't know if its
>>> enough. And I can't find a testsuite file in alchemy sample list that have rtdm
>>> calls.
>>
>> --cobalt is an alias to --posix, those switches are interchangeable. The
>> Makefile looks ok. See demo/posix/cobalt for examples using RTDM sockets
>> for communicating with the real-time IPC driver.
>>
>>>
>>> Can you take a look and tell me where I was wrong?
>>>
>>> Thanks,
>>>  
>>>
>>>> --
>>>> Philippe.
>>>
>>
>>
>> --
>> Philippe.
> 


-- 
Philippe.

