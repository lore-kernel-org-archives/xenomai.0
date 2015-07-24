References: <55AE3AAB.5070403@siemens.com> <55AE4068.5050102@xenomai.org>
 <55AE5D0B.60300@siemens.com> <55B0A89B.5020004@xenomai.org>
 <55B0AEFE.5080202@siemens.com> <55B0B268.7020209@xenomai.org>
 <55B0EE25.1030609@siemens.com> <55B1446A.2080406@xenomai.org>
 <55B1E813.1030705@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55B20D4C.7000103@xenomai.org>
Date: Fri, 24 Jul 2015 12:02:52 +0200
MIME-Version: 1.0
In-Reply-To: <55B1E813.1030705@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3: comapt issues with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 07/24/2015 09:24 AM, Philippe Gerum wrote:
> On 07/23/2015 09:45 PM, Philippe Gerum wrote:
>> On 07/23/2015 03:37 PM, Jan Kiszka wrote:
>>> On 2015-07-23 11:22, Philippe Gerum wrote:
>>>> On 07/23/2015 11:08 AM, Jan Kiszka wrote:
>>>>> On 2015-07-23 10:40, Philippe Gerum wrote:
>>>>>> On 07/21/2015 04:54 PM, Jan Kiszka wrote:
>>>>>>> On 2015-07-21 14:51, Philippe Gerum wrote:
>>>>>>>> On 07/21/2015 02:27 PM, Jan Kiszka wrote:
>>>>>>>>> Hi Philippe,
>>>>>>>>>
>>>>>>>>> just a heads up, I'll try to address this later:
>>>>>>>>>
>>>>>>>>> I received a report that include/rtdm/uapi/rtdm.h contains some data
>>>>>>>>> structures that are used between the kernel and the userspace library
>>>>>>>>> (so not directly by applications) and are not compatible with
>>>>>>>>> 32-on-64-bit (compat) scenarios. We should probably promote anything
>>>>>>>>> that is longer on 64-bit to that size, unconditionally. As this affects
>>>>>>>>> the ABI, it should be fixed before 3.0 release, ideally.
>>>>>>>>>
>>>>>>>>
>>>>>>>> That would require to fix up the client drivers (setsockopt, getsockopt
>>>>>>>> typically). Ok, I'll have a look when I'm done with testing the blackfin
>>>>>>>> port.
>>>>>>>
>>>>>>> Indeed. Just realized that there are already compat structs for the
>>>>>>> socket stuff. However, and that was what our user stumbled over, there
>>>>>>> is none for _rtdm_mmap_request. But that should be really internal, right?
>>>>>>>
>>>>>>
>>>>>> mmap() has the compat thunk for 32<->64 bit conversion already, so this
>>>>>> is ok.
>>>>>
>>>>> Ok... Rechecking the bug report here, the issue is rather the case that
>>>>> off_t becomes 64 bit when defining -D_FILE_OFFSET_BITS=64 for your
>>>>> userland. We are apparently required to account for that case as well.
>>>>>
>>>>
>>>> Ok, so let's move the offset member to loff_t and compat_loff_t in the
>>>> mmap request descriptors, that should do the trick.
>>>>
>>>
>>> I only forwarded this suggestion internally, unfortunately cannot tell
>>> yet how it was implemented, just received the early feedback that it is
>>> not yet working. Maybe we are overseeing something, maybe something went
>>> wrong with the implementation. Will be checked tomorrow.
>>>
>>
>> This is likely an issue with the native alignment of those types, the
>> kernel may offset long members in the compat struct based on different
>> constraints than -m32 does.
>>
> 
> And we probably also need the mmap64 wrapper we don't have yet. Ok, I'm
> working on this.
> 

Pushed to -next, and tested over 32 and 3264 ABI models over x86. This
breaks the ABI, so both kernel and userland have to be rebuilt. The bad
news is that I now have to redo all the testing on all other archs. Oh
well, ...

-- 
Philippe.

