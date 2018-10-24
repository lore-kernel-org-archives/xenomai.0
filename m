Subject: Re: [Xenomai] [PATCH] boilerplate/avl: fix missing include
References: <1539865220-1372-1-git-send-email-sebastian.smolorz@gmx.de>
 <36670432.JDg3nDlJl9@lenni>
 <212cc963-4cb6-2e0d-67db-f74b2719f15f@xenomai.org>
 <13058881.nZKSyxvzTL@lenni>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2f0067c2-d262-3f6c-af18-8d4beddd5c77@xenomai.org>
Date: Wed, 24 Oct 2018 12:47:07 +0200
MIME-Version: 1.0
In-Reply-To: <13058881.nZKSyxvzTL@lenni>
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
To: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Cc: xenomai@xenomai.org

On 10/24/18 12:33 PM, Sebastian Smolorz wrote:
> On 10/23/18 11:11 AM, Philippe Gerum wrote:
>> On 10/19/18 5:10 PM, Sebastian Smolorz wrote:
>>> Hello Philippe,
>>>
>>> Sebastian Smolorz wrote:
>>>> On 10/19/2018 09:16 AM, Philippe Gerum wrote:
>>>>> On 10/18/2018 04:37 PM, Sebastian Smolorz wrote:
>>>>>> Nevertheless, I guess there is an issue with the definition of
>>>>>> const
>>>>>> (line 50) in include/boilerplate/compiler.h. It does work with
>>>>>> gcc
>>>>>> 5.4 but not with gcc 4.3.5.
>>>>>
>>>>> Could you elaborate on this? Which error pops us, in which
>>>>> context?
>>>>
>>>> Compilation of libboilerplate and libiniparser (master and next)
>>>> fails with a cross gcc 4.3.5 for x86_32 (i586) targets. If I
>>>> change the line mentioned above into
>>>>
>>>> #define __const const
>>>>
>>>> the error does not pop up any more. Works also when I completely
>>>> remove the #define __const.
>>>
>>> I've found two additional compile errors due to the usage of ancient
>>> gcc and glibc. I could prepare patches for that. But I'm not sure
>>> how to fix this __const issue properly. I've seen that you
>>> introduced those lines in commit  5632adb8 into -next. I suppose
>>> you faced an issue which needed this fix, am I correct?
>>
>> Adding constness to a function was needed at some point, __const was
>> meant to be a shorthand for annotating the code. You did not provide
>> the error message received from gcc 4.3 so I can't be sure, however
>> the following change might fix the issue:
>>
>> diff --git a/include/boilerplate/compiler.h
>> b/include/boilerplate/compiler.h index f526eb269..469d0c249 100644
>> --- a/include/boilerplate/compiler.h
>> +++ b/include/boilerplate/compiler.h
>> @@ -47,7 +47,7 @@
>>  #endif
>>
>>  #ifndef __const
>> -#define __const		__attribute__((__const__))
>> +#define __const		__attribute__((const))
>>  #endif
>>
>>  #ifndef __pure
> 
> That does not change the error. The condensed error output is:
> 
>   CC       libboilerplate_la-ancillaries.lo
> cc1: warnings being treated as errors
> lib/boilerplate/iniparser/dictionary.c: In function 'xstrdup':
> lib/boilerplate/iniparser/dictionary.c:72: error: passing argument 1 of 
> 'strlen' discards qualifiers from pointer target type
> lib/boilerplate/iniparser/dictionary.c:74: error: passing argument 2 of 

Ok, so this is a conflict with older libc headers defining their own
wrappers for the const qualifier; we have no in-tree users of __pure and
__const definitions anymore, so we should drop them, fixing the issue in
the same move.

-- 
Philippe.

