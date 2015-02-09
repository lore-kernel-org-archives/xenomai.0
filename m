Message-ID: <54D8D7D5.2060000@control.lth.se>
Date: Mon, 09 Feb 2015 16:52:53 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
References: <54D4D409.2020708@control.lth.se> <54D4D9B2.8090805@xenomai.org>
 <54D4DF0C.2080007@control.lth.se> <54D4E285.9000906@xenomai.org>
 <54D4E44B.4060403@control.lth.se>
 <20150206161215.GC27277@hermes.click-hack.org>
 <20150206161626.GD27277@hermes.click-hack.org>
In-Reply-To: <20150206161626.GD27277@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Mixing linux and alchemy (cobalt) calls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2015-02-06 17:16, Gilles Chanteperdrix wrote:
> On Fri, Feb 06, 2015 at 05:12:15PM +0100, Gilles Chanteperdrix wrote:
>> On Fri, Feb 06, 2015 at 04:56:59PM +0100, Anders Blomdell wrote:
>>> On 2015-02-06 16:49, Philippe Gerum wrote:
>>>> On 02/06/2015 04:34 PM, Anders Blomdell wrote:
>>>>> On 2015-02-06 16:11, Philippe Gerum wrote:
>>>>>> On 02/06/2015 03:47 PM, Anders Blomdell wrote:
>>>>>>> I have an application that need both realtime and linux sockets, am I correct in assuming that
>>>>>>> withe the alchemy skin I could access them like
>>>>>>>
>>>>>>>   socket(...           // Linux version
>>>>>>>   __real_socket(...    // Linux version
>>>>>>>   __cobalt_socket(...  // Alchemy/cobalt version
>>>>>>>
>>>>>>> while under the cobalt skin, it would be:
>>>>>>>
>>>>>>>   socket(...           // Alchemy/cobalt version
>>>>>>>   __real_socket(...    // Linux version
>>>>>>>   __cobalt_socket(...  // Alchemy/cobalt version
>>>>>>>
>>>>>>
>>>>>> This depends on the LDFLAGS retrieved from xeno-config:
>>>>>>
>>>>>> 1. with --posix mentioned in the xeno-config --ldflags request
>>>>>>
>>>>>> 	socket(...), __cobalt_socket(...) or __RT(socket(...))  => Cobalt
>>>>>> implementation
>>>>>> 	__real_socket(...) or __STD(socket(...)) => glibc service
>>>>>>
>>>>>> 2. without --posix mentioned in the xeno-config --ldflags request
>>>>>>
>>>>>> 	__cobalt_socket(...) or __RT(socket(...))  => Cobalt implementation
>>>>>> 	socket(...) or __STD(socket(...)) => glibc service
>>>>>>
>>>>>> e.g.
>>>>>>
>>>>>> - the application only wants to access the POSIX services implemented by
>>>>>> Cobalt using the regular POSIX names: LDFLAGS should contain the output of:
>>>>>> $ xeno-config --posix --ldflags, or --cobalt --ldflags.
>>>>>>
>>>>>> - the application wants to access the POSIX services implemented by
>>>>>> Cobalt using the regular POSIX names, and the alchemy API: LDFLAGS
>>>>>> should contain the output of:
>>>>>> $ xeno-config --posix --alchemy --ldflags, or --cobalt --alchemy --ldflags.
>>>>>>
>>>>>> - the application wants to access the POSIX services implemented by
>>>>>> Cobalt solely via the explicit POSIX wrappers, and the alchemy API:
>>>>>> LDFLAGS should contain the output of (i.e. omitting --posix):
>>>>>> $ xeno-config --alchemy --ldflags, or --alchemy --ldflags.
>>>>>>
>>>>>> NOTE: using __RT() is preferred to calling __cobalt(), in case an API
>>>>>> stacked over the Cobalt POSIX API redefines its own implementation of
>>>>>> POSIX services over the dual kernel. __RT() would call the stacked
>>>>>> implementation, __cobalt() would force a call to the Cobalt
>>>>>> implementation of the service.
>>>>>>
>>>>> Thanks for the clarification, will sprinkle the code with __STD(...) 
>>>>> and __RT(...), from here on :-).
>>>>>
>>>>
>>>> That's only required if you want your code to unambiguously route to the
>>>> proper service in case the default symbol wrapping does not fit, or is
>>>> not present. This is typically what libcopperplate does, so that
>>>> non-POSIX apps can link against it, without being required to wrap the
>>>> POSIX symbols in the final executable.
>>>
>>> More to avoid me shooting myself in the foot when trying to juggle sockets
>>> from two different domains (also makes the code less dependent on the linker
>>> flags given). Already got bitten by 'modprobe rtpacket' not loading properly
>>> and the __wrap_socket picking up the posix version. And of course making the 
>>> code clearly document what belongs where.
>>
>> Not loading rtpacket should cause __wrap_socket to use the posix
>> version only if you are trying to create a socket type that the
>> rtpacket module implements. Otherwise, this is a bug.
> 
> And unless code has changed between 2.x and 3.x in this area, using
> __RT() will result in exactly the same behaviour.

You might be right, but AFAICT, on 2.6.2.1 'int __rt_dev_socket(...)' 
(ksrc/skins/rtdm/core.c) calls 'struct rtdm_device *get_protocol_device(...)' 
(ksrc/skins/rtdm/device.c), while in xenomai3/next 'COBALT_IMPL(int, socket,...)'
does a 'XENOMAI_SYSCALL3(sc_cobalt_socket, ...)' and then does a failover to
'_STD(socket, ...)' in case of -ENOSYS (which is what I believe an unloaded rt_packet.ko
gives as a result).

Am I missing something obvious?

/Anders

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


