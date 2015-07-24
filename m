References: <55B0B2EA.8000602@xenomai.org> <55B0B5CA.9080608@siemens.com>
 <55B0B7B6.2080709@xenomai.org> <55B0EBBD.1020509@siemens.com>
 <55B24BD7.9060502@xenomai.org> <55B25204.1010808@siemens.com>
 <55B25505.1090602@xenomai.org> <55B25869.3000505@siemens.com>
 <55B259E6.4070909@xenomai.org> <55B25A38.4010100@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55B25B06.6090004@xenomai.org>
Date: Fri, 24 Jul 2015 17:34:30 +0200
MIME-Version: 1.0
In-Reply-To: <55B25A38.4010100@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_print_auto_init()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 07/24/2015 05:31 PM, Philippe Gerum wrote:
> On 07/24/2015 05:29 PM, Philippe Gerum wrote:
>> On 07/24/2015 05:23 PM, Jan Kiszka wrote:
>>> On 2015-07-24 17:08, Philippe Gerum wrote:
>>>> On 07/24/2015 04:56 PM, Jan Kiszka wrote:
>>>>> On 2015-07-24 16:29, Philippe Gerum wrote:
>>>>>> On 07/23/2015 03:27 PM, Jan Kiszka wrote:
>>>>>>> On 2015-07-23 11:45, Philippe Gerum wrote:
>>>>>>>> On 07/23/2015 11:37 AM, Jan Kiszka wrote:
>>>>>>>>> On 2015-07-23 11:24, Philippe Gerum wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Jan,
>>>>>>>>>>
>>>>>>>>>> Do you still have a use case for calling rt_print_auto_init(false) or
>>>>>>>>>> not calling rt_print_auto_init(true) from libcobalt's bootstrap code?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Huh, that was a day-one feature, now 8 years old, barely remember the
>>>>>>>>> details. I'm currently not aware of a concrete scenario. It definitely
>>>>>>>>> makes sense to revisit this think.
>>>>>>>>>
>>>>>>>>> I guess one, if not the major problem back then was that the implicit
>>>>>>>>> malloc of the initialization step was not consistently causing a
>>>>>>>>> SIGDEBUG warning. That is now different.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Since the current thread won't be notified until XNWARN is armed in its
>>>>>>>> TCB, any objection to move that call as a nop placeholder to the compat
>>>>>>>> section in libtrank, leaving the implicit init to libcobalt as currently?
>>>>>>>
>>>>>>> Ack.
>>>>>>>
>>>>>>
>>>>>> Ok, let's see how deep you can dive into your context stack these days:
>>>>>> what about rt_print_cleanup() now? I see no in-tree callers, and I
>>>>>> wonder whether there is any use case for an application to stop the
>>>>>> stdio support during runtime.
>>>>>
>>>>> I used to have one recently that was specifically interested in
>>>>> terminating the associated thread. But that case was modified later on
>>>>> due to other reasons. In principle, the value of this cleanup function
>>>>> is in the printer thread control, even if that means cutting of wrapped
>>>>> I/O (you could still print via unwrapped services then).
>>>>>
>>>>
>>>> Ok. Was it part of a broader feature aimed at moving the per-process rt
>>>> support to a quiescent state?
>>>
>>> No, rather about ensuring that if you terminate only the main thread in
>>> an application that believes this thread was the last one, the
>>> application as a whole terminates.
>>>
>>
>> We could probably tell the existing atexit() handler to wipe the helper
>> thread too.
>>
> 
> mm, no. This would not exit, precisely.
> 

However, we do have a TSD on the main thread, so signaling the helper
from the TSD destructor would do.

-- 
Philippe.

