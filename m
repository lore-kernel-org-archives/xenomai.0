Message-ID: <5102E05B.3080405@xenomai.org>
Date: Fri, 25 Jan 2013 20:43:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51029170.7070104@siemens.com> <5102D28D.2010908@xenomai.org>
	<5102D688.6080901@siemens.com>
In-Reply-To: <5102D688.6080901@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Lacking xsave support in Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/25/2013 08:01 PM, Jan Kiszka wrote:

> On 2013-01-25 19:44, Gilles Chanteperdrix wrote:
>> On 01/25/2013 03:06 PM, Jan Kiszka wrote:
>>
>>> Hi all,
>>>
>>> yesterday I pushed a fix to my for-upstream queue that properly disables
>>> all xsave-dependent CPU features (AVX/AVX2 namely). However, this is no
>>> real solution for us as it blocks a lot of acceleration potential on
>>> current Intel CPUs.
>>>
>>> Did anyone already look into this in more details? Is it just a matter
>>> of implementing the necessary context switching bits? Are there known
>>
>>> pitfalls?
>>
>> The known pitfalls of FPU support is that we never get it right the
>> first time. And debugging why it fails is hard.
> 
> OK, so no conceptual issues. And it will remain controllable via "noxsave".
> 
> Still need to discuss details here, but I bet we will look into this soon.


You may want to use the "fpu tracer" patches:
http://git.xenomai.org/?p=ipipe-gch.git;a=shortlog;h=refs/heads/core-3.4-fpu_trace
http://git.xenomai.org/?p=xenomai-gch.git;a=shortlog;h=refs/heads/2.6-fpu_trace


-- 
                                                                Gilles.

