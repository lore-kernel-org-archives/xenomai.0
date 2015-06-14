Message-ID: <d377bbf300b9fe31ed4992830d225332.squirrel@sourcetrek.com>
In-Reply-To: <557D40F6.9000105@xenomai.org>
References: <F89CBA55-43A8-4AE5-A859-BFE111D40561@gmail.com>
 <4019d695cc8c27a13bd17adc951e3ade.squirrel@sourcetrek.com>
 <05AD097B-C2A0-4279-A170-79385AC005B1@gmail.com>
 <9c648f9ec1a5abf4d783d8f3a9ada651.squirrel@sourcetrek.com>
 <7296329D-54C3-446C-A206-956BCBAEE441@gmail.com>
 <438716acfb1172076225e9266fa98c04.squirrel@sourcetrek.com>
 <557D40F6.9000105@xenomai.org>
Date: Sun, 14 Jun 2015 10:55:38 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] RTDM-native mainlining - status?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>


Philippe Gerum wrote:
> On 06/14/2015 10:46 AM, Gilles Chanteperdrix wrote:
>>
>> Michael Haberler wrote:
>>>
>>>> Am 13.06.2015 um 09:19 schrieb Gilles Chanteperdrix
>>>> <gilles.chanteperdrix@xenomai.org>:
>>>>
>>>>
>>>> Michael Haberler wrote:
>>>>> I hope I do not overlook some boundary condition - but assuming that
>>>>> building out-of-tree RTDM support is significantly less invasive and
>>>>> version-dependent than patching a kernel, that scheme could
>>>>> enormously
>>>>> widen the range of platforms we could deploy with good results, and
>>>>> at
>>>>> the
>>>>> same time lower maintenance requirements.
>>>>
>>>> No, alas a Linux driver is always version-dependent, so, the driver
>>>> would
>>>> contain some wrappers to handle differences between version. But this
>>>> is
>>>> not something new, everybody maintaining out-of-tree Linux kernel code
>>>> has
>>>> been doing it for a very long time. We do it for Xenomai, even Linux
>>>> developers are doing it for the driver backport project.
>>>
>>> certainly, but if the problem scope changes from "patch a specific
>>> kernel
>>> version for full Xenomai support" to "maintain the API and support
>>> library
>>> for a set of out-of-tree drivers on top of a stock kernel from
>>> elsewhere"
>>> we're in a different (my guess: easier and more widely applicable)
>>> ballgame
>>
>> There should not be a need for a support library, since RTDM uses the
>> usual driver API open, read, write, ioctl, I would expect an RTDM native
>> driver to work with the plain Linux version of these calls.
>>
>>>
>>> I would really be interested in exploring this route with a simple
>>> example, like this GPIO RTDM driver, and try to make this work with say
>>> a
>>> vanilla or RT-PREEMPT kernel - if only to gauge feasibility, effort and
>>> results
>>>
>>> what would you recommend as a starting point?
>>
>> Well, RTDM native is not part of Xenomai (yet), so, the first step would
>> be to to try and compile it. The last commits in the git date back from
>> 2007, so, some adaptation will be needed to get it running with the
>> latest
>> kernels.
>>
>> https://git.xenomai.org/rtdm-native.git/
>>
>
> And changes to the RTDM API brought in by the transition to xenomai 3 too.
>
>

Well, for a test run, as a first step, I guess Michael can ignore these
changes. But ultimately, I agree, this would have to be tackled.

-- 
                                            Gilles.
https://click-hack.org


