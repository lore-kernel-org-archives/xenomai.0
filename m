Message-ID: <6071350d8198953980002de2c777ff85.squirrel@sourcetrek.com>
In-Reply-To: <4BBC4FAD-F087-44E2-BE3F-B35A0AD0A8EA@gmail.com>
References: <F89CBA55-43A8-4AE5-A859-BFE111D40561@gmail.com>
 <4019d695cc8c27a13bd17adc951e3ade.squirrel@sourcetrek.com>
 <05AD097B-C2A0-4279-A170-79385AC005B1@gmail.com>
 <9c648f9ec1a5abf4d783d8f3a9ada651.squirrel@sourcetrek.com>
 <7296329D-54C3-446C-A206-956BCBAEE441@gmail.com>
 <438716acfb1172076225e9266fa98c04.squirrel@sourcetrek.com>
 <4BBC4FAD-F087-44E2-BE3F-B35A0AD0A8EA@gmail.com>
Date: Sun, 14 Jun 2015 13:43:02 +0200
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
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>


Michael Haberler wrote:
>
>> Am 14.06.2015 um 10:46 schrieb Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org>:
>>
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
>
> sounds reasonable, I will give it a try an report.
>
> Any early advice on brushing up this tree would be particularly welcome!

Well, you con try following the build instructions and fix everything that
stops the compilation.

Some information on how to build it may be found here:
https://www.osadl.org/RTDM-native.howto-rtdm-native.0.html
and here:
https://git.xenomai.org/rtdm-native.git/plain/README.rtdm-native

-- 
                                            Gilles.
https://click-hack.org


