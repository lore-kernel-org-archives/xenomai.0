Message-ID: <525ACC78.4060604@xenomai.org>
Date: Sun, 13 Oct 2013 18:38:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5257A979.7080208@siemens.com> <525A7127.3050101@xenomai.org>
	<525A8012.8020703@web.de>
In-Reply-To: <525A8012.8020703@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] forge: Cleanup COPYING files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 10/13/2013 01:12 PM, Jan Kiszka wrote:
> On 2013-10-13 12:08, Philippe Gerum wrote:
>> On 10/11/2013 09:32 AM, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> The following changes since commit
>>> 926e0441446aae116bf5b0701753e4b87a5386a2:
>>>
>>>     doc: update installation guidelines (2013-10-04 15:46:23 +0200)
>>>
>>> are available in the git repository at:
>>>
>>>     git://git.xenomai.org/xenomai-jki.git for-forge
>>>
>>> for you to fetch changes up to f1559e40a39b1a54e0348732402a68eb0dfef0a4:
>>>
>>>     Rename include and lib copying files (2013-10-10 15:15:56 +0200)
>>>
>>> If you do not like COPYING.* renaming, just skip the second patch. The
>>> first on is important as we currently have code that is formally under
>>> no COPYING file.
>>>
>>
>> Thanks for the heads up. However, I disagree with both patches. GPL has
>> never been our default license.
>
> Where did we ever intentionally diverge from the pattern that everything
> is GPL except those bits that need to be linked to or #included by
> third-party programs?

The various lib/ test suites I did write are not GPL, but LGPL, although 
these are executables. You mention a rule you applied to your own 
contribution, which is fine by me. However, other contributors may see 
exceptions to this rule, so a default license makes no sense.

  I strongly believe that this is a very reasonable
> pattern, so I don't understand your disagreement here. And see below
> what damage a missing default license can cause.
>
>> The common rule for Xenomai is to state
>> the licensing terms on a per-file basis, explicitly. When present, the
>> COPYING files basically emphasize the fact that all files in the
>> relevant directory and below share that license. In other words, not
>> having COPYING file in some hierarchy does not mean that we have no
>> license, it's most often right there into each individual files.
>
> Sure, I don't disagree that each source file should state its license.
> We should not merge any more files in the future that lack this.
> However, often we like to reference a COPYING file with the full license
> term, thus it should be reachable, ideally by walking up the directory tree.
>
> Also, having duplicate, slightly diverging COPYING files in subtrees
> where all files require the same license anyway is not very elegant as well.
>

Legalese is not a matter of being elegant. It's a matter of being 
precise. Catch-all license files may be elegant, but they certainly 
aren't precise enough. The point is, as you mentioned, that all files 
merged in the future should bear an explicit license.

Besides, there is no "slightly diverging" licenses in -forge. It's 
either LGPL, or GPL, or GPL+exception for linking. As I mentioned a 
couple of times on this mailing list already, the latter is on its way 
out, since the introduction of the uapi/ section for the kernel files 
which may be shared with userland for common ABI definitions/constants, 
making the former exception useless. I'll push the proper patch accordingly.

All other headers outside the uapi/ areas shall be read from kernel code 
exclusively (GPL), or from userland Xenomai libraries exclusively (LGPL).

So, we'll shortly only have GPL or LGPL in the tree. Looking at the 
facts, I don't see any ambiguity.

>>
>> The files which do not state any licensing terms in a way or another in
>> -forge are as follows:
>>
>> ./lib/boilerplate/tlsf/target.h
>> ./utils/can/rtcansend.c
>> ./utils/can/rtcanrecv.c
>> ./utils/ps/rtps.c
>> ./utils/analogy/wf_facilities.h
>> ./utils/analogy/wf_facilities.c
>> ./testsuite/*
>>
>> The first one (target.h) is merely a build configuration file.
>> $top_srcdir/testsuite/* should not default to GPL, although it's
>> perfectly fine that contributors do state GPL licensing explicitly in
>> such code if they wish to. The few others implementing small utilities
>> are indeed lacking license information.
>>
>> AFAICS, all other files state their license explicitly, or depend on a
>> COPYING file present in the file hierarchy they belong to. If the file
>> belongs to the kernel support, the additional requirement to have it
>> GPLv2 compatible is even implicit per the linux kernel licensing terms,
>> all of our kernel code abide by strictly.
>>
>> At any rate, contributors may want to clarify licensing terms for the
>> code they authored if need be.
>
> If you say that we never had GPL as the default, this has to be
> rephrased: Contributors, it is required to clarify the license of those
> files that do not carry any explicit license reference. We otherwise
> have to remove them from the source tree!
>

Please stick to the facts: I mentioned a short list of files which lack 
explicit licensing information today. This means that by no mean your 
late addition of a catch-all COPYING file would solve anything 
retroactively with respect to this issue. All previous releases of this 
code would not fall under these terms. Therefore, the issue at stake is 
about fixing the current glitches - which are clearly not as "damaging" 
as you claimed - and clarify the policy for the future. This is the 
alternative solution to merging a catch-all COPYING file.

1. fixing the current issues means that contributors who authored these 
files are asked to provide the required fixup (and this includes 
myself). Only these people are entitled to pick the license for their 
code. What we may do is asking them politely to clarify the license. 
Such license would have to be compatible with the project, typically 
GPL/LGPL for userland utilities and GPL for all kernel space, LGPL for 
libraries which would be ok to link in 3rd party apps. This point is 
likely to be a no-brainer for these people, but you just may not force 
this decision on them by suddently covering their code with a license 
using this catch-all mechanism.

2. the policy is "explicit licensing". Terms should appear in the source 
files, and in addition as an external COPYING file in the relevant 
directories when that makes sense.

In any case, be sure that I've been taking Xenomai licensing issues very 
seriously for the past 12 years, and I'm willing to keep it that way.

This said, thanks again for the heads up. There is no reason to leave 
unlicensed code in the tree.

-- 
Philippe.

