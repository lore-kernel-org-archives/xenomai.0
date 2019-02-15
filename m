Subject: Re: [PATCH] cobalt: x86: Use ipipe_root_nr_syscalls
References: <cf2852a2-8000-d545-4d32-fcdab5ba4522@siemens.com>
 <16324092.S9KuMY5lOr@blindfold>
 <849bae3d-90b4-9950-cdd6-73a51a7a3589@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5f052b02-b5d5-8ed6-9880-11ea7eb58450@xenomai.org>
Date: Fri, 15 Feb 2019 15:38:49 +0100
MIME-Version: 1.0
In-Reply-To: <849bae3d-90b4-9950-cdd6-73a51a7a3589@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Richard Weinberger <richard@nod.at>
Cc: Xenomai <xenomai@xenomai.org>

On 2/15/19 3:21 PM, Jan Kiszka wrote:
> On 14.02.19 16:12, Richard Weinberger wrote:
>> Am Donnerstag, 31. Januar 2019, 18:09:53 CET schrieb Jan Kiszka:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Required to handle compat syscalls correctly.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> This is against next. The stable patch needs to touch kernel/cobalt
>>> /posix/syscall.c instead.
>>>
>>> Testing all these would be very appreciated!
>>
>> Finally had time to test and review the patches.
>> The Problem I saw is gone. :-)
>>
>> For all three patches:
>> Reviewed-by: Richard Weinberger <richard@nod.at>
>> Tested-by: Richard Weinberger <richard@nod.at>
>>
> 
> Thanks for testing!
> 
> Philippe, could you pick up the generic ipipe patch? I'll take care of
> the rest.
> 

It's already there.

-- 
Philippe.

