Message-ID: <f384a2881775ae2fc3b81fce890dc7ec.squirrel@sourcetrek.com>
In-Reply-To: <558270FD.9090307@siemens.com>
References: <1649054.cG979aVMUy@soho>
 <66bead79a47e082c19c410f097b53c9e.squirrel@sourcetrek.com>
 <11760776.AKg2s0Tc8c@indiana> <55826C4D.4000506@siemens.com>
 <28e34526295769234fe6fe5971714059.squirrel@sourcetrek.com>
 <558270FD.9090307@siemens.com>
Date: Thu, 18 Jun 2015 09:25:25 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] License Issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka wrote:
> On 2015-06-18 09:05, Gilles Chanteperdrix wrote:
>>
>> Jan Kiszka wrote:
>>> On 2015-06-17 23:35, Leopold Palomo-Avellaneda wrote:
>>>> El Dimecres, 17 de juny de 2015, a les 19:25:56, Gilles Chanteperdrix
>>>> va
>>>> escriure:
>>>>> Leopold Palomo-Avellaneda wrote:
>>>>>> Hi,
>>>>>>
>>>>>> using a debian tool to check the license of the package I have found
>>>>>> that
>>>>>> his
>>>>>
>>>>>> files:
>>>>> This mail looks very different from the one you sent me privately and
>>>>> I
>>>>> told you to post on the list. It does not even concern the same
>>>>> version
>>>>> of
>>>>> Xenomai.
>>>>
>>>> yes,
>>>>
>>>> it's true. But what I understood from you was that it was better that
>>>> I
>>>> sent
>>>> to the list. That file comes from xenomai-2.6.4. Any problem then?
>>>>
>>>> I just need to clarify this kind of things because ftp-masters are
>>>> every
>>>> day
>>>> more strict (what I think it's better), especially with licenses.
>>>> Never
>>>> happens nothing till the day that something happen.
>>>
>>> Out of curiosity: How do these license check work right now? What's the
>>> tool used and how are the outputs processed (manual or automatic
>>> decisions etc.)?
>>>
>>>>
>>>> If can check this kind of stuff it would be better, that's all. For
>>>> instance, I
>>>> was a bit surprised about the autotools generated files, because I
>>>> thought they
>>>> would never had license.
>>>
>>> If something has no license, it cannot be used.
>>
>> That is an over-simplification. Or maybe a policy of the company you
>> work
>> at. But that is not a general truth that applies to everyone.
>
> Of course, it's a simplification (you may still use it secretly under
> your blanket), but your lawyer will tell you something like this if you
> ask. At least when referring to common copyright laws on this planet. So
> this is not a company policy thing but a jurisdiction issue.

What I mean is that there are other cases, such as:
- code in the public domain
- reuse of portions of the code that fall under "fair use" or "right to
quote", that could easily apply to things like the 5 lines x86 arith.h or
the examples. And I would think that of the Makefiles too.

-- 
                                            Gilles.
https://click-hack.org


