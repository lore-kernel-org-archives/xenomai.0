Message-ID: <5548C7A4.5030309@free.fr>
Date: Tue, 05 May 2015 15:37:40 +0200
From: =?windows-1252?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
MIME-Version: 1.0
References: <553FAC36.3050803@free.fr> <553FC281.70308@xenomai.org>
 <5541D505.2000109@free.fr> <5541E930.30000@xenomai.org>
 <5542205E.5080302@free.fr>
In-Reply-To: <5542205E.5080302@free.fr>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] xenomai 3.0rc4 rt_heap_alloc replies with timeout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
unfortunately, There is something wrong for unknown reason using these =

functions.

I made a simple regression program that only create heaps and allocates =

area.

At line 190 of the file, depending on the size value of the heap, the =

program works or not.
This looks like corrupted memory problem...

enclose is the c file, I hope you will be able reproduce it.
Regards,
Steph



On 30/04/2015 14:30, St=E9phane ANCELOT wrote:
> On 30/04/2015 10:34, Philippe Gerum wrote:
>> On 04/30/2015 09:08 AM, St=E9phane ANCELOT wrote:
>>> Hi,
>>>
>>> Ok, I am using more than one heap, it seems being related .
>>>
>> I don't think so. This unit test illustrates such case:
>> http://git.xenomai.org/xenomai-3.git/commit/?h=3Dnext&id=3Dfc7a90768c60e=
59cdc86ed47a42d4757ff2c4d90 =

>>
>>
> Yes, this one rocks.
>
> I found the reason in my application, I created the heap with H_SINGLE =

> (or deprecated H_SHARED)
> but the block is not being allocated if rt_heap_alloc() func size =

> parameter is 0 .
> changing size to blocksize works.
>>> It is not possible anymore?
>> That would be quite a silly decision, isn't it? You should refer to this
>> part of the online migration guide to find out which changes have been
>> introduced in the user-visible interface:
>>
>> http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Heaps
>>
>>> Regards,
>>> S.Ancelot
>>>
>>>
>>>
>>> On 28/04/2015 19:25, Philippe Gerum wrote:
>>>> On 04/28/2015 05:50 PM, St=E9phane ANCELOT wrote:
>>>>> Hi,
>>>>>
>>>>> for unknown reason, using compat api, rt_heap_alloc replies with
>>>>> timeout, or blocks if TM_INFINITE is requested.
>>>> Because the request exceeds the available space. The compat api =

>>>> does not
>>>> wrap rt_heap services, so this is unrelated.
>>>>
>>>>> I also noticed I don't have /dev/rtheap node, is it normal.?
>>>>>
>>>> Yes, /dev/rtheap is gone in 3.x.
>>>>
>>>
>>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

-------------- next part --------------
A non-text attachment was scrubbed...
Name: heap_test.cpp
Type: text/x-c++src
Size: 6429 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150505/44cda4a=
1/attachment.cpp>
