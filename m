Message-ID: <5542205E.5080302@free.fr>
Date: Thu, 30 Apr 2015 14:30:22 +0200
From: =?windows-1252?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
MIME-Version: 1.0
References: <553FAC36.3050803@free.fr> <553FC281.70308@xenomai.org>
 <5541D505.2000109@free.fr> <5541E930.30000@xenomai.org>
In-Reply-To: <5541E930.30000@xenomai.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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

On 30/04/2015 10:34, Philippe Gerum wrote:
> On 04/30/2015 09:08 AM, St=E9phane ANCELOT wrote:
>> Hi,
>>
>> Ok, I am using more than one heap, it seems being related .
>>
> I don't think so. This unit test illustrates such case:
> http://git.xenomai.org/xenomai-3.git/commit/?h=3Dnext&id=3Dfc7a90768c60e5=
9cdc86ed47a42d4757ff2c4d90
>
Yes, this one rocks.

I found the reason in my application, I created the heap with H_SINGLE=20
(or deprecated H_SHARED)
but the block is not being allocated if rt_heap_alloc() func size=20
parameter is 0 .
changing size to blocksize works.
>> It is not possible anymore?
> That would be quite a silly decision, isn't it? You should refer to this
> part of the online migration guide to find out which changes have been
> introduced in the user-visible interface:
>
> http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Heaps
>
>> Regards,
>> S.Ancelot
>>
>>
>>
>> On 28/04/2015 19:25, Philippe Gerum wrote:
>>> On 04/28/2015 05:50 PM, St=E9phane ANCELOT wrote:
>>>> Hi,
>>>>
>>>> for unknown reason, using compat api, rt_heap_alloc replies with
>>>> timeout, or blocks if TM_INFINITE is requested.
>>> Because the request exceeds the available space. The compat api does not
>>> wrap rt_heap services, so this is unrelated.
>>>
>>>> I also noticed I don't have /dev/rtheap node, is it normal.?
>>>>
>>> Yes, /dev/rtheap is gone in 3.x.
>>>
>>
>


