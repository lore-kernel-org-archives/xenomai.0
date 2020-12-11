Subject: Re: Fwd: [Patch 1/5] Problems with upstream SPECTRE mitigation found
 in sendmsg/recvmsg syscalls
References: <1175-5fd33c00-129-25a5a500@199048248>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <45bff22c-7cdf-f5f4-41b8-1fff4a3d3b9f@siemens.com>
Date: Fri, 11 Dec 2020 14:31:25 +0100
MIME-Version: 1.0
In-Reply-To: <1175-5fd33c00-129-25a5a500@199048248>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org

On 11.12.20 10:30, François Legal wrote:
> Le Vendredi, Décembre 11, 2020 09:36 CET, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 11.12.20 09:05, François Legal wrote:
>>> Le Vendredi, Décembre 11, 2020 07:55 CET, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>>>  
>>>> On 07.12.20 11:55, François Legal via Xenomai wrote:
>>>>> From: François LEGAL <devel@thom.fr.eu.org>
>>>>>
>>>>> Remove the copy of struct struct user_msghdr onto stack allocated buffer.
>>>>>
>>>>
>>>> Reasoning is missing here: The driver callbacks are supposed to do that
>>>> copy-from-user.
>>>>
>>>> But the Question is: why? Is that local copy history left-over, or do
>>>> only the drivers know how much to copy?
>>>>
>>>> Jan
>>>>
>>>
>>> Hi Jan,
>>>
>>> The drivers are effectively doing that, hence the problem that happens with SPECTRE mitigation activated (at least on arm arch).
>>> About the length of the copy, the drivers do about the the same, sizeof (struct user_msghdr)
>>
>> Then we should move the common code into the common place, i.e. drop the
>> copies in the drivers instead.
>>
> 
> I wonder, because from what I could read on RTIPC, these driver functions seems to be callable from kernel context (see rtipc_get_arg() ).
> There is a risk of trigging SPECTRE mitigation in case is is called from kernel no, or maybe it does not get called through posix/io.c ?

RTDM drivers can call each other, and that can create a non-user entry
to callbacks. rtipc_get_arg accounts for that via
rtdm_fd_is_user(fd).

If we consolidate again over "callbacks get user_msghdr from kernel
memory" (but nothing that this struct my point to), no driver needs to
copy that struct, just the syscall entry code.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

